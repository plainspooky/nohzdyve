three_wrtvrm:
            proc
            local exec_wrtvrm

            push hl                     ; save 'HL'
        rept 3
            call exec_wrtvrm            ; write a byte on VRAM
        endm
            pop hl                      ; restore 'HL'

            ret                         ; end of routine

    exec_wrtvrm:
            call WRTVRM                 ; write 'A' on VRAM
            push af                     ; save 'AF'
            ld a,$08                    ; 'A' is $08 (~2048)
            add a,h                     ; equal to do : HL + 2048
            ld h,a                      ; put value back to 'H'
            pop af                      ; restore 'AF'

            ret                         ; return to main routine
            endp