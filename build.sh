#!/usr/bin/env bash

# Prevents script from running if there are any errors
set -e

# Timestamp for logs
echo "$(date)"

# Update
git pull origin main

# Generate the files
bash generate.sh

# Make output directory, don't fail if it exists
# mkdir -p build

# Copy to output directory
# cp -R {2.6,3.2,3.3,index.html,results.json,wheel.css} build
