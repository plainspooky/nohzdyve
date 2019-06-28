engine_clothes_first:
            proc

    __FIRST_CLOTHES: equ 29

            call controller_clothes_init

            ld a,__FIRST_CLOTHES        ; get line for first clothes
            ld (clothes_line),a

            ret                         ; end of routine
            endp