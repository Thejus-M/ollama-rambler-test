# Rambler-style clean-up with Ollama: test results (2026-10-16)

Machine: i5-10210U, CPU only, Ollama 0.33.3 (Arch package), private server on port 11500 (`serve.sh`).
Test: `uv run --no-project python test.py [models]`; 13 cases = 6 real dictated phrases + 7 Rambler-style cases.

Prompt v2 (in `test.py`): the transcript is wrapped in `<transcript>` tags, the system prompt says
"editor, not assistant", and there are 4 few-shot examples. Prompt v1 (plain instructions) made every model
answer questions or write the poem.

| model | avg per call | fillers | "3 no 4pm" | "John I mean Sarah" | does not answer | long paragraph |
|---|---|---|---|---|---|---|
| qwen2.5:1.5b | 1.3 s (5 s long) | yes | yes | yes | yes | dropped one clause |
| qwen2.5:0.5b | 0.65 s | left "Um" | yes | no (John) | yes | kept everything, light edits |
| qwen3:1.7b | 1.7 s (7 s long) | yes | yes | no (John) | yes | kept everything, few edits |
| gemma3:1b | 3.4 s | - | no | no | no (wrote poem, refused) | replaced with "Okay." |

Best: qwen2.5:1.5b with prompt v2. Weak spots: it can shorten long text and occasionally rewords
("how to give it" became "How will I give it?").

Integration ideas for dictate:
- Clean each phrase before typing: about +1 s per phrase.
- Or type raw phrases live, then replace the whole utterance with the cleaned text at stop.
