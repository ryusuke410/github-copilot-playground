#!/bin/bash

# Create directory and file, then open it in VSCode
mkdir -p .agdocs/swap
touch .agdocs/swap/answer.md
code .agdocs/swap/answer.md

# Wait for user to press Enter
echo "Waiting for you to edit and save the file. Press Enter when done..."
read -r

# Notify that the file has been edited
echo "Answer file \`.agdocs/swap/answer.md\` has been edited. Continuing..."
