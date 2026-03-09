# simplify

Review changed code for reuse, quality, and efficiency, then fix any issues found.

## When to invoke

- After completing a code change (new feature, bug fix, refactor)
- During code review to audit quality
- When you suspect duplication or unnecessary complexity

## What it checks

- **Reuse**: Identifies duplicated logic that could be extracted or shared
- **Quality**: Flags poor patterns, unclear naming, missing edge cases
- **Efficiency**: Spots unnecessary allocations, redundant operations, or overly complex control flow

## Usage

Invoke manually after making changes:

```
/simplify
```

The skill reviews the diff of changed files and suggests (or directly applies) improvements.
