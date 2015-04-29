#!/usr/bin/python
# -*- coding: utf-8 -*-

import grp
import os
import pprint
import pwd
import subprocess
import sys
import time
from fnmatch import fnmatch
from optparse import OptionParser
from os import listdir, getcwd
from os.path import isdir, join, sep
from stat import *

indenSign = "  "
treeSign = "│ "
innerBranch = "├─"
finalBranch = "└─"


# insert relpath for python 2.4
if not hasattr(os, 'relpath'):
    if os.path is sys.modules.get('ntpath'):
        def relpath(path, start=os.path.curdir):
            """Return a relative version of a path"""
        
            if not path:
                raise ValueError("no path specified")
            start_list = os.path.abspath(start).split(os.path.sep)
            path_list = os.path.abspath(path).split(os.path.sep)
            if start_list[0].lower() != path_list[0].lower():
                unc_path, rest = os.path.splitunc(path)
                unc_start, rest = os.path.splitunc(start)
                if bool(unc_path) ^ bool(unc_start):
                    raise ValueError("Cannot mix UNC and non-UNC paths (%s and %s)"
                                                                        % (path, start))
                else:
                    raise ValueError("path is on drive %s, start on drive %s"
                                                        % (path_list[0], start_list[0]))
            # Work out how much of the filepath is shared by start and path.
            for i in range(min(len(start_list), len(path_list))):
                if start_list[i].lower() != path_list[i].lower():
                    break
            else:
                i += 1
        
            rel_list = [os.path.pardir] * (len(start_list)-i) + path_list[i:]
            if not rel_list:
                return os.path.curdir
            return os.path.join(*rel_list)
    
    else:
        # default to posixpath definition
        def relpath(path, start=os.path.curdir):
            """Return a relative version of a path"""
        
            if not path:
                raise ValueError("no path specified")
        
            start_list = os.path.abspath(start).split(os.path.sep)
            path_list = os.path.abspath(path).split(os.path.sep)
        
            # Work out how much of the filepath is shared by start and path.
            i = len(os.path.commonprefix([start_list, path_list]))
        
            rel_list = [os.path.pardir] * (len(start_list)-i) + path_list[i:]
            if not rel_list:
                return os.path.curdir
            return os.path.join(*rel_list)
        
    os.path.relpath = relpath

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

class NoSuitableFiles(Exception):
    pass

class Termcolor(object):
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


def getModeString(fullPath, stats):
    """
    Receives a path and returns it's chmods as string.
    Example: [-rwxr-wr--]
    """
    bits = "rwx"
    modes = ""
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

    fileType = getFileType(fullPath)

    if fileType is "ln" or fileType is "or":
        filePermissions = stats[ST_MODE]
        modes += 'l'
    else:
        filePermissions = stats[ST_MODE]
        if fileType is 'di':
            modes += 'd'
        else:
            modes += '-'

    for i, perm in enumerate(permissions):
        if filePermissions & perm:
            modes += bits[i % 3]
        else:
            modes += "-"

    return modes

def getGroup(fullPath, stats):
    gid = stats.st_gid

    try:
        group = grp.getgrgid(gid).gr_name
    except KeyError:
        group = str(gid)

    return group

def getOwner(fullPath, stats):
    uid = stats.st_uid

    try:
        user = pwd.getpwuid(uid).pw_name
    except KeyError:
        user = str(uid)

    return user

def getFilesize(fullPath, stats):
    return str(stats.st_size)

def getHumanFilesize(fullPath, stats):
    prefixes = ('', 'k', 'm', 'G', 'T')
    size = stats.st_size

    suffixCount = 0
    while size > 1024:
        suffixCount += 1
        size /= 1024.0

    return "%g" % float("%.1f" % size) + prefixes[suffixCount]


def getMD5Sum(fullPath, stats):
    md5sum = subprocess.Popen(['md5sum', fullPath], stdout=subprocess.PIPE)\
            .communicate()[0]\
            .rstrip()\
            .split(" ")[0]

    return md5sum


def printFileAttributes(fullPath, args):
    attributes = list()
    fileType = getFileType(fullPath)

    if fileType is "ln" or fileType is "or":
        stats = os.lstat(fullPath)
    else:
        stats = os.stat(fullPath)

    if args.protections:
        attributes.append(getModeString(fullPath, stats))

    if args.uid:
        attributes.append(getOwner(fullPath, stats))

    if args.gid:
        attributes.append(getGroup(fullPath, stats))

    if args.humansize:
        attributes.append(getHumanFilesize(fullPath, stats))
    elif args.size:
        attributes.append(getFilesize(fullPath, stats))

    if args.ctime:
        attributes.append(time.ctime(stats.st_ctime))

    if args.mtime:
        attributes.append(time.ctime(stats.st_mtime))

    if args.md5:
        if fileType is 'di' or fileType is 'or':
            attributes.append("-" * 32)
        else:
            attributes.append(getMD5Sum(fullPath, stats))

    return "[%s]" % " ".join(attributes)

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
        if not os.access(fullPath, os.R_OK):
            direntry = "%s %s" % (direntry,  "[error opening dir]")

    if not args.nocolors:
        direntry = colorize(direntry, fileType)

    if (args.protections
            or args.uid
            or args.gid
            or args.md5
            or args.size
            or args.humansize
            or args.ctime
            or args.mtime):
        direntry = " %s  %s" % (printFileAttributes(fullPath, args), direntry)

    if fileType == 'ln':
        direntry += " -> %s" % followSymLink(fullPath)

    if fileType == 'or':
        direntry += " -> %s" % os.readlink(fullPath)

    print "%s%s%s" % (indent, curBranch, direntry)

def handleDir(path, args):
    if args.levels == 0:
        raise NoSuitableFiles

    try:
        if args.nofiles:
            dirEntries = [d for d in os.listdir(path) if isdir(join(path, d))]
        else:
            dirEntries = os.listdir(path)
    except OSError, e:
        raise

    if not args.printall:
        dirEntries = [d for d in dirEntries if not d.startswith('.')]

    if not dirEntries:
        raise NoSuitableFiles

    if args.pattern:
        for pattern in args.pattern:
            dirEntries = [d for d in dirEntries if (os.path.isdir(path + d) or fnmatch(d, pattern))]

    if args.invertfilter:
        for invertfilter in args.invertfilter:
            dirEntries = [d for d in dirEntries if not fnmatch(d, invertfilter)]

    dirEntries.sort(cmp=lambda x,y: cmp(x.lower(), y.lower()))

    return dirEntries

def tree(path, indent, args):
    dirsSeen = 0
    filesSeen = 0

    try:
        dirEntries = handleDir(path, args)
    except (OSError, NoSuitableFiles), e:
        return (0,0)

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

            args.levels -= 1
            (retDirs, retFiles) = tree(fullPath, recIndent, args)
            args.levels += 1

            dirsSeen += retDirs
            filesSeen += retFiles
        else:
            filesSeen += 1

    return (dirsSeen, filesSeen)


def getargs():
    parser = OptionParser(add_help_option=False)
    parser.add_option('--help',
            dest="help", action="store_true")
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
    parser.add_option('-u', '--uid',
            dest="uid", action="store_true",
            help="Displays file owner or UID number.")
    parser.add_option('-g', '--gid',
            dest="gid", action="store_true",
            help="Displays file group owner or GID number.")
    parser.add_option('-m', '--md5',
            dest="md5", action="store_true",
            help="Displays MD5 sum of file.")
    parser.add_option('-s', '--size',
            dest="size", action="store_true",
            help="Print the size in bytes of each file.")
    parser.add_option('-h', '--humansize',
            dest="humansize", action="store_true",
            help="Print the size in a more human readable way.")
    parser.add_option('-L', '--levels',
            dest="levels", action="store",
            type="int", default=-1,
            help="Descend only level directories deep.")
    parser.add_option('-I', '--invertfilter',
            dest="invertfilter", action="append",
            help="Do not list files that match the given pattern.")
    parser.add_option('-P', '--pattern',
            dest="pattern", action="append",
            help="List only those files that match the pattern given.")
    parser.add_option('--mtime',
            dest="mtime", action="store_true",
            help="Displays last modification time of file.")
    parser.add_option('--ctime',
            dest="ctime", action="store_true",
            help="Displays creation time of file.")

    (options, args) = parser.parse_args()

    if options.help:
        parser.print_help()
        sys.exit(0)

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
        if not os.access(args.folder, os.R_OK):
            print colorize(args.folder, "di") + " [error opening dir]"
        else:
            print colorize(args.folder, "di")


    if args.noindentation:
        indenSign = ""
        treeSign = ""
        innerBranch = ""
        finalBranch = ""

    (dirsSeen, filesSeen) = tree(args.folder, "", args)
    print "\n%s directories, %s files" % (dirsSeen, filesSeen)
