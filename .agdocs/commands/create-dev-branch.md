# create-dev-branch Command

## Overview

This command creates a new development branch from the latest `main` branch. It ensures the working directory is clean, fetches the latest remote changes, and creates a new branch based on the development task description.

## Instructions

When a human requests to create a development branch, follow these steps:

### 1. Check Working Directory Status

Verify that there are no uncommitted changes:

```bash
git status
```

**Expected output**: "nothing to commit, working tree clean" or similar.

**If there are changes:**
- Inform the human that there are uncommitted changes
- List the modified files
- Ask for instructions:
  - Should changes be committed first?
  - Should changes be stashed?
  - Should we proceed anyway?

Example message:
```
There are uncommitted changes in the following files:
- src/utils.ts
- test/utils.test.ts

Would you like to:
1. Commit these changes first
2. Stash these changes
3. Proceed anyway (not recommended)
```

Wait for human response before proceeding.

### 2. Fetch Latest Remote Information

Update local references to match the remote repository:

```bash
git fetch origin --prune --all
```

This command:
- Fetches all branches from `origin`
- Prunes deleted remote branches from local references
- Updates all remote-tracking branches

### 3. Determine Branch Name

Ask the human for the development task description if not already provided.

**If task description provided:**
Generate a branch name slug from the task description:
- Use lowercase
- Replace spaces with hyphens
- Remove special characters
- Keep it concise (3-5 words recommended)

Examples:
- "Add user authentication" → `add-user-authentication`
- "Fix login bug" → `fix-login-bug`
- "Update documentation for API" → `update-api-documentation`

**If no task description:**
Ask the human:
```
What feature or task will you be working on in this branch?
```

Wait for response and generate the branch name from their answer.

### 4. Create and Checkout Development Branch

Create a new branch from `origin/main`:

```bash
git checkout -b '{{branch_name_slug}}' origin/main
```

This command:
- Creates a new local branch named `{{branch_name_slug}}`
- Sets the starting point to the latest commit from `origin/main`
- Switches to the newly created branch

### 5. Verify Branch Creation

Confirm the branch was created successfully:

```bash
git branch --show-current
```

Expected output: `{{branch_name_slug}}`

Also check the tracking relationship:

```bash
git status
```

Expected output should show: "On branch {{branch_name_slug}}"

### 6. Report Completion

Inform the human:
```
Development branch created successfully!

Branch name: {{branch_name_slug}}
Base: origin/main
Current branch: {{branch_name_slug}}

You can now start working on your changes.
```

## Usage Examples

### Example 1: Clean working directory

```bash
# Check status
$ git status
On branch main
nothing to commit, working tree clean

# Fetch latest
$ git fetch origin --prune --all

# Create branch
$ git checkout -b 'add-user-profile' origin/main
Switched to a new branch 'add-user-profile'

# Verify
$ git branch --show-current
add-user-profile
```

### Example 2: With uncommitted changes

```bash
# Check status
$ git status
On branch main
Changes not staged for commit:
  modified:   src/app.ts

# Inform human and wait for instructions
AI: There are uncommitted changes in:
- src/app.ts

Would you like to:
1. Commit these changes first
2. Stash these changes
3. Proceed anyway (not recommended)

# Human chooses option 2
$ git stash push -m "WIP: temp stash before branch creation"

# Proceed with branch creation
$ git fetch origin --prune --all
$ git checkout -b 'implement-search' origin/main
```

### Example 3: Interactive branch naming

```
AI: What feature or task will you be working on in this branch?
Human: I want to refactor the database connection logic
AI: [Generates branch name: refactor-database-connection]

$ git fetch origin --prune --all
$ git checkout -b 'refactor-database-connection' origin/main
Switched to a new branch 'refactor-database-connection'
```

## Notes

- Always check for uncommitted changes before creating a branch
- Branch names should be descriptive but concise
- Use kebab-case (lowercase with hyphens) for branch names
- The branch is created from `origin/main`, not local `main`, to ensure latest remote changes
- `git fetch --prune` removes references to deleted remote branches
- If the branch name already exists, git will show an error - ask the human for a different name
- Consider including issue/ticket numbers in branch names if applicable (e.g., `fix-issue-123`)
- Don't proceed with branch creation if there are uncommitted changes without human confirmation

## Branch Naming Conventions

Follow these conventions when generating branch names:

**Prefixes** (optional but recommended):
- `feature/` - New features
- `fix/` - Bug fixes
- `refactor/` - Code refactoring
- `docs/` - Documentation updates
- `test/` - Test additions or modifications
- `chore/` - Maintenance tasks

**Examples with prefixes:**
- `feature/add-user-authentication`
- `fix/login-redirect-issue`
- `refactor/simplify-api-client`
- `docs/update-readme`

**Without prefixes** (simpler, also acceptable):
- `add-user-authentication`
- `fix-login-redirect`
- `simplify-api-client`

Ask the human if they have a preference for using prefixes or not.

## Troubleshooting

### Branch already exists

**Error:**
```
fatal: A branch named 'feature-name' already exists.
```

**Solution:**
Ask the human if they want to:
1. Switch to the existing branch: `git checkout feature-name`
2. Delete and recreate: `git branch -D feature-name` then create new
3. Use a different name: create with modified name

### Remote not up to date

If `git fetch` shows many changes, consider informing the human:
```
Note: Fetched {{N}} new commits from origin/main. 
Your branch will be based on the latest remote code.
```

### Uncommitted changes prevent checkout

If git prevents branch creation due to conflicts:
```
error: Your local changes to the following files would be overwritten by checkout:
	src/file.ts
```

Inform human and recommend:
1. Commit changes: `git commit -am "message"`
2. Stash changes: `git stash`
3. Discard changes: `git checkout -- src/file.ts` (use with caution)

## Related Commands

- `commit-push-pr` - To commit, push, and create PR after development
- `review-pr` - To review pull requests before merging

