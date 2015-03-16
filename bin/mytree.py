#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import pprint
import sys
from fnmatch import fnmatch
from optparse import OptionParser
from os import listdir, getcwd
from os.path import isdir, join, sep
from stat import *

indenSign = "  "
treeSign = "│ "
innerBranch = "├─"
finalBranch = "└─"

colorCodes = {
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
        '40' : {"attrs": ["dark"]},
        '41' : {"on_color": "on_red"},
        '42' : {"on_color": "on_green"},
        '43' : {"on_color": "on_yellow"},
        '44' : {"on_color": "on_blue"},
        '45' : {"on_color": "on_magenta"},
        '46' : {"on_color": "on_cyan"},
        '47' : {"on_color": "on_grey"},
        '93' : {"color": "yellow"},
        }

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


def getModeString(fullPath):
    """
    Receives a path and returns it's chmods as string.
    Example: [-rwxr-wr--]
    """
    bits = "rwx"
    permissions = (
            S_IRUSR,
            S_IWUSR,
            S_IXUSR,
            S_IRGRP,
            S_IWGRP,
            S_IXGRP,
            S_IROTH,
            S_IWOTH,
            S_IXOTH,
            )

    modes = "["
    fileType = getFileType(fullPath)

    if fileType is "ln" or fileType is "or":
        filePermissions = os.lstat(fullPath)[ST_MODE]
        modes += 'l'
    else:
        filePermissions = os.stat(fullPath)[ST_MODE]
        if fileType is 'di':
            modes += 'd'
        else:
            modes += '-'

    for i, perm in enumerate(permissions):
        if filePermissions & perm:
            modes += bits[i % 3]
        else:
            modes += "-"

    modes += "]"

    return modes

def getLSColors():
    # setting default LS_COLORS
    fileTypes = {
            'fi' : ['0'],
            'di' : ['01', '34'],
            'ln' : ['01', '36'],
            'pi' : ['33'],
            'so' : ['01', '35'],
            'bd' : ['01', '33'],
            'cd' : ['01', '33'],
            'mi' : ['0'],
            'or' : ['0'],
            'ex' : ['01', '32'],
            'do' : ['01', '35'],
            }
    try:
        for code in os.environ['LS_COLORS'].split(':'):
            (fileType, colors) = code.split('=')
            fileTypes[fileType] = colors.split(';')
    except KeyError:
        pass # if LS_COLORS not definded use defaults
    except ValueError:
        pass # stupid distries have empty fields in LS_COLORS

    return fileTypes


def colorize(filename, fileType):
    colors = dict()

    for fileGlob in fileTypesAndColors:
        if fnmatch(filename, fileGlob):
            for colorCode in fileTypesAndColors[fileGlob]:
                colors.update(colorCodes[colorCode])
            break # fileGlob found, break out
    else: # no fitting fileGlob found, use one corresponding to fileType
        for colorCode in fileTypesAndColors[fileType]:
            colors.update(colorCodes[colorCode])

    return Termcolor.colored(filename, **colors)

def getFileType(fullPath):
    if os.path.islink(fullPath):
        if os.path.exists(os.readlink(fullPath)):
            return "ln"
        else:
            return "or" # orphaned link
    elif os.path.isdir(fullPath):
        return "di"
    elif os.access(fullPath, os.X_OK):
        return "ex"
    else:
        return "fi"

def followSymLink(fullPath):
    return os.path.realpath(fullPath)

def printTreeEntry(indent, curBranch, fullPath, fileType, args):
    direntry = os.path.basename(fullPath)

    if args.fullpath:
        direntry = join(args.folder, os.path.relpath(fullPath, args.folder))

    if fileType == 'di':
        direntry += sep

    if not args.nocolors:
        direntry = colorize(direntry, fileType)

    if args.protections:
        direntry = " %s  %s" % (getModeString(fullPath), direntry)

    if fileType == 'ln':
        direntry += " -> %s" % followSymLink(fullPath)

    if fileType == 'or':
        direntry += " -> %s" % os.readlink(fullPath)

    print "%s%s%s" % (indent, curBranch, direntry)

def tree(path, indent, args):
    dirsSeen = 0
    filesSeen = 0

    if args.nofiles:
        dirEntries = [d for d in os.listdir(path) if isdir(join(path, d))]
    else:
        dirEntries = os.listdir(path)

    if not args.printall:
        dirEntries = [d for d in dirEntries if not d.startswith('.')]

    if not dirEntries:
        return (0,0)

    dirEntries.sort(cmp=lambda x,y: cmp(x.lower(), y.lower()))

    for i, direntry in enumerate(dirEntries):
        if i == len(dirEntries)-1:
            curBranch = finalBranch
            recIndent = indent +  indenSign
        else:
            curBranch = innerBranch
            recIndent = indent + treeSign + indenSign

        fullPath = join(path, direntry)
        fileType = getFileType(fullPath)

        printTreeEntry(indent, curBranch, fullPath, fileType, args)

        if ((isdir(fullPath) and not fileType in 'ln')
                or (args.followsymlinks and isdir(fullPath))):
            dirsSeen += 1
            (retDirs, retFiles) = tree(fullPath, recIndent, args)

            dirsSeen += retDirs
            filesSeen += retFiles
        else:
            filesSeen += 1

    return (dirsSeen, filesSeen)


def getargs():
    parser = OptionParser()
    parser.add_option('-d', '--directories',
            dest="nofiles", action="store_true",
            help="print only directories")
    parser.add_option('-n', '--nocolors',
            dest="nocolors", action="store_true",
            help="dont't colorize the output")
    parser.add_option('-S', '--ascii',
            dest="ASCII", action="store_true",
            help="Print with ASCII graphics indentation lines.")
    parser.add_option('-a', '--printall',
            dest="printall", action="store_true",
            help="All files are listed.")
    parser.add_option('-i', '--noindentation',
            dest="noindentation", action="store_true",
            help="Don't print indentation lines.")
    parser.add_option('-l', '--followsymlinks',
            dest="followsymlinks", action="store_true",
            help="Don't print indentation lines.")
    parser.add_option('-f', '--fullpath',
            dest="fullpath", action="store_true",
            help="Print the full path prefix for each file.")
    parser.add_option('-p', '--protections',
            dest="protections", action="store_true",
            help="Print the protections for each file.")

    (options, args) = parser.parse_args()

    if not args:
        options.folder = os.getcwd()
    else:
        options.folder = args[0]

    if not sys.stdout.isatty():
        options.nocolors = True

    return options

if __name__ == '__main__':
    args = getargs()
    dirsSeen = 0
    filesSeen = 0
    fileTypesAndColors = getLSColors()

    if not isdir(args.folder):
        sys.stderr.write("ERROR: '%s' is not a directory\n" % args.folder)
        sys.exit(1)

    if args.ASCII is True:
        treeSign = "| "
        innerBranch = "+-"
        finalBranch = "`-"

    if args.nocolors:
        print args.folder
    else:
        print colorize(args.folder, "di")

    if args.noindentation:
        indenSign = ""
        treeSign = ""
        innerBranch = ""
        finalBranch = ""

    (dirsSeen, filesSeen) = tree(args.folder, "", args)
    print "\n%s directories, %s files" % (dirsSeen, filesSeen)
