if 0
            byte random_seed=
endif

random_number:
            proc
            ld a,(random_seed)          ; get random seed
            ld c,a                      ; 'C' = 'A'
        rept 3
            rrca
        endm
            xor $1f
            add a,c
            sbc a,253
            ld (random_seed),a          ; save new random seed

            ret                         ; end of routine
            endp