#!/bin/bash

# Prevents script from running if there are any errors
set -e

echo "$(date)"

# Generate the files
pypinfo --test --json --limit 500 --days 365 "" project > top-pypi-packages.json
