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

game_area:  equ $8000
ram_area:   equ $e000


            org game_area-7

            db $fe                      ; MSX-BASIC binary header
            dw start_code                ; start address
            dw end_code                 ; end address
            dw exec_code                ; execution address


start_code:

    __VERSION:  equ 1
    __RELEASE:  equ 0

            db "CW"                     ; "Crunchworks"
            db "05"                     ; "Nohzdyve"
            db __VERSION+48             ; code version (1 byte)
            db __RELEASE+65             ; code release (1 byte)

           
exec_code:
            include "main.asm"

end_code:
            end
