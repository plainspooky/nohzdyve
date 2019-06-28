if 0
            word    vase_old_pos=0
endif


VASE_WIDTH:         equ 1
VASE_HEIGHT:        equ 3
VASE_SIZE:          equ VASE_WIDTH+VASE_HEIGHT


display_vase_erase:
            proc

            ld a,BLANK                  ; empty character

            ld hl,(vase_old_pos)        ; get old position of vase
            ld de,FB_WIDTH              ; framebuffer's width

        rept 2
            add hl,de
            ld (hl), a                  ; place a empty character
        endm

            ret                         ; end of routine
            endp


display_vase_put:
            proc

            ld hl,vase_line
            ld b,(hl)                   ; 'B' = line of vase
            ld de,FB_WIDTH              ; get framebuffer width

            ld hl,null_zone_1

          __loop:
                add hl,de
                djnz __loop

            ld a,(vase_column)
            ld c,a
            ld b,0

            add hl,bc

            cp VASE_POS_RIGHT
            jr z,__set_right

          __set_left:
            ld de,vase_left

            jr __skip

          __set_right:
            ld de,vase_right

          __skip:

            ld b,VASE_WIDTH             ; width of vase
            ld c,VASE_HEIGHT            ; height of vase

            ld (vase_old_pos),hl      ; save this position

            jp framebuffer_put          ; put shape on framebuffer
            endp


vase_left:
            include "display/shapes/vase_left.asm"

vase_right:
            include "display/shapes/vase_right.asm"