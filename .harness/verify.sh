#!/bin/bash
set -e
cd "$(dirname "$0")/.."
# Dependencies live in the main checkout only (.venv / node_modules are gitignored, so task worktrees and the
# integration export from git archive don't have them).
# - Python: use the main checkout's .venv by absolute path (read-only use works inside the sandbox).
# - Node: vite writes temp files under node_modules/.vite-temp, and the main checkout is read-only inside the
#   sandbox, so a symlink (or resolving up to the parent repo's node_modules) fails with EPERM. Give this tree its
#   own copy instead (APFS clone, cp -c, so it is fast and takes almost no space).
DEPS=/Users/linxiutong/harness-verify-022
export PATH="$DEPS/.venv/bin:$PATH"
if [ "$PWD" != "$DEPS" ] && { [ ! -d node_modules ] || [ -L node_modules ]; }; then
  rm -f node_modules
  cp -cR "$DEPS/node_modules" node_modules 2>/dev/null || cp -R "$DEPS/node_modules" node_modules
fi
ruff check . --extend-exclude .claude,.harness,scripts/testdata,node_modules
mypy src
pytest -q
npm run test:unit
