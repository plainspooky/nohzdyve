if 0
            byte    press_space_blink=0
            byte    scroller_print_message*24
            byte    scroller_print_message_null=0  ; force ASCIIZ
endif


display_screen_init:
            proc

            local   attributes
            local   charset
            local   sprites

    __BACK_COLOR:   equ 1               ; black

    __BRDR_COLOR:   equ 1               ; transparent

    __FORE_COLOR:   equ 15              ; white

    __CHARSET_SIZE: equ CHARSET_TILES_SIZE
    __WALL_SIZE:    equ WALL_TILES_SIZE

    __SPRITES_SIZE: equ EXPLOSIONS_TILES_SIZE + EYEBALL_TILES_SIZE + MAN_FALLING_1_TILES_SIZE + MAN_FALLING_2_TILES_SIZE + MAN_JUMPING_TILES_SIZE + MAN_SPEED_LINES_TILES_SIZE + TEETH_CLOSE_TILES_SIZE + TEETH_OPEN_TILES_SIZE

            xor a                       ; 'A' = 0
            ld (CLIKSW),a               ; disable keyboard click

            ld a,__BACK_COLOR           ; background color
            ld (BAKCLR),a               ; set background color

            ld a,__BRDR_COLOR           ; border color
            ld (BDRCLR),a               ; set border color

            ld a,__FORE_COLOR           ; foreground __FORE_COLOR
            ld (FORCLR),a               ; set foreground color

            call CHGCLR                 ; change colors
            call INIGRP                 ; go to SCREEN 2

            call DISSCR                 ; turn off display

            ld a,BLANK
            ld bc,WIDTH*HEIGHT          ; all tiles on screen
            ld hl,NAMES                 ; name's table on VRAM
            call FILVRM                 ; fill VRAM

            call display_screen_sprites_setup  ; setup 16x16 no zoom sprites

            ld hl,attributes            ; point to color attributes
            call display_screen_colorize

            ld bc,__SPRITES_SIZE        ; size of sprite bank to load
            ld de,SPRITES               ; sprite table on VRAM
            ld hl,sprites               ; location of sprite bank

            call LDIRVM                 ; copy from RAM to VRAM

            ld bc,__WALL_SIZE           ; size of walls patterns
            ld de,PATTERNS              ; patterns table on VRAM
            ld hl,walls                 ; location of wall

            call three_ldirvm           ; copy from RAM to VRAM (×3)

            ld bc,__CHARSET_SIZE        ; charset
            ld de,PATTERNS+__WALL_SIZE  ; patterns table on VRAM
            ld hl,charset               ; location of charset

            call three_ldirvm           ; copy from RAM to VRAM (×3)

            ret                         ; end of routine

            attributes:
            db  0                       ; start at ASCII 0
            db  1,$f1                   ; blank character
            db  6,$81                   ; walls at left side
            db  6,$d1                   ; walls at right side
            db 18,$a1                   ; decorations
            db  1,$e0                   ; nothing...
            db 0                        ; stop colorizing!


            charset:
            include "display/bitmaps/charset.asm"

            sprites:                                        ; SPRITES
            include "display/sprites/man_jumping.asm"       ; 0,1
            include "display/sprites/man_falling_1.asm"     ; 2,3
            include "display/sprites/man_falling_2.asm"     ; 4,5
            include "display/sprites/man_speed_lines.asm"   ; 6,7
            include "display/sprites/teeth_close.asm"       ; 8,9,10,11
            include "display/sprites/teeth_open.asm"        ; 12,13,14,15
            include "display/sprites/eyeball.asm"           ; 16,17,18,19,20
            include "display/sprites/explosions.asm"        ; 21,22,23,24
                                                            ; 25,26,27,28
                                                            ; 29,30,31,32
                                                            ; 33,34,35,36
                                                            ; 37,38,39,40
            endp


display_screen_colorize:
            proc

            push hl                     ; save 'HL'

            ld l,(hl)                   ; get the first character
            ld h,0                      ; 'H' = 0
        rept 3
            add hl, hl                  ; 'HL' x 8
        endm

            ld de,ATTRIBS               ; begin of Attribites' table
            adc hl,de                   ; 'HL' is VRAM address now

            pop de                      ; restore 'HL' as 'DE'

          __colorize_sequence:
                inc de                  ; increment pointer
                ld a,(de)               ; get the # of repetitions

                cp 0                    ; is 0?
                ret z                   ; if 'A' is 0, end of routine

                ld b,a                  ; 'B' is # of repetitions (in tiles)
                inc de
                ld a,(de)               ; attrbutes to use
              __colorize_block:
                    ld c,b              ; save 'B' in 'C'
                    ld b,8              ; 'B' is a tile

                  __colorize_loop:
                        call three_wrtvrm  ; write to VRAM (×3)
                        inc hl          ; incrememt VRAM address
                        djnz __colorize_loop  ; do loop

                    ld b,c              ; restore 'B' from 'C'
                    djnz __colorize_block  ; do loop

                jr __colorize_sequence  ; do loop

            endp


display_screen_game:
            proc

    __TILES_SIZE:   equ AIRCON_TILES_SIZE+CLOTHES_TILES_SIZE+VASE_TILES_SIZE+WALL_TILES_SIZE+WINDOW_TILES_SIZE

            ld hl,__attributes          ; point to color attributes
            call display_screen_colorize

            ld bc,__TILES_SIZE          ; size of patterns to copy
            ld de,PATTERNS+TILE_AREA    ; position to copy
            ld hl,objects               ; pattern to use

            call three_ldirvm           ; copy from RAM to VRAM (×3)

            call framebuffer_reset      ; reset framebuffer
            call display_man_reset      ; reset man
            call display_wall_reset     ; reset wall

            ret                         ; end of routine

          __attributes:
            db 32                       ; start at ASCII 32
            db 16,$c0                   ; <space>!"#$%&'()*+,-./
            db 10,$d0                   ; 0123456789
            db 37,$c0                   ; :;<=>?@ABC...XYZ[\]^
            db  1,$80                   ; "<3"
        rept 6
            db  1,$a1                   ; air conditioner L (yellow part)
            db  2,$71                   ; air conditioner L (cyan part)
        endm
        rept 6
            db  2,$71                   ; air conditioner R (cyan part)
            db  1,$a1                   ; air conditioner R (yellow part)
        endm
            db 19,$a1                   ; flower and window

            db 16,$41                   ; clothes line

            db  2,$d1                   ; under pants
            db  2,$81                   ; left shirt (1st)
            db  2,$a1                   ; right shirt (1st)
            db  2,$f1                   ; sock (1st)
            db  4,$71                   ; sheet (1st)
            db  2,$81                   ; left shirt (2nd)
            db  2,$a1                   ; right shirt (2nd)
            db  2,$f1                   ; sock (2nd)
            db  3,$71                   ; sheet (2nd)
            db  2,$81                   ; left shirt (3rd)
            db  2,$a1                   ; right shirt (3rd)
            db  4,$71                   ; sheet (3rd)

            db  4,$21                   ; sheet (1st)
            db  2,$a1                   ; left shirt (1st)
            db  2,$81                   ; right shirt (1st)
            db  2,$e1                   ; under pants
            db  3,$21                   ; sheet (2nd)
            db  2,$a1                   ; left shirt (2nd)
            db  1,$81                   ; right shirt (2nd)
            db  4,$21                   ; sheet (3rd)
            db  2,$a1                   ; left shirt (3rd)
            db  2,$81                   ; right shirt (3rd)

            db 0                        ; stop colorize!
            endp

display_screen_game_over:
            proc

    __MESSAGE_POS:  equ framebuffer+12*WIDTH+10

            ld de,__game_over_message   ; string to print
            ld hl,__MESSAGE_POS         ; position on framebuffer
            call framebuffer_print      ; print on framebuffer

            jp framebuffer_update       ; update framebuffer and return

          __game_over_message:
            db " GAME  OVER ",0
            endp


display_screen_opening:
            proc

            local   attributes
            local   title_pattern
            local   title_shape

    __TITLE_WIDTH:  equ 24
    __TITLE_HEIGHT: equ 8
    __TITLE_LEN:    equ TITLE_TILES_SIZE

    __TITLE_POS:    equ framebuffer+2*WIDTH+4
    __INSTRU_POS:   equ framebuffer+13*WIDTH+6

            call DISSCR                 ; turn off display

            call framebuffer_reset      ; reset framebuffer

            ld bc,__TITLE_LEN           ; total of tiles to copy
            ld de,PATTERNS+TILE_AREA    ; position to copy
            ld hl,title_pattern         ; pattern to use

            call three_ldirvm           ; copy to VRAM (×3)

            ld hl,attributes          ; color attributes for title
            call display_screen_colorize

            call display_wall_reset     ; reset wall pattern

            call display_wall_put       ; and put it on framebuffer

            ld b,__TITLE_WIDTH          ; title's width
            ld c,__TITLE_HEIGHT         ; title's height
            ld hl,__TITLE_POS           ; position on framebuffer
            ld de,title_shape           ; shape pattern
            call framebuffer_put        ; put on framebuffer

            ld de,__instructions        ; point to instructions
            ld hl,__INSTRU_POS          ; position on framebuffer
            call framebuffer_print      ; print on framebuffer

            call display_screen_score   ; display score bar

            call framebuffer_update     ; update framebuffer

            call ENASCR                 ; turn on display

            ret                         ; end of routine

          __instructions:
            db "USE: < AND > TO MOVE",0

            title_pattern:
            include "display/bitmaps/title.asm"

            title_shape:
            include "display/shapes/title.asm"

            attributes:
            db 32
            db 63,$f1
            db  1,$81                   ; "<3"
            db 20,$a1                   ; "N"
            db  2,$61                   ; "o"/"eyeball"
            db  1,$f1                   ; "o"/"eyeball"
            db  2,$e1                   ; "o"/"eyeball"
            db  2,$81                   ; "o"/"eyeball"
            db  1,$e1                   ; "o"/"eyeball"
            db  1,$f1                   ; "o"/"eyeball"
            db  1,$71                   ; "o"/"eyeball"
            db  1,$e1                   ; "o"/"eyeball"
            db  1,$71                   ; "o"/"eyeball"
            db  1,$51                   ; "o"/"eyeball"
            db 18,$d1                   ; "h"
            db 12,$a1                   ; "z"
            db 18,$21                   ; "d"
            db 19,$d1                   ; "y"
            db  9,$71                   ; "v"
            db 21,$21                   ; "e"
            db  2,$51                   ; "("
            db 10,$41                   ; "c) TUCKERSOFT"
            db 0
            endp


display_screen_opening_animation:
            proc

    __SCROLLER_POS: equ framebuffer+21*WIDTH+4
    __PRESS_SP_POS: equ framebuffer+17*WIDTH+5

    __WIDTH:        equ 24

            ld b,__WIDTH

            ld hl,scroller_print_message
            ld de,(scroller_cursor)

            push de                     ; save cursor string position

          __populate_loop:
                ld a,(de)
                cp 0
                jr z,__break_populate_loop
                ld (hl),a
                inc de
                inc hl
                djnz __populate_loop

          __break_populate_loop:
            xor a
            ld (hl),a

            ld de,scroller_print_message
            ld hl,__SCROLLER_POS

            call framebuffer_print

            ld a,(press_space_blink)    ; get blink status
            ld b,a                      ; save value in 'B'
            and 2                       ; only 2nd bit
            cp 2                        ; is bit 2 set?
            jr z, __not_press_space     ; do not print message

            ld de,__press_space         ; "press space" message
            jr __print_and_update_framebuffer

          __not_press_space:
            ld de, __blank_press_space  ; empty line

          __print_and_update_framebuffer:
            inc b                       ; 'B' = 'B' + 1
            ld a,b                      ; 'A' = 'B'
            and 3                       ; 'A' and 3
            ld (press_space_blink),a    ; save blink status

            ld hl,__PRESS_SP_POS        ; set framebuffer positon
            call framebuffer_print      ; print message

            call framebuffer_update ; update framebuffer

            pop hl                      ; get string positon

            ld a,(hl)                   ; check for <EOT>
            cp 0                        ; is _NULL_?
            jr z, __reset_message_pointer  ; reset position
            inc hl                      ; incremente 'DE'
            ld (scroller_cursor),hl

            ret                         ; end of routine

          __reset_message_pointer:
            ld hl,scroller_message      ; reset string pointer
            ld (scroller_cursor),hl

            ret                         ; end of routine

          __press_space:
            db "SPACE OR TRIG TO START",0

          __blank_press_space:
            ds 22," "
            db 0

    scroller_message:
            ds 23," "
            db "- = NOHZDYVE = -"
            ds 2," "
            db ". . ."
            ds 2," "
            db "^ 2019 GIOVANNI NUNES, ALL RIGHTS RESERVED   "
            ds 8," "
            db "LICENSED UNDER GPL 3.0"
            ds 4," "
            db ". . .   "
            db "BASED ON ZX SPECTRUM GAME WRITTEN BY MATT WESTCOTT"
            db "   . . . "
            db 0

;
; Original scroller message from speccy release...
;

            ; ds 36," "
            ; db "- = NOHZDYVE = -"
            ; ds 2," "
            ; db ". . ."
            ; ds 2," "
            ; db "^ 1984 TUCKERSOFT"
            ; ds 8," "
            ; db "LOOK OUT FOR MORE GREAT GAMES FROM TUCKERSOFT"
            ; ds 3," "
            ; db ". . .   PROGRAMMED BY MATT WESTCOTT   "
            ; db ". . .   DESIGNED BY CLAYTON MCDERMOTT   "
            ; db ". . .   MUSIC BY BRIAN REITZELL   . . . "
            ; db 0                        ; <EOT>

            endp


display_screen_opening_clear:
            proc

            ld a,BLANK                  ; blank character

            ld b,26                     ; game area width
            ld c,24                     ; game area height

            ld hl,framebuffer+0*WIDTH+3 ; framebuffer position

            call framebuffer_fill       ; clear game area

            jp framebuffer_update       ; update screen and return
            endp


display_screen_sprites_setup:
            proc

            ld a,(RG1SAV)               ; read VDP Register #1
            and $e6                     ; disable sprite zoom
            or 2                        ; set sprite size to 16x16
            ld b,a                      ; 'B'='A'

            ld c,1                      ; set 'C' to VDP Register #1
            call WRTVDP                 ; write the new value

            ret                         ; end of routine
            endp


display_screen_score:
            proc

            ld de,score_line            ; string to print
            ld hl,framebuffer+5         ; position on framebuffer

            jp framebuffer_print        ; put on framebuffer
            endp