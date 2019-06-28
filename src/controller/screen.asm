if 0
            byte    jump_frame=
            word    scroller_cursor=
endif


controller_screen_init:
            proc

            jp display_init             ; init display module
            endp


controller_screen_opening:
            proc

            ld hl,scroller_message      ; reset position on scroller
            ld (scroller_cursor),hl     ; and save on "scroller_cursor"

            jp display_screen_opening  ; display opening screen
            endp


controller_screen_opening_animation:
            proc

            call display_screen_opening_animation

            jp get_strig
            endp


controller_screen_opening_clear:
            proc

            jp display_screen_opening_clear
            endp


controller_screen_game_over:
            proc

            call display_eyeball_reset
            call display_teeth_reset

            call display_screen_game_over

          __loop:
                call temporize_init

                call get_strig
                ret z                   ; end of routine

                ld a,(vdp_sync_2)
                call temporize_wait

                jr __loop
            endp


controller_screen_update:
            proc

            jp framebuffer_update       ; update screen
            endp