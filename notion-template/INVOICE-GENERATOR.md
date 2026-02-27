# INVOICE-GENERATOR.md

## Notion Auto-Invoice Generator

This setup lets you generate invoices directly in Notion using your existing client/project data.

---

## What You Get

1. **Invoice Database** — Tracks invoices, links to clients & projects
2. **Auto-Calculated Totals** — Formulas sum up your line items
3. **Invoice Page Template** — Pre-formatted page ready to export as PDF
4. **One-Click Generation** — Database → Page → PDF in 60 seconds

---

## Setup (5 Minutes)

### Step 1: Create the Invoice Database

1. In your Notion workspace, create a new database called **"Invoices"**
2. Add these properties:

| Property | Type | Purpose |
|----------|------|---------|
| Invoice # | Title | Auto-numbered (INV-001, INV-002...) |
| Client | Relation | Link to your Clients database |
| Project | Relation | Link to your Projects database |
| Issue Date | Date | When you send it |
| Due Date | Date | When payment is due |
| Status | Select | Draft → Sent → Paid → Overdue |
| Line Items | Text | List of services (one per line) |
| Rate | Number | Your hourly/project rate |
| Hours | Number | Hours worked |
| Subtotal | Formula | `prop("Hours") * prop("Rate")` |
| Tax Rate | Number | 0.08 for 8% (or 0 for none) |
| Tax Amount | Formula | `prop("Subtotal") * prop("Tax Rate")` |
| Total | Formula | `prop("Subtotal") + prop("Tax Amount")` |
| Notes | Text | Payment terms, thank you message |

### Step 2: Create the Invoice Template Page

1. Create a new page called **"Invoice Template"**
2. Add this content (copy-paste ready):

```
# INVOICE

**Invoice #:** @Invoice #  
**Date:** @Issue Date  
**Due Date:** @Due Date

---

## From
Your Name / Company Name  
Your Email  
Your Website

## Bill To
@Client (pulls from linked Client database)

---

## Services

| Description | Hours | Rate | Amount |
|-------------|-------|------|--------|
| @Line Items | @Hours | $@Rate | $@Subtotal |

**Subtotal:** $@Subtotal  
**Tax (@Tax Rate):** $@Tax Amount  
**Total Due:** $@Total

---

@Notes

---

**Payment Methods:**  
PayPal: your@email.com  
Bank Transfer: (your details)  
Venmo: @yourhandle
```

3. Save this as a template: Click **⋯** → **Duplicate** to create new invoices

### Step 3: Link to Your Existing Databases

In the Invoice database:
1. Add a **Relation** property pointing to your **Clients** database
2. Add a **Relation** property pointing to your **Projects** database
3. Now each invoice knows which client/project it belongs to

---

## How to Generate an Invoice (60-Second Workflow)

### 1. Create Invoice Record
- In your **Invoices** database, click **+ New**
- Select **Client** from dropdown (auto-pulls client info)
- Select **Project** from dropdown
- Set **Issue Date** (today)
- Set **Due Date** (today + 14 days = Net 14)
- Enter **Line Items** (one service per line)
- Enter **Hours** worked
- Enter **Rate** (your hourly/project rate)
- **Subtotal, Tax, Total auto-calculate**

### 2. Generate Invoice Page
- Open the invoice record (click the row)
- Click **⋯** → **Duplicate** your Invoice Template page
- Rename it: "Invoice - [Client Name] - [Date]"
- Replace the @fields with actual values from the database

### 3. Export as PDF
- Click **⋯** → **Export**
- Format: **PDF**
- Include subpages: **No**
- Click **Export**
- Notion generates a clean PDF

### 4. Send & Track
- Attach PDF to email
- Mark **Status** as "Sent" in database
- When paid, change **Status** to "Paid"

---

## Pro Tips

### Auto-Numbering
Use this formula for Invoice #:
```
concat("INV-", formatDate(prop("Issue Date"), "YYYY"), "-", ((prop("$:dense::$:auto:☔️$").filter(current.prop("Issue Date") < prop("Issue Date")).length() + 1))
```
*Or just manually number them INV-001, INV-002...*

### Line Items Format
Write line items like this for easy copying:
```
- Website design: 5 hours @ $100/hr
- Logo revisions: 2 hours @ $100/hr
- Consultation call: 1 hour @ $150/hr
```

### Status Automation (Optional)
Set up a Notion automation:
- When **Due Date** is past + **Status** is "Sent" → Set **Status** to "Overdue"

### Client View (Optional)
Create a linked database view showing:
- All invoices for a specific client
- Total paid vs outstanding
- Last invoice date

---

## Example Invoice Flow

**Scenario:** You just finished a website project for Acme Corp

1. In **Projects** database, mark "Acme Website Redesign" as "Completed"
2. In **Invoices** database, click **+ New**
3. Select **Client**: Acme Corp
4. Select **Project**: Website Redesign
5. Set **Issue Date**: Today
6. Set **Due Date**: 14 days from now
7. **Line Items**:
   ```
   - Website design: 20 hrs
   - SEO optimization: 5 hrs
   - Training session: 2 hrs
   ```
8. **Rate**: $100
9. **Hours**: 27
10. **Subtotal**: $2,700 (auto)
11. **Tax**: 0 (services, no tax)
12. **Total**: $2,700 (auto)
13. Duplicate Invoice Template page
14. Fill in @fields with actual values
15. Export PDF → Send → Mark "Sent"
16. When paid, mark "Paid"

**Total time:** 3 minutes vs. 30 minutes in Canva

---

## Database Schema

```
┌─────────────────────┐     ┌─────────────────────┐
│     CLIENTS         │     │     PROJECTS        │
├─────────────────────┤     ├─────────────────────┤
│ Name                │◄────│ Client (Relation)   │
│ Email               │     │ Project Name        │
│ Address             │     │ Status              │
│ Payment Method      │     │ Hours Logged        │
│ Rate Default        │     │ Budget              │
└─────────────────────┘     └─────────────────────┘
         ▲                           ▲
         │                           │
         │     ┌─────────────────────┴──────────────┐
         │     │            INVOICES                │
         └─────┤  ┌──────────────────────────────┐  │
               │  │ Invoice #                    │  │
               │  │ Client (Relation) ◄──────────┼──┘
               │  │ Project (Relation) ◄─────────┘
               │  │ Issue Date                     │
               │  │ Due Date                       │
               │  │ Status [Draft/Sent/Paid/Over] │
               │  │ Line Items                     │
               │  │ Hours                          │
               │  │ Rate                           │
               │  │ Subtotal (Formula)             │
               │  │ Tax Rate                       │
               │  │ Tax Amount (Formula)           │
               │  │ Total (Formula)                │
               │  │ Notes                          │
               │  └──────────────────────────────┘
               └──────────────────────────────────────┘
```

---

## Files Included

1. **invoice-generator-database.json** — Import to create the full setup
2. **invoice-page-template.md** — Copy-paste template
3. **setup-instructions.md** — This file

---

**Result:** One database. One template. PDF invoices in 60 seconds. Everything connected.
