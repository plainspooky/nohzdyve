#!/usr/bin/env python
"""
make_variables.py
This tool automatically creates definition and initialization statments for
"variables" on assembly source code. I've written it during the MSX port of
Scuttlebutt as a helper.
"""
from __future__ import print_function
from fnmatch import fnmatch
from os import listdir, path
from sys import argv

import logging
import re

# source code processing
IGNORE_FLAG = ".novars"
RAMTOP = "ram_area"
REGEX = "^ +?(byte|word) +([a-z0-9_]+)(=|\\*)([A-z0-9%$_]+)?"
SOURCE_FILE = "*.asm"
START_VARS = "if 0"
STOP_VARS = "endif"

# code generation format
REGISTER_16BIT = "hl"
REGISTER_8BIT = "a"
TABULATION = (12, 32, 52, 56, 64)


def format_declarations(offset, variable_list):
    """ Create the 'variable declaration', receive a byte offset in `offset`
    and a list of variables in `variable_ist`. Return an assembly line of
    code properlly formated:

    ```
    1 --------> 12 ---------------> 32
                variable_name:      equ <RAMTOP>+<offset>
    ```

    If variable name doesn't fit, a simple blank space will be used instead of
    a tabulation mark."""

    declarations = ""

    for var in variable_list:
        size = var.get("size")

        line = tabulate_line(0) + "%s:" % var.get("name")
        line += tabulate_line(1, line) + "equ %s+%d" % (RAMTOP, offset)
        line += tabulate_line(2, line) + "; (%d byte%s)\n" % (
            size,
            "s" if size > 1 else "",
        )

        offset += size
        declarations += line

    return declarations


def format_initialization(variable_list):
    """ Create a 'variable initialization' assigin the correct value to it,
    format binary and hexadecimal values as well and use 'A' register for the
    8-bit values and 'HL' for 16-bit:
    ```
    1 --------> 12
                ld a,<initial value>
                ld (<variable_name>),a

                ld hl,<initial value>
                ld (<variable_name>),a
    ```
    There is no much assembly code optimizing in this part.
    """

    def format_value(base, value, datatype):
        """ Format a value in `value` using its numeric base in `base` and
        datatype in `database`. Return the value formated as a str. """
        if base == "bin":
            size_str = 16 if datatype == "word" else 8
            format_str = "%{:0" + str(size_str) + "b}"
        elif base == "hex":
            size_str = 4 if datatype == "word" else 2
            format_str = "${:0" + str(size_str) + "x}"
        elif base == "label":
            format_str = "{}"
        else:
            return str(value)

        return format_str.format(value)

    initialization = ""

    for var in variable_list:

        if var.get("assign") == "=":
            base = var.get("base")
            datatype = var.get("datatype")
            init = var.get("init")
            name = var.get("name")
            value = var.get("value")

            if init:
                register = REGISTER_16BIT if datatype == "word" else REGISTER_8BIT
                line = tabulate_line(0)
                line += "ld %s,%s\n" % (register, format_value(base, value, datatype))
                line += tabulate_line(0) + "ld (%s),%s\n\n" % (name, register)

                initialization += line

    return initialization


def get_files(directory_list):
    """ (Generator) Get files from selected directories. Receive a list of
    directories in `directory_list`. """

    def check_directories(dirs):
        """ (Generator) Check if each directory from a list in `dirs` can be
        read (it exists) and if there is a file that flags it to be
        ignored. """
        for directory in dirs:
            if path.isdir(directory) and not path.isfile(
                path.join(directory, IGNORE_FLAG)
            ):
                yield directory

    for directory in check_directories(directory_list):
        for filename in listdir(directory):
            if fnmatch(filename, SOURCE_FILE):
                yield path.join(directory, filename)


def parse_file(filename, re_obj):
    """ (Generator) Parse the assembler source code and extract variable
    definitions from it. Receives a file to read in `filename`, the REGEX
    object in `re_obj`. Return a dictionary with the following keys:

    * `assign` : '=' if is a variables or '*' if is an array;
    * `base` : numerical base (binary, decimal, hex or a label);
    * `datatype` : 'byte' for 8-bit values or 'word' for 16-bits;
    * `init` : _True_ if variable need initialization of _False_ if not;
    * `name` : variable name;
    * `size` : size of variable in bytes and
    * `value` : initial value of variable (optiomal). """

    def check_value(value):
        """ Check the numerical base of value in `value`. Return its numerical
        base ('bin', 'dec', 'hex' or 'label') and its real value (decoded).
        Will raise a `ValueError` exception if value can't be recognized. """

        if value.startswith("0x"):
            base = "hex"
            real_value = int(value, 16)
        elif value.startswith("$"):
            base = "hex"
            real_value = int(value[1:], 16)
        elif value.startswith("0b"):
            base = "bin"
            real_value = int(value, 2)
        elif value.startswith("%"):
            base = "bin"
            real_value = int(value[1:], 2)
        elif value.isdigit():
            base = "dec"
            real_value = int(value)
        elif value == "" or not value.isdigit():
            base = "label"
            real_value = value
        else:
            raise ValueError('Not recognize what "%s" is!' % value)

        return base, real_value

    def build_dict(datatype, name, assign, value):
        """ Get values read from file and properlly format as a dictionary
        object, receive `datatype`, `name`, `assign` and `value`; calculate
        real size of it and fill its value. """

        init = not value == ""

        if assign == "=":
            base, value = check_value(value)
            size = 2 if datatype == "word" else 1
        elif assign == "*":
            base = "dec"
            size = int(value) * (2 if datatype == "word" else 1)

        return {
            "assign": assign,
            "base": base,
            "datatype": datatype,
            "init": init,
            "name": name,
            "size": size,
            "value": value,
        }

    parse_flag = False

    with open(filename, "r") as source_code:
        for line in source_code:

            line = line.rstrip()

            if line == STOP_VARS:
                break

            if parse_flag:
                try:
                    values = re_obj.findall(line)[0]
                    yield build_dict(*values)
                except IndexError:
                    pass

            if line == START_VARS:
                parse_flag = True


def tabulate_line(tab_position, text_line=""):
    """ Tabulate line using blank spaces using `TABULATION` as reference.
    Receive `tab_position` as index for `TABULATION` and `text_line` as the
    current line (optional). """
    cursor = len(text_line)
    tabulation = TABULATION[tab_position] - cursor
    return (" " if cursor > tabulation else "") + " " * tabulation


def main():
    """ Main function """
    offset = 0
    variables = []
    parse_re = re.compile(REGEX)

    directories = argv[1:]

    if directories:
        file_list = list(get_files(directories))
        for filename in file_list:
            logging.debug('* Reading "%s".', filename)
            variables += parse_file(filename, parse_re)

        print(format_declarations(offset, variables))
        print(format_initialization(variables))

    else:
        raise ValueError("Directory list is missing!")

    logging.shutdown()


if __name__ == "__main__":
    main()
