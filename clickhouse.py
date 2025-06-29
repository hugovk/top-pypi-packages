# /// script
# requires-python = ">=3.10"
# ///
from __future__ import annotations

import datetime as dt
import json
import urllib.parse
import urllib.request
from pathlib import Path


def get_clickhouse_data() -> str:
    params = {"user": "demo", "default_format": "JSON"}

    today = dt.datetime.now()
    first_of_this_month = today.replace(day=1)
    last_month = first_of_this_month - dt.timedelta(days=1)
    last_month = last_month.strftime("%Y-%m-01")
    print(f"{last_month=}")
    query = f"""
       SELECT SUM(count) AS download_count, project
       FROM pypi.pypi_downloads_per_month
       WHERE month = '{last_month}'
       GROUP BY project
       ORDER BY download_count DESC
       LIMIT 15000"""

    url = "https://sql-clickhouse.clickhouse.com?" + urllib.parse.urlencode(params)
    req = urllib.request.Request(url, data=query.encode("utf-8"), method="POST")
    with urllib.request.urlopen(req) as response:
        data = response.read().decode("utf-8")
    return data


def reformat_clickhouse_json(input_data: dict) -> None:
    rows = [
        {"download_count": int(row["download_count"]), "project": row["project"]}
        for row in input_data["data"]
    ]

    reformatted_data = {
        "last_update": dt.datetime.now(dt.timezone.utc).strftime("%Y-%m-%d %H:%M:%S"),
        "source": "ClickHouse",
    }
    # Rename rows->total_rows and data->rows
    for k, v in input_data.items():
        if k == "rows":
            reformatted_data["total_rows"] = v
        elif k == "data":
            reformatted_data["rows"] = rows
        else:
            reformatted_data[k] = v

    Path("top-pypi-packages.json").write_text(
        json.dumps(reformatted_data, indent=0) + "\n"
    )
    print("Saved to top-pypi-packages.json")


def main() -> None:
    data = get_clickhouse_data()
    data = json.loads(data)
    reformat_clickhouse_json(data)


if __name__ == "__main__":
    main()
