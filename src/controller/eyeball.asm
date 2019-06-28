if 0
            byte    eyeball_alive=
            byte    eyeball_column=
            byte    eyeball_direction=
            byte    eyeball_exploding_frame=
            byte    eye_frame=0
            byte    eyeball_line=
            byte    eyeball_max_column=
            byte    eyeball_min_column=
endif


EYE_ALIVE:          equ 1
EYE_DEAD:           equ 0

EYE_LINE:           equ 191

EYE_LEFT:           equ -1
EYE_RIGHT:          equ +1

EYE_WIDTH:          equ 16
EYE_HEIGHT:         equ 32


controller_eyeball_init:
            proc

            jp controller_eyeball_reset
            endp


controller_eyeball_collision:
            proc

    __POINTS:       equ 10

            ld a,(STATFL)               ; read VDP Status Register
            bit 5,a                     ; check the "Colision Flag"
            ret z

            ld a,(eyeball_column)
            ld e,a                      ; 'E' = 'I0'
            add a,EYE_WIDTH
            ld d,a                      ; 'D' = 'I0' + 'WIDTH'

            ld a,(eyeball_line)
            ld l,a                      ; 'L' = 'J0'
            add a,EYE_HEIGHT
            ld h,a                      ; 'H' = 'J0' + 'HEIGHT'

            call check_collision
            cp FALSE
            ret z

            ld a,EYE_DEAD
            ld (eyeball_alive),a

            ld hl,(score)
            ld de,__POINTS
            adc hl,de
            ld (score),hl

            jp controller_score_update_score
            endp


controller_eyeball_create:
            proc

    __EYE_LEFT_PAD: equ 24
    __EYE_MAX_X: equ 160

            call controller_eyeball_reset

            call random_number          ; get the initial position

            cp __EYE_MAX_X              ; (0..255)
            jr c,__save_value           ; is 'A' lower than 176?

            sub __EYE_MAX_X             ; remove 176 from 'A' (0..79)

          __save_value:
            add a,__EYE_LEFT_PAD        ; width of wall
            ld (eyeball_min_column),a   ; left side of path

            add a,16
            ld (eyeball_column),a       ; middle of path

            add a,16
            ld (eyeball_max_column),a   ; right side of path

            call random_number          ; get the initial direction

            cp 128                      ; 50%, 50% for left or right!
            jr c,__to_left

            ld a,EYE_RIGHT              ; will move to the right
            jr __finish

          __to_left:
            ld a,EYE_LEFT               ; will move to the left

          __finish:
            ld (eyeball_direction),a    ; save initial direction

            ld a,EYE_LINE
            ld (eyeball_line),a         ; put eye on the end of screen

            ld ix,EYE_SPR               ; eyeball's sprite

    if SET_EYE_COLOR>0
            ld (ix+3),EYE_COLOR_TOP     ; get upper color
            ld (ix+7),EYE_COLOR_BOT     ; get bottom color
    else
            call random_color           ; select a new color for eyeball
            ld (ix+3),a
            ld (ix+7),a
    endif

            ld a,EYE_ALIVE
            ld (eyeball_alive),a        ; set status for eyeball

            xor a
            ld (eyeball_exploding_frame),a  ; set exploding frame to zero

            ret                         ; end of routine
            endp


controller_eyeball_exploding:
            proc

            ld a,(eyeball_exploding_frame)  ; current frame

            ld hl,eyeball_line          ; get current line
            ld c,(hl)                   ; set current line in 'B'

            ld hl,eyeball_column        ; get current column
            ld b,(hl)                   ; set current column in 'C'

            ld de,EYE_SPR               ; man's sprites on spritebuffer

            call display_explosion      ; call explosion animation

            ld hl,eyeball_exploding_frame  ; current frame
            inc (hl)

            ret                         ; end of routine
            endp


controller_eyeball_moving:
            proc

            ld a,(eyeball_direction)    ; get eye direction
            cp EYE_RIGHT                ; is eye going to right?
            jr z,__to_right             ; go to right check

          __to_left:
            ld a,(eyeball_column)       ; get eye column
            add a,EYE_LEFT              ; move to left

            ld hl,eyeball_min_column    ; left corner
            cp (hl)                     ; 'A' = 'A' - ('HL')
            jr nc, __update_column      ; is A lower?

            ld hl,eyeball_direction     ; 'HL' to eyeball direction
            ld (hl),EYE_RIGHT           ; move to the right

            jr __update_column          ; update position

          __to_right:
            ld a,(eyeball_column)       ; get eye column
            add a,EYE_RIGHT             ; move to right

            ld hl,eyeball_max_column    ; right corner
            cp (hl)                     ; 'A' = 'A' - ('HL')
            jr c, __update_column       ; is A greater?

            ld hl,eyeball_direction     ; 'HL' to eyeball direction
            ld (hl),EYE_LEFT            ; move to the left

          __update_column:
            ld (eyeball_column),a       ; new eyeball position

            jp display_eyeball_put    ; displays eyeball sprite
            endp


controller_eyeball_sound:
            proc

            ld a,EYE_PSG_CHANNEL        ; set PSG channel
            ld e,12                     ; set value (volume)

            call WRTPSG                 ; write on PSG

            ret                         ; end of routine
            endp


controller_eyeball_reset:
            proc

            jp display_eyeball_reset  ; removes eyeball from screen
            endp


controller_eyeball_up:
            proc

    __EYE_TOP: equ 239
    __EYE_SPEED: equ 2

            ld a,(eyeball_line)         ; get current row
            sub __EYE_SPEED             ; set new position (go up!)

            cp __EYE_TOP                ; is out of screen?
            jp z,controller_eyeball_create  ; yes, reset eyeball

            ld (eyeball_line),a         ; save new position

            ret                         ; end of routine
            endp