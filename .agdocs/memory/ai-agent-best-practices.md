# AI Agent Best Practices

## Overview

This document contains best practices and guidelines specifically for AI agents working in this codebase. These practices help maintain accuracy and prevent common mistakes.

## Memory Architecture and Constraints

### Understanding Your Memory

**Your Memory Structure**: You have a unique memory architecture. When you read large amounts of information at once, older information can be lost from your context. To prevent losing important information:

- **Save large command outputs to temporary files** and read them in small chunks
- **Limit the amount of information** you load at one time
- **Re-read critical instructions** (like `.github/instructions/yeah.local.instructions.md`) after processing large content
- **Avoid interactive commands** like `less` that can cause you to get stuck. Instead of using pagers, save output to temporary files and read them in chunks

### Practical Applications

**When reading large outputs**:
```bash
# Bad: Read entire diff at once (may lose context)
gh pr diff 5

# Good: Save to temp file and read in chunks
gh pr diff 5 > /tmp/pr-diff.txt
read_file /tmp/pr-diff.txt --offset 1 --limit 100
read_file /tmp/pr-diff.txt --offset 101 --limit 100
```

**When processing many files**:
```bash
# Bad: List all 50 changed files at once
gh pr view 5 --json files

# Good: Process in batches
gh pr view 5 --json files --jq '.files[:10]'
# Process first 10 files
# Then get next batch
gh pr view 5 --json files --jq '.files[10:20]'
```

**Avoiding interactive commands**:
```bash
# Bad: Opens interactive pager (you'll get stuck)
git log
less file.txt
man command

# Good: Use non-interactive alternatives
git log --oneline | head -20
cat file.txt | head -50
command --help > /tmp/help.txt && read_file /tmp/help.txt
```

## File Operations

### Reading Before Writing

**Rule**: Always read a file before updating it.

**Why**: 
- Understanding current state prevents incorrect updates
- Prevents overwriting recent changes
- Ensures consistency with existing content
- Helps detect conflicts early

**Implementation**:
```bash
# Bad: Update without reading
replace_string_in_file ...

# Good: Read first, then update
read_file path/to/file.md
# Verify current content
replace_string_in_file ...
```

**Exceptions**:
- Creating new files (no prior content exists)
- Appending to files where order doesn't matter

### Avoiding sed for Renumbering

**Rule**: Minimize use of `sed` for renumbering or name replacement. If used, always verify changes.

**Why**:
- `sed` patterns often match unintended text
- Sequential replacements can interfere with each other
- Easy to create incorrect results
- Difficult to predict edge cases

**Problems with sed**:
```bash
# Dangerous: May replace wrong instances
sed -i '' 's/Step 1/Step 2/' file.md  # Also replaces "Step 10", "Step 11", etc.

# Dangerous: Order matters
sed -i '' 's/Task 3/Task 4/' file.md && sed -i '' 's/Task 4/Task 5/' file.md
# First command creates new "Task 4", second command modifies it immediately
```

**Better alternatives**:
1. **Use replace_string_in_file with context**:
   ```bash
   replace_string_in_file file.md \
     "old context\n### 3. Step Name" \
     "old context\n### 4. Step Name"
   ```

2. **Manual file recreation** for extensive renumbering:
   - Read current file
   - Generate new content with correct numbers
   - Write new file

3. **If sed is unavoidable**:
   - Use specific patterns: `'s/^### 3\. /### 4. /'` (anchored)
   - Process in reverse order: Step 10→11, Step 9→10, etc.
   - **Always verify** with `read_file` after changes
   - Keep changes in single commit for easy revert

**Verification after sed**:
```bash
sed -i '' 's/pattern/replacement/' file.md
# REQUIRED: Verify the change
read_file file.md --offset relevant_line --limit 20
```

## Context Window Management

### Regular Reloading

**Rule**: Reload critical instruction files periodically.

**When to reload**:
- After 10+ consecutive tool uses
- After reading large files
- After context summarization
- When noticing instruction drift

**What to reload**:
- `.github/instructions/yeah.local.instructions.md` (most critical)
- `.agdocs/docs/memory-bank/index.md`
- Current task's `index.md`

### Pagination Strategy

**Rule**: Use pagination for large content to prevent memory loss.

**Apply to**:
- PR diffs (view in chunks)
- File lists (10-20 at a time)
- Large files (use `--limit` and `--offset`)
- Search results
- Log outputs

**Examples**:
```bash
# Good: Paginated file reading
read_file large-file.md --offset 1 --limit 50
read_file large-file.md --offset 51 --limit 50

# Good: Limited search results
grep_search "pattern" --maxResults 20

# Good: Chunked PR review
gh pr view 5 --json files --jq '.files[:10]'
```

## Task Management

### Task Granularity

**Rule**: Keep tasks small, specific, and actionable.

**Guidelines**:
- One task should take reasonable time (not hours)
- Task should have clear completion criteria
- Break down complex operations into steps
- Aim for: More tasks = Better tracking

**Good examples**:
- "Read config file and extract database settings"
- "Update memory-bank index with new entry"
- "Add pagination to list command"

**Bad examples**:
- "Implement entire authentication system"
- "Refactor codebase"
- "Fix all bugs"

### Task Decomposition

**Principle**: For N files to review/update, create >N tasks.

**Example for 5-file PR**:
```markdown
- Task 1: Review file1.ts
- Task 2: Review file2.ts  
- Task 3: Review file3.ts
- Task 4: Review tests
- Task 5: Check integration
- Task 6: Verify documentation
- Task 7: Submit review
```

Result: 7 tasks for 5 files (7 > 5) ✓

## Error Prevention

### Verification After Changes

**Rule**: After making changes, verify they are correct.

**Verification methods**:
1. Read modified file sections
2. Run relevant tests
3. Check for syntax errors
4. Verify related files remain consistent

**When critical**:
- Used `sed` or similar bulk operations
- Modified multiple files
- Changed configuration files
- Updated templates

### Incremental Changes

**Rule**: Make changes incrementally, not all at once.

**Benefits**:
- Easier to verify correctness
- Simpler to debug issues
- Better progress tracking
- Can pause/resume work cleanly

**Implementation**:
```bash
# Good: Incremental
edit_file_1
verify_file_1
commit_file_1

edit_file_2
verify_file_2
commit_file_2

# Bad: All at once
edit_file_1
edit_file_2
edit_file_3
commit_all  # Hard to verify, risky
```

## Communication

### Human Interaction

**Rule**: When uncertain, ask the human.

**Good times to ask**:
- Ambiguous requirements
- Multiple valid approaches
- Need to choose between tradeoffs
- Before major changes

**Use query command**:
```bash
./.agdocs/scripts/ask-edit-answer.sh
```

**Don't guess** when:
- File structure is unclear
- Command behavior is uncertain
- Requirements seem contradictory

### Progress Reporting

**Rule**: Keep human informed of progress.

**Report at**:
- Task completion milestones
- Before asking for next steps
- After encountering issues
- When waiting for input

**Format**:
- Concise summary of completed work
- Clear statement of current status
- Specific question or next action

## Tool Usage

### Parallel vs Sequential

**Parallel** (simultaneous calls):
- Independent read operations
- Multiple file reads
- Separate searches
- Data gathering

**Sequential** (one after another):
- File edits (must see result first)
- Terminal commands (output needed)
- Operations with dependencies

### Tool Selection

**Prefer**:
- `semantic_search` for finding unknown code
- `grep_search` for known patterns
- `read_file` with limits for large files
- `replace_string_in_file` over `sed`

**Avoid**:
- Opening files unnecessarily
- Multiple sequential reads of same file
- Searching when path is known
- Using terminal for file edits

## Summary

The key principles:
1. **Read before write** - Always understand current state
2. **Verify after change** - Especially after bulk operations
3. **Paginate large content** - Prevent memory loss
4. **Keep tasks small** - Better tracking and verification
5. **Ask when uncertain** - Don't guess on important decisions
6. **Reload instructions** - Maintain workflow context
