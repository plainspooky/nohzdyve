#!/usr/bin/env python
"""
    Converts a 256x192 1 bpp Windows Bitmap file into a SCREEN 2 MSX
    loadable using BASIC's BLOAD "",S statement.
"""
# -*- coding: utf-8 -*-


import sys


def main(ifile, ofile):
    """ Main function """
    pattern_table = bytearray(b" " * 6144)

    with open(ifile, "rb") as source:
        __ = source.read(130)
        bmp_data = source.read(6144)
    source.close()

    pos_1 = 0
    for j in range(0, 6144, 256):
        for i in range(8):
            for k in range(32):
                pos_2 = j + i + k * 8
                pattern_table[pos_2] = bmp_data[pos_1]
                pos_1 += 1

    with open(ofile, "wb") as dest:
        for header in (0xFE, 0x00, 0x00, 0xFF, 0x17, 0x00, 0x00):
            dest.write(chr(header))
        dest.write(pattern_table)
    dest.close()


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
