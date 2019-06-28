if 0
            word    aircon_old_pos=0
endif


AIRCON_FRAMES:      equ 2
AIRCON_FRAME_0:     equ 0
AIRCON_FRAME_1:     equ AIRCON_FRAMES/2

AIRCON_WIDTH:  equ 3
AIRCON_HEIGHT: equ 3
AIRCON_SIZE:   equ AIRCON_WIDTH * AIRCON_HEIGHT


display_aircon_erase:
            proc

            ld hl,(aircon_old_pos)      ; get old position of aircon

            ld b,AIRCON_WIDTH-1         ; set width of shape
            ld c,AIRCON_HEIGHT          ; set height of shape

            ld a,(aircon_column)
            cp AIRCON_POS_RIGHT
            jr z, __skip
            inc hl

          __skip:
            ld a,BLANK                  ; blank character

            jp framebuffer_fill         ; fill area on framebuffer
            endp


display_aircon_put:
            proc

            ld hl,aircon_line
            ld b,(hl)                   ; 'B' = line of aircon
            ld de,FB_WIDTH              ; get framebuffer width

            ld hl,null_zone_1           ; begin at dead zone

          __loop:
                add hl,de
                djnz __loop

            ld a,(aircon_column)
            ld c,a
            ld b,0

            add hl,bc

            ld a,(aircon_column)
            cp AIRCON_POS_RIGHT
            jr z,__set_right

          __set_left:
            ld de,aircon_left

            jr __skip

          __set_right:
            ld de,aircon_right

          __skip:

            ld a,(aircon_frame)
            cp AIRCON_FRAMES/2
            jr nc,__put

            push hl                     ; save 'HL'

            ld hl,AIRCON_SIZE
            add hl,de
            ex de,hl

            pop hl                      ; restore 'HL'

          __put:
            ld b,AIRCON_WIDTH           ; width of aircon
            ld c,AIRCON_HEIGHT          ; height of aircon

            ld (aircon_old_pos),hl      ; save this position

            inc a                       ; increment frame
            and AIRCON_FRAMES-1         ; 0 if greater than # of frames
            ld (aircon_frame),a         ; save new frame value

            jp framebuffer_put          ; put shape on framebuffer
            endp


aircon_left:
            include "display/shapes/aircon_left.asm"

aircon_right:
            include "display/shapes/aircon_right.asm"