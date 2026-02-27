# SAMPLE-DATA.md — Pre-Populated Template Data

## 🎯 Sample Clients (5 Ready-to-Use Clients)

### Client 1: Sarah Chen (Tech Startup)
- **Status:** Active
- **Industry:** SaaS
- **Email:** sarah@techflow.io
- **Phone:** +1 (415) 555-0101
- **Rate:** $150/hour
- **Payment Terms:** Net 15
- **Notes:** Repeat client, prefers Slack over email

**Projects:**
| Project | Status | Budget | Hours | Due Date |
|---------|--------|--------|-------|----------|
| Landing Page Redesign | Active | $5,000 | 25 | Mar 15 |
| Dashboard UX | Planning | $8,000 | 40 | Apr 30 |

**Invoices:**
| Invoice # | Amount | Status | Sent Date |
|-----------|--------|--------|-----------|
| INV-2024-001 | $3,750 | Paid | Jan 15 |
| INV-2024-008 | $4,500 | Sent | Feb 20 |

---

### Client 2: Marcus Johnson (Personal Brand)
- **Status:** Active
- **Industry:** Coaching/Consulting
- **Email:** marcus@marcusjohnson.co
- **Phone:** +1 (312) 555-0202
- **Rate:** $120/hour
- **Payment Terms:** Net 30
- **Notes:** Pays promptly, likes detailed breakdowns

**Projects:**
| Project | Status | Budget | Hours | Due Date |
|---------|--------|--------|-------|----------|
| Website Rebuild | Review | $6,000 | 50 | Feb 28 |
| Brand Guidelines | Completed | $2,500 | 15 | Feb 10 |

**Invoices:**
| Invoice # | Amount | Status | Sent Date |
|-----------|--------|--------|-----------|
| INV-2024-003 | $1,800 | Paid | Jan 20 |
| INV-2024-012 | $6,000 | Sent | Feb 25 |

---

### Client 3: GreenLeaf Organics (Small Business)
- **Status:** Active
- **Industry:** E-commerce
- **Email:** orders@greenleaforganics.com
- **Phone:** +1 (503) 555-0303
- **Rate:** $100/hour
- **Payment Terms:** Net 7
- **Notes:** Shop owner, needs simple explanations

**Projects:**
| Project | Status | Budget | Hours | Due Date |
|---------|--------|--------|-------|----------|
| Shopify Migration | Active | $4,500 | 45 | Mar 10 |
| Product Photography | Planning | $2,000 | 20 | Mar 25 |

**Invoices:**
| Invoice # | Amount | Status | Sent Date |
|-----------|--------|--------|-----------|
| INV-2024-005 | $2,500 | Paid | Feb 1 |
| INV-2024-015 | $3,000 | Draft | - |

---

### Client 4: Apex Marketing Agency
- **Status:** Prospective
- **Industry:** Marketing Agency
- **Email:** contact@apexmarketing.com
- **Phone:** +1 (646) 555-0404
- **Rate:** $175/hour (white-label)
- **Payment Terms:** 50% upfront, 50% on delivery
- **Notes:** Potential retainer, waiting on proposal approval

**Projects:**
| Project | Status | Budget | Hours | Due Date |
|---------|--------|--------|-------|----------|
| Client Portal Portal | Prospective | $10,000 | 60 | TBD |
| Monthly Retainer | Prospective | $5,000/mo | 30/mo | TBD |

**Invoices:** None yet (prospective client)

---

### Client 5: Elena Ruiz (Creative Consultant)
- **Status:** Paused
- **Industry:** Non-profit
- **Email:** elena@creativegiving.org
- **Phone:** +1 (305) 555-0505
- **Rate:** $80/hour (discounted)
- **Payment Terms:** Net 45
- **Notes:** Grant-funded, slower payments, mission-driven work

**Projects:**
| Project | Status | Budget | Hours | Due Date |
|---------|--------|--------|-------|----------|
| Donor Platform | Paused | $3,200 | 40 | On hold |

**Invoices:**
| Invoice # | Amount | Status | Sent Date |
|-----------|--------|--------|-----------|
| INV-2024-002 | $2,400 | Paid | Dec 15 |
| INV-2024-006 | $1,600 | Overdue | Jan 10 |

---

## 📊 Overall Dashboard Snapshot

### Revenue This Month (Feb 2024)
| Client | Amount | Status |
|--------|--------|--------|
| Sarah Chen | $4,500 | Sent |
| Marcus Johnson | $6,000 | Sent |
| GreenLeaf | $3,000 | Draft |
| **TOTAL** | **$13,500** | - |

### Outstanding Invoices
| Invoice # | Client | Amount | Days Overdue | Status |
|-----------|--------|--------|--------------|--------|
| INV-2024-006 | Elena Ruiz | $1,600 | 47 days | ⚠️ OVERDUE |
| INV-2024-008 | Sarah Chen | $4,500 | 6 days | ⏰ Sent |
| INV-2024-012 | Marcus Johnson | $6,000 | 1 day | ⏰ Sent |

**Total Outstanding:** $12,100

### Active Projects Requiring Attention
1. **Sarah Chen** — Landing Page due Mar 15 (20 hrs logged, 5 hrs remaining)
2. **GreenLeaf** — Shopify Migration due Mar 10 (30 hrs logged, 15 hrs remaining)
3. **Elena Ruiz** — Donor Platform PAUSED — needs follow-up

---

## 🔄 Sample Invoice Generation Workflow

### Scenario: Sarah Chen Landing Page Completion

**Step 1:** Project marked "Completed" in Projects database

**Step 2:** Create Invoice in Invoices database:
- Invoice #: Auto-generates as INV-2024-016
- Client: Sarah Chen (auto-linked)
- Project: Landing Page Redesign (auto-linked)
- Issue Date: Today
- Due Date: Today + 14 days
- Line Items: 
  - Wireframing: 5 hrs @ $150 = $750
  - UI Design: 12 hrs @ $150 = $1,800
  - Revisions: 8 hrs @ $150 = $1,200
- Hours: 25
- Rate: $150
- Subtotal: **$3,750** (auto-calculated)
- Tax Rate: 0 (services)
- Total: **$3,750** (auto-calculated)

**Step 3:** Export → PDF → Attached → Send → Mark "Sent"

**Step 4:** When paid, mark "Paid", income auto-tracks in dashboard

**Total time:** 3 minutes from completion to sent invoice.

---

## 🎯 Why This Sample Data Matters

**Instant Understanding:** Instead of starting with blank databases, buyers see:
- What a real client entry looks like
- How projects connect to clients
- How invoices auto-calculate
- What a real workflow feels like

**Copy-Paste Ready:** Delete our samples, add your actual clients, keep the structure.

**Psychological:** Seeing $13,500 in potential revenue makes the template feel valuable immediately.

---

*When you duplicate this template, you'll see all these entries pre-populated. Delete them and add your own, or use them as examples while you learn the system.*
