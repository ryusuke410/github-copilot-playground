# Ubiquitous Language

This document defines the domain-specific terminology used throughout the project.

## Core Terms

| English Term | Japanese Term (日本語) | Definition | Usage Example |
|--------------|----------------------|------------|---------------|
| Memory Bank | メモリバンク | A markdown file containing project knowledge such as structure, rules, procedures, or domain terminology | "Update the memory bank when the project structure changes" |
| Dev-Log | 開発ログ | A development task management system using structured markdown files to track goals, plans, and tasks | "Create a dev-log for the authentication feature implementation" |
| ai-agent | AIエージェント | GitHub Copilot or similar AI system following structured commands and documentation (lowercase with hyphen) | "The ai-agent reads yeah.md before starting work" |
| human | 人間 | Human user interacting with the ai-agent, especially in contexts contrasting with ai-agent behavior | "The human provides instructions through dev-log files" |
| Swap Directory | スワップディレクトリ | Git-ignored directory (`.agdocs/swap/`) for temporary working files and dev-logs | "Dev-logs are stored in the swap directory" |
| Command File | コマンドファイル | Markdown file in `.agdocs/commands/` that defines ai-agent behavior with detailed instructions | "Read the command file to understand the workflow" |
| Prompt Entry Point | プロンプトエントリーポイント | Markdown file in `.github/prompts/` (`.prompt.md`) that serves as entry point, typically referencing a command file | "The prompt entry point reads the command file with detailed instructions" |
| Template | テンプレート | Reusable file structure in `.agdocs/templates/` | "Use the template to create a new dev-log" |
| Human Instructions | 人間の指示 | User-provided requirements and context, may be in Japanese | "Check human-instructions.md for the original request" |
| Ubiquitous Language | ユビキタス言語 | Domain-specific terminology with both English and Japanese translations | "Add new terms to the ubiquitous language memory bank" |
| Placeholder | プレースホルダー | Meta-level variable using double-brace notation with snake_case (e.g., `{{variable_name}}`) | "Replace {{repo_root}} with the actual repository path" |

## Workflow Terms

| English Term | Japanese Term (日本語) | Definition | Usage Example |
|--------------|----------------------|------------|---------------|
| Query Command | クエリコマンド | Interactive script that prompts user for input | "Execute the query command to ask the user a question" |
| Status File | ステータスファイル | File tracking dev-log procedure completion (`status.md`) | "Update the status file after completing each step" |
| Index File | インデックスファイル | Table listing all items in a collection | "The index file contains all memory banks" |
| Quick Start | クイックスタート | Guide for beginning work on a dev-log | "Read quick-start.md to understand how to proceed" |
| Phase | フェーズ | Major section of work in a plan | "We're currently in Phase 2 of the implementation" |
| Task | タスク | Specific actionable item with checkbox | "Mark the task as completed when done" |

## System Components

| English Term | Japanese Term (日本語) | Definition | Usage Example |
|--------------|----------------------|------------|---------------|
| `.agdocs` Directory | .agdocs ディレクトリ | Root directory for ai-agent documentation and knowledge | "All memory banks are under .agdocs/memory/" |
| Slug | スラグ | URL-friendly identifier using kebab-case | "Use 'memory-bank' as the slug for this dev-log" |
| Procedure Checklist | 手順チェックリスト | Ordered list of steps in status.md | "Follow the procedure checklist in order" |

## File Types

| English Term | Japanese Term (日本語) | Definition | Usage Example |
|--------------|----------------------|------------|---------------|
| Goals File | ゴールファイル | Document defining objectives and success criteria (`goals.md`) | "Define success criteria in the goals file" |
| Plan File | プランファイル | Document outlining work phases and activities (`plan.md`) | "The plan file describes the implementation approach" |
| Tasks File | タスクファイル | Document with detailed task list (`tasks.md`) | "Check off tasks in the tasks file as you complete them" |

## Abbreviations and Acronyms

| Abbreviation | Full Form | Meaning |
|--------------|-----------|---------|
| AI | Artificial Intelligence | Computer systems performing tasks requiring human intelligence |
| MD | Markdown | Lightweight markup language for formatted text |
| CLI | Command Line Interface | Text-based interface for interacting with programs |

## Notes

- Always use consistent terminology across the codebase and documentation
- When introducing new domain-specific terms, update this memory bank
- All core domain terms must include both English and Japanese translations
- Technical terms (e.g., "Git", "Markdown") do not require Japanese translations
- Use the English term in code and documentation; Japanese is for reference and human communication
