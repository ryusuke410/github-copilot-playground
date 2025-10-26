# Codebase Structure

## Directory Organization

```
github-copilot-playground/
├── .agdocs/                    # AI agent documentation
│   ├── commands/               # Command definitions for AI workflows
│   │   ├── dev-log.md
│   │   ├── initialize-memory-bank.md
│   │   └── yeah.md
│   ├── docs/                   # Documentation
│   │   └── memory-bank/
│   │       ├── index.md
│   │       └── initial-setup.md
│   ├── memory/                 # Memory bank files (project knowledge)
│   │   ├── index.md
│   │   └── *.md
│   ├── scripts/                # Helper scripts
│   ├── swap/                   # Git-ignored working files
│   │   ├── dev-logs/
│   │   │   ├── index.md
│   │   │   └── items/
│   │   │       └── {{dev-log-name}}/
│   │   └── answer.md
│   ├── templates/              # Templates for various structures
│   │   ├── dev-logs/
│   │   │   ├── index.md
│   │   │   └── item/
│   │   │       └── *.md
│   │   └── memory/
│   │       └── index.md
│   └── yeah*.md                # Various yeah.md versions
├── .github/                    # GitHub configuration
│   └── prompts/                # Custom GitHub Copilot prompts
│       ├── dev-log.prompt.md
│       └── yeah.prompt.md
├── .vscode/                    # VS Code configuration
├── scripts/                    # Development scripts
│   ├── ask-edit-answer.sh
│   └── query.sh
└── .git/                       # Git repository data
```

## Module Structure

The project is organized around ai-agent workflows:

### Commands Module (`commands/`)
Defines specific ai-agent behaviors and workflows. These files contain the actual instructions and procedures that the ai-agent follows.

### Prompt Entry Points (`.github/prompts/`)
Custom prompts that serve as entry points for ai-agent workflows. These files typically contain simple instructions to read the corresponding command file, such as:
```
Read {{repo_root}}/.agdocs/commands/command-name.md
```

**Key distinction:**
- **Prompt files** (`.github/prompts/*.prompt.md`): Entry points that reference command files
- **Command files** (`.agdocs/commands/*.md`): Actual content with detailed instructions

### Memory Bank (`memory/`)
Stores project knowledge in markdown files

### Dev-Log System (`swap/dev-logs/`)
Manages development task tracking

### Templates (`templates/`)
Provides reusable structures for documents

## File Naming Conventions

- **Commands**: kebab-case with `.md` extension (e.g., `dev-log.md`)
- **Memory Banks**: kebab-case with `.md` extension (e.g., `project-overview.md`)
- **Templates**: Match target file names
- **Scripts**: kebab-case with `.sh` extension

## Key Directories

### `.agdocs/`
Central directory for all ai-agent documentation and knowledge management. This directory structure enables structured AI-assisted development.

### `.agdocs/commands/`
Contains command definition files (`.md`) that define detailed ai-agent behaviors and workflows. These are the actual instruction content.

### `.github/prompts/`
Contains prompt entry point files (`.prompt.md`) that configure GitHub Copilot behavior. These typically reference command files in `.agdocs/commands/` using patterns like `Read {{repo_root}}/.agdocs/commands/command-name.md`.

### `.agdocs/swap/`
**Git-ignored directory** for temporary working files and dev-logs. Content here is ephemeral and not version controlled.

### `.agdocs/memory/`
Permanent knowledge repository. Files here document project structure, rules, and domain knowledge.

### `.github/prompts/`
Custom prompts that configure GitHub Copilot behavior for specific workflows.

### `scripts/`
Helper scripts for interactive workflows (e.g., user input collection).

## Configuration Files

Currently minimal:
- `.gitignore` - Excludes `.agdocs/swap/` directory
- VS Code workspace settings (if any)
