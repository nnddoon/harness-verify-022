#!/bin/bash
set -e
cd "$(dirname "$0")/.."
source .venv/bin/activate
ruff check .
mypy src
pytest -q
npm run test:unit
