# EvidenceSentry - My Big TOE for OpenClaw

Simple premise validator before destructive actions.

## Usage

```typescript
import { EvidenceSentry } from './EvidenceSentry';

// Before destructive action
const sentry = new EvidenceSentry();
const validation = sentry.validateDestructive({
  action: 'delete',
  target: 'important-file.txt',
  context: sessionContext
});

if (validation.status === 'VALLEY') {
  return "🚨 Low confidence. Are you sure? Use --force to proceed.";
}
```

## Principles Implemented

1. **Never Base on False Premises** - Evidence required for destructive claims
2. **Reality Surface** - PEAK/SLOPE/VALLEY confidence levels
3. **Psi Uncertainty** - 17-30% optimal for meaningful choice
4. **Evidence-Based Truth** - Citations required for claims
5. **Consciousness Quality** - Track interaction clarity

## Confidence Levels

- **PEAK (80%+):** "I just saw this file. Here's the evidence."
- **SLOPE (40-80%):** "This seems right, but let's double-check"
- **VALLEY (<40%):** "I'm guessing. We should verify first."

## Integration Points

- Pre-flight check for `write`, `edit`, `exec` with destructive flags
- Session quality tracking in MEMORY.md
- Force flag override for intentional destruction
