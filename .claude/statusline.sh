#!/bin/bash

input=$(cat)

# Get current git branch
get_git_branch() {
    git branch --show-current 2>/dev/null || echo "no branch"
}

# Get color based on context usage percentage
get_context_color() {
    local percent=$1
    if (( percent < 50 )); then
        echo "32"  # green
    elif (( percent < 80 )); then
        echo "33"  # orange/yellow
    else
        echo "31"  # red
    fi
}

# Generate a 10-character visual progress bar
get_progress_bar() {
    local percent=$1
    local filled=$(( percent / 10 ))
    local empty=$(( 10 - filled ))
    printf "▓%.0s" $(seq 1 "$filled")
    printf "░%.0s" $(seq 1 "$empty")
}

# Extract data from JSON
branch=$(get_git_branch)
used_percent=$(echo "$input" | jq -r '.context_window.used_percentage // 0')

# Check if current_usage exists and is not null
current_usage_exists=$(echo "$input" | jq -r '.context_window.current_usage // "null"')

if [ "$current_usage_exists" != "null" ]; then
    # Calculate total current usage by summing all token types from current_usage
    current_usage_input=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0')
    current_usage_output=$(echo "$input" | jq -r '.context_window.current_usage.output_tokens // 0')
    current_usage_cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')
    current_usage_cache_creation=$(echo "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0')

    # Sum all token types to get total current usage
    total_current_usage=$((current_usage_input + current_usage_output + current_usage_cache_read + current_usage_cache_creation))

    # Convert tokens to thousands (rounded)
    tokens_k=$(( (total_current_usage + 500) / 1000 ))

    # Get context color and progress bar
    context_color=$(get_context_color "$used_percent")
    progress_bar=$(get_progress_bar "$used_percent")

    # Build status line with full context info and progress bar
    printf "\033[36m%s\033[0m • \033[%dmContext used: %s %s%%\033[0m (%dK/200K)" \
        "$branch" \
        "$context_color" \
        "$progress_bar" \
        "$used_percent" \
        "$tokens_k"
else
    # When current_usage is null, show simplified status
    printf "\033[36m%s\033[0m • Context used: --" \
        "$branch"
fi
