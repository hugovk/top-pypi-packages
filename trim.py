"""
Take an input JSON file and keep only the first LIMIT rows
of the "rows" array in the JSON file.
"""

from __future__ import annotations

import argparse
import json


def trim_json(input_file: str, limit: int) -> None:
    with open(input_file) as f:
        data = json.load(f)
    data["rows"] = data["rows"][:limit]
    print(json.dumps(data, indent=0))


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--json",
        type=str,
        default="top-pypi-packages-30-days-all.json",
        help="The input JSON file to trim",
    )
    parser.add_argument(
        "--limit",
        type=int,
        default=8000,
        help="How many rows to keep",
    )
    args = parser.parse_args()
    trim_json(args.json, args.limit)
