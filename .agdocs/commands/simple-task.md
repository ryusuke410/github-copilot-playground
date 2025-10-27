# simple-task Command

## Overview

`simple-task` is a lightweight mechanism for managing a simple series of tasks. It provides a streamlined approach to organizing and executing one-off task groups without the overhead of dev-logs. Use this for straightforward, well-defined work that doesn't require extensive planning phases.

## Directory Structure

```
.agdocs/
  swap/                # Note: This is git ignored
    simple-tasks/
      index.md         # Contains the simple task list table
      items/
        {{simple_task_name_slug}}/
          index.md     # Entry point document, always loaded first
          human-instructions.md  # User instructions
          status.md    # Current status and procedure checklist
          tasks.md      # Task list with checkboxes
          other files as needed...
  templates/
    simple-tasks/
      index.md
      item/
        index.md
        human-instructions.md
        status.md
        tasks.md
```

## Instructions

When a user requests to start a simple task, follow these steps:

### 1. Check Existing Simple Tasks

Read `swap/simple-tasks/index.md` to understand what simple task items already exist. If the index file doesn't exist, create it using `templates/simple-tasks/index.md` as a template.

### 2. Analyze Human Instructions

Carefully analyze the human's instructions to determine:
- **Is this a single cohesive task or multiple separate tasks?**
  - Unless the human explicitly requests multiple separate simple tasks, consolidate related work into ONE simple task
  - Multiple sub-tasks within ONE simple task are created in `tasks.md`
  
- **Is this related to an existing simple task?**
  - Check if any existing simple task (from index) matches or relates to the request
  - If yes, the human might want to continue that existing task rather than create a new one

### 3. Determine Action

Based on the analysis, determine whether to:
- **Continue an existing simple task**: If the request relates to ongoing work in an existing simple task
- **Create ONE new simple task**: For new work, consolidate all related requests into a single simple task

**Important**: By default, create ONE simple task for the entire request unless the human explicitly asks for separate simple tasks.

If there are existing simple tasks that might be related, present the list to the human and ask:
- "I found existing simple task: [name]. Do you want to continue that task, or create a new one?"

### 4a. If Continuing an Existing Simple Task

Read `swap/simple-tasks/items/{{simple_task_name_slug}}/index.md` for the selected simple task and follow the instructions within that file to continue work.

The ai-agent should:
- Read the current `status.md` to understand progress
- Review completed and pending tasks in `tasks.md`
- Continue from where the work left off
- Add new tasks to `tasks.md` if the human's request adds new requirements

### 4b. If Creating ONE New Simple Task

Follow these steps to create a new simple task:

#### 4b-1. Generate Slug Name

Based on the human's instructions, generate a slug name for the simple task:
- Use lowercase
- Replace spaces with hyphens
- Keep it concise and descriptive (2-4 words recommended)
- Remove special characters

Examples:
- "Update documentation" → `update-documentation`
- "Fix login bug" → `fix-login-bug`
- "Add new feature" → `add-new-feature`

#### 4b-2. Create the Simple Task Directory

Create the directory `swap/simple-tasks/items/{{simple_task_name_slug}}`.

#### 4b-3. Update the Simple Task Index

Add the new simple task to the list table in `swap/simple-tasks/index.md` with:
- Slug: `{{simple_task_name_slug}}`
- Display Name: Human-readable name
- Description: Brief description of what this task is about
- Status: "Not Started"

#### 4b-4. Create the Index File

Using `templates/simple-tasks/item/index.md` as a template, create `swap/simple-tasks/items/{{simple_task_name_slug}}/index.md`.

Replace all placeholders:
- `{{simple_task_name_slug}}` → The actual slug name

#### 4b-5. Create Human Instructions File

Using `templates/simple-tasks/item/human-instructions.md` as a template, create `swap/simple-tasks/items/{{simple_task_name_slug}}/human-instructions.md`.

Replace placeholders:
- `{{original_user_request}}` → The user's original request text

#### 4b-6. Create Status File

Using `templates/simple-tasks/item/status.md` as a template, create `swap/simple-tasks/items/{{simple_task_name_slug}}/status.md`.

Keep the status file as-is from the template initially.

#### 4b-7. Create Tasks File

Using `templates/simple-tasks/item/tasks.md` as a template, create `swap/simple-tasks/items/{{simple_task_name_slug}}/tasks.md`.

**Important**: Consolidate all aspects of the human's request into a single, cohesive task list. If the human provides multiple separate requests, combine them into sub-tasks within this ONE simple task's `tasks.md`.

Replace placeholder tasks with actual tasks based on the human's instructions. Convert the human's requirements into specific, actionable tasks. The number of tasks should match the actual work needed - it doesn't have to be exactly 5 tasks.

#### 4b-8. Verify Files

Ensure that all files were created successfully and no placeholders remain in:
- `index.md`
- `human-instructions.md`
- `status.md`
- `tasks.md`

#### 4b-9. Load the Simple Task

Read `swap/simple-tasks/items/{{simple_task_name_slug}}/index.md` and follow the instructions within that file to begin working on the simple task.

## Usage Examples

### Example 1: Create ONE simple task (consolidating multiple requests)

```
Human: Start a simple task. I need to: 1) update README, 2) fix the bug in utils.js, 3) add tests

AI-agent:
1. Checks swap/simple-tasks/index.md
2. Recognizes this as a single cohesive task (not 3 separate simple tasks)
3. Generates slug: update-fix-and-test
4. Creates ONE simple task directory
5. In tasks.md, creates:
   - [ ] Task 1 - Update README with new information
   - [ ] Task 2 - Fix bug in utils.js
   - [ ] Task 3 - Add tests for utils.js
   - [ ] Task 4 - Verify all changes work together
6. Loads index.md and begins work
```

### Example 2: Continue an existing simple task

```
Human: Continue working on the documentation update

AI-agent:
1. Reads swap/simple-tasks/index.md
2. Shows list: "Found existing simple task: 'update-documentation' (Status: In Progress). Continue this task or create new?"
3. Human confirms to continue
4. Loads swap/simple-tasks/items/update-documentation/index.md
5. Reads status.md to see Task 1 and 2 are completed, Task 3 is pending
6. Continues work from Task 3
```

### Example 3: Create new task when human explicitly wants separate tasks

```
Human: Start two separate simple tasks: 1) refactor authentication, 2) update database schema

AI-agent:
1. Recognizes explicit request for TWO separate simple tasks
2. Creates first simple task "refactor-authentication"
3. Creates second simple task "update-database-schema"
4. Asks human which one to start first
```

### Example 4: Default consolidation behavior

```
Human: I need to refactor the auth module, review code, extract functions, add tests, and update docs.

AI-agent:
1. Creates ONE simple task "refactor-auth-module" (not 4 separate tasks)
2. In tasks.md, breaks down into sub-tasks:
   - [ ] Task 1 - Review current authentication code structure
   - [ ] Task 2 - Extract reusable functions
   - [ ] Task 3 - Add unit tests for extracted functions
   - [ ] Task 4 - Update documentation
3. Loads the simple task and begins work
```

## Notes

- The `swap/` directory is git ignored, so simple tasks are not tracked in version control
- **By default, consolidate related work into ONE simple task** unless the human explicitly requests multiple separate simple tasks
- Use simple tasks for straightforward work that doesn't need dev-log's planning phases
- Each simple task should have a meaningful slug that represents the work
- Simple tasks are lighter weight than dev-logs - no goals, plan, or quick-start files
- Convert human instructions into concrete, actionable tasks in tasks.md
- **Tasks can be any number** - don't feel constrained to exactly 5 tasks. Use as many or as few as needed.
- When continuing an existing simple task, review `status.md` and `tasks.md` to understand current progress
- You can add new tasks to an existing simple task's `tasks.md` if the human's request expands the scope

## When to Use Simple Tasks vs Dev-Logs

**Use Simple Tasks for:**
- One-off tasks with clear requirements
- Quick fixes or updates
- Straightforward implementation work
- Tasks that can be completed in a single session

**Use Dev-Logs for:**
- Complex features requiring planning
- Work spanning multiple sessions
- Tasks needing goal alignment and detailed planning
- Large refactoring or architectural changes

## Related Commands

- `dev-log` - For more complex, multi-phase development work
- `yeah` - Core AI agent behavior and rules

