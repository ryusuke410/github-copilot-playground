# create-issue Command

## Overview

This command creates a new GitHub issue with a structured format based on a template. It collects information from the human and generates a well-formatted issue with completion criteria and optional references.

## Instructions

When a human requests to create a GitHub issue, follow these steps:

### 1. Collect Issue Information

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

### 2. Generate Issue Body

Using the template from `.agdocs/templates/github-issue/general.md`, generate the issue body:

```markdown
# {{title}}

## Completion Criteria

- [ ] {{criterion_1}}
- [ ] {{criterion_2}}
- [ ] {{criterion_3}}

## References

- {{reference_1}}
- {{reference_2}}
```

**Guidelines:**
- Use clear, actionable completion criteria
- Include all references provided by the human
- Keep the format consistent with the template

### 3. Create Temporary File

Create a temporary file with the issue body content:

```bash
cat > /tmp/issue-body.md << 'EOF'
[Generated issue body here]
EOF
```

### 4. Display and Confirm

Display the issue details to the human for confirmation:

```
Title: {{title}}

Body:
[Show the generated body]

---
Ready to create this issue? (y/n)
```

### 5. Create the Issue

Once confirmed, create the issue using `gh issue create`:

```bash
gh issue create --title "{{title}}" --body-file /tmp/issue-body.md
```

**Options:**
- Add labels if specified: `--label "bug,enhancement"`
- Self-assign if requested: `--assignee "@me"`
- Add to milestone if specified: `--milestone "v1.0"`

### 6. Report Result

After successful creation:
- Display the issue URL
- Show the issue number
- Confirm creation

Example:
```
✓ Created issue #7
URL: https://github.com/owner/repo/issues/7
```

### 7. Clean Up

Remove the temporary file:

```bash
rm -f /tmp/issue-body.md
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
- Template file is at `.agdocs/templates/github-issue/general.md`
- If the human provides a full description, use it directly instead of prompting for criteria
- Clean up temporary files after creation
- Handle errors gracefully (e.g., network issues, authentication problems)
- For multi-line or complex content, body-file approach is more reliable

## Best Practices

1. **Ask clarifying questions** - If information is missing, ask specific questions
2. **Use clear completion criteria** - Make criteria actionable and testable
3. **Include relevant references** - Link to related issues, PRs, and documentation
4. **Confirm before creating** - Show the issue content for human review
5. **Use temp files** - Avoid shell escaping issues with `--body-file`

## Related Commands

- `update-issue` - Update an existing GitHub issue
- `gh issue create` - GitHub CLI command for issue creation
