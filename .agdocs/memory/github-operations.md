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
