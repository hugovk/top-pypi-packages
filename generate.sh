#!/usr/bin/env bash

# Prevents script from running if there are any errors
set -e

# Check versions
python3 -m pip --version

# Ensure newest pip and pypinfo
python3 -m pip install -U pip

# Check versions
python3 -m pip --version

# Generate and minify
python3 clickhouse.py
jq -c . < top-pypi-packages.json > top-pypi-packages.min.json
echo 'download_count,project' > top-pypi-packages.csv
jq -r '.rows[] | [.download_count, .project] | @csv' top-pypi-packages.json >> top-pypi-packages.csv

# Keep deprecated files with the "-30-days" suffix for now
cp top-pypi-packages.csv      top-pypi-packages-30-days.csv
cp top-pypi-packages.json     top-pypi-packages-30-days.json
cp top-pypi-packages.min.json top-pypi-packages-30-days.min.json
