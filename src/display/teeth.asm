display_teeth_init:
            proc

            jp display_teeth_reset
            endp


display_teeth_put:
            proc

    __TEETH_FRAMES: equ 4*1             ; 2 frames

            ld a,(teeth_frame)          ; get eye's frame
            cp __TEETH_FRAMES/2
            jr c,__set_frame_1          ; if greater than 2, frame #1

          __set_frame_0:
            ld hl,(__frame_0_a)         ; get sprites for frame #0
            ld de,(__frame_0_b)
            jr __set_sprite             ; go to sprite update

          __set_frame_1:
            ld hl,(__frame_1_a)         ; get sprites for frame #1
            ld de,(__frame_1_b)

          __set_sprite:
            inc a                       ; increment frame number
            and __TEETH_FRAMES-1
            ld (teeth_frame),a          ; store current frame number

            ld ix,TEETH_SPR             ; 'IX' is teeth's sprite plane

            ld (ix+2),l                 ; low-byte is the top left sprite
            ld (ix+6),h                 ; hi-byte is the top right sprite
            ld (ix+10),e                ; low-byte is the bottom left sprite
            ld (ix+14),d                ; hi-byte is the bottom right sprite

            ld a,(teeth_column)         ; get X position

            ld (ix+1),a                 ; at top left sprite
            ld (ix+9),a                 ; at top right sprite
            add a,16                    ; increase X position
            ld (ix+5),a                 ; at bottom left sprite
            ld (ix+13),a                ; at bottom right sprite

            ld a,(teeth_line)           ; get Y position

            ld (ix+0),a                 ; at top left sprite
            ld (ix+4),a                 ; at top right sprite
            add a,16                    ; increment Y position
            ld (ix+8),a                 ; at bottom sprite
            ld (ix+12),a                ; at bottom sprite

            ret                         ; end of routine

          __frame_0_a:
            db 8*4                      ; sprite #10
            db 10*4                     ; sprite #8
          __frame_0_b:
            db 9*4                      ; sprite #11
            db 11*4                     ; sprite #9

          __frame_1_a:
            db 12*4                     ; sprite #12
            db 14*4                     ; sprite #13
          __frame_1_b:
            db 13*4                     ; sprite #14
            db 15*4                     ; sprite #15

            endp


display_teeth_reset:
            proc

            ld ix,TEETH_SPR

            ld (ix+3),0                 ; turn 1st sprite transparent
            ld (ix+7),0                 ; turn 2nd sprite transparent
            ld (ix+11),0                ; turn 3rd sprite transparent
            ld (ix+15),0                ; turn 4th sprite transparent

            ret
            endp