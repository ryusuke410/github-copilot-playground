# Quick Start Guide

## Getting Started

Follow these steps to begin working on this PR review:

### 1. Understand the Context

Read the following documents in order:
1. [Human Instructions](./human-instructions.md) - Understand the review request and focus areas
2. [Index](./index.md) - Know the overall status

### 2. Review Current State

- Check the [Tasks](./tasks.md) document to see what's been completed and what's next
- Check the [Status](./status.md) to see current procedure step

### 3. Reorganize Tasks as Needed

1. Edit [tasks.md](./tasks.md) to reorder tasks based on priority or PR structure
2. Add specific tasks for complex changes

### 4. Start Working

1. Pick the next task from the task list
2. Read the task details
3. Begin review
4. **After completing each task, read `.agdocs/commands/yeah.md` to maintain workflow context**
5. Update the task status as you progress

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
- `.agdocs/commands/yeah.md` - Workflow management

## Related Resources

- `.agdocs/memory/github-operations.md` - GitHub API patterns
- `.agdocs/memory/index.md` - All available memory banks
- GitHub CLI documentation: `gh pr --help`
