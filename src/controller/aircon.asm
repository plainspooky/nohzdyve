if 0
            byte    aircon_column=
            byte    aircon_frame=
            byte    aircon_line=
endif


AIRCON_POS_TOP:     equ 1
AIRCON_POS_BOTTOM:  equ HEIGHT+AIRCON_HEIGHT-1

AIRCON_POS_LEFT:    equ 2
AIRCON_POS_RIGHT:   equ 27


controller_aircon_init:
            proc

            jp controller_aircon_reset
            endp


controller_aircon_collision:
            proc

   __AIRCON_I0_LEFT: equ AIRCON_POS_LEFT*8
   __AIRCON_I1_LEFT: equ AIRCON_POS_LEFT*8+(AIRCON_WIDTH*8-1)

   __AIRCON_I0_RIGHT: equ AIRCON_POS_RIGHT*8
   __AIRCON_I1_RIGHT: equ AIRCON_POS_RIGHT*8+(AIRCON_WIDTH*8-1)

   __AIRCON_HEIGHT: equ AIRCON_HEIGHT*8-1

            ld a,(aircon_column)
            cp AIRCON_POS_RIGHT
            jr z,__set_right

          __set_left:
            ld e,__AIRCON_I0_LEFT
            ld d,__AIRCON_I1_LEFT

            jr __skip

          __set_right:
            ld e,__AIRCON_I0_RIGHT
            ld d,__AIRCON_I1_RIGHT

          __skip:
            ld a,(aircon_line)
            sub 3
        rept 3
            add a,a
        endm
            ld l,a                      ; 'L' = 'J0'
            add a,__AIRCON_HEIGHT
            ld h,a                      ; 'H' = 'J0' + 'HEIGHT'

            call check_collision
            cp FALSE
            ret z

            ld a,MAN_DEAD
            ld (man_alive),a

            ret                         ; end of routine
            endp


controller_aircon_create:
            proc

            ld a,AIRCON_POS_BOTTOM
            ld (aircon_line),a          ; save 1st line position

            call random_number          ; pick a number

            cp 127
            jr c, __left_side           ; 50% for each side

          __right_side:
            ld a,AIRCON_POS_RIGHT       ; set aircon at right

            jr __save_position

          __left_side:
            ld a,AIRCON_POS_LEFT        ; set aircon at left

          __save_position:
            ld (aircon_column),a        ; save column position

            ret                         ; end of routine
            endp


controller_aircon_erase:
            proc

            ld a,(aircon_line)          ; get aircon position
            cp AIRCON_POS_BOTTOM        ; is in the bottom of screen?
            ret z                       ; do not erase

            jp display_aircon_erase     ; erase aircon from framebuffer
            endp


controller_aircon_first:
            proc

            ld a,(aircon_line)          ; get aircon position
            push af                     ; save this value

            dec a                       ; one line above
            ld (aircon_line),a          ; save this position
            call display_aircon_put     ; put aircon shape on framebuffer

            pop af                      ; restore previous position
            ld (aircon_line),a          ; restore current position

            ret                         ; end of routine
            endp


controller_aircon_up:
            proc

            call controller_aircon_erase  ; erase shape from framebuffer

            ld a,(aircon_line)
            dec a                       ; decrease one position

            cp AIRCON_POS_TOP           ; is on top?
            jp z,controller_aircon_create  ; create another one

            ld (aircon_line),a          ; save new position

            jp display_aircon_put       ; put aircon shape on framebuffer
            endp


controller_aircon_reset:
            proc

            ld a,AIRCON_FRAME_0         ; set frame to 0
            ld (aircon_frame),a

            ret                         ; end of routine
            endp