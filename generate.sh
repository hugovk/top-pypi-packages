#!/bin/bash

# Prevents script from running if there are any errors
set -e

# Generate the files
/usr/local/bin/pypinfo --json --limit 5000 --days  30 "" project > top-pypi-packages-30-days.json
/usr/local/bin/pypinfo --json --limit 5000 --days 365 "" project > top-pypi-packages-365-days.json
