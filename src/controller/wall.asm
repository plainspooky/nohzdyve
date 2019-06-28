controller_wall_animate:
            proc

    __LEFT_FIRST_LINE:  equ wall_left_side
    __LEFT_LAST_LINE:   equ wall_left_side+WALL_SIZE-WALL_WIDTH

    __RIGHT_FIRST_LINE: equ wall_right_side
    __RIGHT_LAST_LINE:  equ wall_right_side+WALL_SIZE-WALL_WIDTH

            ld hl,__LEFT_FIRST_LINE     ; point left's wall top
            call __save_first_line      ; save the 1st line

            ld bc,WALL_SIZE             ; tiles to copy, all but first line
            ld de,wall_left_side        ; to left side shape
            ld hl,wall_left_side+WALL_WIDTH ; from 2nd line from it
            ldir                        ; transfer

            ld bc,WALL_WIDTH            ; one line
            ld de,__LEFT_LAST_LINE      ; to shape's last line
            ld hl,wall_temp_area        ; from temporary area
            ldir                        ; transfer

            ld hl,__RIGHT_FIRST_LINE    ; point right's wall top
            call __save_first_line      ; save the 1st line

            ld bc,WALL_SIZE             ; tiles to copy, all but first line
            ld de,wall_right_side       ; to right side shape
            ld hl,wall_right_side+WALL_WIDTH  ; from 2nd line from it
            ldir                        ; transfer

            ld bc,WALL_WIDTH            ; one line
            ld de,__RIGHT_LAST_LINE     ; to shape's last line
            ld hl,wall_temp_area        ; from temporary area
            ldir                        ; transfer

            jp display_wall_put         ; display walls

          __save_first_line:
            ld bc,WALL_WIDTH            ; one line
            ld de,wall_temp_area        ; to temporary area
            ldir                        ; transfer

            ret                         ; return
            endp


controller_wall_reset:
            proc

            jp display_wall_put         ; display walls
            endp