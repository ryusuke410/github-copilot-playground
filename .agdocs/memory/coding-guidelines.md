# Coding Guidelines

## Code Formatting

### Markdown Files
- Use ATX-style headers (`#` prefix)
- Leave blank lines before and after headers
- Use consistent list indentation (2 spaces for nested lists)
- Use fenced code blocks with language identifiers
- Maximum line length: 120 characters (flexible for URLs and tables)

### Shell Scripts
- Use `#!/bin/bash` shebang
- Use 2-space indentation
- Quote variables: `"$variable"`
- Use meaningful variable names in lowercase with underscores

## Naming Conventions

### Files and Directories
- **Markdown files**: kebab-case (e.g., `project-overview.md`)
- **Shell scripts**: kebab-case with `.sh` extension
- **Directories**: kebab-case
- **Placeholders**: snake_case with double braces (`{{variable_name}}`)

### Variables (in shell scripts)
- Use lowercase with underscores (snake_case)
- Constants: UPPER_CASE
- Descriptive names (e.g., `answer_file` not `af`)

## Notation Conventions

### Meta Placeholders
When expressing meta-level placeholders in documentation or templates, use the double-brace notation with snake_case:
- Format: `{{placeholder_name}}`
- Examples: `{{repo_root}}`, `{{user_name}}`, `{{file_path}}`

### Role References
When referring to roles in the development workflow:
- **ai-agent**: Refers to the AI assistant (GitHub Copilot or similar) following structured commands and documentation
- **human**: Refers to human users, especially in contexts where contrasted with ai-agent behavior

Examples:
- "The ai-agent reads the command file before starting work"
- "The human provides instructions through dev-log files"
- "Communication between human and ai-agent occurs via the query command"

### Usage Guidelines
- Use consistent role terminology throughout documentation
- Placeholders should be descriptive and use snake_case
- Always wrap placeholders in double braces to distinguish from actual values

## Comment Standards

### Markdown Documentation
- Use clear, concise language
- Provide examples for complex concepts
- Include context and rationale for decisions
- Document assumptions and constraints

### Shell Scripts
```bash
# Single-line comments for brief explanations
# before the relevant code

# Multi-line explanations
# span multiple lines
# like this
```

## Best Practices

### Documentation
1. **Write in English** (except ubiquitous language which includes Japanese)
2. **Be specific**: Provide concrete examples rather than abstract descriptions
3. **Keep it current**: Update docs when making changes
4. **Link related documents**: Use relative links to connect related content
5. **Use templates**: Follow established templates for consistency

### File Organization
1. Follow the established directory structure
2. Place files in appropriate directories
3. Keep related files together
4. Use descriptive filenames

### Git Practices
1. Write clear commit messages
2. Make atomic commits (one logical change per commit)
3. Don't commit generated or temporary files
4. Respect `.gitignore` rules (especially `.agdocs/swap/`)

### AI Agent Workflows
1. Read `yeah.md` and relevant command files before starting work
2. Use todo tool for task management
3. Check dev-log status regularly
4. Update memory banks when project structure changes
5. Ask for clarification when instructions are unclear

### Communication with Human
- All communication with the human should be conducted in Japanese
- Documentation and code must be in English (following language requirements)
- When asking questions or providing updates to the human, use Japanese
- Human instructions and responses may be in Japanese

### Shell Command Execution
- All commands are executed from `{{repo_root}}` (the repository root)
- When a command fails, consider the possibility that you are not in `{{repo_root}}`
- Always use subshells for `cd` commands: `(cd subdir && ls)` instead of `cd subdir && ls`
- Always use subshells for setting environment variables: `(export VAR=value && command)` instead of `export VAR=value && command`
- Use `chmod u+x` instead of `chmod +x` when making files executable
- Subshells ensure that directory changes and environment modifications don't affect the parent shell

## Language Requirements

### English-Only Content
- All documentation (except where noted)
- All code comments
- All commit messages
- Command definitions (`.agdocs/commands/*.md`)
- Documentation command files (`.agdocs/docs/commands/*.md`)
- Memory banks (with exception below)

### Japanese-Allowed Content
- Ubiquitous language entries (must include both English and Japanese)
- Human instructions in dev-logs
- User interaction prompts/responses

## Code Review Checklist

- [ ] All markdown files follow formatting guidelines
- [ ] Shell scripts have proper shebang and are executable
- [ ] File and directory names follow conventions
- [ ] Documentation is in English (except allowed exceptions)
- [ ] Links between documents work correctly
- [ ] No temporary or swap files included in commits
- [ ] Commit message is clear and descriptive
- [ ] Changes are reflected in relevant memory banks

## Tools and Linters

Currently, this project relies on manual review. Potential future additions:
- `markdownlint` for markdown consistency
- `shellcheck` for shell script validation

## Error Handling (Shell Scripts)

```bash
# Check for command success
if [ $? -ne 0 ]; then
    echo "Error: Command failed"
    exit 1
fi

# Check if file exists
if [ ! -f "path/to/file" ]; then
    echo "Error: File not found"
    exit 1
fi
```

## Documentation Templates

Use templates from `.agdocs/templates/` as starting points:
- Dev-log items: `.agdocs/templates/dev-logs/item/`
- Memory bank index: `.agdocs/templates/memory/index.md`
