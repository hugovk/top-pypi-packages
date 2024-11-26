#!/usr/bin/env bash

# Prevents script from running if there are any errors
set -e

# Timestamp for logs
date

# Update
git pull origin main

# Generate the files
bash generate.sh

# Remove big unzipped file
rm top-pypi-packages-30-days-all.csv
rm top-pypi-packages-30-days-all.json

# Make output directory, don't fail if it exists
# mkdir -p build

# Copy to output directory
# cp -R {2.6,3.2,3.3,index.html,results.json,wheel.css} build
