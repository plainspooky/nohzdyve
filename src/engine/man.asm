HIT_WALL_LEFT:      equ 20
HIT_WALL_RIGHT:     equ 220

MAN_START_COLUMN:   equ 132
MAN_START_LINE:     equ 80


engine_man_jumping:
            proc

    __MAN_JUMP_COL: equ 24
    __MAN_JUMP_ROW: equ 63

            xor a
            ld (man_frame_jump),a       ; reset frame animation

            ld a,__MAN_JUMP_ROW
            ld (man_line),a

            ld a,__MAN_JUMP_COL
            ld (man_column),a

          __loop:
                call temporize_reset

                ld hl,man_frame_jump
                ld a,(hl)

                inc (hl)

                cp 0                    ; window's frame 0
                jr z,__open_window

                cp 1                    ; window's frame 1
                jr z,__open_window_1

                cp 2                    ; man jumping
                jr z,__jump_animation

                cp 3
                jr z,__open_window      ; window's frame 0

                cp 4
                jr z,__close_window     ; close window

                cp 5
                jp z,display_man_hide_lines  ; end of routine (last frame)

              __skip:
                call controller_screen_update  ; update screen

                ld a,(vdp_sync_1)
                call temporize_wait     ; wait few "seconds"

                jr __loop

          __open_window:
            xor a                       ; frame 0

          __open_window_skip:
            ld (window_frame),a         ; set window frame
            call display_window_put     ; write on framebuffer

            jr __skip                   ; back to main routine

          __open_window_1:
            ld a,1                      ; frame 1
            jr __open_window_skip       ; write on framebuffer

          __close_window:
            ld a,2                      ; set window frame
            jr __open_window_skip       ; write on framebuffer

            jr __skip                   ; back to main routine

          __jump_animation:
            call display_man_jumping    ; display man jumping

            ld a,(man_column)           ; get current column
            push af                     ; save 'AF'

            cp __MAN_JUMP_COL+40        ; is 40 pixels from initial position?
            call nc,display_man_show_lines  ; yes, write speed lines

            pop af                      ; restore 'AF'
            add a,8                     ; 'A' = 'A' + 8
            cp MAN_COLUMN               ; 'A' < MAN_COLUMN?
            jr nc,__skip                ; do loop and end jump

            ld (man_column),a           ; save new man's position

            ld hl,man_frame_jump        ; decrease frame animation to
            dec (hl)                    ; back to here next time!

            jr __skip                   ; back to main routine
            endp


engine_man_reset:
            proc

            ld a,MAN_START_LINE         ; put man in this initial line
            ld (man_line),a

            ld a,MAN_START_COLUMN       ; put man in this initial column
            ld (man_column),a

            jp controller_man_reset     ; reset man at controller
            endp