#!/bin/bash

# Prevents script from running if there are any errors
set -e

# Generate the files
# pypinfo --test --json --limit 500 --days 365 "" project > top-pypi-packages.json
# TESTING
echo "$(date)"
echo "$(date)" > top-pypi-packages.json
