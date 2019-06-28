get_strig:
            proc

    __KEYBOARD_TRIG:    equ 0           ; keyboard
    __STICK1_TRIG1:     equ 1           ; joystick #1

            ld a,__KEYBOARD_TRIG        ; <SPACE BAR>
            call GTTRIG                 ; get status

            cp 255                      ; check if is pressed?
            ret z                       ; if pressed, return!

            ld a,__STICK1_TRIG1         ; <BUTTON1> on joystick #1
            call GTTRIG                 ; get status

            cp 255                      ; force CARRY

            ret                         ; end of routine
            endp