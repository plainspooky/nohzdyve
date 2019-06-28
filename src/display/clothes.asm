if 0
            word    clothes_old_pos=0
endif


CLOTHES_WIDTH:  equ 26
CLOTHES_HEIGHT: equ 4
CLOTHES_SIZE:   equ CLOTHES_WIDTH * CLOTHES_HEIGHT

CLOTHES_1:      equ clothes
CLOTHES_2:      equ clothes + CLOTHES_SIZE

display_clothes_erase:
            proc

            ld hl,(clothes_old_pos)     ; get old position of clothes
            ld de,FB_WIDTH

            ld b,CLOTHES_HEIGHT-1

          __loop:
                add hl,de
                djnz __loop

            ld b,CLOTHES_WIDTH          ; set width of shape
            ld c,1                      ; set height of shape

            ld a,BLANK                  ; blank character

            jp framebuffer_fill         ; fill area on framebuffer
            endp


display_clothes_put:
            proc

            ld hl,clothes_line
            ld b,(hl)

            ld de,FB_WIDTH

            ld hl,null_zone_1+CLOTHES_POS_COLUMN  ; starting at dead zone

          __loop:
                add hl,de
                djnz __loop

            ld b,CLOTHES_WIDTH          ; width of clothes
            ld c,CLOTHES_HEIGHT         ; height of clothes

            ld a,(clothes_frame)
            cp CLOTHES_FRAME_1
            jr z,__set_2nd_pattern

            ld de,CLOTHES_1             ; 1st pattern for clothes

            jr __skip
          __set_2nd_pattern:

            ld de,CLOTHES_2             ; 2nd pattern for clothes
          __skip:
            ld (clothes_old_pos),hl

            jp framebuffer_put          ; put shape on framebuffer
            endp


clothes:
            include "display/shapes/clothes.asm"