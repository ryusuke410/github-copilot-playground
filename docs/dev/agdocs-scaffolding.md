# AGDocs Scaffolding Script

## Overview

The `agdocs-scaffolding.sh` script sets up the `.agdocs` directory structure in a target directory, enabling AI-assisted development workflows in new projects. This script copies essential files and directories from a source repository while excluding project-specific local files.

## Quick Start

### Basic Usage

```bash
# Run from repository root
./scripts/agdocs-scaffolding.sh <target_directory>
```

### Example

```bash
# Scaffold into a new project
./scripts/agdocs-scaffolding.sh ../my-new-project

# Scaffold into a subdirectory
./scripts/agdocs-scaffolding.sh ./my-project
```

### What Gets Copied

The script copies the following structure:
- ✅ **Commands**: AI agent workflow definitions (`.agdocs/commands/*.md`)
- ✅ **Docs**: Memory bank documentation (`.agdocs/docs/`)
- ✅ **Templates**: Reusable templates (`.agdocs/templates/`)
- ✅ **Scripts**: Helper scripts (`.agdocs/scripts/`)
- ✅ **Prompts**: GitHub Copilot prompts (`.github/prompts/*.prompt.md`)
- ✅ **Instructions**: GitHub instructions (`.github/instructions/*.instructions.md`)

### What Doesn't Get Copied

- ❌ Local files (`*.local.md`, `*.local.prompt.md`, `*.local.instructions.md`)
- ❌ Project-specific memory banks (only `index.md` template is copied)
- ❌ **Swap directory** (temporary files, not part of scaffolded structure)

### After Scaffolding

1. Initialize memory banks with your project content
2. Create project-specific command files if needed
3. Configure prompts for your project
4. Customize copied files as needed

---

## Detailed Specifications

### Command Syntax

```bash
./scripts/agdocs-scaffolding.sh <target_directory>
```

**Parameters:**
- `<target_directory>`: Absolute or relative path where `.agdocs` structure will be created

### Prerequisites and Validation

**Requirements:**
- Script must be executed from repository root (`{{repo_root}}`)
- Target directory must be writable
- Source `.agdocs` directory must exist and be complete

**Validation checks:**
- Checks if target directory's `.agdocs` already exists
  - If exists: Exits with error
  - If not exists: Proceeds with scaffolding

### Execution Steps

The script performs these operations in sequence:

1. **Copy Commands**: Copies all `.md` files from `.agdocs/commands/`
   - **Excludes**: Files ending with `.local.md`
   - Creates target directory if needed

2. **Copy Docs**: Recursively copies `.agdocs/docs/` directory
   - Copies all subdirectories and files

3. **Copy Templates**: Recursively copies `.agdocs/templates/` directory  
   - Preserves directory structure

4. **Initialize Memory**: Creates `.agdocs/memory/` directory
   - Copies only `index.md` from `.agdocs/templates/memory/index.md`
   - Does not copy other memory bank files (project-specific)

5. **Copy Scripts**: Recursively copies `.agdocs/scripts/` directory
   - Preserves execute permissions

6. **Copy Prompts** (if exists): Copies `.prompt.md` files from `.github/prompts/`
   - **Excludes**: Files ending with `.local.prompt.md`
   - Skips if prompts directory doesn't exist

7. **Copy Instructions** (if exists): Copies `.instructions.md` files from `.github/instructions/`
   - **Excludes**: Files ending with `.local.instructions.md`  
   - Skips if instructions directory doesn't exist

### File Exclusion Rules

The script excludes the following file patterns:

- `*.local.md` - Local command definitions
- `*.local.prompt.md` - Local prompt configurations
- `*.local.instructions.md` - Local instruction files

These files typically contain project-specific or developer-specific configurations that should not be copied to new projects.

## Error Handling

### Error Conditions

1. **No target directory specified**
   - **Error**: "Usage: ./scripts/agdocs-scaffolding.sh <target_directory>"
   - **Exit code**: 1

2. **Target `.agdocs` already exists**
   - **Error**: "Error: .agdocs directory already exists in <target_directory>"
   - **Exit code**: 1

3. **Source `.agdocs` not found**
   - **Error**: "Error: Source .agdocs directory not found. Run this script from repository root."
   - **Exit code**: 1

4. **File operation failure**
   - **Error**: Descriptive message about which operation failed
   - **Exit code**: 1

### Success Output

```
Scaffolding .agdocs structure to <target_directory>...
Copying commands...
Copying docs...
Copying memory-bank examples...
Copying templates...
Initializing memory...
Copying scripts...
Copying prompts...
Copying instructions...
Successfully scaffolded .agdocs structure to <target_directory>
```

## Specifications

### Directory Creation

- Creates directories recursively as needed
- Preserves directory structure from source

### File Permissions

- Preserves execute permissions for scripts
- Standard read/write permissions for other files

### Symlinks

- Copies symlink targets (follows symlinks)
- Does not preserve symlinks themselves

### Hidden Files

- Copies `.gitignore` in swap directory
- Does not copy other hidden files unless explicitly specified

## Post-Scaffolding Steps

After running the scaffolding script, you should:

1. Initialize memory banks with project-specific content
2. Create project-specific command files if needed
3. Configure prompts and instructions for your project
4. Set up dev-log system if needed
5. Review and customize copied files

## Limitations

- Does not initialize git repository
- Does not create project-specific memory banks
- Does not configure project-specific commands
- Does not set up CI/CD or build tools
- Requires manual customization after scaffolding

## Troubleshooting

### Script reports "command not found"

Ensure the script has execute permissions:
```bash
chmod u+x scripts/agdocs-scaffolding.sh
```

### Script fails with "Source .agdocs directory not found"

Make sure you're running the script from the repository root:
```bash
cd /path/to/github-copilot-playground
./scripts/agdocs-scaffolding.sh <target>
```

### Files are missing in target

Verify the source `.agdocs` directory is complete and contains all expected files and directories.

## See Also

- Memory Bank: [Codebase Structure](../../.agdocs/memory/codebase-structure.md)
- Memory Bank: [Coding Guidelines](../../.agdocs/memory/coding-guidelines.md)
- Command: [initialize-memory-bank](../../.agdocs/commands/initialize-memory-bank.md)
