engine_vase_first:
            proc

    __FIRST_VASE: equ 12

            call controller_vase_init

            ld a,__FIRST_VASE           ; get line for first vase
            ld (vase_line),a

            ld a,VASE_POS_RIGHT         ; put first vase at right side
            ld (vase_column),a

            ret                         ; end of routine
            endp