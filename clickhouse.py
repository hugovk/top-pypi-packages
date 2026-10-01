# /// script
# requires-python = ">=3.10"
# ///
from __future__ import annotations

import datetime as dt
import json
import urllib.parse
import urllib.request
from pathlib import Path

TOTAL_ROWS = 15_000
# The ClickHouse demo server enforces max_result_rows = 10000
PAGE_SIZE = 10_000


def get_clickhouse_data() -> dict:
    params = {"user": "demo", "default_format": "JSON"}
    url = "https://sql-clickhouse.clickhouse.com?" + urllib.parse.urlencode(params)

    today = dt.datetime.now()
    first_of_this_month = today.replace(day=1)
    last_month = first_of_this_month - dt.timedelta(days=1)
    last_month = last_month.strftime("%Y-%m-01")
    print(f"{last_month=}")

    combined: dict = {}
    for offset in range(0, TOTAL_ROWS, PAGE_SIZE):
        limit = min(PAGE_SIZE, TOTAL_ROWS - offset)
        query = f"""
           SELECT SUM(count) AS download_count, project
           FROM pypi.pypi_downloads_per_month
           WHERE month = '{last_month}'
           GROUP BY project
           ORDER BY download_count DESC, project
           LIMIT {limit} OFFSET {offset}"""
        print(f"Fetching {limit} rows at offset {offset}")

        req = urllib.request.Request(url, data=query.encode("utf-8"), method="POST")
        with urllib.request.urlopen(req) as response:
            page = json.loads(response.read().decode("utf-8"))

        if page.get("exception"):
            msg = f"ClickHouse error: {page['exception']}"
            raise SystemExit(msg)
        if not page.get("data"):
            msg = f"ClickHouse returned no rows for {last_month} at {offset=}"
            raise SystemExit(msg)

        if not combined:
            combined = page
        else:
            combined["data"].extend(page["data"])

    combined["rows"] = len(combined["data"])
    return combined


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
    reformat_clickhouse_json(data)


if __name__ == "__main__":
    main()
