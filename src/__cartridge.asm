;
;   NOHZDYVE for MSX
;
;   Copyright (C) 2019  Giovanni Nunes <giovanni.nunes@gmail.com>
;
;   This is a version of Nohzdyve game for MSX computers written by
;   scratch. It didn't use any routines from the original speccy game,
;   only few graphics (re)imported by screenshots.
;
;   Nohzdyve is a game created in conjunction with the interactive TV
;   program 'Black Mirror: Bandersnatch' by Matt Westcott, Clayton
;   McDermott and with Brian Reitzell for ZX spectrum computers.
;
;   This program is free software: you can redistribute it and/or
;   modify it under the terms of the GNU General Public License as
;   published by the Free Software Foundation, either version 3 of the
;   License, or (at your option) any later version.
;
;   This program is distributed in the hope that it will be useful,
;   but WITHOUT ANY WARRANTY; without even the implied warranty of
;   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;   GNU General Public License for more details.
;
;   You should have received a copy of the GNU General Public License
;   along with this program.  If not, see http://www.gnu.org/licenses/
;

rom_size:   equ 8192
rom_area:   equ $4000
ram_area:   equ $e000


__VERSION:  equ 1
__RELEASE:  equ 0


            org rom_area

            db "AB"                     ; cartridge header
            dw start_code               ; execution address
            db "CW"                     ; "Crunchworks"
            db "05"                     ; "Nohzdyve"
            db __VERSION+48             ; code version (1 byte)
            db __RELEASE+65             ; code release (1 byte)

            ds 6,0                      ; left blank, don't touch!


start_code:
            include "main.asm"


rom_pad:
            ds rom_size-(rom_pad-rom_area),$00  ; pad to fit in ROM size

            end
