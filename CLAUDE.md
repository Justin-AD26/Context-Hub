# Context-Hub — Skill Reference

This repository serves as a centralized hub for Claude Code skill context and configuration. Use it to understand, select, and apply the right skill for a given task.

## Available Skills

### `simplify`
**Purpose:** Review changed code for reuse, quality, and efficiency, then fix any issues found.
**When to use:** After writing or modifying code — invoke to audit recent changes for duplication, dead code, poor patterns, or unnecessary complexity.
**Trigger:** Manual invocation after code changes.

### `claude-api`
**Purpose:** Build applications using the Claude API, Anthropic SDK, or Agent SDK.
**When to use:** When code imports `anthropic`, `@anthropic-ai/sdk`, or `claude_agent_sdk`, or when the task involves building against Anthropic's APIs.
**Do NOT use when:** Code imports other AI SDKs (e.g. `openai`), or the task is general programming or ML/data-science work.

### `session-start-hook`
**Purpose:** Create and configure startup hooks for Claude Code on the web.
**When to use:** When setting up a repository for Claude Code web sessions — creates a `SessionStart` hook so that tests and linters run automatically during web sessions.

## Skill Selection Guide

| Scenario | Skill |
|---|---|
| Audit recently changed code for quality | `simplify` |
| Build an app with Claude/Anthropic APIs | `claude-api` |
| Set up a repo for Claude Code on the web | `session-start-hook` |
