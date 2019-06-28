three_ldirvm:
            proc

            local exec_ldirvm
            local increment_de_value

        rept 2
            call exec_ldirvm            ; call LDIRVRM
            call increment_de_value     ; increment 'DE'
        endm

    exec_ldirvm:
            push bc                     ; save 'BC'
            push de                     ; save 'DE'
            push hl                     ; save 'HL'

            call LDIRVM                 ; copy 'BC' bytes from 'HL' to 'DE'

            pop hl                      ; restore 'HL'
            pop de                      ; restore 'DE'
            pop bc                      ; restore 'BC'

            ret                         ; end of routine

    increment_de_value:
            ld a,$08                    ; 'A' is $08 (~2048)
            add a,d                     ; equal to do : HL + 2048
            ld d,a                      ; put value back to 'D'
            ret                         ; return to main routine
            endp