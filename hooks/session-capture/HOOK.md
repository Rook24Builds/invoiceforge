---
name: session-capture
description: "Captures session state for handoff between sessions - survives resets and crashes"
homepage: https://docs.openclaw.ai/hooks#session-capture
metadata:
  openclaw:
    emoji: "🔄"
    events: ["command:new", "command:reset", "agent:bootstrap"]
    requires:
      config: ["workspace.dir"]
    always: false
---

# Session Capture Hook

Automatically captures session context before `/reset` or `/new` commands, enabling seamless handoff between sessions. When a new session starts, it detects if a handoff is available and injects the previous context.

## What It Does

**On `/reset` or `/new`:**
1. Reads the current session transcript (JSONL)
2. Detects meaningful patterns (blockers, decisions, insights, accomplishments)
3. Generates a summary of work in progress
4. Writes a durable handoff file to `~/.openclaw/agents/<agentId>/handoff/`

**On new session bootstrap:**
1. Checks if a recent handoff file exists (< 24 hours old)
2. Validates the handoff hasn't already been resumed
3. Injects a summary message into the session context
4. Prompts the user to continue where they left off

**Pattern Detection:**
- **Blockers**: Issues, errors, problems preventing progress
- **Decisions**: "Let's use X", "We should do Y", choices made
- **Insights**: Realizations, discoveries, "aha moments"
- **Accomplishments**: Completed tasks, fixes, implementations
- **Tasks Created**: New work items identified

## Configuration

```json
{
  "hooks": {
    "internal": {
      "enabled": true,
      "entries": {
        "session-capture": {
          "enabled": true,
          "config": {
            "expireAfterMinutes": 1440,
            "maxMessages": 50,
            "autoResume": true,
            "projectContext": true
          }
        }
      }
    }
  }
}
```

## File Structure

```
~/.openclaw/agents/<agentId>/
├── sessions/
│   └── <sessionId>.jsonl       # Conversation transcripts
└── handoff/                    # Captured session state
    ├── session-state.json      # Current handoff
    └── resume/                 # Resume queue
        └── pending.json
```

## Commands

| Command | Description |
|---------|-------------|
| `/handoff` | Manually capture current state |
| `/resume` | Force resume from last handoff |
| `/handoff clear` | Discard handoff data |
| `/handoff status` | Show handoff info |

## Requirements

- OpenClaw >= 0.14.0 (for hook system)
- `workspace.dir` must be configured
- Read access to session transcripts
- Write access to agent directory

## Compatibility

- Works alongside `session-memory` hook (complementary)
- Compatible with multi-agent setups
- Respects project context (like VU Bridge)
