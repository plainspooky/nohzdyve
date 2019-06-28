hook_at_interrupt:
            proc

            ld a,$c9                    ; "RET"
            ld (HTIMI),a                ; a fake return
            ld (HTIMI+1),de             ; store routine to call
            ld (HTIMI),a                ; a real return

            ret                         ; end of routine
            endp