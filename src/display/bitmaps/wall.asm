WALL_TILES_SIZE: equ 256

            db $00                      ; 00000000 | ░░░░░░░░   $00
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░

            db $f7                      ; 11110111 | ████░███   $01
            db $f7                      ; 11110111 | ████░███
            db $00                      ; 00000000 | ░░░░░░░░
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████

            db $ff                      ; 11111111 | ████████   $02
            db $ff                      ; 11111111 | ████████
            db $00                      ; 00000000 | ░░░░░░░░
            db $df                      ; 11011111 | ██░█████
            db $df                      ; 11011111 | ██░█████
            db $df                      ; 11011111 | ██░█████
            db $df                      ; 11011111 | ██░█████
            db $df                      ; 11011111 | ██░█████

            db $00                      ; 00000000 | ░░░░░░░░   $03
            db $f7                      ; 11110111 | ████░███
            db $f7                      ; 11110111 | ████░███
            db $f7                      ; 11110111 | ████░███
            db $f7                      ; 11110111 | ████░███
            db $f7                      ; 11110111 | ████░███
            db $00                      ; 00000000 | ░░░░░░░░
            db $ff                      ; 11111111 | ████████

            db $00                      ; 00000000 | ░░░░░░░░   $04
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $00                      ; 00000000 | ░░░░░░░░
            db $df                      ; 11011111 | ██░█████

            db $ff                      ; 11111111 | ████████   $05
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $00                      ; 00000000 | ░░░░░░░░
            db $f7                      ; 11110111 | ████░███
            db $f7                      ; 11110111 | ████░███
            db $f7                      ; 11110111 | ████░███

            db $df                      ; 11011111 | ██░█████   $06
            db $df                      ; 11011111 | ██░█████
            db $df                      ; 11011111 | ██░█████
            db $df                      ; 11011111 | ██░█████
            db $00                      ; 00000000 | ░░░░░░░░
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████

            db $f7                      ; 11110111 | ████░███   $07
            db $f7                      ; 11110111 | ████░███
            db $00                      ; 00000000 | ░░░░░░░░
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████

            db $ff                      ; 11111111 | ████████   $08
            db $ff                      ; 11111111 | ████████
            db $00                      ; 00000000 | ░░░░░░░░
            db $df                      ; 11011111 | ██░█████
            db $df                      ; 11011111 | ██░█████
            db $df                      ; 11011111 | ██░█████
            db $df                      ; 11011111 | ██░█████
            db $df                      ; 11011111 | ██░█████

            db $00                      ; 00000000 | ░░░░░░░░   $09
            db $f7                      ; 11110111 | ████░███
            db $f7                      ; 11110111 | ████░███
            db $f7                      ; 11110111 | ████░███
            db $f7                      ; 11110111 | ████░███
            db $f7                      ; 11110111 | ████░███
            db $00                      ; 00000000 | ░░░░░░░░
            db $ff                      ; 11111111 | ████████

            db $00                      ; 00000000 | ░░░░░░░░   $0a
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $00                      ; 00000000 | ░░░░░░░░
            db $df                      ; 11011111 | ██░█████

            db $ff                      ; 11111111 | ████████   $0b
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $00                      ; 00000000 | ░░░░░░░░
            db $f7                      ; 11110111 | ████░███
            db $f7                      ; 11110111 | ████░███
            db $f7                      ; 11110111 | ████░███

            db $df                      ; 11011111 | ██░█████   $0c
            db $df                      ; 11011111 | ██░█████
            db $df                      ; 11011111 | ██░█████
            db $df                      ; 11011111 | ██░█████
            db $00                      ; 00000000 | ░░░░░░░░
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████

            db $ff                      ; 11111111 | ████████   $0d
            db $ff                      ; 11111111 | ████████
            db $00                      ; 00000000 | ░░░░░░░░
            db $99                      ; 10011001 | █░░██░░█
            db $99                      ; 10011001 | █░░██░░█
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████

            db $00                      ; 00000000 | ░░░░░░░░   $0e
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $00                      ; 00000000 | ░░░░░░░░

            db $00                      ; 00000000 | ░░░░░░░░   $0f
            db $f8                      ; 11111000 | █████░░░
            db $f8                      ; 11111000 | █████░░░
            db $f8                      ; 11111000 | █████░░░
            db $f8                      ; 11111000 | █████░░░
            db $f0                      ; 11110000 | ████░░░░
            db $e0                      ; 11100000 | ███░░░░░
            db $00                      ; 00000000 | ░░░░░░░░

            db $c0                      ; 11000000 | ██░░░░░░   $10
            db $80                      ; 10000000 | █░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░

            db $03                      ; 00000011 | ░░░░░░██   $11
            db $01                      ; 00000001 | ░░░░░░░█
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░

            db $00                      ; 00000000 | ░░░░░░░░   $12
            db $1f                      ; 00011111 | ░░░█████
            db $1f                      ; 00011111 | ░░░█████
            db $1f                      ; 00011111 | ░░░█████
            db $1f                      ; 00011111 | ░░░█████
            db $0f                      ; 00001111 | ░░░░████
            db $07                      ; 00000111 | ░░░░░███
            db $00                      ; 00000000 | ░░░░░░░░

            db $00                      ; 00000000 | ░░░░░░░░   $13
            db $00                      ; 00000000 | ░░░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░

            db $40                      ; 01000000 | ░█░░░░░░   $14
            db $00                      ; 00000000 | ░░░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░

            db $40                      ; 01000000 | ░█░░░░░░   $15
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░

            db $00                      ; 00000000 | ░░░░░░░░   $16
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░

            db $40                      ; 01000000 | ░█░░░░░░   $17
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░

            db $73                      ; 01110011 | ░███░░██   $18
            db $70                      ; 01110000 | ░███░░░░
            db $70                      ; 01110000 | ░███░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░

            db $00                      ; 00000000 | ░░░░░░░░   $19
            db $00                      ; 00000000 | ░░░░░░░░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░

            db $02                      ; 00000010 | ░░░░░░█░   $1a
            db $00                      ; 00000000 | ░░░░░░░░
            db $02                      ; 00000010 | ░░░░░░█░
            db $00                      ; 00000000 | ░░░░░░░░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░

            db $02                      ; 00000010 | ░░░░░░█░   $1b
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░

            db $00                      ; 00000000 | ░░░░░░░░   $1c
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░

            db $02                      ; 00000010 | ░░░░░░█░   $1d
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░
            db $00                      ; 00000000 | ░░░░░░░░

            db $ce                      ; 11001110 | ██░░███░   $1e
            db $0e                      ; 00001110 | ░░░░███░
            db $0e                      ; 00001110 | ░░░░███░
            db $00                      ; 00000000 | ░░░░░░░░
            db $02                      ; 00000010 | ░░░░░░█░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░

            db $55                      ; 01010101 | ░█░█░█░█   $1f
            db $aa                      ; 10101010 | █░█░█░█░
            db $55                      ; 01010101 | ░█░█░█░█
            db $aa                      ; 10101010 | █░█░█░█░
            db $55                      ; 01010101 | ░█░█░█░█
            db $aa                      ; 10101010 | █░█░█░█░
            db $55                      ; 01010101 | ░█░█░█░█
            db $aa                      ; 10101010 | █░█░█░█░