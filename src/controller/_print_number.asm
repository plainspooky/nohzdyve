print_number:
            proc

    __ZERO_CHAR:        equ "0"

            ld bc,-10000                ; ten tousand
            call __format_digit
            ld bc,-1000                 ; one tousand
            call __format_digit
            ld bc,-100                  ; one hundred
            call __format_digit
            ld c,-10                    ; ten
            call __format_digit
            ld c,b

          __format_digit:
            ld a,__ZERO_CHAR-1

            __format_digit_loop:
                inc a
                add hl,bc
                jr c,__format_digit_loop

            sbc hl,bc
            ld (de),a
            inc de

            ret                         ; end of routine
            endp