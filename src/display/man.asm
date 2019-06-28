MAN_COLOR_TOP:                          equ 14
MAN_COLOR_BOT:                          equ 15

MAN_COLOR_SPEED_LINES:                  equ 7


display_man_init:
            proc

            jp display_man_reset        ; reset man's position
            endp


display_man_falling:
            proc

    __MAN_FRAMES: equ 2*2               ; 2 frames + 2 repeats

            ld a,(man_frame)            ; get man's frame
            cp __MAN_FRAMES/2
            jr c,__set_frame_1          ; if greater than 2, frame #1

          __set_frame_0:
            ld hl,(__frame_0)           ; get 1st sprite for frame #0
            jr __set_sprite             ; go to sprite update

          __set_frame_1:
            ld hl,(__frame_1)           ; get 1st sprite for frame #0

          __set_sprite:
            inc a                       ; increment frame number
            and __MAN_FRAMES-1
            ld (man_frame),a            ; store current frame number

            jp display_man_put

          __frame_0:
            db 2*4                      ; sprite #2
            db 3*4                      ; sprite #3

          __frame_1:
            db 4*4                      ; sprite #4
            db 5*4                      ; sprite #5

            endp


display_man_jumping:
            proc

            ld hl,(__man_jumping)
            jp display_man_put

          __man_jumping:
            db 0*4                      ; sprite #0
            db 1*4                      ; sprite #1

            endp


display_man_put:
            proc

            ld ix,MAN_SPR               ; 'IX' is man's sprite plane

            ld (ix+2),l                 ; low-byte is the top sprite
            ld (ix+6),h                 ; hi-byte is the bottom sprite

            ld a,(man_column)           ; update X position
            ld (ix+1),a                 ; at top sprite
            ld (ix+5),a                 ; at bottom sprite

            ld a,(man_line)             ; update Y position
            ld (ix+0),a                 ; at top sprite
            add a,16                    ; increment Y position
            ld (ix+4),a                 ; at bottom sprite

            ret                         ; end of routine
            endp


display_man_hide_lines:
            proc

    __START_ROW:    equ 191

            ld ix,MAN_SPR+8

            ld (ix+0),__START_ROW
            ld (ix+4),__START_ROW

            ret                         ; end of routine
            endp

display_man_show_lines:
            proc

            ld hl,(__speed_lines)       ; sprites from speed lines

            ld ix,MAN_SPR+8             ; set 'IX' to man's sprite layer

            ld (ix+2),l                 ; set sprite patterns
            ld (ix+6),h

            ld a,(man_column)           ; get man column
            sub 24                      ; coulum = column - 24
            ld (ix+1),a                 ; update column
            sub 16                      ; column = column - 24 - 16
            ld (ix+5),a                 ; update column

            ld a,(man_line)             ; get man line
            add a,8                     ; line = lines + 8
            ld (ix+0),a                 ; update line
            ld (ix+4),a                 ; update line

            ret                         ; end of routine

          __speed_lines:
            db 7*4
            db 6*4

            endp


display_man_reset:
            proc

    __START_ROW:    equ 191

            ld ix,MAN_SPR               ; man's sprite position
            ld (ix+0),__START_ROW       ; out of screen
            ld (ix+3),MAN_COLOR_TOP     ; set color of sprite
            ld (ix+4),__START_ROW       ; out of screen
            ld (ix+7),MAN_COLOR_BOT     ; set color of sprite

            ld (ix+8),__START_ROW
            ld (ix+11),MAN_COLOR_SPEED_LINES
            ld (ix+12),__START_ROW
            ld (ix+15),MAN_COLOR_SPEED_LINES

            ret                         ; end of routine
            endp