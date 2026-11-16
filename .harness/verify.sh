#!/bin/bash
set -e
cd "$(dirname "$0")/.."
pytest -q
npm run test:unit
