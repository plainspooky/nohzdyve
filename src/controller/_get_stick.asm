get_stick:
            proc

    __KEYBOARD:         equ 0           ; keyboard
    __STICK1:           equ 1           ; joystick #1

            ld a,__KEYBOARD             ; cursor keys
            call GTSTCK                 ; get status

            cp 0                        ; check if any key is pressed
            ret nz                      ; return if there is

            ld a,__STICK1               ; joystick #1
            call GTSTCK                 ; get status

            ret                         ; end of routine
            endp