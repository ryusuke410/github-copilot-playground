# update-memory-bank-targeted Command

## Overview

This command updates the Memory Bank system with specific content provided by the human. Use this for focused updates when you know exactly what needs to be changed.

## Instructions

When a human requests a targeted update to the memory bank system, follow these steps:

### 1. Read Documentation

Read the following files to understand the current system:
- `.agdocs/docs/memory-bank/index.md` - Memory bank system documentation
- `.agdocs/memory/index.md` - Current memory bank index

### 2. Understand the Update Request

Clarify with the human:
- Which memory bank file(s) need updating
- What specific content needs to be added, modified, or removed
- The context and reason for the update
- Any related updates needed in other files

### 3. Read Target Memory Bank(s)

Read the specific memory bank file(s) that will be updated to understand the current content and structure.

### 4. Make the Updates

Update the specified memory bank(s):
- Add new content in the appropriate section
- Modify existing content as requested
- Remove obsolete information if needed
- Maintain consistent formatting and style
- Ensure all content is in English (except ubiquitous language Japanese terms)

### 5. Update Related Content

If the update affects other memory banks or documentation:
- Update cross-references
- Add related information to other memory banks
- Ensure terminology consistency

### 6. Update Index

Update `.agdocs/memory/index.md`:
- Update "Last Updated" date for modified memory banks (format: YYYY-MM-DD)
- Update descriptions if the scope of the memory bank changed
- Add new entries if new memory banks were created
- Ensure table formatting is correct

### 7. Verify Changes

Review the changes:
- Confirm the update addresses the human's request
- Check that formatting is consistent
- Verify all references and links work
- Ensure language requirements are met

### 8. Report Completion

Provide a summary of:
- Which memory bank(s) were updated
- What changes were made
- Any additional updates made for consistency
- Confirmation that the request has been completed

## Usage Examples

### Example 1: Add a new rule to coding guidelines

```
Human: Add a rule that all TypeScript files must use strict mode
AI-agent: [Updates memory/coding-guidelines.md with the new rule]
```

### Example 2: Update project overview with new stakeholder

```
Human: Add John Smith as a new project contributor
AI-agent: [Updates memory/project-overview.md with the stakeholder information]
```

### Example 3: Add new command to suggested commands

```
Human: Document the new 'deploy' command: npm run deploy
AI-agent: [Updates memory/suggested-commands.md with the new command]
```

## Notes

- This command is for specific, well-defined updates
- Always read documentation files first to understand the system
- Ask for clarification if the update request is unclear
- Update the index after making changes
- For comprehensive updates affecting multiple files, use `update-memory-bank-comprehensive` instead
- Maintain consistency with existing content and formatting

## Related Commands

- `update-memory-bank-comprehensive` - For thorough investigation and updates
- `initialize-memory-bank` - For initial setup of the memory bank system
