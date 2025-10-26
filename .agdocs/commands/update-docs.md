# update-docs Command

## Overview

This command updates repository documentation files (README.md, CONTRIBUTING.md, etc.) to reflect the current reality of the project. Use this when project structure, features, or workflows have changed and documentation needs to be synchronized.

## Instructions

When a human requests to update repository documentation, follow these steps:

### 1. Read Documentation System

Read the following files to understand the current project:
- `.agdocs/memory/index.md` - Memory bank index
- `.agdocs/memory/project-overview.md` - Current project overview
- `.agdocs/memory/codebase-structure.md` - Current codebase structure
- `.agdocs/memory/coding-guidelines.md` - Coding conventions
- `.agdocs/memory/suggested-commands.md` - Available commands

### 2. Identify Documentation Files

List all documentation files that may need updates:
- `README.md` - Project overview, features, quick start
- `CONTRIBUTING.md` - Development guidelines and contribution process
- `docs/` - Additional documentation directories
- Other markdown files in the project root

### 3. Investigate Current Reality

Perform comprehensive investigation of the actual project state:
- List all files and directories in the project
- Check `.agdocs/commands/` for available command files
- Check `.github/prompts/` for prompt entry points
- Review `scripts/` for available scripts
- Examine any configuration files (`.vscode/settings.json`, etc.)
- Note any recent changes or additions

### 4. Compare Documentation with Reality

For each documentation file:
- Read the current content
- Identify discrepancies with actual project state
- Note outdated information
- Identify missing features or components
- Check for broken links or references

Create a checklist of updates needed:
- [ ] Outdated feature descriptions
- [ ] Missing new features
- [ ] Incorrect directory structures
- [ ] Broken or outdated links
- [ ] Changed workflows or commands
- [ ] New tools or dependencies

### 5. Plan Updates

Organize updates by priority:

**High Priority:**
- Incorrect or misleading information
- Broken links or references
- Missing critical features
- Outdated setup instructions

**Medium Priority:**
- Incomplete feature descriptions
- Missing examples
- Outdated usage patterns

**Low Priority:**
- Formatting improvements
- Additional examples
- Minor clarifications

### 6. Execute Updates

For each documentation file:

**README.md:**
- Update "Features" section with current capabilities
- Verify directory structure diagrams
- Update command lists and examples
- Check "Getting Started" instructions
- Update links to other documentation
- Verify installation/setup steps

**CONTRIBUTING.md:**
- Update development workflow if changed
- Verify setup instructions
- Check code style guidelines
- Update testing procedures
- Verify PR process documentation
- Update troubleshooting section

**Other documentation:**
- Update technical documentation
- Refresh API documentation
- Update usage examples
- Fix broken links

### 7. Verify Links and References

Check all links in updated documentation:
- Internal links to other files
- Links to directories
- Links to external resources
- Cross-references between documents

### 8. Update Examples

Ensure all code examples and command examples are:
- Accurate and working
- Using current syntax
- Referencing existing files
- Following current conventions

### 9. Check Consistency

Verify consistency across all documentation:
- Terminology matches ubiquitous language
- Command names match actual files
- Directory paths are correct
- Formatting is consistent
- English is used throughout (except for specified exceptions)

### 10. Report Changes

Provide a summary of:
- Which documentation files were updated
- What changes were made to each
- Any information that needs human verification
- Recommendations for future documentation improvements

## Usage Examples

### Example 1: Update after adding new commands

```
Human: We added several new commands. Update the documentation to reflect them.

AI-agent:
1. Reads .agdocs/commands/ directory
2. Identifies new command files: deploy.md, test.md
3. Updates README.md "Available Commands" section
4. Updates CONTRIBUTING.md with new workflow steps
5. Reports completion
```

### Example 2: Update after restructuring project

```
Human: The project structure changed. Update all documentation.

AI-agent:
1. Investigates current directory structure
2. Updates README.md directory tree diagram
3. Updates CONTRIBUTING.md file organization section
4. Updates docs/dev/ documentation
5. Verifies all links still work
6. Reports changes made
```

### Example 3: Sync documentation after feature additions

```
Human: Update docs to reflect current reality.

AI-agent:
1. Reads memory banks for current project state
2. Compares with README.md and CONTRIBUTING.md
3. Identifies: 3 new features, 2 new commands, 1 removed dependency
4. Updates README.md features and setup
5. Updates CONTRIBUTING.md workflow
6. Reports all changes
```

## Notes

- Always investigate actual project state before making updates
- Don't assume documentation is completely wrong - verify each change
- Preserve the original tone and style of documentation
- Keep README.md concise and focused on essential information
- Keep CONTRIBUTING.md detailed and comprehensive
- Update memory banks if you discover project state changes during investigation
- Test examples and commands before documenting them
- If something is unclear or uncertain, ask the human for clarification
- Consider creating a checklist for complex documentation updates
- Use tools (list_dir, read_file, grep_search) to investigate project state

## Verification Checklist

Before completing the update, verify:
- [ ] All command names match actual files in `.agdocs/commands/`
- [ ] All prompt names match actual files in `.github/prompts/`
- [ ] All directory paths exist and are correct
- [ ] All internal links work
- [ ] All examples are accurate and tested
- [ ] Installation/setup instructions are correct
- [ ] No outdated information remains
- [ ] Consistent terminology throughout
- [ ] English is used throughout (except specified exceptions)

## Related Commands

- `update-memory-bank-comprehensive` - For updating memory banks after discovering project changes
- `update-memory-bank-targeted` - For specific memory bank updates
- `initialize-memory-bank` - For initial memory bank setup

## Best Practices

### Investigation Before Updates

- Use `list_dir` to check directory contents
- Use `file_search` to find specific files
- Use `grep_search` to find references
- Read memory banks for current documented state

### Writing Style

- Keep README.md marketing-focused and user-friendly
- Keep CONTRIBUTING.md technical and detailed
- Use clear, concise language
- Provide concrete examples
- Use bullet points for readability

### Handling Uncertainty

If you discover information that contradicts both documentation and memory banks:
1. Note the discrepancy
2. Ask the human for clarification
3. Update both documentation and memory banks if confirmed
4. Document the reason for the change

### Incremental Updates

For large documentation updates:
1. Update one file at a time
2. Verify changes with the human if significant
3. Test all examples and links
4. Request human review for major restructuring
