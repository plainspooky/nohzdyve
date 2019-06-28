EYE_COLOR_TOP:  equ 15
EYE_COLOR_BOT:  equ 8


display_eyeball_init:
            proc

            jp display_eyeball_reset    ; go to reset routine
            endp


display_eyeball_put:
            proc

    __EYE_FRAMES: equ 2*2               ; 2 frames + 2 repeats

            ld a,(eye_frame)            ; get eye's frame
            cp __EYE_FRAMES/2
            jr c,__set_frame_1          ; if greater than 2, frame #1

          __set_frame_0:
            ld hl,(__frame_l0)          ; set 'HL' with left frame 0
            ld de,(__frame_r0)          ; set 'DE' with left frame 0
            jr __set_sprite             ; go to sprite update

          __set_frame_1:
            ld hl,(__frame_l1)          ; set 'HL' with left frame 1
            ld de,(__frame_r1)          ; set 'DE' with left frame 1

          __set_sprite:
            inc a                       ; increment frame number
            and __EYE_FRAMES-1
            ld (eye_frame),a            ; store current frame number

            ld a,(eyeball_direction)    ; check eyeball direction
            cp EYE_LEFT                 ; is going to the left?
            jr z, __skip_exchange       ; skip register exchange

            ex de,hl                    ; exchange if is going to the right

          __skip_exchange:
            ld ix,EYE_SPR               ; set sprite position

            ld (ix+2),l                 ; low-byte is the top sprite
            ld (ix+6),h                 ; hi-byte is the bottom sprite

            ld a,(eyeball_column)       ; update X position
            ld (ix+1),a                 ; at top sprite
            ld (ix+5),a                 ; at bottom sprite

            ld a,(eyeball_line)         ; update Y position
            ld (ix+0),a                 ; at top sprite
            add a,16                    ; increment Y position
            ld (ix+4),a                 ; at bottom sprite

            ret                         ; end of routine

          __frame_l0:
            db 16*4                      ; sprite #16
            db 18*4                      ; sprite #18

          __frame_l1:
            db 16*4                      ; sprite #16
            db 20*4                      ; sprite #20

          __frame_r0:
            db 16*4                      ; sprite #16
            db 17*4                      ; sprite #17

          __frame_r1:
            db 16*4                      ; sprite #16
            db 19*4                      ; sprite #19

            endp


display_eyeball_reset:
            proc

    __START_ROW:    equ 191
    __START_COL:    equ 0

            ld ix,EYE_SPR

            ld (ix+0),__START_ROW
            ld (ix+1),__START_COL

            ld (ix+4),__START_ROW+16
            ld (ix+5),__START_COL

            ld (ix+8),-32
            ld (ix+9),__START_COL

            ld (ix+12),-32
            ld (ix+13),__START_COL

            ret
            endp