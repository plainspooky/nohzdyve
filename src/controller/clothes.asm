if 0
            byte    clothes_frame=
            byte    clothes_line=
            byte    clothes_visible=
endif


CLOTHES_POS_TOP:    equ 0
CLOTHES_POS_BOTTOM: equ HEIGHT+CLOTHES_HEIGHT-1

CLOTHES_POS_COLUMN: equ 3

CLOTHES_FRAME_1:    equ 0
CLOTHES_FRAME_2:    equ 1

controller_clothes_init:
            proc

            jp controller_clothes_reset
            endp


controller_clothes_create:
            proc

            ld a,(clothes_visible)      ; get clothes visibility
            xor 255                     ; disable visibility
            ld (clothes_visible),a      ; store visibility status

            ld a,CLOTHES_POS_BOTTOM     ; set clothes to screen bottom
            ld (clothes_line),a

            call random_number          ; choose a number
            and 1                       ; only 0 or 1
            ld (clothes_frame),a        ; save it

            ret                         ; end of routine
            endp


controller_clothes_erase:
            proc

            ld a,(clothes_line)         ; get clothes position
            cp CLOTHES_POS_BOTTOM       ; is at screen bottom?
            ret z                       ; do nothing

            jp display_clothes_erase    ; erase clothes on framebuffer
            endp


controller_clothes_reset:
            proc

            ld a,TRUE                   ; changes on first interation
            ld (clothes_visible),a      ; so, it is FALSE!

            ret                         ; end of routine
            endp


controller_clothes_up:
            proc

            ld a,(clothes_visible)      ; is clothes visible?
            cp FALSE
            jr z,__no_draw_clothes      ; no draw clothes this time

          __draw_clothes:
            call display_clothes_erase  ; remove clothes from framebuffer

            ld b,CLOTHES_POS_TOP        ; get clothes's top line

            call __update_clothes_line  ; update position

            jp display_clothes_put      ; put clothes shape on framebuffer

          __no_draw_clothes:
            ld b,CLOTHES_HEIGHT

          __update_clothes_line:
            ld a,(clothes_line)         ; read actual position
            dec a                       ; decrement position

            cp b                        ; reset clothes if reach top
            jp z,controller_clothes_create

            ld (clothes_line),a         ; save new value

            ret                         ; return to main routine
            endp