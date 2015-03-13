#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import pprint
from fnmatch import fnmatch
from optparse import OptionParser
from os import listdir, getcwd
from os.path import isdir, sep

indenSign = "  "
treeSign = "│ "

class Termcolor():
    ATTRIBUTES = dict(
            list(zip([
                'bold',
                'dark',
                '',
                'underline',
                'blink',
                '',
                'reverse',
                'concealed'
                ],
                list(range(1, 9))
                ))
            )
    del ATTRIBUTES['']

    HIGHLIGHTS = dict(
            list(zip([
                'on_grey',
                'on_red',
                'on_green',
                'on_yellow',
                'on_blue',
                'on_magenta',
                'on_cyan',
                'on_white'
                ],
                list(range(40, 48))
                ))
            )

    COLORS = dict(
            list(zip([
                'grey',
                'red',
                'green',
                'yellow',
                'blue',
                'magenta',
                'cyan',
                'white',
                ],
                list(range(30, 38))
                ))
            )

    RESET = '\033[0m'

    @staticmethod
    def colored(text, color=None, on_color=None, attrs=None):
        """Colorize text.

        Available text colors:
            red, green, yellow, blue, magenta, cyan, white.

        Available text highlights:
            on_red, on_green, on_yellow, on_blue, on_magenta, on_cyan, on_white.

        Available attributes:
            bold, dark, underline, blink, reverse, concealed.

        Example:
            colored('Hello, World!', 'red', 'on_grey', ['blue', 'blink'])
            colored('Hello, World!', 'green')
        """
        if os.getenv('ANSI_COLORS_DISABLED') is None:
            fmt_str = '\033[%dm%s'
            if color is not None:
                text = fmt_str % (Termcolor.COLORS[color], text)

            if on_color is not None:
                text = fmt_str % (Termcolor.HIGHLIGHTS[on_color], text)

            if attrs is not None:
                for attr in attrs:
                    text = fmt_str % (Termcolor.ATTRIBUTES[attr], text)

            text += Termcolor.RESET
        return text


def getLSColors():
    fileTypes = dict()
    for code in os.environ['LS_COLORS'].split(':'):
        (fileType, colors) = code.split('=')
        fileTypes[fileType] = colors.split(';')

    fileTypes['fi'] = '0'

    return fileTypes


def colorize(filename, fileType):
    fileSettings = list()
    ls_colors = {
            '0' : {"color": None},
            '01' : {"attrs": ["bold"]},
            '4' : {"attrs": ["underline"]},
            '5' : {"attrs": ["blink"]},
            '7' : {"attrs": ["reverse"]},
            '31' : {"color": "red"},
            '32' : {"color": "green"},
            '33' : {"color": "yellow"},
            '34' : {"color": "blue"},
            '35' : {"color": "magenta"},
            '36' : {"color": "cyan"},
            '37' : {"color": "cyan"},
            '39' : {"color": "white"},
            '40' : {"on_color": "on_black"},
            '41' : {"on_color": "on_red"},
            '42' : {"on_color": "on_green"},
            '43' : {"on_color": "on_yellow"},
            '44' : {"on_color": "on_blue"},
            '45' : {"on_color": "on_magenta"},
            '46' : {"on_color": "on_cyan"},
            '47' : {"on_color": "on_grey"},
            '93' : {"color": "yellow"},
            }

    ls_env = getLSColors()

    colors = dict()
    for fileSetting in ls_env:
        if fnmatch(filename, fileSetting):
            [colors.update(ls_colors[nr]) for nr in ls_env[fileSetting]]
            break
    else:
        [colors.update(ls_colors[nr]) for nr in ls_env[fileType]]

    return Termcolor.colored(filename, **colors)

def getFileType(fullPath):
    if os.path.islink(fullPath):
        return "ln"
    elif os.path.isdir(fullPath):
        return "di"
    else:
        return "fi"

def tree(path, indent):
    dirEntries = os.listdir(path)
    if not dirEntries:
        return

    for direntry in dirEntries[:-1]:
        fullPath = "%s/%s" % (path, direntry)
        fileType = getFileType(fullPath)

        if isdir(fullPath):
            print indent + "├─" + colorize(direntry + sep, fileType)
            tree(fullPath, indent + treeSign + indenSign)
        else:
            print indent + "├─" + colorize(direntry, fileType)
    else: # the last Element
        direntry = dirEntries[-1]
        fullPath = "%s/%s" % (path, direntry)
        fileType = getFileType(fullPath)

        if isdir(fullPath):
            print indent + "└─" + colorize(direntry + sep, fileType)
            tree(fullPath, indent +  indenSign)
        else:
            print indent + "└─" + colorize(direntry, fileType)


def getargs():
    parser = OptionParser()
    parser.add_option('-f', '--nofiles', dest="nofiles", action="store_true")

    (options, args) = parser.parse_args()

    if not args:
        options.folder = os.getcwd()
    else:
        options.folder = args[0]

    return options

if __name__ == '__main__':
    args = getargs()

    tree(args.folder, indenSign)
