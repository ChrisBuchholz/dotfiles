# -*- coding: utf-8 -*-

import os
import sys
import argparse
import imp
import stonebear

from build import build
from push import push
from clean import clean
from deploy import deploy

def main():
    '''
    Main interface function of stonebear
    '''

    # default configuration
    config_filename = 'stonebeard.py'
    config = {
        # compilers
        'compilers': [],
        # files
        'input': [],
        'output': [],
        # list of files to remove from directories specified in [output]
        'remove_from_output_dirs': [],
        # pre and post -commands
        'prebuild': '''''',
        'postbuild': '''''',
        'prepush': '''''',
        'postpush': '''''',
        'preclean': '''''',
        'postclean': '''''',
        # dictionary of environments
        # key is the name of the environment
        # value (multi-line string) is the push-command
        'env': {}
    }

    # declare arguments
    #
    # arguments:
    #   build
    #   push          [env name]
    #   clean
    #   deploy        [env name]
    #   -v, --version
    parser = argparse.ArgumentParser(description='')
    parser.add_argument('--version', '-v', action='version',
                        version='stonebear ' + stonebear.__version__ + '')

    subparser = parser.add_subparsers()

    sub_build = subparser.add_parser('build', help='run build process')
    sub_build.set_defaults(func=build)

    sub_push = subparser.add_parser('push', help='run env push command')
    sub_push.add_argument('env', nargs=1, help='name of environment to use')
    sub_push.set_defaults(func=push)

    sub_clean = subparser.add_parser('clean', help='clean build directory')
    sub_clean.set_defaults(func=clean)

    sub_deploy = subparser.add_parser('deploy', help='run clean, build and\
                                      push processes')
    sub_deploy.add_argument('env', nargs=1, help='name of environment to use')
    sub_deploy.set_defaults(func=deploy)

    # catch IOError on parsing of the argparse object,
    # will return error if one occurs
    try:
        args = parser.parse_args()
    except IOError as e:
        print e
        sys.exit(1)

    # fetch and parse config file
    config_path = os.getcwd() + '/' + config_filename
    try:
        user_config = imp.load_source('stonebeard.config', config_path)
        user_config = user_config.config
    except IOError:
        print 'no config file %s found' % config_path
        sys.exit(1)

    # merge default config with user config
    config = dict(config.items() + user_config.items())

    # run argument function
    args.func(args, config)

    sys.exit(0)

if __name__ in ('__main__', 'stonebear.main'):
    main()
