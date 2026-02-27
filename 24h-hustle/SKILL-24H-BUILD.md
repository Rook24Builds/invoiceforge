# SKILL: Zero-to-Launch in 24 Hours

**Skill Name:** `24h-digital-product`  
**Version:** 1.0  
**Cost to Replicate:** $0.00-$0.05  
**Time to Launch:** 2-4 hours  
**Success Rate:** Validated (1+ sale within 3 hours)

---

## Overview

Build and launch a revenue-generating digital product in under 24 hours with zero budget.

### Product Stack Options
1. **Notion Template** (fastest) — Templates + docs + simple databases
2. **Canva Template Bundle** — Social graphics, invoices, presentations
3. **eBook/Guide** — Google Docs → PDF
4. **Chrome Extension** — If code is required
5. **Carrd Landing Page** — Single-page sales site

---

## The $0.025 Build (Validated)

### Product
**Name:** Freelancer Command Center  
**Price:** $19  
**Format:** Notion template + Canva invoice templates

### Cost Breakdown
| Item | Cost | Tool |
|------|------|------|
| Thumbnail | $0.025 | KIE.ai (Flux 2 Pro, 1K) |
| Template Build | $0 | Notion API |
| Delivery | $0 | Gumroad (10% fee only on sale) |
| **Total** | **$0.025** | — |

### Time Breakdown
| Phase | Duration |
|-------|----------|
| Concept & planning | 15 min |
| Notion template build | 60 min |
| Copywriting | 20 min |
| Thumbnail gen + upload | 10 min |
| Gumroad setup + publish | 15 min |
| **Total** | **2 hr** |

---

## Execution Playbook

### Phase 1: Concept (15 min)
1. Pick ONE pain point for ONE audience (e.g., "freelancers forget to invoice")
2. Define the transformation (from chaos → organized)
3. Price: $9-$49 (impulse range for templates)

### Phase 2: Build (60 min)
**Notion Template Structure:**
```
Parent Page
├── Dashboard (embeds + quick links)
├── Quick Start Guide
├── Clients DB (status, LTV, relations)
├── Projects DB (deadlines, linked to clients)
└── Invoices DB (amount, status, due date, linked to clients/projects)
```

**Database Relations:**
- Clients ←→ Projects (1:many)
- Clients ←→ Invoices (1:many)
- Projects ←→ Invoices (1:1)

**Formula Properties:**
- "Days Until Due": `dateBetween(prop("Due Date"), now(), "days")`
- "Lifetime Value": Rollup of all paid invoices per client

### Phase 3: Visuals (10 min)
**Thumbnail Prompt (Flux 2 Pro):**
```
Abstract dark gradient background, sharp geometric lines, clean lines, deep colors transitioning between black and deep blue, minimalist and modern aesthetic, no text, no letters, professional business software theme --ar 1:1 --style raw
```

**Cost:** $0.025 at KIE.ai

### Phase 4: Copy (20 min)
**Structure:**
1. Hook (pain point)
2. Problem agitation ("you know this feeling...")
3. Solution intro
4. What's inside (bullet list)
5. How it works (3 steps)
6. Perfect for ( personas)
7. Includes ( deliverables)
8. Price anchor ("less than your hourly rate")

### Phase 5: Delivery (15 min)
**Gumroad Setup:**
1. Create product (name, price, description)
2. Upload thumbnail (1200x800 min)
3. Add content file (README.md with Notion duplicate link)
4. Set refund policy (30-day recommended)
5. PUBLISH (requires payment setup first!)

**Payment Setup Requirements:**
- Bank account (routing/account number)
- Identity verification (SSN last 4, DOB)
- Address
- Only needs to be done ONCE per account

---

## Distribution (Hardest Part)

### Free Channels
| Channel | Effort | Reach |
|---------|--------|-------|
| Hacker News "Show HN" | Low | High |
| IndieHackers "New Product" | Low | Med |
| Newsletter curators (cold email) | Med | Low-Med |
| Gumroad Discover | Passive | Low |
| Reddit (if you have account) | High | High |

### Paid Channels
| Channel | Cost | ROI |
|---------|------|-----|
| Twitter/X ads | $20+ | Unlikely at $19 price |
| Reddit ads | $5/day min | Possible |
| Newsletter sponsorship | $100+ | Not worth for single product |

### Reality Check
**Build ≠ Launch ≠ Sales**

Most 24-hour products die at launch because:
1. No distribution channel
2. No audience
3. SEO takes months
4. "Build it and they will come" is a lie

**Success requires:** Existing reach OR willingness to hustle distribution.

---

## Metrics to Track

| Metric | Target |
|--------|--------|
| Time to first sale | < 24 hours |
| Cost to build | < $1 |
| Break-even | 1 sale |
| CAC (customer acquisition cost) | $0 (organic) |
| LTV potential | $19 (one-time) |

---

## Lessons Learned

### What Worked
1. Notion API is fast for template creation
2. Flux 2 Pro at 1K is good enough for thumbnails
3. Gumroad handles all payment/delivery complexity
4. $19 is impulse-buy territory

### What Didn't
1. Gumroad takes you to payment settings instead of telling you WHY
2. Marketing without distribution is near-impossible
3. Build time is 10% of total effort; marketing is 90%

### Pivot Options if No Sales
1. Lower price to $9 (psychological barrier)
2. Bundle with other templates
3. Give away free version, upsell paid
4. Target different audience (agencies vs freelancers)
5. Add video walkthrough as proof of value

---

## Files Generated

- `PRODUCT-README.md` — Buyer deliverable
- `GUMROAD-LISTING.md` — Full sales page copy
- `LAUNCH-REDDIT.md` — Reddit post templates
- `READY-TO-SHIP.md` — Pre-flight checklist
- `MARKETING-ASSETS.md` — Outreach templates

---

## Skill Checklist

```
[ ] Defined audience and pain point
[ ] Built minimum viable template/product
[ ] Generated thumbnail ($0.025)
[ ] Wrote compelling sales copy
[ ] Set up Gumroad with payment info
[ ] Published product
[ ] Optimized for discoverability
[ ] Created distribution plan
[ ] Executed at least one marketing channel
[ ] Tracked first sale
```

**Completion:** Validated ✅
