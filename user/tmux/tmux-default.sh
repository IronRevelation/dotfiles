#!/usr/bin/env bash

# Check if a session named "default" exists
if tmux has-session -t default 2>/dev/null; then
    # If it exists, attach to it
    if [[ -z $TMUX ]]; then
        # If we're not already in a tmux session, attach to it
        tmux attach-session -t default
    else
        # If we're already in a tmux session, switch to it
        tmux switch-client -t default
    fi
else
    # If it doesn't exist, create it
    if [[ -z $TMUX ]]; then
        # If we're not in a tmux session, create and attach
        tmux new-session -s default
    else
        # If we're already in a tmux session, create it detached and switch
        tmux new-session -ds default
        tmux switch-client -t default
    fi
fi
