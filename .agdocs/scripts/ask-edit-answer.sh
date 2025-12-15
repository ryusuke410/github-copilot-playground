#!/bin/bash

# Create directory and file, then open it in VSCode
mkdir -p .agdocs/swap
touch .agdocs/swap/human-answer.md
code .agdocs/swap/human-answer.md

# Wait for user to press Enter
echo "Waiting for you to edit and save the file. Press Enter when done..."
read -r

# Save a copy to the log directory with timestamp
unix_time=$(date +%s)
mkdir -p .agdocs/swap/human-answer-log
cp .agdocs/swap/human-answer.md ".agdocs/swap/human-answer-log/human-answer-${unix_time}.md"

# Notify that the file has been edited
echo "Answer file \`.agdocs/swap/human-answer.md\` has been edited. Continuing..."
