# Quick Start Guide

## Getting Started

Follow these steps to begin working on this PR review:

### 0. Important Reminders

⚠️ **Context Window Management**:
- Your memory has limitations. Reading too much information at once can cause earlier context to be lost.
- **Always use pagination** when reading diffs, file lists, or large outputs
- Read changed files in small batches (5-10 files at a time)
- Review systematically file-by-file rather than loading everything at once
- If you notice forgetting instructions, re-read `.github/instructions/yeah.local.instructions.md`

🔍 **GitHub Operations**:
- Before performing GitHub operations (PR comments, issue updates, etc.), **read the memory-bank** first
- Check `.agdocs/memory/github-operations.md` for correct API usage patterns
- Use memory-bank to understand proper command syntax and avoid common mistakes

### 1. Understand the Context

Read the following documents in order:
1. [Human Instructions](./human-instructions.md) - Understand the review request and focus areas
2. [Index](./index.md) - Know the overall status
3. **`.agdocs/memory/github-operations.md`** - Understand GitHub API patterns before reviewing

### 2. Review Current State

- Check the [Tasks](./tasks.md) document to see what's been completed and what's next
- Check the [Status](./status.md) to see current procedure step

### 3. Reorganize Tasks as Needed

1. Edit [tasks.md](./tasks.md) to reorder tasks based on priority or PR structure
2. Add specific tasks for complex changes
3. **Break down by files**: Aim for at least 1 task per file (more for large files)

### 4. Start Working

1. Pick the next task from the task list
2. Read the task details
3. **Use pagination**: Don't load entire PR diff at once
4. Begin review
5. **Check related files for consistency**: Don't just review the changed file in isolation
   - Look at files that import/use the changed code
   - Check if interfaces/contracts are maintained
   - Verify consistency with related modules
   - Example: If reviewing `auth/login.ts`, also check `middleware/auth.ts`, `types/auth.ts`
6. **After completing each task**:
   - Read `.github/instructions/yeah.local.instructions.md` to maintain workflow context
   - **Check the List of Changes section in [tasks.md](./tasks.md)** to verify it's complete and accurate
   - If the List of Changes is incomplete or outdated, update it to reflect all changes made
7. Update the task status as you progress

### 5. Handle Task Modifications

**If human requests task additions or modifications:**
1. **First, update [human-instructions.md](./human-instructions.md)** with the new requirements
2. Then, reorganize and update [tasks.md](./tasks.md) accordingly
3. Continue with the updated task list

This ensures the human's intent is documented before task restructuring.

### 6. Document Progress

- Update task status in [tasks.md](./tasks.md)
- Add notes or findings to relevant documents
- Update the status in [../index.md](../index.md)

## Tips

- Always read `index.md` first when resuming work
- Keep review comments focused and actionable
- Follow objective feedback guidelines from `.agdocs/commands/review-pr.md`
- Don't comment just to acknowledge - silence means approval
- Be specific and constructive in feedback

## Commands

- `.agdocs/commands/review-pr.md` - Complete PR review workflow
- `.github/instructions/yeah.local.instructions.md` - Workflow management

## Related Resources

- `.agdocs/memory/github-operations.md` - GitHub API patterns
- `.agdocs/memory/index.md` - All available memory banks
- GitHub CLI documentation: `gh pr --help`
