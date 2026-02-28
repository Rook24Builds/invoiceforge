# Make.com Integration for INVOICEFORGE

## What This Does

Connect INVOICEFORGE to Make.com (free tier) to:
- Generate PDFs from your invoices
- Email invoices automatically
- Save PDFs back to Notion

## Prerequisites

1. **Make.com account** (free at make.com)
2. **Google account** (for PDF template)
3. **Notion integration** (already set up in template)

---

## Setup (15 Minutes)

### Step 1: Create Google Doc Template

1. Open [Google Docs](https://docs.new)
2. Create your invoice layout:

```
INVOICE {{invoice_number}}

From: YOUR COMPANY
To: {{client_name}}
Address: {{client_address}}

Date: {{issue_date}}
Due Date: {{due_date}}

| Description | Hours | Rate | Amount |
|-------------|-------|------|--------|
{{line_items}}

Subtotal: {{subtotal}}
Tax ({{tax_percent}}%): {{tax_amount}}
Total: {{total}}
```

3. Replace everything in {{ }} with your actual formatting
4. File → Save as "Invoice Template"

### Step 2: Build the Make Scenario

1. Log into [Make.com](https://make.com)
2. Click "Create a new scenario"
3. Add modules in this order:

#### Module 1: Notion - Watch Database Items
- Connection: Your Notion account
- Database: "Invoices"
- Trigger: Status changed to "Sent"
- Limit: 10

#### Module 2: Notion - Get a Database Item
- Database Item ID: Use ID from Module 1
- This gets invoice details

#### Module 3: Notion - Query a Database
- Database: "Work Log"
- Filter: Invoice relation = Invoice ID from Step 2
- This gets line items

#### Module 4: Notion - Get a Database Item
- Database: "Clients"
- ID: Use Client ID from Step 2
- This gets client details

#### Module 5: Google Docs - Create a Document from Template
- Template: "Invoice Template" (from Step 1)
- Title: "Invoice {{invoice_number}}"
- Merge fields:
  - {{invoice_number}} ← Invoice # field
  - {{client_name}} ← Client name
  - {{client_address}} ← Client address
  - {{issue_date}} ← Invoice Date
  - {{due_date}} ← Due Date
  - {{subtotal}} ← Amount field
  - {{tax_percent}} ← Tax % field
  - {{tax_amount}} ← Tax formula field
  - {{total}} ← Total formula field
  - {{line_items}} ← Create from Work Log entries

#### Module 6: Google Docs - Download a Document
- Document ID: From Step 5
- Type: PDF

#### Module 7: Notion - Update a Database Item
- Database: "Invoices"
- ID: From Step 2
- Properties:
  - PDF: Upload file from Step 6

#### Module 8: Gmail - Send an Email (Optional)
- To: {{client_email}}
- Subject: "Invoice {{invoice_number}} - Due {{due_date}}"
- Body: Your message
- Attachment: PDF from Step 6

### Step 3: Test

1. Create a new invoice in Notion
2. Add line items via Work Log
3. Set tax percentage
4. Change Status to "Sent"
5. Check Make.com history
6. See PDF generated and saved to Notion!

---

## Template Variables Reference

| Variable | Source | Description |
|----------|--------|-------------|
| `{{invoice_number}}` | Invoice # | INV-001, etc. |
| `{{client_name}}` | Clients → Name | "Acme Corp" |
| `{{client_email}}` | Clients → Email | billing@acme.com |
| `{{client_address}}` | Clients → Address | Full address text |
| `{{issue_date}}` | Invoices → Date Issued | 2024-02-28 |
| `{{due_date}}` | Invoices → Due Date | 2024-03-30 |
| `{{subtotal}}` | Invoices → Amount | $1,425.00 |
| `{{tax_percent}}` | Invoices → Tax % | 8 |
| `{{tax_amount}}` | Invoices → Tax (formula) | $114.00 |
| `{{total}}` | Invoices → Total | $1,539.00 |
| `{{line_items}}` | Work Log ↺ | Table rows |

---

## Troubleshooting

### Issue: Make doesn't see my invoices
**Fix:** Ensure your Notion integration has access to all databases

### Issue: Line items not showing
**Fix:** Check Work Log entries are linked to the invoice via relation

### Issue: Tax shows 0
**Fix:** Set "Tax Percent" field (e.g., 8 for 8%)

### Issue: PDF not saving
**Fix:** Make sure "PDF (files)" property exists in Invoices database

---

## Cost

| Service | Cost |
|---------|------|
| Make.com | 1,000 ops/month FREE |
| Google Docs | Free |
| Gmail | Free (up to 500/day) |
| Notion API | Free |
| **Total** | **$0** |

---

## Support

Questions? Email: rookbuilds24@grr.la

Built by Rook Builds | Powered by Notion + Make
