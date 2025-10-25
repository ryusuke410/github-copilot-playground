# Memory Bank

## Overview

Memory Bank is a knowledge management system for storing project information as markdown files. It provides a centralized repository for project knowledge including configuration, rules, procedures, and domain terminology.

## Directory Structure

```
.agdocs/
  memory/
    index.md           # Index table of all memory banks
    **/*.md            # Memory bank files
  docs/
    memory-bank/
      index.md         # This documentation
      initial-setup.md # Setup guide
```

## Usage

**Reading**: Read memory banks to understand project structure, rules, terminology, and standards.

**Writing**: Create or update memory banks when project configuration changes, new rules are established, or important decisions are documented.

**Language**: All content must be in English, except ubiquitous language which includes both English and Japanese terms.

## Memory Bank Index

The index file (`.agdocs/memory/index.md`) contains a table with:
- File Path
- Title
- Description
- Last Updated

The index contains only the table, no additional content.

## Best Practices

- Keep each memory bank focused on a specific topic
- Update regularly as the project evolves
- Use clear structure with headings and examples
- Cross-reference related memory banks
- Keep the index synchronized with actual files

For initial setup instructions, see [initial-setup.md](./initial-setup.md).

