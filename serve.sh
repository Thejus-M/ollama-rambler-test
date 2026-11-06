#!/bin/bash
# Private Ollama server for this test only: own port, models kept in ./models.
cd "$(dirname "$0")" || exit 1
export OLLAMA_HOST=127.0.0.1:11500
export OLLAMA_MODELS="$PWD/models"
export OLLAMA_KEEP_ALIVE=10m
exec ollama serve
