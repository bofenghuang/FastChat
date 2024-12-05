#!/usr/bin/env bash

# curl http://localhost:8000/v1/models

# model_name="mistral-nemo-instruct-2407"
# model_name="meta-llama-3.1-8b-instruct"
# model_name="meta-llama-3.1-70b-instruct"
# model_name="meta-llama-3.1-405b-instruct-fp8"
model_name="aya-expanse-32b"

# model_name="Llama-3-Vgn-8B-Instruct-v0.1"

curl http://localhost:8000/v1/chat/completions \
    -H "Content-Type: application/json" \
    -d '{
        "model": "'$model_name'",
        "messages": [
            {"role": "user", "content": "Hi!"},
            {"role": "assistant", "content": "Hello!"},
            {"role": "user", "content": "Hi again!"}
        ],
        "temperature": 0,
        "top_k": 50
    }'
