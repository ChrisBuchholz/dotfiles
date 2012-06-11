# -*- coding: utf-8 -*-

import subprocess

def push(args, config):
    '''
    actual function to run the environment command
    '''
    envs = config['environments']
    env = args.env[0]

    # run prepush command
    subprocess.call(config['prepush'], shell=True)

    # check if env exists in config['envs'] and run env_cmd if it does
    if env in envs:
        env_cmd = envs[env]
        subprocess.call(env_cmd, shell=True)
    else:
        print "no environment '%s' defined in stonebeard.py" % env

    # run postpush command
    subprocess.call(config['postpush'], shell=True)
