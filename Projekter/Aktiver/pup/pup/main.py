# This file is part of pup released under GNU General Public License
# See COPYING for more information

import os
import sys
import argparse

def push(service, content):
    print "SERVICE: " + service + "\n"
    print "CONTENT:\n" + content

def checkState():
    """ Figure out if pup was called with an argument.

        If so, find if it was content to paste or the
        path to a file whos content should get pasted.

        If not, notify user about missing argument and
        exit
    """

    services = ["github", "pastebin"]

    argparser = argparse.ArgumentParser(description='Accept a string of \
            content or path to a file of which to upload to the pasting \
            service')
    argparser.add_argument('--service', '-s', nargs=1, default='github', \
            choices=services, help='Service to where the paste should be \
            uploaded to. Defaults to `github`')
    argparser.add_argument('content', nargs='?', type=argparse.FileType('r'), \
            default=sys.stdin, help='You can pipe anything to it, or provide \
            a path to a file which content will get used.')
    args = argparser.parse_args()

    service, content = "".join(args.service), args.content.read()

    push(service, content)

if __name__ in ("__main__", "pup.main"):
    checkState()
