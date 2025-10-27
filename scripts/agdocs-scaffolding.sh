#!/bin/bash

# AGDocs Scaffolding Script
# Scaffolds the .agdocs directory structure to a target directory

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print error messages
error() {
    echo -e "${RED}Error: $1${NC}" >&2
    exit 1
}

# Function to print success messages
success() {
    echo -e "${GREEN}$1${NC}"
}

# Function to print info messages
info() {
    echo "$1"
}

# Check if target directory is provided
if [ $# -eq 0 ]; then
    error "Usage: ./scripts/agdocs-scaffolding.sh <target_directory>"
fi

TARGET_DIR="$1"
SOURCE_AGDOCS=".agdocs"

# Check if source .agdocs exists
if [ ! -d "$SOURCE_AGDOCS" ]; then
    error "Source .agdocs directory not found. Run this script from repository root."
fi

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Check if target .agdocs already exists
if [ -d "$TARGET_DIR/.agdocs" ]; then
    error ".agdocs directory already exists in $TARGET_DIR"
fi

info "Scaffolding .agdocs structure to $TARGET_DIR..."

# Create target .agdocs directory
mkdir -p "$TARGET_DIR/.agdocs"

# 1. Copy commands (exclude .local.md files)
if [ -d "$SOURCE_AGDOCS/commands" ]; then
    info "Copying commands..."
    mkdir -p "$TARGET_DIR/.agdocs/commands"
    for file in "$SOURCE_AGDOCS/commands"/*.md; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            if [[ ! "$filename" =~ \.local\.md$ ]]; then
                cp "$file" "$TARGET_DIR/.agdocs/commands/"
            fi
        fi
    done
fi

# 2. Copy docs directory
if [ -d "$SOURCE_AGDOCS/docs" ]; then
    info "Copying docs..."
    cp -r "$SOURCE_AGDOCS/docs" "$TARGET_DIR/.agdocs/"
fi

# 3. Copy templates directory
if [ -d "$SOURCE_AGDOCS/templates" ]; then
    info "Copying templates..."
    cp -r "$SOURCE_AGDOCS/templates" "$TARGET_DIR/.agdocs/"
fi

# 4. Initialize memory directory (only index.md)
info "Initializing memory..."
mkdir -p "$TARGET_DIR/.agdocs/memory"
if [ -f "$SOURCE_AGDOCS/templates/memory/index.md" ]; then
    cp "$SOURCE_AGDOCS/templates/memory/index.md" "$TARGET_DIR/.agdocs/memory/index.md"
elif [ -f "$SOURCE_AGDOCS/memory/index.md" ]; then
    # Fallback to copying from memory if template doesn't exist
    cp "$SOURCE_AGDOCS/memory/index.md" "$TARGET_DIR/.agdocs/memory/index.md"
fi

# 5. Copy scripts directory
if [ -d "$SOURCE_AGDOCS/scripts" ]; then
    info "Copying scripts..."
    cp -r "$SOURCE_AGDOCS/scripts" "$TARGET_DIR/.agdocs/"
    # Preserve execute permissions
    chmod u+x "$TARGET_DIR/.agdocs/scripts"/*.sh 2>/dev/null || true
fi

# 6. Copy prompts from .github/prompts (exclude .local.prompt.md files) - if directory exists
if [ -d ".github/prompts" ]; then
    info "Copying prompts..."
    mkdir -p "$TARGET_DIR/.github/prompts"
    shopt -s nullglob
    for file in .github/prompts/*.prompt.md; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            if [[ ! "$filename" =~ \.local\.prompt\.md$ ]]; then
                cp "$file" "$TARGET_DIR/.github/prompts/"
            fi
        fi
    done
    shopt -u nullglob
fi

# 7. Copy instructions from .github/instructions (exclude .local.instructions.md files) - if directory exists
if [ -d ".github/instructions" ]; then
    info "Copying instructions..."
    mkdir -p "$TARGET_DIR/.github/instructions"
    shopt -s nullglob
    for file in .github/instructions/*.instructions.md; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            if [[ ! "$filename" =~ \.local\.instructions\.md$ ]]; then
                cp "$file" "$TARGET_DIR/.github/instructions/"
            fi
        fi
    done
    shopt -u nullglob
fi

success "Successfully scaffolded .agdocs structure to $TARGET_DIR"
info ""
info "Next steps:"
info "  1. Initialize memory banks with project-specific content"
info "  2. Create project-specific command files if needed"
info "  3. Configure prompts and instructions for your project"
info "  4. Review and customize copied files"
