# Suggested Commands

This document lists common commands used in this project's development workflow.

## Development

### Navigate to Project
```bash
cd /Users/ryusuke/nr/github-copilot-playground
```

### View Directory Structure
```bash
tree -L 3 -I '.git'
# or
ls -la
```

## Git Operations

### Check Status
```bash
git status
```

### View Differences
```bash
git diff
```

### Stage Changes
```bash
git add .agdocs/memory/*.md
git add .agdocs/docs/
```

### Commit Changes
```bash
git commit -m "Add memory bank system"
```

### Push to Remote
```bash
git push origin main
```

## File Operations

### Create Directories
```bash
mkdir -p .agdocs/memory
mkdir -p .agdocs/swap/dev-logs/items
```

### View File Contents
```bash
cat .agdocs/commands/dev-log.md
less .agdocs/docs/memory-bank/index.md
```

### Search for Content
```bash
grep -r "memory bank" .agdocs/
find .agdocs/ -name "*.md" -type f
```

## Script Execution

### Interactive Question Script
```bash
./scripts/ask-edit-answer.sh
```

### Query Script
```bash
./scripts/query.sh
```

## Memory Bank Operations

### Create Memory Bank Index
```bash
# Index file is manually maintained
code .agdocs/memory/index.md
```

### List Memory Banks
```bash
ls -1 .agdocs/memory/*.md
```

### View Memory Bank
```bash
cat .agdocs/memory/project-overview.md
```

## Dev-Log Operations

### List Dev-Logs
```bash
cat .agdocs/swap/dev-logs/index.md
```

### Navigate to Dev-Log
```bash
cd .agdocs/swap/dev-logs/items/memory-bank/
```

### View Dev-Log Status
```bash
cat .agdocs/swap/dev-logs/items/memory-bank/status.md
```

## Documentation

### Edit Documentation
```bash
code .agdocs/docs/memory-bank/index.md
```

### View Templates
```bash
ls -la .agdocs/templates/
```

## Troubleshooting

### Check File Permissions
```bash
ls -l scripts/*.sh
```

### Make Script Executable
```bash
chmod +x scripts/ask-edit-answer.sh
```

### View Recent Git History
```bash
git log --oneline -10
```

### Verify Directory Structure
```bash
tree -L 2 .agdocs/
```

## Notes

- Most work in this project is file creation and documentation
- No compilation or build steps required
- Scripts are mainly for interactive workflows with AI agents
- The `.agdocs/swap/` directory is git-ignored
