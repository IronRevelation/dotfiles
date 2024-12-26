#!/usr/bin/env bash

# Directories with your projects
PROJECT_DIRS=(
    ~
)

# Combine directories and fuzzy search
all_projects=$(for dir in "${PROJECT_DIRS[@]}"; do
    find "$dir" -mindepth 1 -maxdepth 1 -type d 2>/dev/null
done)

selected=$(echo "$all_projects" | fzf --prompt="Select a project: ")

if [ -z "$selected" ]; then
    echo "No project selected."
    exit 1
fi

# Derive session name from the project directory name
session_name=$(basename "$selected")

# Check if a Zellij session already exists
if zellij list-sessions | grep -q "^$session_name$"; then
    echo "Attaching to existing Zellij session: $session_name"
    zellij attach "$session_name"
    exit 0
fi



# Create a new Zellij session with tabs
zellij --layout default_layout.kdl -s "$session_name"
