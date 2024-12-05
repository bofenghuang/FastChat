#!/usr/bin/env bash

# Setup vllm server

source scripts/.env

#     --port 8010 \
#     --disable-log-requests \

# python -m vllm.entrypoints.openai.api_server \
#     --model /projects/bhuang/models/llm/pretrained/llama/Meta-Llama-3.1-405B-Instruct-FP8 \
#     --served-model-name meta-llama-3.1-405b-instruct-fp8 \
#     --max_model_len 8192 \
#     --tensor-parallel-size 8

model_path=/projects/bhuang/models/llm/pretrained/CohereForAI/aya-expanse-8b

#     --gpu-memory-utilization 0.8 \
    # --trust-remote-code \

python -m vllm.entrypoints.openai.api_server \
    --model $model_path \
    --served-model-name ${model_path##*/} \
    --tensor-parallel-size 4 \

# export VLLM_ATTENTION_BACKEND=FLASHINFER
# python -m vllm.entrypoints.openai.api_server \
#     --model google/gemma-2-27b-it \
#     --served-model-name gemma-2-27b-it \
#     --trust-remote-code
