#!/usr/bin/env bash

# Prevents script from running if there are any errors
set -e

# Fetch total number of packages
TOTLAL=$(curl -s https://pypi.org \
  | sed -nE -e '/[,0-9]+ projects/p' \
  | sed -e 's/projects//g' -e 's/[ ,]//g')

add_total_number()
{
  jq --argjson total_projects "$TOTAL" '{total_projects: $total_projects}+.' \
    | sed -E -e 's/^ +//g'
}

# Generate the files
/usr/local/bin/pypinfo --json --indent 0 --limit 4000 --days  30 "" project \
  | add_total_number \
  > top-pypi-packages-30-days.json
/usr/local/bin/pypinfo --json --indent 0 --limit 4000 --days 365 "" project \
  | add_total_number \
  > top-pypi-packages-365-days.json

# Minify the files
# Not human-readable or diffable, but about 11% smaller, eg. 268K->238K
jq -c . < top-pypi-packages-30-days.json > top-pypi-packages-30-days.min.json
jq -c . < top-pypi-packages-365-days.json > top-pypi-packages-365-days.min.json
