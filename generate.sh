#!/usr/bin/env bash

# Prevents script from running if there are any errors
set -e

# Check versions
python3 -m pip --version
/home/botuser/.local/bin/pypinfo --version

# Ensure newest pip and pypinfo
python3 -m pip install -U pip
python3 -m pip install -U pypinfo

# Check versions
python3 -m pip --version
/home/botuser/.local/bin/pypinfo --version

# Generate and minify
/home/botuser/.local/bin/pypinfo --all --json --indent 0 --limit 15000 --days 29 "" project > top-pypi-packages-30-days.json
jq -c . < top-pypi-packages-30-days.json > top-pypi-packages-30-days.min.json
echo 'download_count,project' > top-pypi-packages-30-days.csv
jq -r '.rows[] | [.download_count, .project] | @csv' top-pypi-packages-30-days.json >> top-pypi-packages-30-days.csv
