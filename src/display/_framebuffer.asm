if 0
            byte    null_zone_1*96
            byte    framebuffer*768
            byte    null_zone_2*160
            byte    spritebuffer*48
endif


BLANK:      equ 0                       ; character for empty space
FB_WIDTH:   equ 32                      ; width of framebuffer
FB_HEIGHT:  equ 24                      ; height of framebuffer
FB_SIZE:    equ FB_WIDTH*FB_HEIGHT      ; size in tiles of the framebuffer
SB_SIZE:    equ 48                      ; size of spritebuffer in bytes


framebuffer_init:
            proc

            ld de,framebuffer_update_irq  ; call this to update framebuffer
            call hook_at_interrupt      ; hook it on HTIMI (video interrupt)

            jp framebuffer_reset        ; reset framebuffer area
            endp


framebuffer_fill:
            proc

            ld d,a                      ; save 'A' on 'D'

          __loop_y:
                push bc                 ; save 'C', 'B' holds shape's width
                ld a,d                  ; restore 'A' from 'D'

              __loop_x:
                    ld (hl),a           ; put value on on framebuffer
                    inc hl              ; next framebuffer position
                    djnz __loop_x       ; do loop

                pop bc                  ; restore 'BC'
                push bc                 ; save 'BC' (again)
                ld a,WIDTH              ; get framebuffer's width
                sub b                   ; get WIDTH-shape's size
                ld b,a                  ; store it on 'B'

              __loop:
                    inc hl              ; next line of framebuffer
                    djnz __loop         ; do loop

                pop bc                  ; restore 'BC'
                dec c                   ; decremente shapes's height
                ld a,c                  ; store in 'A'
                cp 0                    ; is 0?
                jr nz,__loop_y          ; if not zero, do loop

            ret                         ; end of routine
            endp


framebuffer_print:
            proc

          __loop:
                ld a,(de)               ; get byte from string
                cp 0                    ; is _NULL_?
                ret z                   ; end of routine
                ld (hl),a               ; print on framebuffer
                inc de                  ; increment string pointer
                inc hl                  ; increment framebuffer pointer
                jr __loop               ; do loop
            endp


framebuffer_put:
            proc

          __loop_y:
                push bc                 ; save 'C', 'B' holds shape's width

              __loop_x:
                    ld a,(de)           ; get shape tile
                    ld (hl),a           ; put on framebuffer
                    inc hl              ; next framebuffer position
                    inc de              ; next shape's tile
                    djnz __loop_x       ; do loop

                pop bc                  ; restore 'BC'
                push bc                 ; save 'BC' (again)
                ld a,WIDTH              ; get framebuffer's width
                sub b                   ; get WIDTH-shape's size
                ld b,a                  ; store it on 'B'

              __loop:
                    inc hl              ; next line of framebuffer
                    djnz __loop         ; do loop

                pop bc                  ; restore 'BC'
                dec c                   ; decremente shapes's height
                ld a,c                  ; store in 'A'
                cp 0                    ; is 0?
                jr nz,__loop_y          ; if not zero, do loop

            ret                         ; end of routine
            endp


framebuffer_reset:
            proc
            local clear_loop

            ld hl,spritebuffer          ; start of sprite buffer

            ld b,32                     ; number of sprites planes

          __loop0:
                ld a,-32                ; (-32, -32), out of screen
            rept 2
                ld (hl),a               ; 'HL' <- 'A'
                inc hl                  ; 'HL'++
            endm
                xor a                   ; 'A' = 0, transparent
            rept 2
                ld (hl),a               ; 'HL' <- 'A'
                inc hl                  ; 'HL'++
            endm
                djnz __loop0            ; do lopp

            ld a,BLANK                  ; character to fill screen
            ld hl,framebuffer           ; framebuffer address

        rept (FB_SIZE/256)-1
            call clear_loop             ; clear 256 bytes of screen
        endm

            clear_loop:
            ld b,256                    ; total of 256 bytes
          __loop1:
                ld (hl),a               ; write on framebuffer
                inc hl                  ; increase pointer
                djnz __loop1            ; do loop

            ret                         ; return / end of routine
            endp


framebuffer_update:
            proc

            ld a,$cd                    ; this is a "CALL"
            ld (HTIMI),a                ; enable framebuffer update

            ret                         ; end of routine


framebuffer_update_irq:
            ld bc,FB_SIZE               ; size of framebuffer
            ld de,NAMES                 ; name's table on VRAM
            ld hl,framebuffer           ; framebuffer address
            call LDIRVM                 ; copy RAM to VRAM

            ld bc,SB_SIZE               ; size of spritebuffer
            ld de,SPR_NAMES             ; sprite's names on VRAM
            ld hl,spritebuffer          ; spritebuffer address
            call LDIRVM                 ; copy RAM to VRAM

            ld a,$c9                    ; "RET"
            ld (HTIMI),a                ; disable framebuffer interrupt

            ret                         ; end of routine
            endp