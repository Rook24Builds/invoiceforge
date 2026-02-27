# OpenClaw Session Handoff System Design

## Executive Summary

This document proposes a **Session Handoff System** for OpenClaw that enables session-to-session continuity across crashes, timeouts, and `/reset` commands. Inspired by Viber Universal's pattern-based session capture and persistent storage, this system creates a durable, queryable session history that survives interruptions.

---

## 1. Current-State Analysis

### 1.1 How OpenClaw Handles Sessions Today

**Storage Locations:**
- **Session Store**: `~/.openclaw/agents/<agentId>/sessions/sessions.json` (map of sessionKey → session metadata)
- **Transcripts**: `~/.openclaw/agents/<agentId>/sessions/<SessionId>.jsonl` (conversation history)
- **Session Keys**: `agent:<agentId>:<mainKey>` format (e.g., `agent:main:main`)

**Session Lifecycle:**
- Sessions are **reused** until they expire (by daily reset at 4 AM or idle timeout)
- Reset triggers: `/new`, `/reset` commands create **fresh session IDs**
- Transcripts capture full conversation but are **isolated per session**

**Current Hooks Available:**
- `command:new` - fired when `/new` is issued
- `command:reset` - fired when `/reset` is issued
- `command:stop` - fired when `/stop` is issued
- `agent:bootstrap` - before workspace bootstrap files inject
- `gateway:startup` - after gateway starts

**Existing Session-Memory Hook:**
- Only triggers on `command:new`
- Extracts last 15 lines from **pre-reset** transcript
- Saves to `<workspace>/memory/YYYY-MM-DD-slug.md`
- **Problem**: Only captures at reset, not continuously; loses context of *why* reset happened

### 1.2 What's Missing

| Capability | Current State | Needed |
|------------|--------------|--------|
| Pre-crash capture | ❌ None | ✅ Automatic snapshot on crash signal |
| Cross-session context | ❌ Lost on `/reset` | ✅ Handoff file bridging sessions |
| Pattern detection | ❌ None | ✅ VU-style blockers/decisions/insights |
| Project scoping | ❌ Session-only | ✅ Persistent project context |
| Recovery resume | ❌ None | ✅ "Resume where you left off" detection |
| Handoff trigger | ❌ Manual only | ✅ Automatic + hook-driven |

---

## 2. Problems with Existing Session Handling

### 2.1 Session Boundaries = Data Loss

```
Session A (abc123) ──[/reset]──> Session B (xyz789)
     │                                  │
     └─ JSONL history              JSONL history ──┘
         (orphaned)                    (fresh start)

Result: Context lost, agent doesn't know what was in progress
```

### 2.2 Crash Recovery Gap

If OpenClaw crashes or times out:
- Session ID may or may not change (depends on timing)
- Partial work in progress is not captured
- No mechanism to resume interrupted tasks

### 2.3 No Semantic Understanding

OpenClaw captures *messages* but doesn't understand:
- What was being worked on
- What blockers/discoveries were made
- What decisions need to persist
- What the current "micro-task" is

### 2.4 Multi-Project Confusion

Without project context:
- Sessions accumulate mixed contexts
- Agent can't filter by current work
- Context bloat from unrelated topics

---

## 3. Proposed Session Handoff System

### 3.1 Core Concept

Create a **Session State Bridge** that captures critical context at key moments and makes it available to new sessions. The system operates in three phases:

1. **CAPTURE**: Hook-driven snapshots of session state
2. **PERSIST**: Durable storage in `.openclaw/handoff/` directory
3. **RESUME**: Automatic detection and injection into new sessions

### 3.2 Handoff Triggers

| Trigger | Event | Captures |
|---------|-------|----------|
| Pre-reset | `command:reset`, `command:new` | Current context before wipe |
| Periodic | Every N messages | Incremental checkpoints |
| Tool-heavy | After large tool results | Complex work milestones |
| User-mark | `/handoff` command | Explicit capture request |
| Signal | SIGTERM, timeout | Emergency crash dump |

### 3.3 Session State Schema

**File**: `~/.openclaw/agents/<agentId>/handoff/session-state.json`

```typescript
interface SessionState {
  // Identity
  agentId: string;
  sessionKey: string;
  previousSessionId: string | null;
  
  // Timing
  createdAt: string;      // ISO timestamp
  updatedAt: string;
  expiresAt: string;      // Auto-expire stale handoffs
  
  // Context
  project: string;        // Current project filter (like VU)
  mode: 'work' | 'chat' | 'deep';
  
  // Content (VU-style patterns)
  patterns: PatternNote[];
  
  // Summary
  summary: {
    lastTopic: string;
    inProgress: string[]; // Tasks being worked on
    blockers: string[];   // Known blockers
    decisions: string[];  // Recent decisions
    nextStep: string;     // Predicted next action
  };
  
  // Technical
  lastMessageIndex: number; // Where in JSONL we left off
  transcriptHash: string;   // Verify integrity
  
  // Recovery
  resumeAvailable: boolean;
  resumeOfferedAt: string | null;
}

interface PatternNote {
  id: string;
  type: 'blocker' | 'decision' | 'insight' | 'accomplishment' | 'scope_creep' | 'task_created';
  content: string;
  timestamp: string;
  confidence: number;     // Pattern match confidence
  sourceMessageIndex: number; // Which JSONL message triggered this
  resolved?: boolean;       // For blockers
}
```

### 3.4 Handoff Directory Structure

```
~/.openclaw/agents/<agentId>/
├── sessions/
│   ├── sessions.json           # Session registry
│   └── <sessionId>.jsonl       # Full transcripts
├── handoff/                    # NEW: Session handoff storage
│   ├── session-state.json      # Current handoff state
│   ├── snapshots/              # Periodic checkpoints
│   │   ├── 2026-02-26T20-00-00.json
│   │   └── 2026-02-26T20-30-00.json
│   ├── patterns/               # Pattern history
│   │   └── 2026-02-26.jsonl    # All patterns today
│   └── resume/                 # Resume queue
│       └── pending.json        # Sessions needing pickup
```

---

## 4. Hook Implementation Plan

### 4.1 Session Capture Hook

**Hook**: `session-capture`
**Events**: `command:reset`, `command:new`, `agent:bootstrap`

**Flow:**

```
User sends /reset
     ↓
Gateway fires `command:reset` event
     ↓
session-capture hook handler
     ├── 1. Read current session JSONL transcript
     ├── 2. Extract last 50 messages
     ├── 3. Run pattern detection (VU-style)
     ├── 4. Generate session summary using LLM
     ├── 5. Write handoff/session-state.json
     ├── 6. Set resumeAvailable = true
     ↓
Gateway continues with reset
```

### 4.2 Session Restore Detection

**Hook**: `agent:bootstrap`
**Event**: `agent:bootstrap`

**Flow:**

```
New session starts (after /reset or fresh start)
     ↓
Gateway fires `agent:bootstrap` event
     ↓
session-capture hook handler
     ├── 1. Check handoff/session-state.json exists
     ├── 2. Check if resumeAvailable = true
     ├── 3. Check not expired (within 24h default)
     ├── 4. If valid, inject context into bootstrapFiles
     │      - Add SYSTEM msg: "Previous session ended..."
     │      - Add handoff summary to context
     ├── 5. Mark resume as offered
     ↓
Agent starts with restored context
```

### 4.3 Pattern Detection Engine

**Reuses VU Bridge patterns** from `viber-bridge.ts`:

```typescript
// Lightweight pattern detection (no VU DB dependency)
const PATTERNS = {
  blocker: [
    /broke|bug|error|fail|crash|not working/i,
    /can't|cannot|unable to|stuck on/i,
    /blocking|preventing|issue|problem/i,
  ],
  decision: [
    /let's\s+(use|do|go with)|we should|decided to/i,
    /going to\s+(use|implement)|chosen|selected/i,
    /i think we should|how about we/i,
  ],
  insight: [
    /i (learned|realized|discovered|figured out)/i,
    /turns out|makes sense|now i understand/i,
    /the reason|explains why|because of/i,
  ],
  accomplishment: [
    /fixed|built|created|implemented|completed/i,
    /got.*working|working now|solved|done|finished/i,
    /successfully|verified|confirmed/i,
  ],
};

function detectPatterns(message: string): DetectedPattern {
  for (const [type, patterns] of Object.entries(PATTERNS)) {
    for (const pattern of patterns) {
      if (pattern.test(message)) {
        return { type, confidence: 0.8, content: message };
      }
    }
  }
  return { type: 'none', confidence: 0, content: '' };
}
```

---

## 5. Resume Mechanism

### 5.1 Detection Logic

When a new session starts:

```typescript
async function checkForHandoff(context: BootstrapContext): Promise<HandoffInfo | null> {
  const handoffPath = path.join(context.workspaceDir, '.openclaw', 'handoff', 'session-state.json');
  
  if (!fs.existsSync(handoffPath)) {
    return null;
  }
  
  const state: SessionState = JSON.parse(fs.readFileSync(handoffPath, 'utf-8'));
  
  // Check if expired (default: 24 hours)
  const expiresAt = new Date(state.expiresAt);
  if (expiresAt < new Date()) {
    return null; // Handoff expired
  }
  
  // Check if already resumed (prevent double-resume)
  if (state.resumeOfferedAt && !forceResume) {
    const offeredAt = new Date(state.resumeOfferedAt);
    const minutesSinceOffer = (Date.now() - offeredAt.getTime()) / 60000;
    if (minutesSinceOffer < 5) {
      return null; // Already offered recently
    }
  }
  
  return state;
}
```

### 5.2 Resume Injection

When resuming, inject this into the session context:

```markdown
## Previous Session Context

The previous session ended at {state.updatedAt}.

### Current Project
{state.project}

### In Progress
{state.summary.inProgress.map(task => `- ${task}`).join('\n')}

### Recent Blockers
{state.summary.blockers.map(b => `- ${b}`).join('\n')}

### Recent Decisions
{state.summary.decisions.map(d => `- ${d}`).join('\n')}

### Suggested Next Step
{state.summary.nextStep}

---

Ask the user: "Would you like to continue where we left off with [project]?"
```

### 5.3 User Commands

| Command | Behavior |
|---------|----------|
| `/handoff` | Manually capture current state for handoff |
| `/resume` | Force resume from last handoff (even if auto-resume was skipped) |
| `/handoff clear` | Clear handoff state (discard resume data) |
| `/handoff status` | Show current handoff state info |

---

## 6. Project Context Isolation

Modeled after VU's `setProject()` filter:

### 6.1 Project Tracking

```typescript
// Track current project in session state
interface ProjectContext {
  name: string;           // e.g., "viber-universal", "openclaw", "general"
  active: boolean;        // Only capture patterns when active
  startedAt: string;
  handoffEnabled: boolean;
}

// Filter patterns - only capture for active projects
function shouldCapture(message: string, project: ProjectContext): boolean {
  if (!project.active || project.name === 'general') {
    return false;
  }
  
  // Skip casual conversation
  const casualPatterns = [
    /^(hey|hi|hello|yo|what's up)/i,
    /^(nice|cool|awesome|thanks)/i,
  ];
  
  // Require work keywords
  const workKeywords = /build|create|implement|fix|bug|error|task|project|code/i;
  
  return !casualPatterns.some(p => p.test(message)) && workKeywords.test(message);
}
```

### 6.2 Project-Aware Handoff

When resuming, if project is set:
- Filter previous session patterns to only that project's context
- Offer to load related project memories (from `memory/`)
- Set project context automatically if user accepts resume

---

## 7. Prototype Implementation

### 7.1 Files to Create

```
~/.openclaw/workspace/hooks/session-capture/
├── HOOK.md              # Hook metadata and documentation
└── handler.ts           # Main handler implementation

~/.openclaw/workspace/handoff/   # Created at runtime
├── session-state.json
└── snapshots/
```

### 7.2 Key Implementation Details

**Hook Metadata (HOOK.md)**:
- Events: `command:new`, `command:reset`, `agent:bootstrap`
- Requires: `workspace.dir` configuration
- Provides: Session handoff capture and resume

**Handler Logic**:
1. On `command:new`/`command:reset`: Capture pre-reset state
2. On `agent:bootstrap`: Check for and inject handoff context
3. Pattern detection runs on last 30 messages
4. LLM generates summary (lightweight prompt)

**Storage**:
- Uses `~/.openclaw/agents/<agentId>/handoff/` directory
- JSON format for easy inspection
- File-based (no external dependencies)

---

## 8. Integration with Existing Systems

### 8.1 OpenClaw Gateway

- Uses existing hook system (no core modifications needed)
- Leverages `sessionKey`, `sessionId` from hook context
- Reads existing JSONL transcripts
- Mutates `context.bootstrapFiles` to inject handoff context

### 8.2 VU Bridge (Future)

- Can feed patterns to VU's `session-notes.json`
- Project context aligns with VU project filtering
- Optional: Sync handoff state to VU database for cross-system visibility

### 8.3 Session-Memory Hook

- Complementary: session-memory saves to `memory/`
- Session-capture saves to `handoff/`
- Handoff takes precedence for immediate context
- Memory provides long-term historical lookup

---

## 9. Security and Privacy Considerations

1. **Data Retention**: Handoff files expire after 24 hours by default (configurable)
2. **Sensitive Data**: Patterns avoid capturing full messages (just summaries)
3. **Access**: Handoff directory is within user's `.openclaw/` directory
4. **Multi-User**: Per-agent isolation means agents don't share handoffs

---

## 10. Testing Strategy

### 10.1 Manual Tests

1. Start session → work on task → `/reset` → verify handoff file created
2. Start new session → verify handoff context injected
3. Wait 25 hours → verify handoff expired and ignored
4. `/handoff clear` → verify handoff removed

### 10.2 Automated Tests

- Pattern detection accuracy test suite
- Handoff file schema validation
- Resume injection integration tests

---

## 11. Future Enhancements

1. **Cross-Agent Handoff**: Share context between different agents
2. **Tool Result Snapshots**: Capture partial work from large tool executions
3. **Multi-Modal**: Include canvas/image context in handoff
4. **Sync to VU**: Real-time pattern sync to VIBER Universal database
5. **Compression**: Delta-compress handoff history

---

## 12. Summary: What We Build Today

**Core Capability**: A hook-based session handoff system that:

1. ✅ Captures session context before `/reset` and `/new`
2. ✅ Detects meaningful patterns (blockers, decisions, insights)
3. ✅ Stores durable handoff state in `~/.openclaw/agents/<agentId>/handoff/`
4. ✅ Automatically injects handoff context into new sessions
5. ✅ Respects project context (like VU's filter)
6. ✅ Expires stale handoffs automatically
7. ✅ Works with existing OpenClaw hook system (no core changes)

**Files Created**:
- `hooks/session-capture/HOOK.md` - Hook metadata
- `hooks/session-capture/handler.ts` - Capture/restore logic
- This design document

**Next Steps**:
1. Hook development (see prototype files)
2. Pattern detection refinement
3. LLM summary generation optimization
4. User testing and feedback
