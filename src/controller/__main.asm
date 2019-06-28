MAN_PSG_CHANNEL:    equ 8
EYE_PSG_CHANNEL:    equ 9
TEETH_PSG_CHANNEL:  equ 10


            include "controller/_check_collision.asm"
            include "controller/_get_stick.asm"
            include "controller/_get_strig.asm"
            include "controller/_print_number.asm"
            include "controller/_random_color.asm"
            include "controller/_random_number.asm"

            include "controller/aircon.asm"
            include "controller/clothes.asm"
            include "controller/eyeball.asm"
            include "controller/man.asm"
            include "controller/score.asm"
            include "controller/screen.asm"
            include "controller/teeth.asm"
            include "controller/vase.asm"
            include "controller/wall.asm"


controller_sound_init:
            proc

            xor a
            ld hl,__sound_sets

            ld b,6
            __loop:
                ld e,(hl)
                call WRTPSG
                inc a
                inc hl
                nop
                djnz __loop

            ret

          __sound_sets:
            db $00, $0e
            db $00, $07
            db $00, $00

            endp


controller_sound_off:
            proc

            ld b,3
            ld a,MAN_PSG_CHANNEL
            ld e,0
          __sound_loop:
                call WRTPSG
                inc a
                djnz __sound_loop

            ret
            endp