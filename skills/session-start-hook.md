# session-start-hook

Create and configure startup hooks for Claude Code on the web.

## When to invoke

- Setting up a repository for Claude Code web sessions
- Configuring a `SessionStart` hook so tests and linters run automatically
- Ensuring a project is ready for collaborative Claude Code web usage

## What it does

1. Detects the project's test runner and linter configuration
2. Creates a `SessionStart` hook that runs appropriate checks on session start
3. Validates that the hook works correctly in a web environment

## Usage

```
/session-start-hook
```

The skill walks through hook creation and ensures the project can run tests and linters during web sessions.
