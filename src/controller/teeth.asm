if 0
            byte    teeth_column=
            byte    teeth_direction=
            byte    teeth_frame=0
            byte    teeth_line=
endif


TEETH_LINE:     equ 191
TEETH_SPEED:    equ  4
TEETH_TOP:      equ TEETH_LINE+24       ; sprite height

TEETH_LEFT:     equ -4
TEETH_RIGHT:    equ +4

TEETH_MAX:      equ 200
TEETH_MIN:      equ  24

TEETH_WIDTH:    equ 32
TEETH_HEIGHT:   equ 24

controller_teeth_init:
            proc

            jp controller_teeth_reset   ; reset teeth
            endp


controller_teeth_collision:
            proc

            ld a,(STATFL)               ; read VDP Status Register
            bit 5,a                     ; check the "Colision Flag"
            ret z

            ld a,(teeth_column)
            ld e,a                      ; 'E' = 'I0'
            add a,TEETH_WIDTH
            ld d,a                      ; 'D' = 'I0' + 'WIDTH'

            ld a,(teeth_line)
            ld l,a                      ; 'L' = 'J0'
            add a,TEETH_HEIGHT
            ld h,a                      ; 'H' = 'J0' + 'HEIGHT'

            call check_collision        ; check colision
            cp FALSE                    ; if not colision...
            ret z                       ; end of routine (do nothing)

            ld a,MAN_DEAD               ; set man as DEAD
            ld (man_alive),a

            ret                         ; end of routine
            endp


controller_teeth_create:
            proc

            call controller_teeth_reset

            call random_number          ; get the initial position

            cp TEETH_MAX                ; (0..255)
            jr c,__save_value           ; is 'A' lower than TEETH_MAX?

            sub TEETH_MAX               ; remove 176 from 'A' (0..79)

          __save_value:

            ld (teeth_column),a         ; save teeth position

            call random_number          ; get the initial direction

            cp 128                      ; 50%, 50% for left or right!
            jr c,__to_left

            ld a,TEETH_RIGHT            ; will move to the right
            jr __finish

          __to_left:
            ld a,TEETH_LEFT            ; will move to the left

          __finish:
            ld (teeth_direction),a     ; save initial direction

            ld a,TEETH_LINE
            ld (teeth_line),a          ; put TEETH on the end of screen

            ld ix,TEETH_SPR             ; eyeball's sprite

            call random_color           ; select a new color for eyeball

            ld (ix+3),a                 ; set color of 1st sprite
            ld (ix+7),a                 ; set color of 2nd sprite
            ld (ix+11),a                ; set color of 3rd sprite
            ld (ix+15),a                ; set color of 4th sprite

            ret                         ; end of routine
            endp


controller_teeth_moving:
            proc

            ld a,(teeth_line)           ; get current row
            sub TEETH_SPEED             ; set new position (go up!)

            cp TEETH_TOP              ; is out of screen?
            ; jp nc,controller_teeth_create  ; yes, reset teeth
            jp z,controller_teeth_create  ; yes, reset teeth

            ld (teeth_line),a           ; get teeth's line

            ld a,(teeth_direction)      ; get TEETH direction
            cp TEETH_RIGHT              ; is TEETH going to right?
            jr z,__to_right             ; go to right check

          __to_left:
            ld a,(teeth_column)         ; get TEETH column
            add a,TEETH_LEFT            ; move to left

            cp TEETH_MIN                ; is left side?
            jr nc, __update_column      ; is A lower?

            ld hl,teeth_direction       ; 'HL' to teeth direction
            ld (hl),TEETH_RIGHT         ; move to the right

            jr __update_column          ; update position

          __to_right:
            ld a,(teeth_column)         ; get TEETH column
            add a,TEETH_RIGHT           ; move to right

            cp TEETH_MAX                ; if right side?
            jr c, __update_column       ; is A greater?

            ld hl,teeth_direction       ; 'HL' to teeth direction
            ld (hl),TEETH_LEFT          ; move to the left

          __update_column:
            ld (teeth_column),a         ; new teeth position

            jp display_teeth_put
            endp


controller_teeth_sound:
            proc

            ld a,(teeth_frame)          ; get Teeth frame
            srl a                       ; divide by 2

            ret nz                      ; return if not zero

            ld a,TEETH_PSG_CHANNEL      ; set PSG channel
            ld e,13                     ; set value (volume)

            call WRTPSG                 ; write on PSG

            ret                         ; end of routine
            endp


controller_teeth_reset:
            proc

            jp display_teeth_reset      ; removes teeth from screen
            endp