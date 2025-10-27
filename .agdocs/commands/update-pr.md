# update-pr Command

## Overview

This command updates a pull request's description (body) based on the current diff/changes. It reviews the PR changes, shows both the original and updated descriptions to the human for confirmation, and then applies the update.

## Instructions

When a human requests to update a PR description, follow these steps:

### 1. Identify the PR

Determine which PR to update:

**If human specifies PR number:**
- Use the provided number directly (e.g., "Update PR #5")

**If no PR specified:**
- Use current branch's PR: `gh pr view --json number --jq '.number'`
- If no PR for current branch, list recent PRs and ask human

### 2. Get PR Diff and Current Description

Retrieve current PR information and changes:

```bash
# Get PR metadata
gh pr view {{pr_number}} --json number,title,body,changedFiles,additions,deletions

# Get changed files list
gh pr view {{pr_number}} --json files --jq '.files[].path'

# View diff (optional, for context)
gh pr diff {{pr_number}}
```

### 3. Analyze Changes

Review the PR changes to determine if description needs updating:

**Check for:**
- Files added/modified since last description update
- New features or bug fixes not mentioned in current description
- Significant changes in scope
- Outdated information in current description

### 4. Assess Description Update Need

**If description is current and accurate:**
- Inform human: "PR description appears current. No update needed."
- Ask if they still want to update it

**If description needs updating:**
- Proceed to next step

### 5. Propose Updated Description

Generate or ask human for updated description that reflects current changes.

**Guidelines for description:**
- Summarize overall changes, not every file
- Focus on what changed and why
- Keep it concise and relevant
- Avoid verbose file listings

### 6. Display Original vs Updated Description

Show a clear comparison for human confirmation:

```
=== PR #{{number}}: {{title}} ===

Changed Files: {{count}} files (+{{additions}}, -{{deletions}})

Files:
  {{file1}}
  {{file2}}
  ...

---

=== ORIGINAL DESCRIPTION ===

{{original_body}}

---

=== UPDATED DESCRIPTION ===

{{updated_body}}

---

Apply this update? (y/n)
```

**Critical**: Always show both original and updated descriptions side-by-side for comparison.

### 7. Await Human Confirmation

Ask the human to review and confirm:
- Display the comparison clearly
- Wait for explicit confirmation (y/n)
- If declined, ask if they want to modify the update

### 8. Apply Update

Once confirmed, update the PR:

```bash
# Create temporary file with new description
cat > /tmp/pr-body-update.md << 'EOF'
{{updated_description}}
EOF

# Update PR
gh pr edit {{pr_number}} --body-file /tmp/pr-body-update.md
```

### 9. Report Result

After successful update:
```
✓ Updated PR #{{number}}
URL: https://github.com/owner/repo/pull/{{number}}
```

### 10. Clean Up

Remove temporary files:
```bash
rm -f /tmp/pr-body-update.md
```

## Usage Examples

### Example 1: Update PR after adding commits

```
Human: Update PR #5 description

AI-agent:
1. Gets PR #5 info: 13 files changed, +570, -13
2. Gets current description
3. Analyzes recent commits
4. Proposes updated description
5. Shows: ORIGINAL vs UPDATED side-by-side
6. Asks: "Apply this update? (y/n)"
7. Human confirms: y
8. Updates PR with gh pr edit 5 --body-file ...
```

### Example 2: PR description is already current

```
Human: Update the PR description

AI-agent:
1. Gets current branch PR (#5)
2. Reviews changes vs description
3. Determines description is current
4. Says: "PR description appears current. The following files are documented:
   - simple-task.md (added)
   - templates updated
   Do you still want to update it?"
Human: No, that's fine
AI-agent: No changes made.
```

### Example 3: Human provides specific update

```
Human: Update PR #5. Add a section about the new testing improvements.

AI-agent:
1. Gets current PR #5 description
2. Shows original description
3. Asks: "What should the updated description include for testing improvements?"
4. Human provides details
5. Shows ORIGINAL vs UPDATED
6. Human confirms
7. Updates PR
```

## Notes

- Always use `--body-file` to avoid shell escaping issues
- **Always show original and updated descriptions for comparison**
- Clean up temporary files after update
- If PR scope changed significantly, suggest updating title too
- Avoid verbose descriptions listing every file
- Focus on overall impact and key changes
- Get explicit human confirmation before applying update

## Best Practices

1. **Compare before updating** - Always show original vs new content
2. **Await confirmation** - Never update without explicit approval
3. **Use temp files** - Avoid shell quoting issues with `--body-file`
4. **Keep descriptions concise** - Summarize changes, don't list every file
5. **Focus on impact** - Explain what changed and why, not just what files
6. **Check if update needed** - Don't update if description is already accurate
7. **Suggest title updates** - If PR scope changed, offer to update title too

## Error Handling

- **PR not found**: Verify PR number or check current branch
- **No changes**: If description doesn't need update, inform human
- **Permission denied**: Check authentication with `gh auth status`
- **Confirmation declined**: Ask if human wants to modify proposed update

## Related Commands

- `create-issue` - Create a new GitHub issue
- `update-issue` - Update an existing issue
- `commit-push-pr` - Commit, push, and create PR
- `gh pr edit` - GitHub CLI command for PR editing
