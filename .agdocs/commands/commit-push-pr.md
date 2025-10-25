# commit-push-pr Command

## Overview

This command creates a commit, pushes it to the remote repository, and creates a pull request on GitHub. It provides a streamlined workflow for completing work and submitting it for review.

## Instructions

When a human requests to commit, push, and create a PR, follow these steps:

### 1. Stage Files

Stage the files to be included in the commit using `git add`:

```bash
git add {{file_paths}}
```

Common patterns:
- `git add .` - Stage all changed files in current directory
- `git add -A` - Stage all changed files in repository
- `git add path/to/file` - Stage specific file
- `git add -p` - Interactively stage chunks

### 2. Review Staged Changes

Execute `git status` to verify the staged changes:

```bash
git status
```

Review the output to ensure:
- All intended files are staged
- No unintended files are included
- File changes are appropriate

If modifications are needed, use:
- `git reset HEAD {{file}}` - Unstage a file
- `git add {{file}}` - Stage additional files

### 3. Create Commit

Execute `git commit` with a clear, concise commit message:

```bash
git commit -m '{{commit_message}}'
```

Commit message guidelines:
- Use imperative mood (e.g., "Add feature" not "Added feature")
- Keep first line under 50 characters
- Use English for commit messages
- Be specific and descriptive
- Follow conventional commits format if applicable (feat:, fix:, docs:, etc.)

Examples:
```bash
git commit -m 'feat: add user authentication system'
git commit -m 'fix: resolve memory leak in data processor'
git commit -m 'docs: update API documentation'
```

### 4. Push to Remote

Push the commit to the remote repository:

```bash
git push -u origin HEAD
```

This command:
- Pushes the current branch to `origin`
- Uses `HEAD` to automatically use the current branch name
- Sets upstream tracking with `-u` flag

If the branch doesn't exist on remote, it will be created automatically.

### 5. Create Pull Request

Use the `gh` CLI to create a pull request:

```bash
gh pr create --title "{{pr_title}}" --body "{{pr_body}}"
```

Or use the body template provided by the human:

```bash
gh pr create --title "{{pr_title}}" --body "## 変更内容

{{変更内容を簡潔に説明する}}

{{実装内容に直観的な意外性がある場合は、その選択の理由も説明する}}

## レビュー時に確認

{{レビュー時に特に注意して見てほしい点があれば記載する}}"
```

Alternative approaches:

**Use editor for PR body:**
```bash
gh pr create --title "{{pr_title}}" --editor
```

**Use template file:**
```bash
gh pr create --title "{{pr_title}}" --template "{{template_file}}"
```

**Interactive mode (prompts for all fields):**
```bash
gh pr create
```

**Fill from commit messages:**
```bash
gh pr create --fill
```

### 6. Verify PR Creation

After successful PR creation, `gh` will output the PR URL. Verify:
- PR was created successfully
- Title and description are correct
- Base branch is correct
- All CI checks are triggered

## Usage Examples

### Example 1: Basic workflow

```bash
# Stage all changes
git add .

# Review changes
git status

# Commit
git commit -m 'feat: add memory-bank examples'

# Push
git push -u origin HEAD

# Create PR
gh pr create --title "Add memory-bank examples" --body "Added examples for shell commands, language, and notation."
```

### Example 2: With template

```bash
git add src/
git status
git commit -m 'fix: resolve authentication bug'
git push -u origin HEAD
gh pr create --title "Fix authentication bug" --body "## 変更内容

認証トークンの検証ロジックを修正しました。

## レビュー時に確認

セキュリティ面での問題がないか確認してください。"
```

### Example 3: Interactive mode

```bash
git add .
git status
git commit -m 'docs: update README'
git push -u origin HEAD
gh pr create
# gh will prompt for title, body, base branch, etc.
```

## Additional Options

### Draft PR

Create a draft PR that isn't ready for review:

```bash
gh pr create --draft --title "{{title}}" --body "{{body}}"
```

### Assign Reviewers

Request specific reviewers:

```bash
gh pr create --title "{{title}}" --body "{{body}}" --reviewer username1,username2
```

### Add Labels

Add labels to the PR:

```bash
gh pr create --title "{{title}}" --body "{{body}}" --label bug,urgent
```

### Specify Base Branch

Target a specific base branch:

```bash
gh pr create --base develop --title "{{title}}" --body "{{body}}"
```

## Notes

- Always review staged changes before committing
- Use clear, descriptive commit messages in English
- The `-u origin HEAD` pattern is preferred for pushing new branches
- `gh pr create` requires GitHub CLI to be installed and authenticated
- PR body can include issue references (e.g., "Fixes #123") to auto-close issues
- Use `gh auth login` if not authenticated
- Use `gh auth refresh -s project` if adding PR to projects

## Troubleshooting

### Authentication Error

If `gh` reports authentication errors:
```bash
gh auth login
```

### Push Rejected

If push is rejected due to remote changes:
```bash
git pull --rebase origin {{branch_name}}
git push -u origin HEAD
```

### No Commits to Push

If there are no commits to push, ensure you've created a commit:
```bash
git log --oneline -n 1  # Verify commit exists
```

## Related Commands

- `git add` - Stage changes for commit
- `git status` - Review staged changes
- `git commit` - Create commit
- `git push` - Push commits to remote
- `gh pr create` - Create pull request on GitHub
