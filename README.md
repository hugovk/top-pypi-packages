# top-pypi-packages

A weekly dump of the 500 most-downloaded packages from PyPI: 

* https://hugovk.github.io/top-pypi-packages/top-pypi-packages.json

## Server setup notes

From cron, it runs pypinfo to dump JSON and commit back to this repo.

### Install Python 3.6 and pip

For example on Ubuntu 14.04:

```bash
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install python3.6
python3.6 --version
curl https://bootstrap.pypa.io/get-pip.py | sudo python3.6
```

### Install and set up pypinfo

Follow https://github.com/ofek/pypinfo to sign up for BigQuery, install and authenticate

```bash
sudo pip3 install pypinfo
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
17 15 * * Tue /home/botuser/github/top-pypi-packages/top-pypi-packages.sh > /tmp/top-pypi-packages.log 2>&1
```
