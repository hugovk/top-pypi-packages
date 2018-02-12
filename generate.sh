#!/bin/bash

# Prevents script from running if there are any errors
set -e

# Generate the files
/usr/local/bin/pypinfo --json --indent 0 --limit 5000 --days  30 "" project > top-pypi-packages-30-days.json
/usr/local/bin/pypinfo --json --indent 0 --limit 5000 --days 365 "" project > top-pypi-packages-365-days.json

# Minify the files
# Not human-readable or diffable, but about 11% smaller, eg. 268K->238K
jq -c . < top-pypi-packages-30-days.json > top-pypi-packages-30-days.min.json
jq -c . < top-pypi-packages-365-days.json > top-pypi-packages-365-days.min.json
