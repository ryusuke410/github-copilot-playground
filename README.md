# GitHub Copilot Playground

A repository for experimenting with AI-assisted development workflows using GitHub Copilot, structured documentation systems, and the AGDocs framework.

## Features

### 🤖 AI-Assisted Development Workflows

This repository provides a comprehensive framework for building AI-assisted development workflows:

- **Structured Command System**: Pre-defined workflows for common development tasks
- **Memory Bank System**: Project knowledge management with markdown files
- **Custom GitHub Copilot Prompts**: Entry points for AI agent workflows
- **Dev-Log System**: Task management and progress tracking

### 📦 AGDocs Scaffolding

Install the `.agdocs` directory structure into new projects:

```bash
./scripts/agdocs-scaffolding.sh /path/to/new-project
```

The scaffolding script copies:
- Command definitions for AI workflows
- Memory bank documentation templates
- Helper scripts and tools
- GitHub Copilot prompts

[Learn more about AGDocs Scaffolding](docs/dev/agdocs-scaffolding.md)

### 🔄 `/yeah` Command

The `/yeah` command is a critical component for continuous AI agent operation. It ensures the AI agent:
- Never ends the conversation prematurely
- Maintains workflow context across operations
- Follows structured task management
- Reloads critical instructions automatically

**Usage:**
1. Open GitHub Copilot Chat
2. Type `/yeah` 
3. Follow with your task description or instructions

The `/yeah` command loads `.agdocs/commands/yeah.md`, which contains the core rules for AI agent behavior.

### 🌟 `awake` Prompt

The `awake` prompt is a standalone version of the `/yeah` command, designed for continuous AI agent operation without requiring the full command file setup.

**Key Features:**
- **Continuous Operation**: Keeps the AI agent active and working without ending the conversation
- **Task Management**: Uses the todo tool to track progress across multi-step work
- **Context Preservation**: Automatically reloads critical instructions when the context window is compressed
- **Interactive Queries**: Prompts the user for input when clarification is needed or tasks are complete

**Usage:**
1. Open GitHub Copilot Chat
2. Attach `awake.prompt.md` to your chat
3. Provide your task instructions

**When to Use:**
- Long-running tasks that require multiple steps
- Situations where you want the AI agent to manage its own workflow
- When you need continuous interaction without manual intervention

The `awake` prompt is particularly useful for:
- Complex refactoring tasks
- Multi-file updates
- Documentation generation
- Systematic code reviews

Unlike `/yeah`, which references a command file, `awake` contains complete instructions within the prompt file itself, making it self-contained and easy to use in any context.

## The `.agdocs` Directory

The `.agdocs` directory is the heart of this AI-assisted development system:

```
.agdocs/
├── commands/              # AI agent workflow definitions
│   ├── yeah.md           # Core AI agent rules
│   ├── add-command.md    # Create new command files
│   ├── commit-push-pr.md # Git workflow automation
│   ├── create-dev-branch.md  # Branch creation workflow
│   ├── create-issue.md   # GitHub issue creation
│   ├── dev-log.md        # Task management with dev-logs
│   ├── initialize-memory-bank.md  # Memory bank initialization
│   ├── review-pr.md      # PR review workflow
│   ├── simple-task.md    # Lightweight task management
│   ├── update-docs.md    # Documentation update workflow
│   ├── update-issue.md   # GitHub issue update
│   ├── update-pr.md      # PR description update
│   ├── update-memory-bank-comprehensive.md  # Comprehensive updates
│   └── update-memory-bank-targeted.md  # Targeted updates
├── docs/                  # Documentation
│   ├── commands/         # Command documentation
│   │   └── index.md      # Command list and descriptions
│   └── memory-bank/      # Memory bank system docs
│       ├── index.md
│       ├── initial-setup.md
│       └── examples/     # Example memory banks
│           ├── github-operations.md
│           └── ai-agent-best-practices.md
├── memory/                # Project knowledge (memory banks)
│   ├── index.md
│   ├── project-overview.md
│   ├── codebase-structure.md
│   ├── coding-guidelines.md
│   ├── ubiquitous-language.md
│   ├── suggested-commands.md
│   ├── github-operations.md
│   └── ai-agent-best-practices.md
├── scripts/               # Helper scripts
│   └── ask-edit-answer.sh
├── swap/                  # Git-ignored working files
│   ├── dev-logs/         # Dev-log task tracking
│   ├── simple-tasks/     # Simple task tracking
│   └── review-pr/        # PR review tracking
└── templates/             # Reusable templates
    ├── commands/         # Command templates
    ├── dev-logs/         # Dev-log templates
    ├── simple-tasks/     # Simple task templates
    ├── review-pr/        # PR review templates
    ├── github-issues/    # GitHub issue templates
    └── memory/           # Memory bank templates
```

### Key Components

- **Commands**: Structured instructions for AI workflows (e.g., creating branches, reviewing PRs, committing code, managing GitHub issues)
- **Memory Banks**: Project knowledge repository in markdown format
- **Prompts**: GitHub Copilot entry points that reference command files
- **Scripts**: Interactive helpers for user input collection
- **Dev-Logs**: Task management system for complex work
- **Simple Tasks**: Lightweight task management for one-off work
- **Templates**: Reusable structures for commands, tasks, and documentation

## Getting Started

### Prerequisites

- Git
- GitHub CLI (`gh`)
- GitHub Copilot subscription
- VS Code (recommended)

### Quick Start

1. **Clone this repository:**
   ```bash
   git clone https://github.com/ryusuke410/github-copilot-playground.git
   cd github-copilot-playground
   ```

2. **Use the `/yeah` command:**
   - Open GitHub Copilot Chat in VS Code
   - Type `/yeah` followed by your task
   - Example: `/yeah create a new development branch`

3. **Scaffold into a new project:**
   ```bash
   ./scripts/agdocs-scaffolding.sh /path/to/your-project
   ```

## Available Commands

The `.agdocs/commands/` directory contains pre-defined workflows:

- **`yeah.md`**: Core AI agent behavior and rules
- **`add-command.md`**: Create new command files
- **`commit-push-pr.md`**: Automated git commit, push, and PR creation
- **`create-dev-branch.md`**: Development branch creation from main
- **`create-issue.md`**: Create structured GitHub issues from templates
- **`dev-log.md`**: Task management with dev-logs
- **`initialize-memory-bank.md`**: Memory bank initialization
- **`review-pr.md`**: Systematic PR review workflow
- **`simple-task.md`**: Lightweight mechanism for managing one-off task groups
- **`update-docs.md`**: Update repository documentation to reflect current reality
- **`update-issue.md`**: Update existing GitHub issue title and/or description
- **`update-memory-bank-comprehensive.md`**: Comprehensive memory bank updates
- **`update-memory-bank-targeted.md`**: Targeted memory bank updates
- **`update-pr.md`**: Update PR description based on current changes

## GitHub Copilot Prompts

The `.github/prompts/` directory contains custom prompts for GitHub Copilot:

- **`awake.prompt.md`**: Standalone prompt for continuous AI agent operation
- **`commit-push-pr.prompt.md`**: Entry point for commit, push, and PR workflow
- **`create-dev-branch.prompt.md`**: Entry point for branch creation workflow
- **`create-issue.prompt.md`**: Entry point for GitHub issue creation workflow
- **`dev-log.prompt.md`**: Entry point for dev-log task management
- **`review-pr.prompt.md`**: Entry point for PR review workflow
- **`simple-task.prompt.md`**: Entry point for simple task management workflow
- **`update-docs.prompt.md`**: Entry point for documentation update workflow
- **`update-issue.prompt.md`**: Entry point for GitHub issue update workflow
- **`update-pr.prompt.md`**: Entry point for PR description update workflow
- **`yeah.prompt.md`**: Entry point for the yeah command workflow

Most prompts reference their corresponding command files in `.agdocs/commands/`, except `awake.prompt.md` which is self-contained.

## Memory Bank System

Memory banks store project knowledge in a structured, AI-readable format:

- **Project Overview**: Purpose, stakeholders, architecture
- **Codebase Structure**: Directory organization, module structure
- **Coding Guidelines**: Style guides, naming conventions, best practices
- **Ubiquitous Language**: Domain terminology
- **Suggested Commands**: Common development and git commands
- **GitHub Operations**: API usage patterns and workflows
- **AI Agent Best Practices**: Guidelines for AI agents working in the codebase

Memory banks enable the AI agent to understand your project deeply and provide contextually appropriate suggestions.

## Documentation

- [AGDocs Scaffolding Documentation](docs/dev/agdocs-scaffolding.md)
- [Memory Bank System](.agdocs/docs/memory-bank/index.md)
- [Memory Bank Initial Setup](.agdocs/docs/memory-bank/initial-setup.md)
- [Memory Bank Examples](.agdocs/docs/memory-bank/examples/)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines.

## License

This is an experimental/playground repository. Use at your own discretion.

## Acknowledgments

Built with GitHub Copilot to explore AI-assisted development workflows and structured documentation systems.
