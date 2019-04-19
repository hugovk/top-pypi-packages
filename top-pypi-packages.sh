#!/usr/bin/env bash
# To be run from cron

# Prevents script from running if there are any errors
set -e

cd ~/github/top-pypi-packages
./build.sh
./deploy.sh
