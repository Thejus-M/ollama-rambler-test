"""Interactive Rambler-style clean-up: type or dictate a line, press Enter,
see the cleaned text and how long it took. Ctrl+D or empty line x2 to quit.

    ./try.sh [model]      (default qwen2.5:1.5b)
"""
import sys

from test import chat

MODEL = sys.argv[1] if len(sys.argv) > 1 else "qwen2.5:1.5b"

print(f"Loading {MODEL}...", flush=True)
chat(MODEL, "hello")
print("Ready. Type or dictate (CTRL+TAB) a line, then press Enter. Ctrl+D quits.\n")
while True:
    try:
        raw = input("raw   > ").strip()
    except (EOFError, KeyboardInterrupt):
        print()
        break
    if not raw:
        continue
    out, dt = chat(MODEL, raw)
    print(f"clean < {out}\n        ({dt:.1f}s)\n")
