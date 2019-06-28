engine_aircon_first:
            proc

    __FIRST_AIRCON: equ 23

            call controller_aircon_init

            ld a,__FIRST_AIRCON         ; get line for firt aircon
            ld (aircon_line),a

            ld a,AIRCON_POS_RIGHT       ; get column for first aircon
            ld (aircon_column),a

            ret                         ; end of routine
            endp