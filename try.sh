#!/bin/bash
# Start the private Ollama server if needed, run the interactive tester,
# and stop the server again on exit if this script started it.
cd "$(dirname "$0")" || exit 1
started=0
if ! curl -s 127.0.0.1:11500/api/version >/dev/null; then
  setsid ./serve.sh > serve.log 2>&1 &
  started=1
  for _ in $(seq 50); do sleep 0.2; curl -s 127.0.0.1:11500/api/version >/dev/null && break; done
fi
uv run --no-project python try.py "$@"
if ((started)); then pkill -f '[o]llama serve'; echo "test server stopped"; fi
