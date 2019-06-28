if 0
            byte    wall_left_side*75
            byte    wall_temp_area*3
            byte    wall_right_side*75
endif


WALL_WIDTH:  equ 3
WALL_HEIGHT: equ 25
WALL_SIZE:   equ WALL_WIDTH * WALL_HEIGHT


display_wall_init:
            proc

            jp display_wall_reset
            endp

display_wall_reset:
            proc

            ld bc,WALL_WIDTH*WALL_HEIGHT  ; bytes to copy
            ld de,wall_left_side        ; RAM area to store wall
            ld hl,left_wall             ; left wall shape
            ldir                        ; copy to buffer

            ld bc,WALL_WIDTH*WALL_HEIGHT  ; bytes to copy
            ld de,wall_right_side       ; RAM area to store wall
            ld hl,right_wall            ; right wall shape
            ldir                        ; copy to buffer

            ret                         ; end of routine
            endp


display_wall_put:
            proc

            ld b,WALL_WIDTH             ; width of wall
            ld c,HEIGHT                 ; height of screen
            ld de,wall_left_side        ; pattern to left wall
            ld hl,framebuffer           ; left side of screen

            call framebuffer_put        ; put shape on framebuffer

            ld b,WALL_WIDTH             ; width of wall
            ld c,HEIGHT                 ; height of screen
            ld de,wall_right_side       ; pattern of right wall
            ld hl,framebuffer+WIDTH-WALL_WIDTH ; right side of screen

            jp framebuffer_put          ; put shape on framebuffer and return
            endp


walls:
            include "display/bitmaps/wall.asm"

left_wall:
            include "display/shapes/wall_left.asm"

right_wall:
            include "display/shapes/wall_right.asm"