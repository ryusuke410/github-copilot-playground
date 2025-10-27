# update-issue Command

## Overview

This command updates an existing GitHub issue's title and/or body description. It helps modify issue content while ensuring the human reviews and confirms changes before applying them.

## Prerequisites

Before using this command, review the following memory banks for necessary knowledge:
- `.agdocs/memory/github-operations.md` - GitHub issue operations and best practices
- `.agdocs/memory/index.md` - Full list of available memory banks

## Instructions

When a human requests to update a GitHub issue, follow these steps:

### 1. Identify the Issue

Determine which issue to update:

**If human specifies issue number:**
- Use the provided number directly (e.g., "Update issue #6")

**If human describes issue:**
- List recent issues: `gh issue list --limit 10`
- Display the list to the human
- **If issue not found in first 10**: Show next 10 with `gh issue list --limit 10 --offset 10`
- Continue pagination if needed until issue is found or human provides number
- Ask human to confirm which issue to update

### 2. Get Current Issue Content

Retrieve the current issue details using `gh issue view`. Reference `.agdocs/memory/github-operations.md` for exact command syntax.

Display current content to the human:
```
Current Issue #{{number}}:

Title: {{current_title}}

Body:
{{current_body}}
```

### 3. Collect Update Information

Ask the human what to update:
- "What should the new title be? (Leave empty to keep current)"
- "What should the new body be? (Leave empty to keep current)"

**Options:**
- Update title only
- Update body only
- Update both title and body

### 4. Prepare Updated Content

Based on human input, prepare the new content:

**If updating body:**
- Create a temporary file with the new body content:
```bash
mkdir -p /tmp/agdocs
cat > /tmp/agdocs/issue-body-update.md << 'EOF'
{{new_body_content}}
EOF
```

**Fallback if `/tmp/` not available:**
```bash
mkdir -p .agdocs/swap/tmp
cat > .agdocs/swap/tmp/issue-body-update.md << 'EOF'
{{new_body_content}}
EOF
```

**If updating title only:**
- No file needed, use `--title` flag directly

### 5. Display Changes for Confirmation

Show a clear comparison:

```
=== Proposed Changes for Issue #{{number}} ===

{{if title changed}}
Title:
  OLD: {{old_title}}
  NEW: {{new_title}}
{{endif}}

{{if body changed}}
Body:
  OLD:
  ---
  {{old_body}}
  ---
  
  NEW:
  ---
  {{new_body}}
  ---
{{endif}}

=== End of Changes ===

Confirm these changes? (y/n)
```

### 6. Apply Updates

Once confirmed, update the issue using `gh issue edit`. **Reference `.agdocs/memory/github-operations.md` for exact command syntax and options.**

**Important**: Do not copy commands from this file directly. Consult the memory bank for current best practices.

Basic patterns:
- Update title and body: Refer to memory bank
- Update title only: Refer to memory bank
- Update body only: Refer to memory bank

### 7. Report Result

After successful update:
```
✓ Updated issue #{{number}}
URL: https://github.com/owner/repo/issues/{{number}}
```

### 8. Clean Up

Remove temporary files:
```bash
rm -f /tmp/agdocs/issue-body-update.md
# or if fallback location was used:
rm -f .agdocs/swap/tmp/issue-body-update.md
```

## Usage Examples

### Example 1: Update title only

```
Human: Update issue #6 title to "Fix login bug - High Priority"

AI-agent:
1. Gets current issue #6
2. Shows current title
3. Prepares new title
4. Confirms with human
5. Executes: gh issue edit 6 --title "Fix login bug - High Priority"
```

### Example 2: Update body only

```
Human: Update issue #6 description to add more completion criteria

AI-agent:
1. Gets current issue #6
2. Shows current body
3. Asks for new body content
4. Creates temp file with new body
5. Shows OLD vs NEW comparison
6. Confirms with human
7. Executes: gh issue edit 6 --body-file /tmp/issue-body-update.md
```

### Example 3: Update both title and body

```
Human: Update issue #6. Change title to "Authentication Refactor" and update the body with new requirements

AI-agent:
1. Gets current issue #6
2. Shows current title and body
3. Collects new title and body
4. Shows comparison for both
5. Confirms with human
6. Executes: gh issue edit 6 --title "..." --body-file /tmp/...
```

### Example 4: Update by searching

```
Human: Update the issue about dark mode

AI-agent:
1. Lists issues: gh issue list
2. Finds #8 "Implement dark mode"
3. Asks: "Found issue #8 'Implement dark mode'. Is this the one?"
4. Proceeds with update workflow
```

## Notes

- Always show current content before updating
- **Always confirm changes with human before applying**
- Use `--body-file` for body updates to avoid shell escaping issues
- Display clear OLD vs NEW comparison
- Handle partial updates (title only or body only)
- Clean up temporary files after operation
- If human says "keep current", don't update that field
- **Paginate through issue lists**: Show 10 at a time, continue if not found
- **Always reference memory banks** for command syntax and best practices
- Use `/tmp/agdocs/` for temp files, or `.agdocs/swap/tmp/` as fallback

## Best Practices

1. **Always get confirmation** - Show OLD and NEW content side-by-side
2. **Use temp files for body** - Avoid shell quoting issues
3. **Be explicit about changes** - Make it clear what will be modified
4. **Handle ambiguity** - If issue isn't specified clearly, list and ask
5. **Preserve what shouldn't change** - Only update requested fields

## Error Handling

- **Issue not found**: Verify issue number exists
- **Permission denied**: Check authentication with `gh auth status`
- **No changes**: If human provides same content, inform and skip update
- **Empty input**: Treat as "keep current value"

## Related Commands

- `create-issue` - Create a new GitHub issue
- `gh issue edit` - GitHub CLI command for issue editing
- `gh issue view` - View issue details
