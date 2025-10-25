# dev-log Command

## Overview

`dev-log` is a mechanism for managing a series of development tasks. It provides a structured approach to organizing, planning, and tracking development work.

## Directory Structure

```
.agdocs/
  swap/                # Note: This is git ignored
    dev-logs/
      index.md         # Contains the dev-log list table
      items/
        {{dev_log_name_slug}}/
          index.md     # Entry point document, always loaded first
          human-instructions.md  # User instructions
          status.md    # Current status of the dev-log
          goals.md      # Purpose and goals
          plan.md       # Work plan
          tasks.md      # Task list with numbered todos
          quick-start.md  # Quick start guide for beginning work
          other related files...
  templates/
    dev-logs/
      index.md
      item/
        index.md
        human-instructions.md
        goals.md
        plan.md
        tasks.md
        quick-start.md
```

## Instructions

When a user requests to work with a dev-log, follow these steps:

### 1. Check existing dev-logs

Read `swap/dev-logs/index.md` to understand what dev-log items already exist. If the index file doesn't exist, create it using `templates/dev-logs/index.md` as a template.

### 2. Align with human

Present the list of existing dev-logs to the human and determine whether to:
- **Create a new dev-log**: If the user's request is clearly for a new task
- **Load an existing dev-log**: If the user's request relates to an existing dev-log item

Ask the human to confirm which option to proceed with. Always show the list of existing dev-logs so the human can make an informed decision.

### 3a. If loading an existing dev-log

Read `swap/dev-logs/items/{{dev_log_name_slug}}/index.md` for the selected dev-log and follow the instructions within that file to continue work.

### 3b. If creating a new dev-log

Follow these steps to create a new dev-log:

#### 3b-1. Create the dev-log directory

Create the directory `swap/dev-logs/items/{{dev_log_name_slug}}` based on the user's instructions. Only create the directory at this step.

#### 3b-2. Update the dev-log index

Add the new dev-log to the list table in `swap/dev-logs/index.md`.

#### 3b-3. Create the index file

Using `templates/dev-logs/item/index.md` as a template, create `swap/dev-logs/items/{{dev_log_name_slug}}/index.md`. Placeholders such as `{{dev_log_name_slug}}` should be replaced with appropriate content based on the dev-log's purpose and status.

#### 3b-4. Verify the index file

Ensure that the index file `swap/dev-logs/items/{{dev_log_name_slug}}/index.md` was created successfully and no placeholders remain.

#### 3b-5. Load the index file

Read `swap/dev-logs/items/{{dev_log_name_slug}}/index.md` to begin working with the dev-log.

## Notes

- The `swap/` directory is git ignored, so dev-logs are not tracked in version control
- Use the template files as a starting point for consistency
- Each dev-log should have a meaningful slug that represents the work being done
