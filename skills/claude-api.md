# claude-api

Build applications using the Claude API, Anthropic SDK, or Agent SDK.

## When to invoke

**Trigger automatically** when code imports any of:
- `anthropic` (Python)
- `@anthropic-ai/sdk` (TypeScript/JavaScript)
- `claude_agent_sdk`

**Trigger manually** when the user asks to:
- Build something with the Claude API
- Use Anthropic SDKs
- Work with the Agent SDK

## When NOT to invoke

- Code imports `openai` or another AI SDK
- General programming tasks unrelated to Anthropic APIs
- ML/data-science work that doesn't involve Claude

## Key context

- The most recent Claude model family is Claude 4.5/4.6
- Model IDs: `claude-opus-4-6`, `claude-sonnet-4-6`, `claude-haiku-4-5-20251001`
- Default to the latest and most capable models when building new applications

## Usage

```
/claude-api
```

The skill provides guidance, code patterns, and best practices for Anthropic API integration.
