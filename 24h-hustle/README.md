# INVOICEFORGE

**Auto-Generating Invoice System for Notion**

Link Work Log entries to Invoices for itemized billing. Auto-calculate totals. Generate PDFs via free automation.

---

## What Makes This Different

**Most Notion templates:** Blank databases + manual calculations

**INVOICEFORGE:**
- ✅ **Pre-populated** with 5 clients, 8 projects, 10 invoices
- ✅ **Itemized invoices** via Work Log → Invoice relations
- ✅ **Auto-calculations** (Hours × Rate = Amount, Tax, Total)
- ✅ **PDF Generation** (via Make.com free tier)
- ✅ **Make.com Template** included (no coding required)

---

## The Workflow

```
Client → Project → Work Log (tasks/hours) → Invoice (with line items) → PDF → Send
```

**60-second invoicing:**
1. Log hours in Work Log
2. Select which Invoice to bill
3. Amount auto-calculates from Hours × Rate
4. Set status to "Sent" → triggers Make → PDF generated
5. PDF saved back to Notion → download & send

---

## Included

### Notion Template
- **Clients Database** (5 sample clients)
  - Relations to Projects
  - Auto-calculated totals
- **Projects Database** (8 sample projects)
  - Budget tracking
  - Status workflow
- **Work Log Database** (task-level time tracking)
  - Task description
  - Hours × Rate = Amount (formula)
  - Relations: Project → Invoice
- **Invoices Database** (10 sample invoices)
  - **Line Items relation** to Work Log
  - **Total from Tasks** rollup (auto-sums)
  - Tax % field + Tax formula
  - Status: Draft / Sent / Paid / Overdue
  - **PDF files property** (for generated PDFs)

### Make.com Integration
- **15-minute setup guide**
- Connects Invoice "Status = Sent" → PDF generation
- Uses Google Docs template
- Saves PDF to Notion
- Optional: auto-email to client
- **Cost: $0** (Make free tier: 1,000 ops/month)

### Sample Data
| Type | Count | Description |
|------|-------|-------------|
| Clients | 5 | SaaS, Agency, Design, Logistics, Corp |
| Projects | 8 | Active, Completed, On Hold, Draft |
| Invoices | 10 | Draft, Sent, Paid, Overdue statuses |
| Work Log | 3 | Linked to invoices for itemized billing |

---

## Key Features

| Feature | How It Works |
|---------|--------------|
| **Itemized Invoices** | Link Work Log entries to Invoices → line items appear on invoice |
| **Auto-Calculations** | Hours × Rate = Amount (Work Log) → Total from Tasks rollup (Invoices) |
| **Tax Support** | Tax % field + formula: Amount × % = Tax |
| **Status Workflow** | Draft → Sent → Paid / Overdue |
| **PDF Generation** | Make.com scenario watches "Sent" → generates PDF → saves to Notion |
| **Client Dashboard** | Auto-calculated: Total Invoiced, Paid, Outstanding per client |

---

## Architecture

```
┌──────────────┐    ┌──────────────┐    ┌─────────────────┐
│   CLIENTS    │────│  PROJECTS    │────│   WORK LOG      │
│              │    │              │    │                 │
│ • Name       │    │ • Name       │    │ • Task          │
│ • Email      │    │ • Client     │    │ • Hours         │
│ • Address    │    │ • Status     │    │ • Rate          │
│ • Hourly Rate│    │ • Budget     │    │ • Amount (calc) │
└──────┬───────┘    └──────┬───────┘    └───┬───────────┬─┘
       │                   │                │           │
       │                   │                │           │
       └───────────────────┴────────────────┘           │
                                                   relation
       ┌─────────────────────────────────────────────────┘
       │
┌──────▼───────┐
│  INVOICES    │
│              │
│ • Invoice #  │
│ • Client     │
│ • Line Items │───relation───→ Work Log entries
│ • Amount     │
│ • Tax %      │
│ • Tax (calc) │
│ • Total (calc)│
│ • Status     │
│ • PDF (files)│←── Make.com saves generated PDF here
└──────────────┘
```

---

## Quick Start

### 1. Duplicate Template (2 min)
1. Click "Duplicate" on the Notion share link
2. Template copies to your workspace
3. Explore sample data

### 2. Add First Client (2 min)
1. Open **Clients** database
2. Click "+ New"
3. Fill: Name, Email, Address, Hourly Rate

### 3. Create Project (2 min)
1. Open **Projects** database
2. Link to Client
3. Set Budget, Status

### 4. Log Hours (2 min)
1. Open **Work Log**
2. Add Task Description
3. Enter Hours, Rate auto-fills from Client
4. Amount auto-calculates
5. Select Project and Invoice to bill

### 5. Generate Invoice (Optional - 10 min setup)
1. Set up [Make.com integration](MAKE-INTEGRATION.md) (one-time)
2. Change Invoice Status to "Sent"
3. PDF auto-generates → saves to Notion
4. Download PDF, email to client

---

## Make.com Integration

**Included:** `MAKE-INTEGRATION.md` with step-by-step setup

**Requirements:**
- Make.com account (free)
- Google account (for PDF template)

**What it does:**
- Watches for "Status = Sent"
- Pulls invoice + line items
- Generates PDF via Google Docs
- Saves PDF to Notion
- Optional: emails to client

**Setup time:** 15 minutes  
**Monthly cost:** $0 (1,000 free operations)

---

## Pricing

**$19** — One-time purchase

**Includes:**
- Notion template (all databases + sample data)
- Make.com integration guide
- Google Docs PDF template

**Requires:**
- Notion account (free)
- Make.com account (free tier)
- Google account (free)

---

## FAQ

**Q: How do I generate PDFs?**  
A: Three options:
1. **Recommended:** Use included Make.com setup → auto-generate PDFs
2. **Manual:** Notion → Export → PDF (page by page)
3. **Canva:** Use included 3 Canva templates

**Q: Can I use without Make.com?**  
A: Yes. Template works fully. Make.com is optional for PDF automation.

**Q: Is my data private?**  
A: Yes. Everything lives in YOUR Notion. Make.com only accesses what you authorize.

**Q: Can I customize?**  
A: Fully. It's Notion — change properties, add fields, modify formulas.

---

## Files Included

```
INVOICEFORGE/
├── 📊 Notion Template (duplicate link)
├── 📖 SETUP.md - Quick start guide
├── ⚙️ MAKE-INTEGRATION.md - Make.com setup
├── 📄 SAMPLE-DATA.md - Sample data explanation
├── 🎨 Canva Templates/ - 3 invoice designs
└── 📝 Canva Template Links.md
```

---

## Support

Questions? Email: rookbuilds24@grr.la

Built in 24 hours. Yours forever.

**♜ Rook Builds** | Auto-generate. Don't calculate.
