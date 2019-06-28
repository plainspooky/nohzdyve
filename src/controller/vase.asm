if 0
            byte    vase_column=
            byte    vase_line=
endif


VASE_POS_TOP:     equ 1
VASE_POS_BOTTOM:  equ HEIGHT+VASE_HEIGHT-1
VASE_POS_LEFT:    equ 3
VASE_POS_RIGHT:   equ 28


controller_vase_init:
            proc

            jp controller_vase_reset
            endp


controller_vase_collision:
            proc

    __VASE_I0_LEFT: equ VASE_POS_LEFT*8
    __VASE_I1_LEFT: equ VASE_POS_LEFT*8+7

    __VASE_I0_RIGHT: equ VASE_POS_RIGHT*8
    __VASE_I1_RIGHT: equ VASE_POS_RIGHT*8+7

    __VASE_HEIGHT: equ 8

             ld a,(vase_column)
             cp VASE_POS_RIGHT
             jr z,__set_right

           __set_left:
             ld e,__VASE_I0_LEFT
             ld d,__VASE_I1_LEFT

             jr __skip

           __set_right:
             ld e,__VASE_I0_RIGHT
             ld d,__VASE_I1_RIGHT

           __skip:
             ld a,(vase_line)
             dec a
         rept 3
             add a,a
         endm
             ld l,a                      ; 'L' = 'J0'
             add a,__VASE_HEIGHT
             ld h,a                      ; 'H' = 'J0' + 'HEIGHT'

             call check_collision
             cp FALSE
             ret z

             ld a,MAN_DEAD
             ld (man_alive),a

             ret                         ; end of routine
             endp


controller_vase_create:
            proc

            ld a,VASE_POS_BOTTOM
            ld (vase_line),a            ; save 1st line position

            call random_number          ; pick a number

            cp 127
            jr c, __left_side           ; 50% for each side

          __right_side:
            ld a,VASE_POS_RIGHT         ; set vase at right

            jr __save_position

          __left_side:
            ld a,VASE_POS_LEFT          ; set vase at left

          __save_position:
            ld (vase_column),a          ; save column position

            ret                         ; end of routine
            endp


controller_vase_erase:
            proc

            ld a,(vase_line)            ; get vase position
            cp VASE_POS_BOTTOM          ; is at screen bottom?
            ret z                       ; do nothinh

            jp display_vase_erase       ; erase vase on framebuffer
            endp


controller_vase_first:
            proc

            ld a,(vase_line)            ; get vase position
            push af                     ; save this value

            dec a                       ; one line above
            ld (vase_line),a            ; save this position
            call display_vase_put       ; put aircon shape on framebuffer

            pop af                      ; restore previous position
            ld (vase_line),a            ; save this value

            ret                         ; end of routine
            endp


controller_vase_reset:
            proc

            ret                         ; end of routine
            endp


controller_vase_up:
            proc

            call controller_vase_erase  ; erase shape from framebuffer

            ld a,(vase_line)
            dec a                       ; decrease one position

            cp VASE_POS_TOP             ; is on top?
            jp z,controller_vase_create   ; create another one

            ld (vase_line),a            ; save new position

            jp display_vase_put         ; put vase shape on framebuffer
            endp