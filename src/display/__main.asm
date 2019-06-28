PATTERNS:   equ $0000
NAMES:      equ $1800
SPR_NAMES:  equ $1b00
ATTRIBS:    equ $2000
SPRITES:    equ $3800

WIDTH:      equ 32                      ; width of screen (in tiles)
HEIGHT:     equ 24                      ; height of screen (in tiles)
TILE_CHAR:  equ 96
TILE_AREA:  equ TILE_CHAR*8          ; place to redefined characters
EXP_FRAMES: equ 5


display_init:
            proc
            call display_screen_init    ; prepare screen
            call framebuffer_init       ; initialize framebuffer
            ret                         ; end of routine
            endp

            include "display/_three_ldirvm.asm"
            include "display/_three_wrtvrm.asm"
            include "display/_framebuffer.asm"
            include "display/_hook_at_interrupt.asm"
            ;
            ; sprites planes must be defined bofore framebuffer load
            ;
            TEETH_SPR:  equ spritebuffer            ; layers 0-3 (4 sprites)
            MAN_SPR:    equ spritebuffer+4*4        ; layers 4-7 (2+2 sprites)
            EYE_SPR:    equ spritebuffer+8*4        ; layers 8-11 (2+2 sprites)

            include "display/aircon.asm"
            include "display/clothes.asm"
            include "display/eyeball.asm"
            include "display/man.asm"
            include "display/screen.asm"
            include "display/teeth.asm"
            include "display/vase.asm"
            include "display/wall.asm"
            include "display/window.asm"


display_explosion:
            proc
            push af                         ; save 'AF'

            ld ixl,e                        ; copy 'DE' to 'IX'
            ld ixh,d

            ld a,c                          ; get actual line of sprite

            ld d,a                          ; store new value on 'D'
            add a,16                        ; increase in 16 pixels
            ld h,a                          ; and store new value on 'H'

            ld a,b                          ; get actual column of sprite

            sub 8                           ; and reduce in 8 pixels
            ld e,a                          ; store new value on 'E'
            add a,16                        ; increase in 16 pixels
            ld l,a                          ; and store new value on 'L'

            pop af                          ; restore 'AF'

            ld iy,__frames

          __set_explosion_frame:
            inc iy
            dec a
            cp 255
            jr nz, __set_explosion_frame

            ld b,(iy)                   ; get 1st sprite of this frame
            ld c,(iy+5)                 ; get the color

            ld (ix+0),d                 ; line
            ld (ix+1),e                 ; column
            ld (ix+2),b                 ; sprite pattern
            ld (ix+3),c                 ; sprite color

            call __next_sprite          ; increase sprite pattern

            ld (ix+4),d                 ; line
            ld (ix+5),l                 ; column
            ld (ix+6),b                 ; sprite pattern
            ld (ix+7),c                 ; sprite color

            call __next_sprite          ; increase sprite pattern

            ld (ix+8),h                 ; line
            ld (ix+9),e                 ; column
            ld (ix+10),b                ; sprite pattern
            ld (ix+11),c                ; sprite color

            call __next_sprite          ; increase sprite pattern

            ld (ix+12),h                ; line
            ld (ix+13),l                ; column
            ld (ix+14),b                ; sprite pattern
            ld (ix+15),c                ; sprite color

            call __next_sprite          ; increase sprite pattern

            ret

          __next_sprite:
        rept 4
            inc b
        endm
            ret

          __frames:
            db 21*4, 25*4, 29*4, 33*4, 41*4  ; first sprite for each explosion

          __colors:
            db 15, 14, 7, 4, 0

            endp


objects:
            include "display/bitmaps/aircon.asm"
            include "display/bitmaps/vase.asm"
            include "display/bitmaps/window.asm"
            include "display/bitmaps/clothes.asm"