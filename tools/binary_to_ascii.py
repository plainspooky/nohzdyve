#!/usr/bin/env python3
"""
    Converts a binary file in a ASCII representation that is more
    human readable.
"""
from codecs import decode
from sys import argv

TABS = (" " * 12, " " * 22)
TILE_SIZE = 8
UNI_BLOCKS = [decode(i, encoding="unicode_escape") for i in ["\\u2591", "\\u2588"]]


def convert_bin_to_ascii(bitmap_raw, print_offset=False, char_offset=None):
    """ Converts a binary array in an ASCII representation that is more
    human friendy, receives the binary array as `bitmap_raw` and, optionally,
    `print_offset` to enable printing of character and ASCII code of it as
    `char_offset`. Returns a string. """

    # reset tile counter
    tile_counter = 0

    output_file = ""

    for byte_raw in bitmap_raw:

        # convert tile on a unicode based representation.
        bitmap_value = "".join(
            UNI_BLOCKS[1] if i == "1" else UNI_BLOCKS[0] for i in f"{byte_raw:08b}"
        )

        # format line and write it on file.
        output_file += (
            f"{TABS[0]}db ${byte_raw:02x}{TABS[1]}; {byte_raw:08b} | {bitmap_value}"
        )

        if tile_counter == 0 and print_offset:
            output_file += f"   ${char_offset:02x}\n"
            char_offset += 1

        else:
            output_file += "\n"

        # do a new line for every new tile...
        tile_counter += 1

        if tile_counter == TILE_SIZE:
            output_file += "\n"
            tile_counter = 0

    return output_file


def main():
    """ Main function. """
    old_file = argv[1]

    try:
        # it's optional!
        char_off, print_off = int("0x" + argv[2], 16) & 255, True

    except IndexError:
        char_off, print_off = None, False

    if "." in old_file:
        # file does has an extension.
        filename, __ = old_file.split(".")
    else:
        # file doesn't has an extension.
        filename = old_file

    # new filename is always an ASM file
    new_file = filename + ".asm"

    # read file
    bitmap_raw = bytearray(open(old_file, "rb").read())

    # write file
    with open(new_file, "w") as i:
        i.write("{}_TILES_SIZE: equ {}\n\n".format(filename.upper(), len(bitmap_raw)))
        i.write(convert_bin_to_ascii(bitmap_raw, print_off, char_off))

    print(f"{new_file} created.")


if __name__ == "__main__":
    main()
