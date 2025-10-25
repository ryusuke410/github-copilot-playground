# Suggested Commands

## Always Use Subshells for Directory Changes

**Good: Subshell isolates directory change**
```bash
(cd path/to/dir && command)
```

**Bad: Changes current directory**
```bash
cd path/to/dir && command && cd -
```

## Use Subshells for Export

Environment variables should also use subshells to avoid polluting the current shell:

**Good: Export in subshell**
```bash
(export VAR=value && command)
```

**Bad: Exports to current shell**
```bash
export VAR=value && command
```

## Use chmod u+x Instead of chmod +x

**Good: Explicit user permission**
```bash
chmod u+x script.sh
```

**Bad: Less explicit**
```bash
chmod +x script.sh
```

`chmod u+x` explicitly grants execute permission to the user owner only, while `chmod +x` grants execute permission to user, group, and others.

## Why Subshells?

1. **Isolation**: Directory change doesn't affect current shell
2. **Safety**: Fails fast if directory doesn't exist
3. **Clarity**: Intent is explicit
4. **Maintainability**: Easy to modify
