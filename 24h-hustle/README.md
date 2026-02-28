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

### 5. Generate PDF (Optional - 15 min setup)
1. Import `INVOICEFORGE-PDF-Generator.json` to Make.com
2. Follow `MAKE-SCENARIO-SETUP.md` to connect accounts
3. Change Invoice Status to "Sent"
4. PDF auto-generates → saves to Notion
5. Download PDF, email to client

---

## Make.com Integration (PDF Automation)

**What You Get:**
- Importable Make scenario (`INVOICEFORGE-PDF-Generator.json`)
- Step-by-step setup guide (`MAKE-SCENARIO-SETUP.md`)
- Google Doc template instructions

**What It Does:**
1. Watches your INVOICEFORGE Invoices database
2. When Status = "Sent" → triggers automatically
3. Pulls invoice data + line items (Work Log) + client info
4. Generates professional PDF via Google Docs
5. Saves PDF back to your Notion invoice (files property)
6. Optional: auto-emails PDF to client

**Setup:** 15 minutes (import JSON + connect accounts)  
**Cost:** $0/month (Make free tier: 1,000 operations)  
**Usage:** ~7 operations per invoice = ~140 invoices/month free

**What's Included:**
- `INVOICEFORGE-PDF-Generator.json` — Ready to import
- `MAKE-SCENARIO-SETUP.md` — Complete walkthrough
- `MAKE-INTEGRATION.md` — Technical reference

---

## Pricing

**$19** — One-time purchase

**Includes:**
- Notion template (all databases + sample data)
- `INVOICEFORGE-PDF-Generator.json` — Importable Make scenario
- `MAKE-SCENARIO-SETUP.md` — Step-by-step PDF automation guide
- `MAKE-INTEGRATION.md` — Technical reference
- Google Docs template instructions

**Requires:**
- Notion account (free)
- Make.com account (free tier)
- Google account (free)

---

## FAQ

**Q: How do I generate PDFs?**  
A: Two options:
1. **Recommended:** Import Make scenario → Status "Sent" triggers auto-generation
2. **Manual:** Notion → Export → PDF (per page)

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
├── 📖 SETUP.md — Quick start guide
├── ⚙️ MAKE-SCENARIO-SETUP.md — PDF automation setup (15 min)
├── ⚙️ MAKE-INTEGRATION.md — Technical reference
├── ⚙️ make-scenarios/
│   └── INVOICEFORGE-PDF-Generator.json — Import to Make.com
└── 📄 SAMPLE-DATA.md — Sample data explanation
```

---

## Support

Questions? Email: rookbuilds24@grr.la

Built in 24 hours. Yours forever.

**♜ Rook Builds** | Auto-generate. Don't calculate.
