# add-command Command

## Overview

This command creates a new command file in `.agdocs/commands/` and optionally creates a corresponding prompt entry point in `.github/prompts/`.

## Instructions

When a human requests to create a new command, follow these steps:

### 1. Read Documentation

Read the following files to understand the command system:
- `.agdocs/docs/memory-bank/index.md` - Memory bank system documentation
- `.agdocs/memory/codebase-structure.md` - Understand command/prompt architecture
- `.agdocs/memory/coding-guidelines.md` - Follow naming and formatting conventions

### 2. Clarify Requirements

Understand what the new command should do:
- Command name (will be kebab-case, e.g., `new-command.md`)
- Purpose and overview of the command
- Detailed instructions and workflow steps
- Whether a prompt entry point is needed in `.github/prompts/`
- Any related commands or templates

### 3. Review Existing Commands

Read 1-2 existing command files as examples:
- `.agdocs/commands/initialize-memory-bank.md` - Example of setup command
- `.agdocs/commands/update-memory-bank-targeted.md` - Example of update command
- `.agdocs/commands/dev-log.md` - Example of workflow command

### 4. Create the Command File

Create a new file in `.agdocs/commands/{{command_name}}.md` with the following structure:

```markdown
# {{command_name}} Command

## Overview

[Brief description of what this command does and when to use it]

## Instructions

When a human requests [describe the trigger], follow these steps:

### 1. [First Step Title]

[Detailed instructions for the first step]

### 2. [Second Step Title]

[Detailed instructions for the second step]

[Continue with additional steps as needed]

## Usage Examples

[Optional: Provide concrete examples of how to use this command]

## Notes

- [Important considerations]
- [Edge cases or limitations]
- [Best practices specific to this command]

## Related Commands

- `related-command-1` - [Brief description]
- `related-command-2` - [Brief description]
```

### 5. Create Prompt Entry Point (Optional)

If requested, create `.github/prompts/{{command_name}}.prompt.md`:

```markdown
Read {{repo_root}}/.agdocs/commands/{{command_name}}.md
```

Or with additional context if needed:

```markdown
1. Read {{repo_root}}/.agdocs/commands/{{command_name}}.md
2. Follow human instructions.
```

### 6. Verify Structure

Ensure the new files follow conventions:
- Command file uses kebab-case naming
- Content is in English
- Follows markdown formatting guidelines
- Uses proper placeholder notation (`{{variable_name}}`)
- Includes all required sections (Overview, Instructions, Notes)
- References related commands if applicable

### 7. Update Documentation

Consider updating related documentation:
- Add entry to `.agdocs/memory/suggested-commands.md` if it's a commonly used command
- Update `.agdocs/memory/codebase-structure.md` if it introduces new patterns
- Cross-reference from related command files

### 8. Report Completion

Inform the human about:
- The command file created and its location
- The prompt entry point created (if applicable)
- How to use the new command
- Any related documentation updated

## Usage Examples

### Example 1: Simple command without prompt entry point

```
Human: Create a command to list all dev-logs
AI-agent: [Creates .agdocs/commands/list-dev-logs.md with appropriate content]
```

### Example 2: Command with prompt entry point

```
Human: Create a command called "deploy" with a prompt file
AI-agent: 
[Creates .agdocs/commands/deploy.md]
[Creates .github/prompts/deploy.prompt.md]
```

### Example 3: Command that extends existing workflow

```
Human: Create a command to archive completed dev-logs
AI-agent: 
[Creates .agdocs/commands/archive-dev-log.md]
[Updates related commands to cross-reference]
```

## Notes

- All command files must be in English
- Use clear, imperative language in instructions
- Break complex workflows into numbered steps
- Include examples when the command has parameters or options
- Always read documentation first to understand the system
- Maintain consistency with existing command file structure
- If the command introduces new concepts, consider updating memory banks
- Prompt entry points are optional but useful for frequently used commands

## Related Commands

- `update-memory-bank-targeted` - For updating documentation after adding commands
- `initialize-memory-bank` - Example of well-structured command file
