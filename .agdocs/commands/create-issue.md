# create-issue Command

## Overview

This command creates a new GitHub issue with a structured format based on a template. It collects information from the human and generates a well-formatted issue with completion criteria and optional references.

## Prerequisites

Before using this command, review the following memory banks for necessary knowledge:
- `.agdocs/memory/github-operations.md` - GitHub issue operations and best practices
- `.agdocs/memory/index.md` - Full list of available memory banks

## Instructions

When a human requests to create a GitHub issue, follow these steps:

### 1. Select Template

Read `.agdocs/templates/github-issues/index.md` to see available issue templates. Choose the appropriate template based on the human's requirements, or ask the human to select one.

The selected template will guide the structure of the issue body.

### 2. Collect Issue Information

Gather the following information from the human:

**Required:**
- **Title**: Short, descriptive title for the issue

**Optional:**
- **Completion Criteria**: List of checkboxes defining when the issue is complete
- **References**: Related PRs, issues, documentation, or external resources

If the human doesn't provide all information, ask specific questions:
- "What should be the issue title?"
- "What are the completion criteria? (Things that need to be done)"
- "Are there any references or related resources?"

### 3. Generate Issue Body

Using the selected template from `.agdocs/templates/github-issues/items/`, generate the issue body by replacing placeholders with collected information.

**Guidelines:**
- Use clear, actionable completion criteria
- Include all references provided by the human
- Keep the format consistent with the template
- Follow the template structure without adding unnecessary content

### 4. Create Temporary File

Create a temporary file with the issue body content:

**Preferred location (create directory if needed):**
```bash
mkdir -p /tmp/agdocs
cat > /tmp/agdocs/issue-body.md << 'EOF'
[Generated issue body here]
EOF
```

**Fallback location if `/tmp/` is not available:**
```bash
mkdir -p .agdocs/swap/tmp
cat > .agdocs/swap/tmp/issue-body.md << 'EOF'
[Generated issue body here]
EOF
```

### 5. Display and Confirm

Display the issue details to the human for confirmation:

```
Title: {{title}}

Body:
[Show the generated body]

---
Ready to create this issue? (y/n)
```

### 6. Create the Issue

Once confirmed, create the issue using `gh issue create`. Reference `.agdocs/memory/github-operations.md` for the exact command syntax and options.

**Important**: Do not copy commands from this file directly. Consult the memory bank for current best practices and proper command usage.

Basic pattern:
```bash
gh issue create --title "{{title}}" --body-file {{temp_file_path}}
```

**Options to consider** (see memory bank for details):
- Add labels if specified
- Self-assign if requested
- Add to milestone if specified

### 7. Report Result

After successful creation:
- Display the issue URL
- Show the issue number
- Confirm creation

Example:
```
✓ Created issue #7
URL: https://github.com/owner/repo/issues/7
```

### 8. Clean Up

Remove the temporary file:

```bash
rm -f /tmp/agdocs/issue-body.md
# or if fallback location was used:
rm -f .agdocs/swap/tmp/issue-body.md
```

## Usage Examples

### Example 1: Basic issue creation

```
Human: Create an issue to fix the login bug

AI-agent:
1. Collects: Title = "Fix login bug"
2. Asks: "What are the completion criteria?"
   Human: "Fix the authentication flow, add tests, update documentation"
3. Generates body with 3 completion criteria
4. Creates issue with gh issue create
```

### Example 2: Issue with references

```
Human: Create an issue for implementing dark mode. Reference PR #5 and the design doc.

AI-agent:
1. Collects: Title = "Implement dark mode"
2. Asks: "What are the completion criteria?"
   Human: "Add dark mode toggle, update CSS, test in all browsers"
3. Generates body with criteria and 2 references (PR #5, design doc)
4. Creates issue
```

### Example 3: Self-assigned issue

```
Human: Create an issue to refactor the auth module and assign it to me

AI-agent:
1. Collects information
2. Generates body
3. Creates with: gh issue create ... --assignee "@me"
```

## Notes

- Always use `--body-file` instead of `--body` to avoid shell escaping issues
- Template files are located in `.agdocs/templates/github-issues/items/`
- See `.agdocs/templates/github-issues/index.md` for available templates
- If the human provides a full description, use it directly instead of prompting for criteria
- Clean up temporary files after creation
- Handle errors gracefully (e.g., network issues, authentication problems)
- For multi-line or complex content, body-file approach is more reliable
- **Always reference memory banks** for command syntax and best practices
- Use `/tmp/agdocs/` for temp files, or `.agdocs/swap/tmp/` as fallback

## Best Practices

1. **Ask clarifying questions** - If information is missing, ask specific questions
2. **Use clear completion criteria** - Make criteria actionable and testable
3. **Include relevant references** - Link to related issues, PRs, and documentation
4. **Confirm before creating** - Show the issue content for human review
5. **Use temp files** - Avoid shell escaping issues with `--body-file`

## Related Commands

- `update-issue` - Update an existing GitHub issue
- `gh issue create` - GitHub CLI command for issue creation
