# Top PyPI Packages

[![DOI](https://zenodo.org/badge/116806538.svg)](https://zenodo.org/badge/latestdoi/116806538)

A monthly dump of the 4,000 most-downloaded packages from PyPI:

* https://hugovk.github.io/top-pypi-packages/top-pypi-packages-30-days.json
* https://hugovk.github.io/top-pypi-packages/top-pypi-packages-365-days.json

Minified:

* https://hugovk.github.io/top-pypi-packages/top-pypi-packages-30-days.min.json
* https://hugovk.github.io/top-pypi-packages/top-pypi-packages-365-days.min.json

## Server setup notes

From cron, it runs pypinfo to dump JSON and commit back to this repo.

### Install Python 3.6, pip and jq

For example on Ubuntu 14.04:

```bash
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install python3.6
python3.6 --version
curl https://bootstrap.pypa.io/get-pip.py | sudo python3.6
sudo apt-get install jq
```

### Install and set up pypinfo

Follow https://github.com/ofek/pypinfo to sign up for BigQuery, install and authenticate

```bash
sudo pip3 install "pypinfo>=13.0.0"
pypinfo --help
pypinfo --auth path/to/your_credentials.json
```

### Set up this repo

```bash
git clone git@github.com:hugovk/top-pypi-packages.git
cd top-pypi-packages
git config user.name "Deploy Bot"
git config user.email "deploybot@example.com"
git config user.name
git config user.email
```

* Create SSH key on server: https://www.digitalocean.com/community/tutorials/how-to-use-ssh-keys-with-digitalocean-droplets
* Add your SSH key to the ssh-agent:
https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#adding-your-ssh-key-to-the-ssh-agent
* Add deploy key with write access at https://github.com/hugovk/top-pypi-packages/settings/keys/new


### Run from cron

```bash
crontab -e
# First of the month
30 17 1 * * ( eval "$(ssh-agent -s)"; ssh-add ~/.ssh/id_rsa-top-pypi-packages; /home/botuser/github/top-pypi-packages/top-pypi-packages.sh ) > /tmp/top-pypi-packages.log 2>&1
```
