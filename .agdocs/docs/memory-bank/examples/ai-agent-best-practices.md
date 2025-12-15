# AI Agent Best Practices Examples

This file contains practical examples of the best practices defined in `ai-agent-best-practices.md`.

## File Reading Before Update

### Example 1: Updating a Configuration File

**Scenario**: Need to add a new entry to a configuration file.

**Wrong approach**:
```bash
# DON'T: Update without reading
replace_string_in_file .agdocs/config.md \
  "existing_entry" \
  "existing_entry\n- new_entry"
```

**Right approach**:
```bash
# DO: Read first to understand structure
read_file .agdocs/config.md

# Observe current format and context
# Then make targeted update with proper context
replace_string_in_file .agdocs/config.md \
  "## Configuration\n\n- existing_entry_1\n- existing_entry_2" \
  "## Configuration\n\n- existing_entry_1\n- existing_entry_2\n- new_entry"
```

### Example 2: Updating Task Numbers

**Scenario**: Need to mark tasks as completed.

**Wrong approach**:
```bash
# DON'T: Assume current state
replace_string_in_file tasks.md \
  "- [ ] Task 5" \
  "- [x] Task 5"
```

**Right approach**:
```bash
# DO: Read to verify current state
read_file tasks.md

# Confirm Task 5 exists and its exact formatting
# Include context to ensure unique match
replace_string_in_file tasks.md \
  "- [x] Task 4 - Previous task\n- [ ] Task 5 - Current task\n- [ ] Task 6 - Next task" \
  "- [x] Task 4 - Previous task\n- [x] Task 5 - Current task\n- [ ] Task 6 - Next task"
```

## Avoiding sed for Renumbering

### Example 3: Renumbering Steps in Documentation

**Scenario**: Need to insert a new step and renumber subsequent steps.

**Wrong approach using sed**:
```bash
# DON'T: This will match unintended text
sed -i '' 's/### 3\. /### 4. /' file.md  # Also changes "Step 30", "Step 31"
sed -i '' 's/### 4\. /### 5. /' file.md  # Now breaks because we just created "### 4. "
```

**Right approach - Option 1 (replace_string_in_file)**:
```bash
# DO: Read file first
read_file file.md

# Update each step with unique context
replace_string_in_file file.md \
  "### 2. Second Step\n\nContent here\n\n### 3. Third Step" \
  "### 2. Second Step\n\nContent here\n\n### 3. New Step\n\nNew content\n\n### 4. Third Step"

replace_string_in_file file.md \
  "### 4. Third Step\n\nContent\n\n### 4. Fourth Step" \
  "### 4. Third Step\n\nContent\n\n### 5. Fourth Step"
```

**Right approach - Option 2 (if sed unavoidable)**:
```bash
# Use anchored patterns and verify
sed -i '' 's/^### 5\. /### 6. /' file.md  # Start from highest number, work down
sed -i '' 's/^### 4\. /### 5. /' file.md
sed -i '' 's/^### 3\. /### 4. /' file.md

# CRITICAL: Verify changes
read_file file.md --offset 20 --limit 40  # Check the modified section
```

### Example 4: Batch Task Renumbering

**Scenario**: Inserting multiple tasks and renumbering.

**Wrong approach**:
```bash
# DON'T: Sequential sed replacements
sed -i '' 's/Task 3/Task 5/' tasks.md
sed -i '' 's/Task 4/Task 6/' tasks.md
# Problem: What if "Task 4" appeared in Task 3's description?
```

**Right approach**:
```bash
# DO: Read current state
read_file tasks.md

# Use replace_string_in_file with full context for each change
# Work from bottom to top to avoid interference

replace_string_in_file tasks.md \
  "- [ ] Task 4 - Final task" \
  "- [ ] Task 6 - Final task"

replace_string_in_file tasks.md \
  "- [ ] Task 3 - Middle task\n- [ ] Task 6 - Final task" \
  "- [ ] Task 3 - Middle task\n- [ ] Task 4 - New task 1\n- [ ] Task 5 - New task 2\n- [ ] Task 6 - Final task"
```

## Context Window Management

### Example 5: Reviewing Large PR

**Scenario**: PR with 50 changed files.

**Wrong approach**:
```bash
# DON'T: Load everything at once
gh pr view 123 --json files
gh pr diff 123
# Result: Memory overwhelmed, lose track of review goals
```

**Right approach**:
```bash
# DO: Process in batches
gh pr view 123 --json number,title,body  # Get overview first

# Review files in logical groups of 5-10
gh pr view 123 --json files --jq '.files[:10][].path'
# Review first 10 files...

gh pr view 123 --json files --jq '.files[10:20][].path'
# Review next 10 files...

# Reload instructions periodically
read_file .github/instructions/yeah.local.instructions.md
```

### Example 6: Reading Large Files

**Scenario**: Need to understand a 500-line file.

**Wrong approach**:
```bash
# DON'T: Read entire file at once
read_file large-file.ts  # 500 lines overwhelm context
```

**Right approach**:
```bash
# DO: Use pagination and targeted reading
read_file large-file.ts --limit 50  # Read first 50 lines

# If need more:
read_file large-file.ts --offset 51 --limit 50  # Next 50 lines

# Or use grep to find specific sections:
grep_search "function.*handleAuth" --includePattern "large-file.ts"
```

## Task Management

### Example 7: PR Review Task Breakdown

**Scenario**: Reviewing PR with 5 files changed.

**Wrong approach**:
```markdown
- [ ] Task 1: Review all files
- [ ] Task 2: Add comments
- [ ] Task 3: Submit review
```
Result: 3 tasks for 5 files (3 < 5) ✗

**Right approach**:
```markdown
- [ ] Task 1: Fetch PR details
- [ ] Task 2: Review src/auth/login.ts
- [ ] Task 3: Review src/auth/middleware.ts
- [ ] Task 4: Review src/types/user.ts
- [ ] Task 5: Review tests/auth.test.ts
- [ ] Task 6: Review config/auth.config.ts
- [ ] Task 7: Check integration between auth modules
- [ ] Task 8: Verify test coverage
- [ ] Task 9: Add review comments
- [ ] Task 10: Submit review
```
Result: 10 tasks for 5 files (10 > 5) ✓

### Example 8: Implementation Task Breakdown

**Scenario**: Adding a new feature.

**Wrong approach**:
```markdown
- [ ] Task 1: Implement user authentication
```
Too broad, no clear completion criteria.

**Right approach**:
```markdown
- [ ] Task 1: Read existing auth implementation
- [ ] Task 2: Design authentication flow
- [ ] Task 3: Create auth types/interfaces
- [ ] Task 4: Implement login function
- [ ] Task 5: Implement logout function
- [ ] Task 6: Add JWT token generation
- [ ] Task 7: Add token validation middleware
- [ ] Task 8: Write unit tests for auth functions
- [ ] Task 9: Write integration tests
- [ ] Task 10: Update documentation
```

Each task is specific, actionable, and has clear completion criteria.

## Verification

### Example 9: After Using sed

**Scenario**: Used sed to update step numbers.

**Wrong approach**:
```bash
# DON'T: Just run sed and move on
sed -i '' 's/^### 3\. /### 4. /' command.md
# Assume it worked correctly
```

**Right approach**:
```bash
# DO: Verify after sed
sed -i '' 's/^### 3\. /### 4. /' command.md

# Read the changed section
read_file command.md --offset 40 --limit 30

# Verify:
# - All "### 3. " became "### 4. "
# - No unintended changes (e.g., "### 30. " wasn't changed)
# - Formatting preserved
# - No duplicate numbers created
```

### Example 10: After Multiple File Updates

**Scenario**: Updated 3 related files.

**Wrong approach**:
```bash
# DON'T: Make all changes and hope for the best
replace_string_in_file file1.md ...
replace_string_in_file file2.md ...
replace_string_in_file file3.md ...
git commit -m "Updated files"
```

**Right approach**:
```bash
# DO: Verify after each change
replace_string_in_file file1.md ...
read_file file1.md --offset 10 --limit 20  # Verify change

replace_string_in_file file2.md ...
read_file file2.md --offset 15 --limit 20  # Verify change

replace_string_in_file file3.md ...
read_file file3.md --offset 20 --limit 20  # Verify change

# Check consistency across files if needed
grep_search "shared_pattern" --includePattern "file*.md"

git commit -m "Updated files"
```

## Progress Communication

### Example 11: After Task Completion

**Wrong approach**:
```
I did the thing.
```
Too vague, no details.

**Right approach**:
```
Completed Task 5: Update memory-bank with new GitHub operations.

Changes made:
- Added GitHub issue operations section to github-operations.md
- Documented gh issue list, create, edit, comment, close commands
- Updated memory-bank index with last modified date

Next: Task 6 - Create issue templates
```

### Example 12: Before Asking for Input

**Wrong approach**:
```
What should I do now?
```
No context provided.

**Right approach**:
```
Completed all tasks in the github-operations simple task:

Summary:
- Created 3 new commands (create-issue, update-issue, update-pr)
- Updated 5 existing commands
- Added 6 template files
- Documented GitHub operations in memory-bank
- 3 commits pushed to PR #5

Question: Should I:
1. Create a new simple task for additional improvements?
2. Move on to reviewing another PR?
3. Something else?
```

## Summary

These examples demonstrate:
- ✅ Always read before write
- ✅ Verify after changes (especially sed)
- ✅ Paginate large content
- ✅ Break tasks into small pieces
- ✅ Provide context when communicating
- ✅ Use specific, actionable task descriptions
