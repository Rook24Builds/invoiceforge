# Session Handoff Pattern

Mechanism for persisting work across OpenClaw sessions.

## The Problem
- Sessions compact when context hits 80%
- Browser automation consumes tokens fast
- Work-in-progress can be lost on reset

## The Solution
**Pre-compaction flush → Durable storage → Resume on bootstrap**

### 1. Pre-Compaction Flush (Critical)
When memory exceeds 70% or heartbeat signals compaction:
- Write all pending work to workspace files
- Update memory/YYYY-MM-DD.md with status
- Commit to git if possible
- Document next steps explicitly

### 2. Durable Storage Pattern
```
24h-hustle/
  ├── DEVTO-ARTICLE.md      # Publish-ready content
  ├── CARRD-CONTENT.md      # Copy for landing page
  ├── GUMROAD-LISTING.md     # Product details
  └── LAUNCH-CHECKLIST.md    # Current status

memory/
  └── YYYY-MM-DD.md          # Daily log + session state
```

### 3. Bootstrap Resume
On new session:
1. Read memory/YYYY-MM-DD.md
2. Read SKILL.md for patterns
3. Check workspace for pending files
4. Resume from last documented state

## Browser Automation Lessons
- **Text operations:** Safe, low token cost
- **Browser:** 60s timeout risk, high token burn
- **Pivot rule:** When context >70%, switch to text-only

## Session Safety Checklist
- [ ] Context <80% before browser ops
- [ ] Files written before long operations
- [ ] Memory updated with current status
- [ ] Next steps documented explicitly
