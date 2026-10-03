# Top PyPI Packages

[![DOI](https://zenodo.org/badge/116806538.svg)](https://zenodo.org/badge/latestdoi/116806538)

A monthly dump of the 15,000 most-downloaded packages from PyPI:

* https://hugovk.dev/top-pypi-packages/top-pypi-packages.min.json

Unminified:

* https://hugovk.dev/top-pypi-packages/top-pypi-packages.json

**Note:** It now takes too much quota to collect data for 365 days.
Those files were last updated on 2021-04-01 and have been removed.
Old versions can be found in [releases](https://github.com/hugovk/top-pypi-packages/releases).

## How it's updated

[`update.yml`](.github/workflows/update.yml) runs on GitHub Actions on the first of each month.
It fetches last month's download counts from the public
[ClickHouse PyPI dataset](https://clickpy.clickhouse.com/)
with `clickhouse.py`, commits the new files, tags a release, and GitHub Pages serves them from `main`.

To rerun it, or for a dry run that doesn't commit, use "Run workflow" on the
[Actions tab](https://github.com/hugovk/top-pypi-packages/actions/workflows/update.yml).

### Run locally

Needs Python 3.10+ and [jq](https://jqlang.github.io/jq/):

```bash
./generate.sh
```
