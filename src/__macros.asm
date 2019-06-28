macro   m___push_all
            push af
            push bc
            push de
            push hl
            push ix
            push iy
            endm

macro   m___pop_all
            pop iy
            pop ix
            pop hl
            pop de
            pop bc
            pop af
            endm
