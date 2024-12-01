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

# Check if zip is installed
if ! command -v zip &> /dev/null
then
    echo "zip not found, consider: apt install zip"
    exit 1
fi

# Generate and minify
/home/botuser/.local/bin/pypinfo --all --json --indent 0 --limit 10000000 --days 29 "" project > top-pypi-packages-30-days-all.json
python3 trim.py > top-pypi-packages-30-days.json
jq -c . < top-pypi-packages-30-days.json > top-pypi-packages-30-days.min.json
echo 'download_count,project' > top-pypi-packages-30-days-all.csv
echo 'download_count,project' > top-pypi-packages-30-days.csv
jq -r '.rows[] | [.download_count, .project] | @csv' top-pypi-packages-30-days-all.json >> top-pypi-packages-30-days-all.csv
jq -r '.rows[] | [.download_count, .project] | @csv' top-pypi-packages-30-days.json     >> top-pypi-packages-30-days.csv
zip top-pypi-packages-30-days-all.csv.zip  top-pypi-packages-30-days-all.csv
zip top-pypi-packages-30-days-all.json.zip top-pypi-packages-30-days-all.json
