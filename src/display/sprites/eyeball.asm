EYEBALL_TILES_SIZE: equ 160

            db $07                      ; 00000111 | ░░░░░███
            db $1f                      ; 00011111 | ░░░█████
            db $3c                      ; 00111100 | ░░████░░
            db $78                      ; 01111000 | ░████░░░
            db $7f                      ; 01111111 | ░███████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████

            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $7f                      ; 01111111 | ░███████
            db $75                      ; 01110101 | ░███░█░█
            db $3a                      ; 00111010 | ░░███░█░
            db $1d                      ; 00011101 | ░░░███░█
            db $07                      ; 00000111 | ░░░░░███

            db $e0                      ; 11100000 | ███░░░░░
            db $f8                      ; 11111000 | █████░░░
            db $3c                      ; 00111100 | ░░████░░
            db $1e                      ; 00011110 | ░░░████░
            db $fe                      ; 11111110 | ███████░
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████
            db $ff                      ; 11111111 | ████████

            db $fd                      ; 11111101 | ██████░█
            db $ff                      ; 11111111 | ████████
            db $f5                      ; 11110101 | ████░█░█
            db $ea                      ; 11101010 | ███░█░█░
            db $56                      ; 01010110 | ░█░█░██░
            db $ac                      ; 10101100 | █░█░██░░
            db $58                      ; 01011000 | ░█░██░░░
            db $e0                      ; 11100000 | ███░░░░░

            db $10                      ; 00010000 | ░░░█░░░░
            db $1b                      ; 00011011 | ░░░██░██
            db $09                      ; 00001001 | ░░░░█░░█
            db $04                      ; 00000100 | ░░░░░█░░
            db $04                      ; 00000100 | ░░░░░█░░
            db $04                      ; 00000100 | ░░░░░█░░
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░

            db $04                      ; 00000100 | ░░░░░█░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $01                      ; 00000001 | ░░░░░░░█
            db $01                      ; 00000001 | ░░░░░░░█
            db $02                      ; 00000010 | ░░░░░░█░
            db $00                      ; 00000000 | ░░░░░░░░

            db $08                      ; 00001000 | ░░░░█░░░
            db $d8                      ; 11011000 | ██░██░░░
            db $d0                      ; 11010000 | ██░█░░░░
            db $d0                      ; 11010000 | ██░█░░░░
            db $a0                      ; 10100000 | █░█░░░░░
            db $a0                      ; 10100000 | █░█░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░

            db $80                      ; 10000000 | █░░░░░░░
            db $80                      ; 10000000 | █░░░░░░░
            db $80                      ; 10000000 | █░░░░░░░
            db $80                      ; 10000000 | █░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░

            db $10                      ; 00010000 | ░░░█░░░░
            db $1b                      ; 00011011 | ░░░██░██
            db $0b                      ; 00001011 | ░░░░█░██
            db $0b                      ; 00001011 | ░░░░█░██
            db $05                      ; 00000101 | ░░░░░█░█
            db $05                      ; 00000101 | ░░░░░█░█
            db $02                      ; 00000010 | ░░░░░░█░
            db $02                      ; 00000010 | ░░░░░░█░

            db $01                      ; 00000001 | ░░░░░░░█
            db $01                      ; 00000001 | ░░░░░░░█
            db $01                      ; 00000001 | ░░░░░░░█
            db $01                      ; 00000001 | ░░░░░░░█
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░

            db $08                      ; 00001000 | ░░░░█░░░
            db $d8                      ; 11011000 | ██░██░░░
            db $90                      ; 10010000 | █░░█░░░░
            db $20                      ; 00100000 | ░░█░░░░░
            db $20                      ; 00100000 | ░░█░░░░░
            db $20                      ; 00100000 | ░░█░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░

            db $20                      ; 00100000 | ░░█░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $80                      ; 10000000 | █░░░░░░░
            db $80                      ; 10000000 | █░░░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░

            db $10                      ; 00010000 | ░░░█░░░░
            db $1b                      ; 00011011 | ░░░██░██
            db $0b                      ; 00001011 | ░░░░█░██
            db $03                      ; 00000011 | ░░░░░░██
            db $06                      ; 00000110 | ░░░░░██░
            db $04                      ; 00000100 | ░░░░░█░░
            db $08                      ; 00001000 | ░░░░█░░░
            db $09                      ; 00001001 | ░░░░█░░█

            db $15                      ; 00010101 | ░░░█░█░█
            db $14                      ; 00010100 | ░░░█░█░░
            db $10                      ; 00010000 | ░░░█░░░░
            db $10                      ; 00010000 | ░░░█░░░░
            db $08                      ; 00001000 | ░░░░█░░░
            db $04                      ; 00000100 | ░░░░░█░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░

            db $08                      ; 00001000 | ░░░░█░░░
            db $d8                      ; 11011000 | ██░██░░░
            db $90                      ; 10010000 | █░░█░░░░
            db $20                      ; 00100000 | ░░█░░░░░
            db $40                      ; 01000000 | ░█░░░░░░
            db $80                      ; 10000000 | █░░░░░░░
            db $80                      ; 10000000 | █░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░

            db $00                      ; 00000000 | ░░░░░░░░
            db $80                      ; 10000000 | █░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░

            db $10                      ; 00010000 | ░░░█░░░░
            db $1b                      ; 00011011 | ░░░██░██
            db $09                      ; 00001001 | ░░░░█░░█
            db $04                      ; 00000100 | ░░░░░█░░
            db $02                      ; 00000010 | ░░░░░░█░
            db $01                      ; 00000001 | ░░░░░░░█
            db $01                      ; 00000001 | ░░░░░░░█
            db $00                      ; 00000000 | ░░░░░░░░

            db $00                      ; 00000000 | ░░░░░░░░
            db $01                      ; 00000001 | ░░░░░░░█
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░

            db $08                      ; 00001000 | ░░░░█░░░
            db $d8                      ; 11011000 | ██░██░░░
            db $d0                      ; 11010000 | ██░█░░░░
            db $c0                      ; 11000000 | ██░░░░░░
            db $60                      ; 01100000 | ░██░░░░░
            db $20                      ; 00100000 | ░░█░░░░░
            db $10                      ; 00010000 | ░░░█░░░░
            db $90                      ; 10010000 | █░░█░░░░

            db $a8                      ; 10101000 | █░█░█░░░
            db $28                      ; 00101000 | ░░█░█░░░
            db $08                      ; 00001000 | ░░░░█░░░
            db $08                      ; 00001000 | ░░░░█░░░
            db $10                      ; 00010000 | ░░░█░░░░
            db $20                      ; 00100000 | ░░█░░░░░
            db $00                      ; 00000000 | ░░░░░░░░
            db $00                      ; 00000000 | ░░░░░░░░