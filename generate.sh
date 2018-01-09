#!/bin/bash

# Prevents script from running if there are any errors
set -e

# Generate the files
/usr/local/bin/pypinfo --test --json --limit 500 --days 365 "" project > top-pypi-packages.json
