#!/usr/bin/env bash

#Inspired from the tmux-sessionizer script made by ThePrimeagen

# Find all git repositories in ~/Documents/programming
if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/Documents/programming -type d -path "*/\.git" -prune -exec dirname {} \; | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

# Function to set up new session with windows
create_new_session() {
    # Create new session with base-index 1 for the first window (nvim)
    tmux new-session -ds $selected_name -c $selected "nvim ."
    # Rename the first window to "nvim"
    tmux rename-window -t $selected_name:1 "nvim"

    # Create a right pane that takes 40% of the space
    tmux split-window -h -p 40 -t $selected_name:1 -c $selected

    # Select and zoom the first pane (nvim)
    tmux select-pane -t $selected_name:1.1
    tmux resize-pane -Z -t $selected_name:1.1
    # Check if devenv.nix exists, then create the devenv window
    if [[ -f "$selected/devenv.nix" ]]; then
        # Create a second window running devenv up
        tmux new-window -t $selected_name -c $selected "devenv up"
        # Rename the second window to "devenv"
        tmux rename-window -t $selected_name:2 "devenv"
    fi

    # Select the first window when attaching
    tmux select-window -t $selected_name:1
}

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    # Create the session detached first
    create_new_session
    # Then attach to it
    tmux attach-session -t $selected_name
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    create_new_session
fi

tmux switch-client -t $selected_name
