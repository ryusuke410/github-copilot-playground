# start-simple-task Command

## Overview

`start-simple-task` is a lightweight mechanism for managing a simple series of tasks. It provides a streamlined approach to organizing and executing one-off task groups without the overhead of dev-logs. Use this for straightforward, well-defined work that doesn't require extensive planning phases.

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

### 2. Determine Action

Based on the user's request, determine whether to:
- **Create a new simple task**: If the user's request is for a new task
- **Load an existing simple task**: If the user's request relates to an existing simple task item

If there are existing simple tasks, present the list to the human and confirm which option to proceed with.

### 3a. If Loading an Existing Simple Task

Read `swap/simple-tasks/items/{{simple_task_name_slug}}/index.md` for the selected simple task and follow the instructions within that file to continue work.

### 3b. If Creating a New Simple Task

Follow these steps to create a new simple task:

#### 3b-1. Generate Slug Name

Based on the human's instructions, generate a slug name for the simple task:
- Use lowercase
- Replace spaces with hyphens
- Keep it concise and descriptive (2-4 words recommended)
- Remove special characters

Examples:
- "Update documentation" → `update-documentation`
- "Fix login bug" → `fix-login-bug`
- "Add new feature" → `add-new-feature`

#### 3b-2. Create the Simple Task Directory

Create the directory `swap/simple-tasks/items/{{simple_task_name_slug}}`.

#### 3b-3. Update the Simple Task Index

Add the new simple task to the list table in `swap/simple-tasks/index.md` with:
- Slug: `{{simple_task_name_slug}}`
- Display Name: Human-readable name
- Description: Brief description of what this task is about
- Status: "Not Started"

#### 3b-4. Create the Index File

Using `templates/simple-tasks/item/index.md` as a template, create `swap/simple-tasks/items/{{simple_task_name_slug}}/index.md`.

Replace all placeholders:
- `{{simple_task_name_slug}}` → The actual slug name

#### 3b-5. Create Human Instructions File

Using `templates/simple-tasks/item/human-instructions.md` as a template, create `swap/simple-tasks/items/{{simple_task_name_slug}}/human-instructions.md`.

Replace placeholders:
- `{{original_user_request}}` → The user's original request text

#### 3b-6. Create Status File

Using `templates/simple-tasks/item/status.md` as a template, create `swap/simple-tasks/items/{{simple_task_name_slug}}/status.md`.

Keep the status file as-is from the template initially.

#### 3b-7. Create Tasks File

Using `templates/simple-tasks/item/tasks.md` as a template, create `swap/simple-tasks/items/{{simple_task_name_slug}}/tasks.md`.

Replace placeholder tasks with actual tasks based on the human's instructions. Convert the human's requirements into specific, actionable tasks.

#### 3b-8. Verify Files

Ensure that all files were created successfully and no placeholders remain in:
- `index.md`
- `human-instructions.md`
- `status.md`
- `tasks.md`

#### 3b-9. Load the Simple Task

Read `swap/simple-tasks/items/{{simple_task_name_slug}}/index.md` and follow the instructions within that file to begin working on the simple task.

## Usage Examples

### Example 1: Create a new simple task

```
Human: Start a simple task to update the README with new features

AI-agent:
1. Checks swap/simple-tasks/index.md (doesn't exist, creates it)
2. Generates slug: update-readme-features
3. Creates directory: swap/simple-tasks/items/update-readme-features/
4. Creates all required files from templates
5. Replaces placeholders with actual content
6. Loads index.md and begins work
```

### Example 2: Load an existing simple task

```
Human: Continue working on the documentation update

AI-agent:
1. Reads swap/simple-tasks/index.md
2. Shows list of existing tasks
3. Identifies "update-readme-features" matches the request
4. Loads swap/simple-tasks/items/update-readme-features/index.md
5. Continues work based on status.md
```

### Example 3: Create task with specific requirements

```
Human: Start a simple task to refactor the authentication module. 
       Break it into: review code, extract functions, add tests, update docs.

AI-agent:
1. Creates simple task "refactor-auth-module"
2. In tasks.md, creates specific tasks:
   - [ ] Task 1 - Review current authentication code structure
   - [ ] Task 2 - Extract reusable functions
   - [ ] Task 3 - Add unit tests for extracted functions
   - [ ] Task 4 - Update documentation
3. Loads the simple task and begins work
```

## Notes

- The `swap/` directory is git ignored, so simple tasks are not tracked in version control
- Use simple tasks for straightforward work that doesn't need dev-log's planning phases
- Each simple task should have a meaningful slug that represents the work
- Simple tasks are lighter weight than dev-logs - no goals, plan, or quick-start files
- Convert human instructions into concrete, actionable tasks in tasks.md

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

