#!/usr/bin/python

import argparse
import os
import pprint
from os import listdir, getcwd
from os.path import isdir

def tree(path):
    dirs = list()
    files = list()

    for direntry in  os.listdir(path):
        if isdir("%s/%s" % (path, direntry)):
            tree("%s/%s" % (path, direntry))
        else:
            print "file: " + direntry

def getargs():
    parser = argparse.ArgumentParser(description='Show files in a tree hierarchy')
    parser.add_argument('-f', '--nofiles', action="store_false")
    parser.add_argument('folder', nargs='?', default=os.getcwd())
    return parser.parse_args()

if __name__ == '__main__':
    args = getargs()

    tree(args.folder)
