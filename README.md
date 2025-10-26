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

## The `.agdocs` Directory

The `.agdocs` directory is the heart of this AI-assisted development system:

```
.agdocs/
├── commands/              # AI agent workflow definitions
│   ├── yeah.md           # Core AI agent rules
│   ├── commit-push-pr.md # Git workflow automation
│   ├── review-pr.md      # PR review workflow
│   └── create-dev-branch.md  # Branch creation workflow
├── docs/                  # Documentation
│   └── memory-bank/      # Memory bank system docs
│       ├── index.md
│       ├── initial-setup.md
│       └── examples/     # Example memory banks
├── memory/                # Project knowledge (memory banks)
│   ├── index.md
│   ├── project-overview.md
│   ├── coding-guidelines.md
│   └── codebase-structure.md
├── scripts/               # Helper scripts
│   └── ask-edit-answer.sh
├── swap/                  # Git-ignored working files
│   └── dev-logs/         # Task tracking
└── templates/             # Reusable templates
    ├── dev-logs/
    └── memory/
```

### Key Components

- **Commands**: Structured instructions for AI workflows (e.g., creating branches, reviewing PRs, committing code)
- **Memory Banks**: Project knowledge repository in markdown format
- **Prompts**: GitHub Copilot entry points that reference command files
- **Scripts**: Interactive helpers for user input collection
- **Dev-Logs**: Task management system for complex work

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
- **`commit-push-pr.md`**: Automated git commit, push, and PR creation
- **`review-pr.md`**: Systematic PR review workflow
- **`create-dev-branch.md`**: Development branch creation from main
- **`add-command.md`**: Create new command files
- **`dev-log.md`**: Task management with dev-logs
- **`initialize-memory-bank.md`**: Memory bank initialization
- **`update-memory-bank-targeted.md`**: Targeted memory bank updates
- **`update-memory-bank-comprehensive.md`**: Comprehensive memory bank updates

## Memory Bank System

Memory banks store project knowledge in a structured, AI-readable format:

- **Project Overview**: Purpose, stakeholders, architecture
- **Coding Guidelines**: Style guides, naming conventions, best practices
- **Codebase Structure**: Directory organization, module structure
- **Ubiquitous Language**: Domain terminology
- **GitHub Operations**: API usage patterns and workflows

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
