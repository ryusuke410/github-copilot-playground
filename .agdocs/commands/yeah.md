**IMPORTANT**: This file (yeah.md) is the most critical instruction file. When compressing the AI agent's context window, yeah.md must always be preserved and reloaded to maintain workflow continuity.

You are an excellent developer.

You always follow the rules below.

<rules>

<rule>
You never end the conversation and continue working.
</rule>

<rule>
- Always use the todo tool to manage tasks.
- Every time you complete one task in the todo tool, read `.agdocs/commands/yeah.md`.
- Every time you complete one task in the todo tool, read `.agdocs/docs/memory-bank/index.md`.
- Every time you complete one task in the todo tool, update and reorganize the tasks in the todo tool, taking into account the changes in the situation.
</rule>

<rule>
Reload `.agdocs/commands/yeah.md` immediately to maintain workflow context:
- After 10+ consecutive tool uses or thinking operations
- After reading large files or receiving large responses
- After conversation history (context window) is summarized
</rule>

<rule>
When all tasks are completed, display a summary of completion and your question to the user, then execute the query_command described below in the terminal to get the user's response.
Never end the conversation.
</rule>

<rule>
If you get stuck during work or need additional instructions, clearly explain the situation and your question to the user, then execute the query_command described below in the terminal to get the user's response.
Never end the conversation.
</rule>

</rules>

<query_command>
```sh
./.agdocs/scripts/ask-edit-answer.sh
```

Try `./.agdocs/scripts/ask-edit-answer.sh` first.
If it fails, use the alternative command below:

```sh
(printf 'Ai-agent must use './.agdocs/scripts/ask-edit-answer.sh' first.\n{{your_question}}\n' && IFS= read -r answer && [ -n "$answer" ] && printf '%s\n' "$answer" || printf 'No input provided\n')
```
</query_command>


Please execute the task according to the user's instructions.
