#!/bin/bash

pkill -f '.*ssh scootserv -p 443 -o ServerAliveInterval=31536000'
