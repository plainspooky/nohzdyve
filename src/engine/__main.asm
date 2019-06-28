if 0
            byte    input_device=
            byte    total_lifes=0
            byte    vdp_sync_1=
            byte    vdp_sync_2=
endif


LIFES:      equ 3                       ; number of lifes


engine_init:
            proc

            call temporize_init
            ld (vdp_sync_1),a

            add a,a
            ld (vdp_sync_2),a

            call controller_screen_init ; init screen
            call controller_score_init  ; init score
            call controller_clothes_init  ; init clothes

          __loop:
                call controller_sound_init  ; set sound registers
                call controller_score_reset  ; reset score for new game

                call engine_opening     ; run opening screen

                call engine_game        ; run game engine

                jr __loop
            endp


engine_opening:
            proc

            call controller_sound_init  ; set sound registers
            call controller_score_reset  ; reset score for new game

            call controller_screen_opening

            __loop:
                  call temporize_reset    ; reset internal counter

                  call controller_screen_opening_animation

                  jr z, __skip          ; skip if trig was pressed?

                  ld a,(vdp_sync_2)

                  call temporize_wait   ; wait a moment

                  jr __loop     ; do loop

                __skip:
                  jp display_screen_opening_clear

            ret
            endp


engine_game:
            proc

            call controller_score_update_score  ; update score

          __lifes_loop:
            call display_screen_game    ; prepare game's screen (!!!)

            call controller_wall_reset  ; reset wall

            call controller_score_put   ; print score

            call engine_man_reset       ; reset man's controller

            call controller_eyeball_create  ; creates the first eyeball
            call controller_teeth_create  ; creates the first teeth

            call engine_aircon_first    ; create an aircon at right bottom
            call engine_clothes_first   ; create clothes o correct position
            call engine_vase_first      ; create a vase at left bottom

            call controller_aircon_first

            call controller_vase_first

            call controller_screen_update

            call engine_man_jumping

              __game_loop:
                call temporize_reset    ; reset internal counter

                call controller_aircon_up  ; up air conditioner
                call controller_clothes_up  ; up clothes
                call controller_vase_up ; up vase of flower

              __do_man_animate:
                ld a,(man_alive)        ; get man status
                cp MAN_ALIVE            ; is man alive?
                jr nz, __man_is_dead    ; no, explode him!

              __man_is_alive:
                call controller_man_moving  ; do moving (get input from user)

                call controller_man_hit_walls  ; check hit on walls
                call controller_aircon_collision
                call controller_vase_collision

                call controller_eyeball_up  ; eyeball up

                jr __do_animate_eyeball ; do eyeball animation...

              __man_is_dead:

                call controller_man_sound

                call controller_man_exploding  ; display right frame of explosion
                ld a,(man_exploding_frame)  ; get current frame
                cp EXP_FRAMES           ; is finished?

                jr z,__decrease_lifes   ; yes, break this loop

              __do_animate_eyeball:
                ld a,(eyeball_alive)    ; get eyeball status
                cp EYE_ALIVE            ; is eyeball alive?
                jr nz,__eyeball_is_dead ; no, explode it!

              __eyeball_is_alive:
                call controller_eyeball_moving
                call controller_eyeball_collision

                jr __do_animate_screen_objects

              __eyeball_is_dead:

                call controller_eyeball_sound

                call controller_eyeball_exploding  ; explode eyeball
                ld a,(eyeball_exploding_frame)  ; get current frame
                cp EXP_FRAMES           ; is finished?

                jr nz,__do_animate_screen_objects

                call controller_eyeball_create  ; create another eyeball

              __do_animate_screen_objects:
                call controller_teeth_sound
                call controller_teeth_moving
                call controller_teeth_collision

                call controller_score_put  ; update the score
                call controller_screen_update  ; update screen data

              __timer_loop:
                ld a,(vdp_sync_1)
                call temporize_wait       ; wait few "seconds"

                call controller_wall_animate  ; animate walls for next frame
                call controller_sound_off ; disable sound

                jr __game_loop              ; do loop

          __decrease_lifes:

            call controller_sound_off

            ld a,(total_lifes)
            dec a
            cp 0
            jr z,__game_over

            ld (total_lifes),a

            call controller_score_update_lifes  ; update lifes on screen

            jp __lifes_loop             ; back to game

          __game_over:

            call controller_score_put  ; update the score

            call controller_screen_game_over

            ret                         ; end of routine
            endp


            include "engine/_temporize.asm"


            include "engine/aircon.asm"
            include "engine/clothes.asm"
            include "engine/eyeball.asm"
            include "engine/man.asm"
            include "engine/teeth.asm"
            include "engine/vase.asm"