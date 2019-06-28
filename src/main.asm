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

            include "__macros.asm"      ; macros
            include "__config.asm"      ; build configuration

            include "../src/libraries/__msx1bios.asm"
            include "../src/libraries/__msx1variables.asm"
            include "../src/libraries/__msx1hooks.asm"


main:
            proc

            include "__variables.asm"   ; automatically generated!

            call INITIO                 ; restart PSG ports and
            call GICINI                 ; restart PSG registers as well

            call engine_init            ; start game

          __loop:
            jr __loop                   ; avoid game to back to MSX-BASIC

            endp


            include "controller/__main.asm"
            include "display/__main.asm"
            include "engine/__main.asm"