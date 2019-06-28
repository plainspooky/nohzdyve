random_color:
            proc

            call random_number          ; get the initial direction
            and 15                      ; only between 0 and 15

            cp 2
            ret nc                      ; end of routine if >2

            add a,2                     ; 'A' = 'A' + 2

            ret                         ; end of routine
            endp