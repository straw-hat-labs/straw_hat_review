#!/bin/sh

service supervisor start
sh -c "mix $*"
