#!/usr/bin/python
# -*- coding: utf-8 -*-

# TODO: handle cornercases with nofiles

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
            #[colors.update(ls_colors[nr]) for nr in ls_env[fileSetting]]
            for colorCode in ls_env[fileSetting]:
                colors.update(ls_colors[colorCode])
            break # filesetting found, break out
    else:
        #[colors.update(ls_colors[nr]) for nr in ls_env[fileType]]
        for colorCode in ls_env[fileType]:
            colors.update(ls_colors[colorCode])

    return Termcolor.colored(filename, **colors)

def getFileType(fullPath):
    if os.path.islink(fullPath):
        return "ln"
    elif os.path.isdir(fullPath):
        return "di"
    else:
        return "fi"

def tree(path, indent, args):
    dirsSeen = 0
    filesSeen = 0

    dirEntries = os.listdir(path)
    if not dirEntries:
        return (0,0)

    dirEntries.sort(cmp=lambda x,y: cmp(x.lower(), y.lower()))

    for direntry in dirEntries[:-1]:
        fullPath = "%s/%s" % (path, direntry)
        fileType = getFileType(fullPath)

        if isdir(fullPath):
            dirsSeen += 1
            if args.nocolors:
                fileString = direntry + sep
            else:
                fileString = colorize(direntry + sep, fileType)

            print "%s%s%s" % (indent, "├─", fileString)

            (retDirs, retFiles) = tree(fullPath, indent + treeSign + indenSign, args)
            dirsSeen += retDirs
            filesSeen += retFiles
        elif not args.nofiles:
            filesSeen += 1
            if args.nocolors:
                fileString = direntry
            else:
                fileString = colorize(direntry, fileType)

            print indent + "├─" + fileString
    else: # the last Element
        direntry = dirEntries[-1]
        fullPath = "%s/%s" % (path, direntry)
        fileType = getFileType(fullPath)

        if isdir(fullPath):
            dirsSeen += 1
            if args.nocolors:
                fileString = direntry + sep
            else:
                fileString = colorize(direntry + sep, fileType)

            print indent + "└─" + fileString
            (retDirs, retFiles) = tree(fullPath, indent +  indenSign, args)
        elif not args.nofiles:
            filesSeen += 1
            if args.nocolors:
                fileString = direntry
            else:
                fileString = colorize(direntry, fileType)

            print indent + "└─" + fileString

    return (dirsSeen, filesSeen)


def getargs():
    parser = OptionParser()
    parser.add_option('-d', '--directories',
            dest="nofiles", action="store_true")
    parser.add_option('-n', '--nocolors',
            dest="nocolors", action="store_true")

    (options, args) = parser.parse_args()

    if not args:
        options.folder = os.getcwd()
    else:
        options.folder = args[0]

    return options

if __name__ == '__main__':
    args = getargs()
    dirsSeen = 0
    filesSeen = 0

    if args.nocolors:
        print args.folder
    else:
        print colorize(args.folder, "di")

    (dirsSeen, filesSeen) = tree(args.folder, indenSign, args)
    print "\n%s directories, %s files" % (dirsSeen, filesSeen)
