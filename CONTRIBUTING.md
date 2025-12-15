# Contributing to GitHub Copilot Playground

Thank you for your interest in contributing to this experimental AI-assisted development framework!

## Overview

This project explores AI-assisted development workflows using GitHub Copilot, structured documentation, and the AGDocs framework. Contributions should align with this experimental and exploratory nature.

## Getting Started

### Prerequisites

- **Git** and **GitHub CLI** (`gh`)
- **GitHub Copilot** subscription
- **VS Code** (recommended editor)
- Basic understanding of:
  - GitHub Copilot and AI-assisted development
  - Markdown documentation
  - Shell scripting (Bash)

### Setting Up Your Development Environment

1. **Fork and clone the repository:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/github-copilot-playground.git
   cd github-copilot-playground
   ```

2. **Test the `/yeah` command:**
   - Open VS Code
   - Open GitHub Copilot Chat
   - Type `/yeah` followed by a test task

3. **Run the scaffolding script:**
   ```bash
   # Test in a temporary directory
   ./scripts/agdocs-scaffolding.sh /tmp/test-scaffold
   ```

## Development Workflow

### Creating a Development Branch

Use the `/yeah` command with instructions:

```
/yeah create a development branch for [your feature]
```

Or manually:

```bash
git fetch origin --prune
git checkout -b feature/your-feature-name origin/main
```

### Making Changes

Follow these guidelines based on what you're modifying:

#### Command Files (`.agdocs/commands/*.md`)

- Use clear, imperative language
- Break complex workflows into numbered steps
- Include usage examples
- Follow the structure of existing command files
- Test commands with GitHub Copilot

#### Memory Banks (`.agdocs/memory/*.md`)

- Keep content focused on a single topic
- Use English (except ubiquitous language)
- Update `.agdocs/memory/index.md` when adding/modifying files
- Include concrete examples

#### Documentation (`docs/**/*.md`)

- Write in English
- Use clear headings and structure
- Provide code examples where applicable
- Link to related documentation

#### Scripts (`scripts/*.sh`)

- Follow bash best practices
- Include error handling
- Add comments for complex logic
- Test thoroughly before committing

### Code Style and Conventions

#### Markdown Files

- Use ATX-style headers (`#` prefix)
- Leave blank lines before and after headers
- Use fenced code blocks with language identifiers
- Maximum line length: 120 characters (flexible for URLs)

#### File Naming

- **Markdown files**: `kebab-case.md`
- **Shell scripts**: `kebab-case.sh`
- **Directories**: `kebab-case`
- **Placeholders**: `{{snake_case}}`

#### Commit Messages

Follow conventional commits format:

```
type(scope): description

feat: add new command for deployment automation
fix: resolve git fetch command error
docs: update memory bank setup guide
chore: update scaffolding script permissions
```

**Types:**
- `feat`: New features
- `fix`: Bug fixes
- `docs`: Documentation changes
- `refactor`: Code restructuring
- `test`: Test additions/modifications
- `chore`: Maintenance tasks

### Testing Your Changes

1. **Test command files:**
   - Use `/yeah` to test command workflows
   - Verify all steps execute correctly
   - Check for clear error messages

2. **Test scripts:**
   ```bash
   # Test scaffolding script
   ./scripts/agdocs-scaffolding.sh /tmp/test-dir
   
   # Verify copied structure
   ls -la /tmp/test-dir/.agdocs
   ```

3. **Test documentation:**
   - Read through your changes
   - Verify all links work
   - Check code examples are accurate

### Submitting Changes

#### 1. Commit Your Changes

```bash
git add .
git status  # Review changes
git commit -m "type: description"
```

#### 2. Push to Your Fork

```bash
git push -u origin HEAD
```

#### 3. Create a Pull Request

```bash
gh pr create --title "Brief description" --body "## 変更内容

Detailed description of changes

## レビュー時に確認

Points to review"
```

Or use the `/yeah` command:
```
/yeah commit, push, and create PR
```

## Pull Request Guidelines

### PR Title and Description

- Use descriptive, concise titles
- Include detailed description of changes
- Explain the motivation and context
- List any breaking changes
- Mention related issues or PRs

### PR Review Process

1. **Self-review:**
   - Review your own changes before submitting
   - Check for typos and formatting
   - Verify all tests pass

2. **Address feedback:**
   - Respond to review comments promptly
   - Make requested changes
   - Re-request review when ready

3. **Merge:**
   - Ensure CI checks pass
   - Wait for approval
   - Squash and merge (preferred)

## Project Structure

Key directories and their purposes:

```
.agdocs/
├── commands/         # AI workflow definitions
├── docs/            # Documentation
│   ├── commands/   # Command documentation
│   └── memory-bank/  # Memory bank system docs
├── memory/          # Project knowledge (memory banks)
├── scripts/         # Helper scripts
├── swap/            # Git-ignored working files
│   ├── dev-logs/   # Dev-log tracking
│   ├── simple-tasks/  # Simple task tracking
│   └── review-pr/  # PR review tracking
└── templates/       # Reusable templates
    ├── commands/   # Command templates
    ├── dev-logs/   # Dev-log templates
    ├── simple-tasks/  # Simple task templates
    ├── review-pr/  # PR review templates
    ├── github-issues/  # GitHub issue templates
    └── memory/     # Memory bank templates

.github/
├── instructions/    # AI agent instructions
│   ├── yeah.local.instructions.md  # Personal instructions (git-ignored)
│   └── yeah.local.instructions.example.md  # Example template
└── prompts/         # GitHub Copilot entry points

docs/
└── dev/            # Development documentation

scripts/
└── agdocs-scaffolding.sh  # Installation script
```

## Documentation Standards

### Language Requirements

**English-only content:**
- All documentation
- All code comments
- All commit messages
- Command definitions
- Memory banks (except ubiquitous language)

**Japanese-allowed content:**
- PR descriptions
- Ubiquitous language entries (bilingual)
- Human interaction prompts

### Notation Conventions

- **Placeholders**: `{{snake_case}}`
- **Role references**: `ai-agent`, `human`
- **Repository root**: `{{repo_root}}`

## Common Tasks

### Adding a New Command

1. Create command file: `.agdocs/commands/new-command.md`
2. Follow existing command structure
3. Create prompt entry point: `.github/prompts/new-command.prompt.md`
4. Update relevant documentation
5. Test with `/yeah` command

### Adding a Memory Bank

1. Create markdown file: `.agdocs/memory/new-topic.md`
2. Add entry to `.agdocs/memory/index.md`
3. Follow memory bank structure
4. Include examples where applicable

### Updating Documentation

1. Make changes in appropriate `docs/` directory
2. Update cross-references as needed
3. Verify links work correctly
4. Update table of contents if applicable

## Troubleshooting

### Script Permission Issues

```bash
chmod u+x scripts/agdocs-scaffolding.sh
chmod u+x .agdocs/scripts/*.sh
```

### GitHub CLI Authentication

```bash
gh auth login
gh auth refresh -h github.com
```

### Git Issues

```bash
# Reset changes
git reset --hard origin/main

# Clean untracked files
git clean -fd
```

## Getting Help

- Open an issue for bugs or feature requests
- Use discussions for questions
- Review existing PRs and issues for examples

## Code of Conduct

- Be respectful and professional
- Provide constructive feedback
- Focus on the code, not the person
- Help create a welcoming environment

## License

By contributing, you agree that your contributions will be licensed under the same terms as the project.

Thank you for contributing to the GitHub Copilot Playground!
