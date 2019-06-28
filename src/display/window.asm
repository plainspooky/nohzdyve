if 0
            word    window_frame=0
endif

WINDOW_WIDTH:       equ 3
WINDOW_HEIGHT:      equ 3
WINDOW_SIZE:        equ WINDOW_WIDTH*WINDOW_HEIGHT

WINDOW_COLUMN:      equ 2
WINDOW_LINE:        equ 8

WINDOW_POSITION:    equ WINDOW_LINE*FB_WIDTH+WINDOW_COLUMN


display_window_put:
            proc

            ld hl,window                ; windows' patterns
            ld a,(window_frame)         ; get current frame

            cp 0
            jr z,__skip                 ; if frame = 0, skip

            ld de,WINDOW_SIZE

          __loop:
                add hl,de               ; 'HL' = 'HL' + 1
                dec a                   ; 'A' = 'A' - 1

                cp 0
                jr nz,__loop            ; do loop,if 'A' != 0

          __skip:
            ex de,hl                    ; swap 'DE' with 'HL'

            ld bc, WINDOW_WIDTH+256*WINDOW_HEIGHT  ; Load 'B' and 'C'
            ld hl,framebuffer+WINDOW_POSITION

            jp framebuffer_put          ; update framebuffer
            endp

window:
            include "display/shapes/window.asm"