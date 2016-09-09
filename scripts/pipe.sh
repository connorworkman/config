#!/bin/bash

echo hello

if test -t 1; then
    # Stdout is a terminal.
    exec >log 2>&1
else
    # Stdout is not a terminal, no logging.
    false
fi

echo goodbye
echo error >&2

