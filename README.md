# Context-Hub

A centralized hub for Claude Code skill context and configuration.

## Structure

```
Context-Hub/
├── CLAUDE.md                  # Skill reference and selection guide
├── .claude/
│   └── settings.json          # Skill configuration and trigger rules
└── skills/
    ├── simplify.md            # Code quality review skill
    ├── claude-api.md          # Anthropic API/SDK skill
    └── session-start-hook.md  # Web session startup hook skill
```

## Skills

| Skill | Purpose |
|---|---|
| `simplify` | Review changed code for reuse, quality, and efficiency |
| `claude-api` | Build apps with the Claude API or Anthropic SDK |
| `session-start-hook` | Create startup hooks for Claude Code on the web |

See [CLAUDE.md](CLAUDE.md) for detailed usage guidance and selection criteria.