#!/bin/bash
set -e
cd "$(dirname "$0")/.."
# Dependencies live in the main checkout only (.venv / node_modules are gitignored, so task worktrees and the
# integration export from git archive don't have them). Use them by absolute path.
DEPS=/Users/linxiutong/harness-verify-022
export PATH="$DEPS/.venv/bin:$PATH"
node -e "require.resolve('vitest/package.json')" >/dev/null 2>&1 || ln -s "$DEPS/node_modules" node_modules
ruff check . --extend-exclude .claude,.harness,scripts/testdata
mypy src
pytest -q
npm run test:unit
