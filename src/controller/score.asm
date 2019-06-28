if 0
            word    hi_score=
            word    score=
            byte    score_line*23
            ;       "<Heart><Heart><Heart>  SC:00000 HI:00000" + NULL
endif


LIFE_POS:   equ     score_line
SCORE_POS:  equ     score_line+8
HI_POS:     equ     score_line+17


controller_score_init:
            proc

    __TEMPLATE_SIZE:    equ 23

            ld bc,__TEMPLATE_SIZE       ; size of string
            ld de,score_line            ; score line
            ld hl,__score_template      ; score template
            ldir                        ; copy bytes

            ld a,LIFES
            ld (total_lifes),a          ; reset number of lifes

            ld hl,0
            ld (score),hl               ; reset the score

            ld hl,0
            ld (hi_score),hl            ; reset the high score

            call controller_score_update_hiscore  ; update high-score
            call controller_score_update_score  ; update score

            jp controller_score_update_lifes  ; update lifes

          __score_template:
            db "___  SC:????? HI:?????",0

            endp


controller_score_reset:
            proc

            call controller_score_update_hiscore  ; update high-score

            ld hl,0
            ld (score),hl               ; reset the score

            ld a,LIFES
            ld (total_lifes),a          ; reset number of lifes

            jp controller_score_update_lifes  ; update lifes
            endp


controller_score_update_score:
            proc

            ld hl,(score)               ; get score value
            ld de,SCORE_POS             ; set position

            jp print_number             ; print score value
            endp

controller_score_update_hiscore:
            proc

            ld de,(score)               ; get score value
            ld hl,(hi_score)            ; get high score value

            sbc hl,de                   ; 'HL' = 'HL' - 'DE'

            jr nc,__skip                ; if not carry (greater)

            ex de,hl
            ld (hi_score),hl            ; we have a new record!

            jr __print

          __skip:
            ld hl,(hi_score)            ; restore current high score

          __print:
            ld de,HI_POS                ; set positon

            jp print_number             ; print hi-score
            endp

controller_score_put:
            proc

            jp display_screen_score     ; put score line on framebuffer
            endp

controller_score_update_lifes:
            proc

    __HEART:            equ "_"         ; heart pattern ("<3")

            ld a,(total_lifes)          ; current number of lifes
            ld b,LIFES                  ; default number of lifes
            ld c,__HEART                ; the heard pattern

            ld hl,LIFE_POS              ; position on score line

          __loop:
                ld (hl),c               ; put one heart on score line

                dec a                   ; 'A' = 'A' - 1
                cp 0                    ; if 'A' != 0, go to __skip
                jr nz,__skip

                ld c," "                ; change pattern to SPACE

              __skip:
                inc hl                  ; increment 'HL'
                djnz __loop             ; do loop

            ret                         ; end of routine
            endp