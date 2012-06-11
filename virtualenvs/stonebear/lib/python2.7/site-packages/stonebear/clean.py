# -*- coding: utf-8 -*-

import os
import shutil
import subprocess

def clean(args, config):
    '''
    clean [output_dir]
    '''
    # run preclean command
    subprocess.call(config['preclean'], shell=True)

    # remove all files/folders from [output]
    cwd = os.getcwd() + '/'
    for o in config['output']:
        co = cwd + o
        if os.path.exists(co):
            if os.path.isdir(co):
                try:
                    shutil.rmtree(co)
                except OSError:
                    raise
                    sys.exit(1)
            else:
                try:
                    os.remove(co)
                except OSError:
                    raise
                    sys.exit(1)

    # run postclean command
    subprocess.call(config['postclean'], shell=True)
