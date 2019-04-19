#!/usr/bin/env bash
# To be run from cron
cd ~/github/top-pypi-packages
./build.sh
./deploy.sh
