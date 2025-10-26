# review-pr Command

## Overview

This command provides a systematic workflow for reviewing pull requests. It guides you through fetching PR information, checking out the branch, analyzing changes, and submitting review comments.

## Instructions

When a human requests to review a PR, follow these steps:

### 1. List Open Pull Requests

Get a list of open PRs using `gh pr list`:

```bash
gh pr list
```

This displays PRs with their number, title, branch, and author.

For more detailed information in JSON format:

```bash
gh pr list --json number,title,headRefName,author,updatedAt
```

### 2. Select PR to Review

Ask the human which PR they want to review. They can specify by:
- PR number (e.g., `#123`)
- Branch name
- PR URL

Example interaction:
```
AI: Which PR would you like to review? (Specify by PR number, branch name, or URL)
Human: #1
```

### 3. Fetch PR Details

Get detailed information about the selected PR:

```bash
gh pr view {{pr_number}} --json number,title,body,headRefName,baseRefName,author,files,additions,deletions,commits
```

Display key information to the human:
- PR title and description
- Author
- Base and head branches
- Number of changed files
- Additions/deletions count
- Number of commits

### 4. Update Remote Information

Fetch the latest remote information to ensure you have current data:

```bash
git fetch origin --prune
```

This command:
- Fetches all branches from `origin` remote
- Prunes deleted remote branches from local references
- Updates remote tracking references

### 5. Checkout PR Branch

Check out the PR's branch locally:

```bash
gh pr checkout {{pr_number}}
```

Or manually:
```bash
git checkout -b {{local_branch_name}} origin/{{pr_branch_name}}
```

Verify you're on the correct branch:
```bash
git branch --show-current
```

### 6. Get List of Changed Files

Get the list of files changed in this PR:

**Using gh:**
```bash
gh pr diff {{pr_number}} --name-only
```

**Using git:**
```bash
git diff --name-only {{base_branch}}...{{head_branch}}
```

Store this list for systematic review.

### 7. Plan Review Tasks

Break down the review into specific, manageable tasks. Consider:

**Code Quality:**
- Check for code style consistency
- Review naming conventions
- Verify proper error handling
- Check for code duplication

**Functionality:**
- Verify the code implements the stated goals
- Check edge cases are handled
- Test critical paths

**Best Practices:**
- Check for security concerns
- Review performance implications
- Verify documentation is updated
- Check test coverage

**Project-Specific:**
- Verify memory bank updates if structure changes
- Check command files follow conventions
- Ensure English is used in documentation

Create a todo list with specific review tasks for the changed files.

### 8. Execute Review Tasks

For each review task:

1. **Read the relevant files:**
   ```bash
   # Use read_file or appropriate tool to examine code
   ```

2. **Analyze the changes:**
   - Compare with requirements
   - Check for issues or improvements
   - Note any questions for the author

3. **Draft line-specific comments:**
   
   For issues found at specific lines, collect the following information:
   - File path (e.g., `src/utils.ts`)
   - Line number where the issue occurs
   - Comment text explaining the issue
   - The commit SHA (get it with `git log -1 --format=%H`)
   
   Example comment draft:
   ```
   File: src/utils.ts
   Line: 42
   Comment: Missing error handling for null input. Consider adding a null check before processing.
   ```

Keep track of all draft comments (both line-specific and general).

### 9. Add Line-Specific Comments

You have two options for adding comments: **individual comments** or **batch review**. Choose based on your workflow preference.

#### Option A: Add Individual Line Comments (Immediately Visible)

Add comments one by one using the GitHub REST API. These appear immediately on the PR.

**Get the latest commit SHA:**
```bash
COMMIT_SHA=$(gh pr view {{pr_number}} --json commits --jq '.commits[-1].oid')
```

**Get repository owner and name:**
```bash
OWNER=$(gh repo view --json owner --jq '.owner.login')
REPO=$(gh repo view --json name --jq '.name')
```

**Add a single-line comment:**
```bash
gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/$OWNER/$REPO/pulls/{{pr_number}}/comments \
  -f body='{{comment_text}}' \
  -f commit_id="$COMMIT_SHA" \
  -f path='{{file_path}}' \
  -F line={{line_number}} \
  -f side='RIGHT'
```

**Add a multi-line comment (line range):**
```bash
gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/$OWNER/$REPO/pulls/{{pr_number}}/comments \
  -f body='{{comment_text}}' \
  -f commit_id="$COMMIT_SHA" \
  -f path='{{file_path}}' \
  -F start_line={{start_line}} \
  -f start_side='RIGHT' \
  -F line={{end_line}} \
  -f side='RIGHT'
```

**Complete example:**
```bash
# Get repository info
OWNER=$(gh repo view --json owner --jq '.owner.login')
REPO=$(gh repo view --json name --jq '.name')

# Get latest commit
COMMIT_SHA=$(gh pr view 1 --json commits --jq '.commits[-1].oid')

# Add comment to line 42 in src/utils.ts
gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/$OWNER/$REPO/pulls/1/comments \
  -f body='Missing error handling for null input' \
  -f commit_id="$COMMIT_SHA" \
  -f path='src/utils.ts' \
  -F line=42 \
  -f side='RIGHT'
```

#### Option B: Create Pending Review with Multiple Comments (Submit Together)

Create a PENDING review with multiple line-specific comments, then submit them all at once. This is equivalent to GitHub's "Start a review" button.

**Step 1: Get repository info and commit SHA:**
```bash
OWNER=$(gh repo view --json owner --jq '.owner.login')
REPO=$(gh repo view --json name --jq '.name')
COMMIT_SHA=$(gh pr view {{pr_number}} --json commits --jq '.commits[-1].oid')
```

**Step 2: Create PENDING review with multiple comments:**
```bash
jq -n \
  --arg commit_id "$COMMIT_SHA" \
  --arg body "Overall review summary (optional)" \
  '{
    commit_id: $commit_id,
    body: $body,
    comments: [
      {
        path: "{{file_path_1}}",
        position: {{line_number_1}},
        body: "{{comment_text_1}}"
      },
      {
        path: "{{file_path_2}}",
        position: {{line_number_2}},
        body: "{{comment_text_2}}"
      }
    ]
  }' | gh api --method POST "/repos/$OWNER/$REPO/pulls/{{pr_number}}/reviews" --input -
```

This creates a review in `PENDING` state. The response includes a `review_id` (e.g., `"id": 3380364268`).

**Step 3: Submit the pending review:**

Get the review ID from the previous response, then:

```bash
# For approval (cannot approve your own PR)
gh api --method POST "/repos/$OWNER/$REPO/pulls/{{pr_number}}/reviews/{{review_id}}/events" \
  -f body="Final review comments" \
  -f event="APPROVE"

# For requesting changes
gh api --method POST "/repos/$OWNER/$REPO/pulls/{{pr_number}}/reviews/{{review_id}}/events" \
  -f body="Please address these comments" \
  -f event="REQUEST_CHANGES"

# For commenting only
gh api --method POST "/repos/$OWNER/$REPO/pulls/{{pr_number}}/reviews/{{review_id}}/events" \
  -f body="Review completed" \
  -f event="COMMENT"
```

**Complete batch review example:**
```bash
# Get repository info
OWNER=$(gh repo view --json owner --jq '.owner.login')
REPO=$(gh repo view --json name --jq '.name')
COMMIT_SHA=$(gh pr view 1 --json commits --jq '.commits[-1].oid')

# Create pending review with 2 comments
REVIEW_RESPONSE=$(jq -n \
  --arg commit_id "$COMMIT_SHA" \
  --arg body "Found a few issues that need attention" \
  '{
    commit_id: $commit_id,
    body: $body,
    comments: [
      {
        path: "src/utils.ts",
        position: 42,
        body: "Missing error handling for null input"
      },
      {
        path: "test/utils.test.ts",
        position: 15,
        body: "Need test case for edge condition"
      }
    ]
  }' | gh api --method POST "/repos/$OWNER/$REPO/pulls/1/reviews" --input -)

# Extract review ID
REVIEW_ID=$(echo "$REVIEW_RESPONSE" | jq -r '.id')

# Submit the review
gh api --method POST "/repos/$OWNER/$REPO/pulls/1/reviews/$REVIEW_ID/events" \
  -f body="Please address the comments above before merging" \
  -f event="COMMENT"
```

**Choosing between Option A and B:**

- **Use Option A (individual comments)** when:
  - You want comments to appear immediately as you review
  - You're doing a simple review with few comments
  - You want flexibility to add comments incrementally

- **Use Option B (batch review)** when:
  - You want all comments to appear together (like "Start a review" in GitHub UI)
  - You're doing a comprehensive review with many comments
  - You want to review everything before notifying the PR author

**Note:** Line-specific comments use `position` (not `line`) which represents the position in the diff, starting from the first `@@` hunk header. For files with simple additions (like new files), `position` often equals the line number.

### 10. Compile General Review Comments

After completing all review tasks, compile your findings:

**If issues found:**
- List all concerns with file references
- Provide specific suggestions for improvement
- Include code examples where helpful

**If approved:**
- Summarize what you verified
- Note positive aspects
- Mention any minor suggestions

### 10. Compile General Review Comments

After adding all line-specific comments, compile overall review summary:

**If issues found:**
- Summarize the key concerns
- Reference line comments you've already added
- Provide high-level suggestions

**If approved:**
- Summarize what you verified
- Note positive aspects
- Mention any minor suggestions

### 11. Submit Overall Review

Submit the review using `gh pr review`:

**Request changes:**
```bash
gh pr review {{pr_number}} --request-changes --body "{{review_comments}}"
```

**Approve:**
```bash
gh pr review {{pr_number}} --approve --body "{{review_comments}}"
```

**Comment only:**
```bash
gh pr review {{pr_number}} --comment --body "{{review_comments}}"
```

## Usage Examples

### Example 1: Basic review workflow

```bash
# List open PRs
gh pr list

# Human selects PR #1
# Fetch details
gh pr view 1 --json number,title,headRefName,files

# Update remote
git fetch origin --prune

# Checkout PR
gh pr checkout 1

# Get changed files
gh pr diff 1 --name-only

# Review files and create comments
# ...

# Submit review
gh pr review 1 --approve --body "LGTM! Code follows conventions and tests pass."
```

### Example 2: Review with individual line-specific comments

```bash
gh pr list
# Select PR #2

gh pr view 2
git fetch origin --prune
gh pr checkout 2

# Get repo info and commit SHA
OWNER=$(gh repo view --json owner --jq '.owner.login')
REPO=$(gh repo view --json name --jq '.name')
COMMIT_SHA=$(gh pr view 2 --json commits --jq '.commits[-1].oid')

# Add line-specific comments (Option A: individual comments)
gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  /repos/$OWNER/$REPO/pulls/2/comments \
  -f body='Missing error handling for null input. Consider adding a null check.' \
  -f commit_id="$COMMIT_SHA" \
  -f path='src/utils.ts' \
  -F line=42 \
  -f side='RIGHT'

gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  /repos/$OWNER/$REPO/pulls/2/comments \
  -f body='Need to add test case for edge condition' \
  -f commit_id="$COMMIT_SHA" \
  -f path='test/utils.test.ts' \
  -F line=15 \
  -f side='RIGHT'

# Submit overall review
gh pr review 2 --request-changes --body "I've added specific comments on the lines that need attention. Please address these before merging."
```

### Example 2b: Review with batch comments (pending review)

```bash
gh pr list
# Select PR #2

gh pr view 2
git fetch origin --prune
gh pr checkout 2

# Get repo info and commit SHA
OWNER=$(gh repo view --json owner --jq '.owner.login')
REPO=$(gh repo view --json name --jq '.name')
COMMIT_SHA=$(gh pr view 2 --json commits --jq '.commits[-1].oid')

# Create pending review with multiple comments (Option B: batch review)
REVIEW_RESPONSE=$(jq -n \
  --arg commit_id "$COMMIT_SHA" \
  --arg body "Found a few issues that need attention" \
  '{
    commit_id: $commit_id,
    body: $body,
    comments: [
      {
        path: "src/utils.ts",
        position: 42,
        body: "Missing error handling for null input. Consider adding a null check."
      },
      {
        path: "test/utils.test.ts",
        position: 15,
        body: "Need to add test case for edge condition"
      }
    ]
  }' | gh api --method POST "/repos/$OWNER/$REPO/pulls/2/reviews" --input -)

# Extract review ID and submit
REVIEW_ID=$(echo "$REVIEW_RESPONSE" | jq -r '.id')
gh api --method POST "/repos/$OWNER/$REPO/pulls/2/reviews/$REVIEW_ID/events" \
  -f body="Please address the comments above before merging" \
  -f event="REQUEST_CHANGES"
```

### Example 3: Review with multi-line comments

```bash
# Add comment spanning lines 10-15
gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  /repos/$OWNER/$REPO/pulls/3/comments \
  -f body='This entire function needs refactoring. Consider extracting into smaller methods.' \
  -f commit_id="$COMMIT_SHA" \
  -f path='src/processor.ts' \
  -F start_line=10 \
  -f start_side='RIGHT' \
  -F line=15 \
  -f side='RIGHT'

# Submit overall review
gh pr review 3 --comment --body "Added suggestions for code organization."
```

### Example 4: Review with approval

```bash
# Review files, no issues found

# Submit approval with summary
gh pr review 4 --approve --body "LGTM! Reviewed all changes:

**Verified:**
- Code follows project conventions
- All tests pass
- Documentation is updated
- No security concerns

Great work!"
```

## Review Guidelines

### When to Add Comments

**Add comments for:**
- **Issues or problems**: Code that has bugs, errors, or doesn't work as intended
- **Questions or uncertainties**: Anything unclear or that needs clarification from the author
- **Security or performance concerns**: Potential risks or inefficiencies
- **Best practice violations**: Code that deviates from established patterns
- **Missing edge cases**: Scenarios that aren't handled
- **Documentation gaps**: Missing or unclear documentation

**Do NOT add comments for:**
- **Good code**: If something is well-written, don't comment just to praise it
- **Personal preferences**: Unless it violates project conventions, avoid style nitpicks
- **Minor formatting**: Unless significant or project convention

**When in doubt:**
If you're even slightly unsure whether something is a problem, **add a comment as a question**. It's better to ask and clarify than to let a potential issue slip through.

Examples:
- "Is this null check necessary here? I'm not sure if `value` can be null in this context."
- "Should we handle the case where the array is empty?"
- "I'm wondering if this could cause a race condition. Have you considered that scenario?"

### Comment Tone and Style

**Tone principles:**
- **Polite and professional**: Always maintain respect and courtesy
- **Collaborative, not confrontational**: Frame as discussion, not criticism
- **Specific and constructive**: Point out exactly what and suggest how to improve
- **Humble**: Use "I think", "consider", "perhaps" when appropriate
- **Question-based when uncertain**: Frame uncertainties as questions

**Good comment examples:**
```
❌ Bad: "This is wrong."
✅ Good: "I think there might be an issue here. When X happens, this could cause Y. Consider handling that case."

❌ Bad: "Why didn't you add error handling?"
✅ Good: "Should we add error handling here in case the API call fails?"

❌ Bad: "This code is hard to read."
✅ Good: "This logic is a bit complex. Would it help to extract this into a separate function with a descriptive name?"

❌ Bad: "You forgot to update the tests."
✅ Good: "I don't see test coverage for this new behavior. Could you add a test case to verify this works correctly?"

❌ Bad: "Use async/await instead."
✅ Good: "Have you considered using async/await here? It might make the error handling clearer and the code easier to follow."
```

**Structure of a good comment:**
1. **Observation**: What you noticed
2. **Impact/Risk**: Why it matters (if not obvious)
3. **Suggestion**: How to address it (if you have one)
4. **Question**: If uncertain, frame as a question

Example:
```
I noticed that `userId` isn't validated before the database query. If an invalid ID is passed, this could cause a database error. Consider adding validation at the start of the function, or would it make sense to handle this at the API layer instead?
```

### Code Quality Checks

- **Readability**: Is the code easy to understand?
- **Maintainability**: Will future developers understand this?
- **Consistency**: Does it follow project conventions?
- **Simplicity**: Is the solution as simple as possible?

### Security Considerations

- Input validation
- Authentication/authorization
- Sensitive data handling
- Dependency vulnerabilities

### Performance

- Algorithmic efficiency
- Resource usage
- Potential bottlenecks
- Scalability concerns

### Testing

- Test coverage for new code
- Edge cases handled
- Integration tests if needed
- Test quality and maintainability

### Documentation

- Code comments where needed
- README updates
- API documentation
- Memory bank updates

## Notes

- Always fetch latest remote info before reviewing
- **Only comment on issues, questions, or concerns - not on good code**
- **Be polite, professional, and respectful in all comments**
- **When uncertain, frame comments as questions rather than statements**
- Focus on important issues, not nitpicks
- Provide specific examples and suggestions
- Ask questions when intent is unclear
- Verify tests pass before approving
- Check that documentation is updated
- Consider project-specific guidelines from memory banks
- **Use `gh api` for line-specific comments, not `gh pr review`**
- **For detailed GitHub API usage patterns, check `.agdocs/memory/index.md` to find the relevant memory bank**
- Choose between individual comments (Option A) or batch review (Option B) based on your workflow
- For batch reviews, all comments appear together when you submit the pending review
- Line-specific comments use `position` in diff, not absolute line numbers in files
- Line-specific comments are immutable once posted (cannot be edited via CLI)
- Cannot approve your own PRs (use `COMMENT` or `REQUEST_CHANGES` instead)

## GitHub Operations Reference

For advanced GitHub API operations not covered in this command file, consult the memory bank:

**Check `.agdocs/memory/index.md`** to find the relevant memory bank file for GitHub operations. The memory bank contains detailed documentation on:
- Creating PR review comments with correct `gh api` syntax
- Replying to review comments (using `/replies` endpoint or `in_reply_to` parameter)
- Resolving review threads using GraphQL API
- Common GitHub API patterns and troubleshooting

**Key syntax points for `gh api` commands:**
- Always use `--method POST` (not just `POST`)
- Use `-f` flag for string parameters (body, commit_id, path)
- Use `-F` flag for numeric parameters (line, start_line, in_reply_to)
- Include `X-GitHub-Api-Version` header for API versioning
- Review thread resolution requires GraphQL API (REST API doesn't support it)

## Review Comment Best Practices

### Batching Comments

- **Group related comments together** when possible to reduce notification noise
- If multiple issues in the same file relate to the same concept, consider one comment referencing all locations
- Use batch review (Option B) when you have many comments to ensure they appear together

### Overall Review Summary

- **Keep the overall review summary concise** (2-3 sentences)
- Focus on high-level observations and next steps
- Avoid repeating details already in line-specific comments
- Don't include praise or evaluation phrases (e.g., "Great job!", "LGTM")

### Comment Tone

- **Avoid evaluative language** - focus on facts and questions
- Bad: "This is poorly written" 
- Good: "Consider extracting this logic into a separate function for clarity"
- Bad: "Nice work on this implementation"
- Good: (No comment if code is fine - only comment on issues)

### When to Comment

- **Don't comment just to acknowledge** - silence means approval
- Only add comments for:
  - Issues that need fixing
  - Questions that need answers
  - Suggestions for improvement
  - Security or performance concerns

## Troubleshooting

### Cannot checkout PR

If `gh pr checkout` fails:
```bash
# Manually fetch and checkout
git fetch origin pull/{{pr_number}}/head:pr-{{pr_number}}
git checkout pr-{{pr_number}}
```

### Merge conflicts shown

If diff shows many changes:
```bash
# Get clean diff from base branch
git diff $(git merge-base HEAD {{base_branch}})..HEAD
```

### Authentication issues

```bash
gh auth login
```

## Related Commands

- `gh pr list` - List pull requests
- `gh pr view` - View PR details
- `gh pr checkout` - Check out PR branch
- `gh pr diff` - View PR changes
- `gh pr review` - Submit overall review
- `gh api` - Make GitHub REST API calls (for line-specific comments)
- `git fetch` - Update remote information
- `git diff` - Compare changes

## Additional Resources

- [GitHub REST API - Create a review comment](https://docs.github.com/en/rest/pulls/comments#create-a-review-comment-for-a-pull-request)
- [GitHub REST API - Create a review](https://docs.github.com/en/rest/pulls/reviews#create-a-review-for-a-pull-request)
- [GitHub REST API - Submit a review](https://docs.github.com/en/rest/pulls/reviews#submit-a-review-for-a-pull-request)
- [gh api documentation](https://cli.github.com/manual/gh_api)
- [jq manual](https://stedolan.github.io/jq/manual/) - for JSON processing
