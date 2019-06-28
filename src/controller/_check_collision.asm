TRUE:               equ -1
FALSE:              equ  0


check_collision:
            proc

            ld a,(man_column)
            ld ixl,a                    ; 'IXL' = 'X0'

            add a,MAN_WIDTH
            ld ixh,a                    ; 'IXH' = 'X0' + 'WIDTH'

            ld a,(man_line)
            ld iyl,a                    ; 'IYL' = 'Y0'

            add a,MAN_HEIGHT
            ld iyh,a                    ; 'IYH' = 'Y0' + 'HEIGHT'

            ld a,e
            cp ixh                      ; i0 < x0 + width
            jr nc, __return_false

            ld a,d
            cp ixl                      ; i0 + width > x0
            jr c,__return_false

            ld a,l
            cp iyh                      ; j0 < y1 + height
            jr nc,__return_false

            ld a,h
            cp iyl                      ; j0 + height > y1
            jr c,__return_false

          __return_true:
            ld a,TRUE

            ret                         ; return "True"

          __return_false:
            ld a,FALSE

            ret                         ; return "False"
            endp