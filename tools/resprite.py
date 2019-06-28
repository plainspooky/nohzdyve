#!/usr/bin/env python
"""
    Reorganizes two bitmap structures with 256 bytes into a TMS99x8's
    sprite structure.
"""
from sys import argv


def main():
    """ Main function """
    first_line = argv[1]
    second_line = argv[2]
    destination_file = argv[3]

    first_bank = bytearray(open(first_line, "rb").read())
    second_bank = bytearray(open(second_line, "rb").read())

    with open(destination_file, "wb") as export_bank:
        for i in range(0, 256, 8):
            export_bank.write(first_bank[i : i + 8])
            export_bank.write(second_bank[i : i + 8])


if __name__ == "__main__":
    main()
