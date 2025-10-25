# Memory Bank Initial Setup

This guide provides step-by-step instructions for setting up the Memory Bank system in a new project.

## Prerequisites

- `.agdocs/` directory exists in the project root
- Understanding of the project's structure and requirements

## Setup Steps

### Step 1: Create Directory Structure

Create the necessary directories for the Memory Bank system:

```bash
mkdir -p .agdocs/memory
mkdir -p .agdocs/docs/memory-bank
```

### Step 2: Create Documentation Files

Create `.agdocs/docs/memory-bank/index.md` using the documentation from this repository or by reading the Memory Bank overview.

This file provides guidance on how to use the Memory Bank system.

### Step 3: Create the Index File

Create `.agdocs/memory/index.md` using `.agdocs/templates/memory/index.md` as a template:

```markdown
| File Path | Title | Description | Last Updated |
|-----------|-------|-------------|--------------|
```

This index will be populated as you create memory bank files.

### Step 4: Create Initial Memory Banks

When setting up the memory bank system for the first time, consider creating memory banks for:

#### 4.1 Project Overview
**File**: `memory/project-overview.md`
- Project purpose and goals
- Key stakeholders
- High-level architecture
- Technology stack overview
- Project timeline and milestones

#### 4.2 Codebase Structure
**File**: `memory/codebase-structure.md`
- Directory organization and layout
- Module and package structure
- File naming conventions
- Build and output directories
- Configuration file locations

#### 4.3 Suggested Commands
**File**: `memory/suggested-commands.md`
- Common development commands
- Build and run commands
- Testing commands
- Deployment commands
- Troubleshooting commands

#### 4.4 Coding Guidelines
**File**: `memory/coding-guidelines.md`
- Code formatting and style
- Naming conventions
- Comment standards
- Best practices
- Code review checklist

#### 4.5 Ubiquitous Language
**File**: `memory/ubiquitous-language.md`
- Domain terminology (English and Japanese)
- Abbreviations and acronyms
- Context-specific meanings
- Usage examples

### Step 5: Populate Memory Banks with Content

For detailed templates and examples for each memory bank, see the sections below:

#### 5.1 Project Overview Template

Create `.agdocs/memory/project-overview.md`:

```markdown
# Project Overview

## Purpose

[Describe the main purpose and goals of the project]

## Key Stakeholders

- [Stakeholder 1]
- [Stakeholder 2]

## High-Level Architecture

[Describe the overall architecture]

## Technology Stack

- **Frontend**: [Technologies]
- **Backend**: [Technologies]
- **Database**: [Technologies]
- **Infrastructure**: [Technologies]

## Project Timeline

- **Start Date**: [Date]
- **Key Milestones**:
  - [Milestone 1]: [Date]
  - [Milestone 2]: [Date]
```

#### 5.2 Codebase Structure Template

Create `.agdocs/memory/codebase-structure.md`:

```markdown
# Codebase Structure

## Directory Organization

```
project-root/
  src/              # Source code
  tests/            # Test files
  docs/             # Documentation
  config/           # Configuration files
  .agdocs/          # AI agent documentation
```

## Module Structure

[Describe how the code is organized into modules/packages]

## File Naming Conventions

- **Components**: PascalCase (e.g., `UserProfile.tsx`)
- **Utilities**: camelCase (e.g., `formatDate.ts`)
- **Tests**: `*.test.ts` or `*.spec.ts`

## Key Directories

### `/src`
[Description of source directory]

### `/tests`
[Description of test directory]
```

#### 5.3 Suggested Commands Template

Create `.agdocs/memory/suggested-commands.md`:

```markdown
# Suggested Commands

## Development

### Install Dependencies
```bash
npm install
# or
pnpm install
```

### Start Development Server
```bash
npm run dev
# or
pnpm dev
```

## Building

### Build for Production
```bash
npm run build
```

### Build for Staging
```bash
npm run build:staging
```

## Testing

### Run All Tests
```bash
npm test
```

### Run Tests in Watch Mode
```bash
npm run test:watch
```

### Run Tests with Coverage
```bash
npm run test:coverage
```

## Deployment

### Deploy to Staging
```bash
npm run deploy:staging
```

### Deploy to Production
```bash
npm run deploy:prod
```

## Troubleshooting

### Clear Cache
```bash
npm run clean
```

### Reset Dependencies
```bash
rm -rf node_modules package-lock.json
npm install
```
```

#### 5.4 Coding Guidelines Template

Create `.agdocs/memory/coding-guidelines.md`:

```markdown
# Coding Guidelines

## Code Formatting

- Use [Prettier/ESLint/etc.] for automatic formatting
- Indentation: [2 spaces / 4 spaces / tabs]
- Line length: Maximum [80/100/120] characters

## Naming Conventions

### Variables
- Use descriptive names
- camelCase for variables and functions
- PascalCase for classes and types

### Functions
- Use verb phrases (e.g., `getUserData`, `calculateTotal`)
- Keep functions focused on a single responsibility

### Constants
- UPPER_SNAKE_CASE for constants
- Group related constants together

## Comment Standards

### When to Comment
- Complex algorithms or business logic
- Public API documentation
- TODO items with issue tracker references

### When NOT to Comment
- Obvious code that explains itself
- Redundant comments that restate the code

## Best Practices

### General
- Follow DRY (Don't Repeat Yourself) principle
- Keep functions small and focused
- Use meaningful variable names
- Write self-documenting code

### Error Handling
- Always handle errors explicitly
- Use appropriate error types
- Provide helpful error messages

### Testing
- Write tests for all new features
- Maintain test coverage above [X%]
- Use descriptive test names

## Code Review Checklist

- [ ] Code follows style guidelines
- [ ] All tests pass
- [ ] New tests added for new functionality
- [ ] Documentation updated if needed
- [ ] No console.log or debugging code left
- [ ] Error handling is appropriate
- [ ] Performance considerations addressed
```

#### 5.5 Ubiquitous Language Template

Create `.agdocs/memory/ubiquitous-language.md`:

```markdown
# Ubiquitous Language

This document defines the domain-specific terminology used throughout the project.

## Core Terms

| English Term | Japanese Term (日本語) | Definition | Usage Example |
|--------------|----------------------|------------|---------------|
| Memory Bank | メモリバンク | A knowledge repository file containing project information | "Update the memory bank with the new API guidelines" |
| Dev-Log | 開発ログ | Development task management system | "Create a dev-log for the authentication feature" |
| [Term 3] | [日本語 3] | [Definition] | [Example] |

## Domain-Specific Terms

### [Domain Area 1]

| English Term | Japanese Term (日本語) | Definition | Usage Example |
|--------------|----------------------|------------|---------------|
| [Term] | [日本語] | [Definition] | [Example] |

### [Domain Area 2]

| English Term | Japanese Term (日本語) | Definition | Usage Example |
|--------------|----------------------|------------|---------------|
| [Term] | [日本語] | [Definition] | [Example] |

## Abbreviations and Acronyms

| Abbreviation | Full Form | Meaning |
|--------------|-----------|---------|
| API | Application Programming Interface | Interface for software communication |
| [Abbr] | [Full Form] | [Meaning] |

## Notes

- Always use consistent terminology across the codebase
- When introducing new terms, update this document
- Include both English and Japanese for all domain terms
```

### Step 6: Update the Index

After creating each memory bank, update `.agdocs/memory/index.md`:

```markdown
| File Path | Title | Description | Last Updated |
|-----------|-------|-------------|--------------|
| memory/project-overview.md | Project Overview | High-level project information and goals | 2025-10-26 |
| memory/codebase-structure.md | Codebase Structure | Directory organization and file structure | 2025-10-26 |
| memory/suggested-commands.md | Suggested Commands | Common development and deployment commands | 2025-10-26 |
| memory/coding-guidelines.md | Coding Guidelines | Code style and best practices | 2025-10-26 |
| memory/ubiquitous-language.md | Ubiquitous Language | Domain terminology and definitions | 2025-10-26 |
```

### Step 7: Customize Memory Banks

Review each memory bank file and customize the content based on your specific project:

1. Replace placeholder text with actual project information
2. Add project-specific sections as needed
3. Remove sections that don't apply to your project
4. Ensure all information is accurate and up-to-date

### Step 8: Establish Maintenance Process

Set up a process for keeping memory banks current:

1. **Regular Reviews**: Schedule periodic reviews (e.g., monthly)
2. **Update Triggers**: Update memory banks when:
   - Project structure changes
   - New conventions are adopted
   - Important decisions are made
   - New team members join

3. **Version Control**: Commit memory banks to git (if `.agdocs/memory/` is not git-ignored)

## Verification

After setup, verify that:

- [ ] All required directories exist
- [ ] Index file is created and properly formatted
- [ ] All initial memory banks are created
- [ ] Content in memory banks is customized for your project
- [ ] Index is updated with all memory bank entries
- [ ] All files use English (except Japanese in ubiquitous language)

## Next Steps

1. Share memory banks with the team
2. Integrate memory bank references into development workflows
3. Update memory banks as the project evolves
4. Create additional memory banks as needed

## Tips

- Start with the essential memory banks listed above
- Add more memory banks gradually as needs arise
- Keep memory banks focused on specific topics
- Use cross-references to link related memory banks
- Review and update regularly to maintain accuracy
