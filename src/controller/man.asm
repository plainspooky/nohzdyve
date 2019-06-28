if 0
            byte    man_alive=
            byte    man_column=
            byte    man_direction=
            byte    man_exploding_frame=
            byte    man_falling=
            byte    man_frame=0
            byte    man_frame_jump=
            byte    man_line=
            byte    man_max_fall=
endif


MAN_ALIVE:          equ 1
MAN_DEAD:           equ 0

MAN_FALL_DOWN:      equ 1
MAN_FALL_UP:        equ -1

MAN_DEEP_FALL:      equ 96
MAN_DEEPEST_FALL:   equ 128
MAN_HIGH_FALL:      equ 48

MAN_COLUMN:         equ 132
MAN_LINE:           equ 72

MAN_MOVE_FAST:      equ 4
MAN_MOVE_SLOW:      equ 1
MAN_NO_MOVE:        equ 0

MAN_WIDTH:          equ 16
MAN_HEIGHT:         equ 32


controller_man_init:
            proc

            jp  controller_man_reset    ; reset object
            endp


controller_man_exploding:
            proc

            ld a,(man_exploding_frame)  ; current frame

            ld hl,man_line              ; get current line
            ld c,(hl)                   ; set current line in 'B'

            ld hl,man_column            ; get current column
            ld b,(hl)                   ; set current column in 'C'

            ld de,MAN_SPR               ; man's sprites on spritebuffer

            call display_explosion      ; call explosion animation

            ld hl,man_exploding_frame   ; current frame
            inc (hl)                    ; increment frame

            ret                         ; end of routine
            endp


controller_man_falling:
            proc

            ld a,(man_column)           ; get man vertical position
            ld hl,man_direction         ; get fall direction
            add a,(hl)                  ; change vertical position

            ld (man_column),a           ; update vertical position

          __move_down_or_up:
            ld a,(man_line)             ; get man horizontal position
            ld hl,man_falling           ; get fall increment
            add a,(hl)                  ; change horizontal position

            ld (man_line),a             ; update horizontal position

            ld hl,man_max_fall          ; has fall enough?
            cp (hl)
            jr nc, __to_move_up         ; yes, change direction

            cp MAN_HIGH_FALL            ; has top high?
            ret nz                      ; no, exit routine

          __to_move_down:
            ld a,MAN_DEEP_FALL          ; set default deep line
            ld (man_max_fall),a

            ld a,MAN_FALL_DOWN          ; change direction

            jr __save_and_finish

          __to_move_up:
            ld a,MAN_FALL_UP            ; change direction

          __save_and_finish:
            ld (man_falling),a          ; save falling direction

            ret                         ; end of routine
            endp


controller_man_hit_walls:
            proc
            ld a,(man_column)           ; get current column

            cp HIT_WALL_RIGHT           ; column is near the left wall?
            jr nc, __hit_on_walls       ; yes, hit!

            cp HIT_WALL_LEFT            ; colum is near the right wall?
            ret nc                      ; no, exit routine

          __hit_on_walls:
            ld a,MAN_DEAD
            ld (man_alive),a            ; kill the man!

            ret                         ; end of routine
            endp


controller_man_moving:
            proc

    __LEFT_KEY:     equ 3
    __RIGHT_KEY:    equ 7

            call display_man_falling    ; display man's falling

            call controller_man_falling ; do man's falling

            call get_stick              ; read input

            cp 0                        ; check if there is any data
            ret z                       ; if no input, exit

          __check_input:
            cp __LEFT_KEY
            jr z, __move_right          ; move to the left

            cp __RIGHT_KEY
            jr z, __move_left           ; move to the right

            ret                         ; nothing to do, exit

          __move_right:
            ld a,(man_column)           ; get current position
            add a,MAN_MOVE_FAST         ; increment position
            ld (man_column),a           ; update position

            ld a,MAN_MOVE_SLOW          ; set new direction
            ld (man_direction),a

            jr __set_max_fall           ; change max fall line

          __move_left:
            ld a,(man_column)           ; get current position
            add a,-MAN_MOVE_FAST        ; decrement position
            ld (man_column),a           ; update position

            ld a,-MAN_MOVE_SLOW         ; set new direction
            ld (man_direction),a

         __set_max_fall:
            ld a,MAN_DEEPEST_FALL       ; when moving, man falls deeper
            ld (man_max_fall),a

            ret                         ; end of routine
            endp


controller_man_sound:
            proc

            ld a,MAN_PSG_CHANNEL        ; set PSG channel
            ld e,14                     ; set value (volume)

            call WRTPSG                 ; write on PSG

            ret                         ; end of routine
            endp


controller_man_reset:
            proc

            call display_man_reset      ; remove man from screen

            ld a,MAN_ALIVE
            ld (man_alive),a            ; set status for man

            ld a,MAN_LINE
            ld (man_line),a             ; set line positon for man

            ld a,MAN_COLUMN
            ld (man_column),a           ; set column position for man

            ld a,MAN_NO_MOVE
            ld (man_direction),a        ; set direction of fall (none/left/right)

            xor a
            ld (man_exploding_frame),a  ; set exploding frame to zero

            ld a,MAN_FALL_DOWN
            ld (man_falling),a          ; set direction of fall (up/down)

            ld a,MAN_DEEP_FALL
            ld (man_max_fall),a         ; set how deep man falls

            ret                         ; end of routine
            endp