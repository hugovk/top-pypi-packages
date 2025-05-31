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
days=22
/home/botuser/.local/bin/pypinfo --all --json --indent 0 --limit 15000 --days $days --test "" project
/home/botuser/.local/bin/pypinfo --all --json --indent 0 --limit 15000 --days $days        "" project > top-pypi-packages.json
jq -c . < top-pypi-packages.json > top-pypi-packages.min.json
echo 'download_count,project' > top-pypi-packages.csv
jq -r '.rows[] | [.download_count, .project] | @csv' top-pypi-packages.json >> top-pypi-packages.csv

# Keep deprecated files with the "-30-days" suffix for now
cp top-pypi-packages.csv      top-pypi-packages-30-days.csv
cp top-pypi-packages.json     top-pypi-packages-30-days.json
cp top-pypi-packages.min.json top-pypi-packages-30-days.min.json
