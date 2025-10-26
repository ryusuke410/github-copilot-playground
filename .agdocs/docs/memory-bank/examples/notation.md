# Notation Standards

## Notation Conventions

### Meta Placeholders
When expressing meta-level placeholders in documentation or templates, use the double-brace notation with snake_case:
- Format: `{{placeholder_name}}`
- Examples: `{{repo_root}}`, `{{user_name}}`, `{{file_path}}`

Do not use other formats like `$PLACEHOLDER`, `%PLACEHOLDER%`, or `<PLACEHOLDER>`.

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
