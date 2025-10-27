# GitHub Operations

## Overview

This memory bank documents common GitHub operations and API usage patterns that are frequently needed but not immediately obvious.

## PR Review Comment Resolution

### Problem

When fixing issues identified in PR review comments, you may want to programmatically mark those review threads as resolved. The GitHub REST API does not support this operation.

### Solution: Use GraphQL API

GitHub only provides the ability to resolve review threads through the GraphQL API using the `resolveReviewThread` mutation.

#### Step 1: Get Thread IDs

Review threads have their own IDs (different from comment IDs). Query for thread IDs:

```bash
gh api graphql -f query='
query {
  repository(owner: "OWNER", name: "REPO") {
    pullRequest(number: PR_NUMBER) {
      reviewThreads(first: 100) {
        nodes {
          id
          isResolved
          comments(first: 1) {
            nodes {
              databaseId
              path
              body
            }
          }
        }
      }
    }
  }
}'
```

**Key Points:**
- Thread IDs start with `PRRT_` (e.g., `PRRT_kwDOQJE7tM5fVuVb`)
- Comment IDs (databaseId) are different from thread IDs
- Each thread contains one or more comments

#### Step 2: Resolve Threads

Use the `resolveReviewThread` mutation for each thread:

```bash
gh api graphql -f query="mutation {
  resolveReviewThread(input: {threadId: \"PRRT_kwDOQJE7tM5fVuVb\"}) {
    thread {
      id
      isResolved
    }
  }
}"
```

**Batch Resolution:**

```bash
for thread_id in "PRRT_xxx" "PRRT_yyy" "PRRT_zzz"; do
  gh api graphql -f query="mutation {
    resolveReviewThread(input: {threadId: \"$thread_id\"}) {
      thread {
        id
        isResolved
      }
    }
  }"
done
```

### Why Not REST API?

The REST API endpoint `PATCH /repos/{owner}/{repo}/pulls/comments/{comment_id}` does not support a `state` parameter for resolving threads. Attempting to use it returns:

```json
{
  "message": "Invalid request.\n\n\"state\" is not a permitted key.\n\"body\" wasn't supplied.",
  "status": "422"
}
```

### Reference

- GitHub GraphQL API Docs: https://docs.github.com/en/graphql/reference/mutations#resolvereviewthread
- Stack Overflow Discussion: https://stackoverflow.com/a/73317004

## PR Review Comment Creation

### Using REST API

The REST API can be used to create review comments:

```bash
gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/OWNER/REPO/pulls/PR_NUMBER/comments \
  -f body='Comment text' \
  -f commit_id='COMMIT_SHA' \
  -f path='path/to/file.ext' \
  -F line=42
```

**Important Syntax Notes:**
- Use `--method POST` (not just `POST`)
- Use `-f` flag for string parameters (body, commit_id, path)
- Use `-F` flag for numeric parameters (line)
- Include `X-GitHub-Api-Version` header for API versioning

**Key Parameters:**
- `body`: Comment text
- `commit_id`: The SHA of the commit to comment on
- `path`: Relative path to the file
- `line`: Line number in the file

### Replying to Review Comments

**Method 1: Using the /replies endpoint (Recommended)**

```bash
gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/OWNER/REPO/pulls/PR_NUMBER/comments/COMMENT_ID/replies \
  -f body='Reply text'
```

**Important:**
- The endpoint MUST include the PR number: `/pulls/{pull_number}/comments/{comment_id}/replies`
- The previous attempt using `/pulls/comments/{comment_id}/replies` (without PR number) does NOT work - returns 404
- Only the `body` parameter is required for replies
- All other parameters (commit_id, path, line, etc.) are ignored when replying
- ✅ **Verified working command**

**Method 2: Using in_reply_to parameter**

```bash
# First, get the latest commit SHA
COMMIT_SHA=$(gh pr view PR_NUMBER --json commits --jq '.commits[-1].oid')

# Then create a comment with in_reply_to
gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/OWNER/REPO/pulls/PR_NUMBER/comments \
  -f body='Reply text' \
  -f commit_id="$COMMIT_SHA" \
  -f path='path/to/file.ext' \
  -F line=LINE_NUMBER \
  -F in_reply_to=COMMENT_ID
```

**Important Syntax Notes:**
- Use `--method POST` (not just `POST`)
- Use `-f` flag for string parameters (body, commit_id, path)
- Use `-F` flag for numeric parameters (line, in_reply_to)
- Include `X-GitHub-Api-Version` header for API versioning

**Note:**
- Requires all parameters (commit_id, path, line) in addition to in_reply_to
- More verbose than Method 1
- ✅ **Verified working command**
- **Recommendation:** Use Method 1 (/replies endpoint) for simpler syntax

### Batch Comment Creation

When creating multiple comments, use a loop or jq to process files:

```bash
gh api /repos/OWNER/REPO/pulls/PR_NUMBER/files --jq '.[] | {path, sha}' | \
while read -r file_data; do
  # Process each file and create comments
done
```

## Common Patterns

### Get PR Files

```bash
gh pr view PR_NUMBER --json files --jq '.files[].path'
```

### Get Latest Commit SHA

```bash
gh pr view PR_NUMBER --json commits --jq '.commits[-1].oid'
```

### List All Comments

```bash
gh api /repos/OWNER/REPO/pulls/PR_NUMBER/comments
```

### Check PR Status

```bash
gh pr view PR_NUMBER --json state,reviewDecision
```

## Best Practices

1. **Always use GraphQL for thread resolution** - The REST API does not support this operation
2. **Batch operations carefully** - Don't overwhelm the API with too many requests at once
3. **Verify thread IDs** - Query for thread IDs before attempting resolution
4. **Handle positive comments separately** - Don't resolve threads that contain positive feedback unless appropriate
5. **Use jq for parsing** - Parse JSON responses with jq for reliable data extraction

## GitHub Issue Operations

### Overview

GitHub CLI (`gh`) provides comprehensive commands for managing issues. All operations can be performed via `gh issue` subcommands.

### List Issues

List all open issues in the current repository:

```bash
gh issue list
```

**Common Options:**
- `--state {open|closed|all}` - Filter by state (default: open)
- `--label strings` - Filter by labels
- `--assignee string` - Filter by assignee
- `--author string` - Filter by author
- `--limit int` - Maximum number to fetch (default: 30)
- `--json fields` - Output in JSON format
- `--search query` - Search with advanced query syntax

**Examples:**
```bash
# List open issues
gh issue list

# List all issues (including closed)
gh issue list --state all

# List issues with specific label
gh issue list --label "bug"

# List issues assigned to you
gh issue list --assignee "@me"

# Get JSON output with specific fields
gh issue list --json number,title,state,labels
```

### Create Issue

Create a new issue with title and body:

```bash
gh issue create --title "Issue Title" --body "Issue description"
```

**Common Options:**
- `-t, --title string` - Issue title (required if not using -e)
- `-b, --body string` - Issue body text
- `-F, --body-file file` - Read body from file
- `-l, --label name` - Add labels
- `-a, --assignee login` - Assign users (use "@me" for self-assign)
- `-m, --milestone name` - Add to milestone
- `-p, --project title` - Add to project
- `-e, --editor` - Open editor to write title and body

**Examples:**
```bash
# Create issue with title and body
gh issue create --title "Bug: Login fails" --body "Users cannot log in"

# Create with labels
gh issue create --title "Feature request" --body "Add dark mode" --label "enhancement"

# Self-assign
gh issue create --title "Fix typo" --body "Fix documentation typo" --assignee "@me"

# Create from file
gh issue create --title "Complex issue" --body-file issue-description.md

# Open editor
gh issue create --editor
```

**Body Structure Best Practice:**

```markdown
## Completion Criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## References

- Related PR: #123
- Documentation: https://example.com
```

### Edit Issue

Edit an existing issue's title, body, labels, assignees, or milestone:

```bash
gh issue edit <number> --title "New Title" --body "New body"
```

**Common Options:**
- `-t, --title string` - Set new title
- `-b, --body string` - Set new body
- `-F, --body-file file` - Read body from file
- `--add-label name` - Add labels
- `--remove-label name` - Remove labels
- `--add-assignee login` - Add assignees
- `--remove-assignee login` - Remove assignees
- `-m, --milestone name` - Set milestone
- `--remove-milestone` - Remove milestone association

**Examples:**
```bash
# Update title and body
gh issue edit 6 --title "Updated title" --body "Updated description"

# Add labels
gh issue edit 6 --add-label "bug" --add-label "priority:high"

# Remove label
gh issue edit 6 --remove-label "wontfix"

# Add assignee
gh issue edit 6 --add-assignee "@me"

# Update from file
gh issue edit 6 --body-file updated-description.md

# Edit multiple issues at once
gh issue edit 6 7 8 --add-label "needs-review"
```

### Add Comment

Add a comment to an existing issue:

```bash
gh issue comment <number> --body "Comment text"
```

**Common Options:**
- `-b, --body text` - Comment body text
- `-F, --body-file file` - Read comment from file
- `-e, --editor` - Open editor to write comment
- `--edit-last` - Edit the last comment
- `--delete-last` - Delete the last comment

**Examples:**
```bash
# Add simple comment
gh issue comment 6 -b 'This looks good to me!'

# Add comment from file
gh issue comment 6 --body-file comment.md

# Open editor
gh issue comment 6 --editor

# Edit your last comment
gh issue comment 6 --edit-last

# Delete your last comment
gh issue comment 6 --delete-last --yes
```

### View Issue

View issue details in terminal or browser:

```bash
gh issue view <number>
```

**Common Options:**
- `--web` - Open in web browser
- `--json fields` - Output specific fields in JSON
- `-c, --comments` - Show comments

**Examples:**
```bash
# View in terminal
gh issue view 6

# View in browser
gh issue view 6 --web

# Get JSON output
gh issue view 6 --json number,title,body,state,labels,comments

# Show comments
gh issue view 6 --comments
```

### Close Issue

Close an issue with optional comment:

```bash
gh issue close <number> [-c "Closing comment"]
```

**Examples:**
```bash
# Close issue
gh issue close 6

# Close with comment
gh issue close 6 -c 'Fixed in PR #10'

# Close multiple issues
gh issue close 6 7 8
```

### Reopen Issue

Reopen a closed issue:

```bash
gh issue reopen <number>
```

### Issue Identification

Issues can be specified in multiple formats:
- By number: `123`
- By URL: `https://github.com/OWNER/REPO/issues/123`

### Shell Scripting Tips

**Important**: When using `gh issue` commands in shell scripts, be careful with quote handling:

```bash
# Single quotes - literal string, no variable expansion
gh issue comment 6 -b 'Comment text'

# Double quotes - allows variable expansion but can cause issues with special characters
gh issue comment 6 -b "Comment text with $VARIABLE"

# For complex text with special characters, use single quotes or escape properly
gh issue create --title 'Issue: Testing quotes' --body 'Body with "quotes" and special chars!'

# Reading from file is often safer for complex content
gh issue create --title "My Issue" --body-file description.md
```

### Best Practices for Issue Management

1. **Use meaningful titles** - Clear, concise titles help with issue tracking
2. **Include completion criteria** - Add checkboxes for clear acceptance criteria
3. **Add relevant labels** - Use labels to categorize issues
4. **Self-assign when working** - Use `--assignee "@me"` to claim issues
5. **Close with context** - Include closing comment referencing fixes or PRs
6. **Use body files for complex content** - Avoid shell escaping issues with `-F` flag
7. **Leverage JSON output** - Parse with `jq` for scripting and automation

## GitHub PR Update Operations

### Overview

GitHub CLI (`gh`) provides the `gh pr edit` command for updating pull request metadata including title, body, labels, assignees, reviewers, and more.

### Edit PR Title and Body

Update PR title and/or body description:

```bash
# Update title only
gh pr edit <number> --title "New PR Title"

# Update body only
gh pr edit <number> --body "New PR description"

# Update both
gh pr edit <number> --title "New Title" --body "New description"

# Update body from file
gh pr edit <number> --body-file description.md
```

**Common Options:**
- `-t, --title string` - Set new title
- `-b, --body string` - Set new body text
- `-F, --body-file file` - Read body from file (recommended for complex content)
- `-B, --base branch` - Change base branch

**Examples:**
```bash
# Update PR #5 title
gh pr edit 5 --title "feat: Add new authentication system"

# Update PR #5 body from file
gh pr edit 5 --body-file updated-description.md

# Update current branch's PR
gh pr edit --title "Updated title"
```

### Edit PR Labels

Add or remove labels from a pull request:

```bash
# Add labels
gh pr edit <number> --add-label "bug,priority:high"

# Remove labels
gh pr edit <number> --remove-label "wontfix"

# Add and remove in one command
gh pr edit <number> --add-label "reviewed" --remove-label "needs-review"
```

**Examples:**
```bash
# Add multiple labels
gh pr edit 5 --add-label "enhancement" --add-label "documentation"

# Remove label
gh pr edit 5 --remove-label "work-in-progress"
```

### Edit PR Assignees and Reviewers

Manage assignees and reviewers:

```bash
# Add assignees
gh pr edit <number> --add-assignee "@me"
gh pr edit <number> --add-assignee "username1,username2"

# Remove assignees
gh pr edit <number> --remove-assignee "username"

# Add reviewers
gh pr edit <number> --add-reviewer "username1,username2"

# Remove reviewers
gh pr edit <number> --remove-reviewer "username"
```

**Special Values for Assignees:**
- `@me` - Assign to yourself
- `@copilot` - Assign to Copilot (not supported on GitHub Enterprise Server)

**Note**: `@me` and `@copilot` are **NOT** supported for reviewers.

**Examples:**
```bash
# Self-assign
gh pr edit 5 --add-assignee "@me"

# Add reviewers
gh pr edit 5 --add-reviewer "alice,bob"

# Remove reviewer
gh pr edit 5 --remove-reviewer "charlie"
```

### Edit PR Milestone

Add or remove milestone association:

```bash
# Set milestone
gh pr edit <number> --milestone "v1.0"

# Remove milestone
gh pr edit <number> --remove-milestone
```

**Examples:**
```bash
# Add to milestone
gh pr edit 5 --milestone "Version 2.0"

# Remove from milestone
gh pr edit 5 --remove-milestone
```

### PR Identification

PRs can be specified in multiple formats:
- By number: `5`
- By URL: `https://github.com/OWNER/REPO/pull/5`
- By branch: `feature-branch` (edits PR for that branch)
- Omit for current branch: `gh pr edit --title "New title"`

### Get PR Diff Information

View PR changes to determine if description needs updating:

```bash
# View PR in terminal
gh pr view <number>

# View PR diff
gh pr diff <number>

# Get changed files
gh pr view <number> --json files --jq '.files[].path'

# Get PR metadata
gh pr view <number> --json number,title,body,state,changedFiles,additions,deletions
```

**Examples:**
```bash
# View PR #5 details
gh pr view 5

# Get list of changed files
gh pr view 5 --json files --jq '.files[].path'

# Get PR stats
gh pr view 5 --json changedFiles,additions,deletions
```

### Shell Scripting Tips for PR Updates

**Quote Handling:**
```bash
# Single quotes - literal string
gh pr edit 5 -b 'PR description'

# Reading from file is safer for complex content
gh pr edit 5 --body-file description.md

# For titles with special characters
gh pr edit 5 --title 'feat: Add "smart" authentication'
```

**Checking if Update Needed:**
```bash
# Get current PR body
current_body=$(gh pr view 5 --json body --jq '.body')

# Compare and update if different
if [ "$current_body" != "$new_body" ]; then
  echo "$new_body" > /tmp/pr-body.md
  gh pr edit 5 --body-file /tmp/pr-body.md
fi
```

### Best Practices for PR Updates

1. **Use body files for complex updates** - Avoid shell escaping issues with `-F` flag
2. **Show before/after for confirmation** - Display current and new content before updating
3. **Update description when PR scope changes** - Keep PR description in sync with actual changes
4. **Avoid verbose descriptions** - Don't list every file; focus on overall changes and impact
5. **Update title to reflect changes** - Keep title accurate as PR evolves
6. **Clean up temp files** - Remove temporary body files after use
7. **Verify updates** - Use `gh pr view` to confirm changes applied correctly

### Common Patterns

**Update PR after adding more commits:**
```bash
# Review changes
gh pr diff 5

# Update description
cat > /tmp/pr-body.md << 'EOF'
## Changes

Added new features and fixed bugs.

### New Features
- Feature A
- Feature B

### Bug Fixes
- Fix issue X
- Fix issue Y
EOF

gh pr edit 5 --body-file /tmp/pr-body.md
rm /tmp/pr-body.md
```

**Update PR title based on changed files:**
```bash
# Get changed files
files=$(gh pr view 5 --json files --jq '.files[].path' | head -5)

# Generate descriptive title
# Update PR
gh pr edit 5 --title "refactor: Update authentication and API modules"
```
