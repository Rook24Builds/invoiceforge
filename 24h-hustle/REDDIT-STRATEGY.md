# Reddit Engagement Strategy — INVOICEFORGE

## Core Rule: Add Value First, Link Last

Never lead with the product.
Lead with help. Plant the seed. Let them ask.

---

## r/freelance — Pain Point Hunting

### Comment Template 1: Invoicing Pain
**Target:** Posts about "how do you invoice clients?"

```
I was in the same boat — juggling Notion, Sheets, Canva.

Built something that cut it to 60 seconds:
- Pre-populated client data
- Auto-calculating totals
- PDF export

$19 saved me probably 10 hours in the first month.

Happy to share what's working if helpful.
```

**When they reply:**
```
Sure — I put together INVOICEFORGE for exactly this.

Notion template with auto-calculation baked in.
Pre-populated with sample clients so you can see the workflow.

 rook24.gumroad.com/l/invoiceforge if you want to check it out.
```

---

### Comment Template 2: Client Management Chaos
**Target:** "How do you organize client work?"

```
I track everything in Notion but the game-changer was linking databases:

Clients → Projects → Invoices (all connected)

Change a client's rate in one place, future invoices auto-update.
Status flows through: contacted → scoped → invoiced → paid

Used to spend 15 min per invoice. Now 60 seconds.

The linked database thing is underrated.
```

---

### Comment Template 3: Overdue Invoices
**Target:** "Client won't pay, what do I do?"

```
Prevention > Recovery.

I built a system that makes invoicing so frictionless I do it same-day now:
- 60-second workflow
- Auto-calculates everything
- PDF export built-in

No more "I'll invoice tomorrow." Tomorrow becomes next week. Next week becomes chasing 30-day-old invoices.

Automate the friction out.
```

---

## r/SaaS — Efficiency Angle

### Comment Template: Workflow Automation
**Target:** "What's your stack for operations?"

```
For invoicing specifically:

Notion (client data) + Auto-calc formulas + PDF export

Pre-populated templates so new team members understand it immediately.
No "how does this work?" Slack messages.

Whole thing built for $0.05. Sometimes simple > sophisticated.
```

---

## r/Notion — Technical Cred

### Comment Template: Formula Help
**Target:** "How do I calculate invoices in Notion?"

```
You need linked databases + rollups.

Structure:
Clients DB (rate per hour)
  ↓
Projects DB (linked to client, pulls rate)
  ↓
Invoices DB (hours × pulled rate = total)

Formula in Invoices:
```
prop("Hours") * prop("Client").prop("Rate")
```

I built a full template around this if you want to see it working with sample data.
```

**If they ask:**
```
It's called INVOICEFORGE — pre-populated with clients so you don't have to guess what the workflow looks like.

 rook24.gumroad.com/l/invoiceforge (made it $19 because honestly I couldn't justify charging more for something built in 24 hours)
```

---

## r/webdev — Tech Stack

### Comment Template: Side Project
**Target:** "What are you building this weekend?"

```
Shipped INVOICEFORGE — Notion invoice generator.

Stack:
- Notion databases (formulas + rollups)
- Canva templates (PDF export)
- GitHub Pages (landing)
- Gumroad (payments)

Total cost: $0.05 (one AI-generated product image)
24-hour build.

First time doing "build in public." Weirdly fun.
```

---

## Comment Engagement Rules

### Do:
- Read the full post before commenting
- Be genuinely helpful
- Use specific details, not generic advice
- Wait for them to ask for the link
- Reply to every response

### Don't:
- Drop links unasked
- Use obvious copy-paste
- Post to multiple threads rapidly (rate limit yourself)
- Defend the product if criticism comes

### Timing:
- Comment on posts < 6 hours old
- 3-5 comments per day max
- Spread across subreddits
- Peak hours: 9-11am, 7-9pm EST

---

## Subreddit Priority

1. **r/freelance** — Primary target (pain posts daily)
2. **r/Notion** — Technical credibility
3. **r/SaaS** — Business efficiency angle
4. **r/webdev** — Side project story
5. **r/solopreneurs** — Bootstrap angle

---

## Follow-Up Strategy

**When someone comments on your comment:**
1. Reply within 30 minutes if possible
2. Add specific value
3. Only share link if they explicitly ask or show interest

**Build reputation first. Sales second.**
