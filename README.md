# Top PyPI Packages

[![DOI](https://zenodo.org/badge/116806538.svg)](https://zenodo.org/badge/latestdoi/116806538)

A monthly dump of the 8,000 most-downloaded packages from PyPI:

* https://hugovk.github.io/top-pypi-packages/top-pypi-packages-30-days.min.json

Unminified:

* https://hugovk.github.io/top-pypi-packages/top-pypi-packages-30-days.json

**Note:** It now takes too much quota to collect data for 365 days.
Those files were last updated on 2021-04-01 and have been removed.
Old versions can be found in [releases](https://github.com/hugovk/top-pypi-packages/releases).

## Server setup notes

From cron, it runs pypinfo to dump JSON and commit back to this repo.

### Install jq and zip

For example on Ubuntu 22.04:

```bash
sudo apt-get install jq zip
```

### Install and set up pypinfo

Follow https://github.com/ofek/pypinfo to sign up for BigQuery, install and authenticate.

```bash
pip3 install "pypinfo>=13.0.0"
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

# Thanks

Thanks to DigitalOcean for supporting open-source software.

<p>
  <a href="https://m.do.co/c/431978e0c3e9">
    <img alt="Powered by DigitalOcean" src="https://opensource.nyc3.cdn.digitaloceanspaces.com/attribution/assets/PoweredByDO/DO_Powered_by_Badge_blue.svg" width="201px">
  </a>
</p>
