temporize_init:
            proc

            call temporize_reset        ; reset temporize values
            jp temporize_config         ; connfigure temporizing
            endp


temporize_config:
            proc

    __NTSC_DELAY:       equ 3
    __PAL_DELAY:        equ 2

            ld a,($002b)                ; read MSX version on ROM
            bit 7,a                     ; is bit 7 is '1'?

            jr nz, __adjust_for_pal     ; yes, is a 50Hz machine

          __adjust_for_ntsc:
            ld a,__NTSC_DELAY           ; NTSC system (60Hz)

            ret                         ; end of routine

          __adjust_for_pal:
            ld a,__PAL_DELAY            ; PAL system (50Hz)

            ret                         ; end of routine
            endp


temporize_reset:
            proc

            xor a                       ; 'A' = 0
            ld (JIFFY),a                ; reset internal counter

            ret                         ; end of routine
            endp


temporize_wait:
            proc

            ld b,a                      ; 'B' = 'A'

          __wait_loop:
                ld a,(JIFFY)            ; get internal counter value
                cp b                    ; is it the value?
                jr nz, __wait_loop      ; do loop

            ret                         ; end of routine
            endp