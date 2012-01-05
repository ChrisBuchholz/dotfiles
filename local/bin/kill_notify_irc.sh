#!/bin/bash

pkill -f '.*ssh scootservirc -p 443 -o ServerAliveInterval=31536000'
