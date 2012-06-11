# -*- coding: utf-8 -*-

from build import build
from push import push
from clean import clean

def deploy(args, config):
    '''
    convenience function that builds and pushes in one call
    '''
    build(args, config)
    push(args, config)
