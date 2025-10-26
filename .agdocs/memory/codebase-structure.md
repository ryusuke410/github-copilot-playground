# Codebase Structure

## Directory Organization

```
github-copilot-playground/
├── .agdocs/                    # AI agent documentation
│   ├── commands/               # Command definitions for AI workflows
│   │   ├── yeah.md
│   │   ├── commit-push-pr.md
│   │   ├── review-pr.md
│   │   ├── create-dev-branch.md
│   │   ├── add-command.md
│   │   ├── dev-log.md
│   │   ├── initialize-memory-bank.md
│   │   ├── update-memory-bank-targeted.md
│   │   └── update-memory-bank-comprehensive.md
│   ├── docs/                   # Documentation
│   │   └── memory-bank/
│   │       ├── index.md
│   │       ├── initial-setup.md
│   │       └── examples/       # Memory bank examples
│   │           ├── github-operations.md
│   │           ├── language.md
│   │           ├── notation.md
│   │           └── shell-command.md
│   ├── memory/                 # Memory bank files (project knowledge)
│   │   ├── index.md
│   │   ├── project-overview.md
│   │   ├── codebase-structure.md
│   │   ├── coding-guidelines.md
│   │   ├── suggested-commands.md
│   │   ├── ubiquitous-language.md
│   │   └── github-operations.md
│   ├── scripts/                # Helper scripts
│   │   └── ask-edit-answer.sh
│   ├── swap/                   # Git-ignored working files
│   │   ├── dev-logs/
│   │   │   ├── index.md
│   │   │   └── items/
│   │   │       └── {{dev-log-name}}/
│   │   └── answer.md
│   └── templates/              # Templates for various structures
│       ├── dev-logs/
│       │   ├── index.md
│       │   └── item/
│       │       └── *.md
│       └── memory/
│           └── index.md
├── .github/                    # GitHub configuration
│   ├── prompts/                # Custom GitHub Copilot prompts
│   │   ├── awake.prompt.md
│   │   ├── yeah.prompt.md
│   │   ├── commit-push-pr.prompt.md
│   │   ├── create-dev-branch.prompt.md
│   │   ├── dev-log.prompt.md
│   │   └── review-pr.prompt.md
│   └── instructions/           # GitHub instructions (if any)
├── .vscode/                    # VS Code configuration
│   └── settings.json           # Terminal command auto-approval rules
├── docs/                       # Development documentation
│   └── dev/
│       └── agdocs-scaffolding.md  # Scaffolding script documentation
├── scripts/                    # Development scripts
│   └── agdocs-scaffolding.sh  # AGDocs installation script
├── README.md                   # Project overview and features
├── CONTRIBUTING.md             # Development guidelines
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

**Special case - awake.prompt.md:**
This is a standalone prompt file that does NOT reference a command file. It contains complete instructions for keeping the ai-agent active during extended work sessions. It provides task management rules, context reloading triggers, and query commands for continuous human interaction.

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
Helper scripts for interactive workflows (e.g., user input collection) and development automation.

### Root Documentation Files

- **`README.md`**: Project overview, features, and quick start guide. Explains:
  - AGDocs framework and AI-assisted workflows
  - `/yeah` command and its importance
  - `.agdocs` directory structure
  - AGDocs scaffolding script usage
  - Memory bank system overview

- **`CONTRIBUTING.md`**: Development guidelines for contributors. Includes:
  - Setup instructions and prerequisites
  - Development workflow and best practices
  - Code style conventions and commit message format
  - PR guidelines and review process
  - Common tasks and troubleshooting

### `docs/dev/`
Development documentation directory containing:
- `agdocs-scaffolding.md`: Comprehensive guide for the AGDocs scaffolding script

## Configuration Files

- **`.gitignore`** - Excludes `.agdocs/swap/` directory
- **`.vscode/settings.json`** - VS Code workspace settings, including:
  - `chat.tools.terminal.autoApprove` - Auto-approval rules for terminal commands executed by AI agent
  - Rules for git commands, file operations, and project-specific scripts
  - Whitelist patterns for safe commands, blacklist patterns for dangerous operations
