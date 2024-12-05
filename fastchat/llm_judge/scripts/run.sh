#!/usr/bin/env bash

source scripts/.env

stage=${1:-0}

# model_name="gpt-4o-2024-08-06"
# model_name="chatgpt-4o-2024-08-08"
# model_name="claude-3-5-sonnet-20240620"
# model_name="gemini-1.5-pro"
# model_name="mistral-large-2407"
# model_name="ministral-3b-2410"
# model_name="ministral-8b-2410"
model_name="aya-expanse-32b aya-expanse-8b"

# model_name="meta-llama-3.1-8b-instruct"
# model_name="meta-llama-3.1-70b-instruct"
# model_name="meta-llama-3.1-405b-instruct-fp8"

# model_name="Qwen2.5-0.5B-Instruct"
# model_name="Qwen2.5-1.5B-Instruct Qwen2.5-0.5B-Instruct"

# model_name="mistral-nemo-instruct-2407"
# model_name="Mistral-Small-Instruct-2409"

# model_name="c4ai-command-r-plus"

# model_name="Llama-3-Vgn-8B-Instruct-v0.1"


if [ $stage -eq 0 ]; then
    echo -e "Infer...\n"

    # Propritory API
    # #############################################
    # python3 gen_api_answer.py \
    #     --bench-name mt_bench_french \
    #     --model $model_name \
    #     --parallel 16

    # vLLM as backend
    # #############################################
    python gen_api_answer.py \
        --bench-name mt_bench_french \
        --model $model_name \
        --openai-api-base http://localhost:8000/v1 \
        --openai-api-key "EMPTY" \
        --parallel 16

    # Infer
    # #############################################
    # python gen_model_answer.py \
    #     --bench-name mt_bench_french \
    #     --model-path bofenghuang/vigostral-7b-chat \
    #     --model-id vigostral-7b-chat

    # python gen_model_answer.py \
    #     --bench-name mt_bench_french \
    #     --model-path mistralai/Mixtral-8x7B-Instruct-v0.1 \
    #     --model-id mixtral-8x7b-instruct-v0.1 \
    #     --num-gpus-total 3 \
    #     --num-gpus-per-model 3

    # python gen_model_answer.py \
    #     --bench-name mt_bench_french \
    #     --model-path CohereForAI/c4ai-command-r-v01 \
    #     --model-id c4ai-command-r-v01 \
    #     --num-gpus-total 2 \
    #     --num-gpus-per-model 2 \
    #     --dtype float16

fi

if [ $stage -eq 1 ]; then
    echo -e "Judge...\n"

    # Judge
    # #############################################

    # model_list=""
    # model_list+=" gpt-4o-2024-05-13 gpt-4o-mini-2024-07-18 gpt-4-turbo-2024-04-09 gpt-3.5-turbo-0125"
    # model_list+=" claude-3-5-sonnet-20240620 claude-3-sonnet-20240229 claude-3-opus-20240229 claude-3-haiku-20240307"
    # model_list+=" gemini-1.5-pro gemini-1.5-flash"
    # model_list+=" mistral-large-2402 mistral-small-2402 open-mixtral-8x22b-2404"
    # model_list+=" c4ai-command-r-plus"
    # model_list+=" meta-llama-3-70b-instruct meta-llama-3-8b-instruct"
    # model_list+=" gemini-1.5-pro gemini-1.5-flash claude-3-5-sonnet-20240620"

    # python gen_judgment.py \
    #     --bench-name mt_bench_french \
    #     --model-list $model_list \
    #     --parallel 8

    # model_name="mistral-large-2407 meta-llama-3.1-405b-instruct-fp8"
    # model_name="Qwen2-72B-Instruct gpt-4o-2024-08-06"
    # model_name="Qwen2-7B-Instruct"
    # model_name="chatgpt-4o-2024-08-08"

    python gen_judgment.py \
        --bench-name mt_bench_french \
        --model-list $model_name \
        --parallel 16

fi

if [ $stage -eq 2 ]; then
    echo -e "Analysis...\n"

    # Analysis
    # #############################################

    # model_list=""
    model_list+=" Llama-3-Vgn-8B-Instruct-v0.1 Llama-3-Vgn-8B-Instruct-v0.2 Llama-3-Vgn-8B-Instruct-v0.3 Llama-3-Vgn-8B-Instruct-v0.4 Llama-3-Vgn-8B-Instruct-v0.5 Llama-3-Vgn-8B-Instruct-v0.6 Llama-3-Vgn-8B-Instruct-v0.7"
    model_list+=" Llama-3-Vgn-70B-Instruct-v0.1"

    # python show_result.py \
    #     --bench-name mt_bench_french \
    #     --model-list $model_list

    python show_result.py \
        --bench-name mt_bench_french

fi

# if [ $stage -eq 3 ]; then
#     echo -e "Demo...\n"

#     # demo
#     # #############################################

#     python qa_browser.py --bench-name mt_bench_french
# fi
