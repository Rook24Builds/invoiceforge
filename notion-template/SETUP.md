# How to Set Up the Invoice Generator in Notion

## The 3-Minute Setup

### Step 1: Create a New Database

1. In Notion, type `/database` and select "Database - Full page"
2. Name it **"Invoices"**
3. Click **+ New** to add columns

### Step 2: Add These Columns

| Column Name | Type | Notes |
|-------------|------|-------|
| Invoice # | Title | This will be the name |
| Client | Relation | First create Clients database, then link it |
| Project | Relation | First create Projects database, then link it |
| Issue Date | Date | When you send |
| Due Date | Date | When payment due |
| Status | Select | Draft, Sent, Paid, Overdue |
| Line Items | Text | Services provided |
| Hours | Number | Time worked |
| Rate | Number | $/hour or flat rate |
| Subtotal | Formula | Click "Formula" → Type: `prop("Hours") * prop("Rate")` |
| Tax Rate | Number | e.g., 0.08 for 8% |
| Tax Amount | Formula | Type: `prop("Subtotal") * prop("Tax Rate")` |
| Total | Formula | Type: `prop("Subtotal") + prop("Tax Amount")` |
| Notes | Text | Payment terms, etc. |

### Step 3: Link Your Existing Databases

**If you already have Clients/Projects databases:**
1. In Invoices database, click "+" to add column
2. Choose **Relation**
3. Select your **Clients** database
4. Repeat for **Projects** database
5. Now each invoice can link to a client and project

### Step 4: Create Invoice Template Page

1. Outside the database, create a new page: "Invoice Template"
2. Paste this inside:

```markdown
# INVOICE

**Invoice #:** INV-00X  
**Date:** [Today]  
**Due Date:** [Due]

---

## From
[Your Name]  
[Your Email]  
[Your Website]

## Bill To
[Client Name from Linked Database]

---

## Services

| Description | Qty | Rate | Amount |
|-------------|-----|------|--------|
| [Service 1] | [Hrs] | $[Rate] | $[Amount] |
| [Service 2] | [Hrs] | $[Rate] | $[Amount] |

**Subtotal:** $[Amount]  
**Tax:** $[Amount]  
**Total Due:** $[Amount]

---

Payment via: [PayPal/Venmo/Bank]

Thank you for your business!
```

3. Save this page as your template

### Step 5: Generate an Invoice

**When you're ready to bill:**

1. Go to **Invoices** database
2. Click **+ New** (creates new invoice row)
3. Fill in:
   - Invoice #: INV-001 (or use Notion's auto-number)
   - Client: Select from dropdown (auto-links)
   - Project: Select from dropdown
   - Issue Date: Today
   - Due Date: +14 days
   - Line Items: List services
   - Hours: Total hours
   - Rate: Your rate
   - **Subtotal & Total auto-calculate**

4. Now you have two options:

#### Option A: Quick Export (Fast)
- Click into the invoice row
- Click **⋯** → **Export** → **PDF**
- Notion generates a clean PDF with your data
- Attach to email, send

#### Option B: Pretty Invoice (Nicer)
- Duplicate your "Invoice Template" page
- Copy values from the database into the template
- Customize formatting, add logo
- Export as PDF
- Send

---

## Pro Workflow

### Template Shortcut
Create a Notion template button:
1. In your Invoices database, click **⋯** → **Templates**
2. Click **+ New template**
3. Name it "New Invoice"
4. Set default values:
   - Status: Draft
   - Tax Rate: 0.08 (or 0)
   - Notes: "Payment due within 14 days. Thank you!"

Now click template → New invoice pre-filled → You just add client/details.

### Auto-Calculating Totals
Your database automatically calculates:
- **Subtotal** = Hours × Rate
- **Tax** = Subtotal × Tax Rate
- **Total** = Subtotal + Tax

Change any number → Totals update instantly.

### Rolling Totals View
Create a calendar view:
1. In Invoices database, click **+** next to your current view
2. Select **Calendar**
3. Date property: **Due Date**
4. Now you see when payments are due

Create a "Paid" view:
1. Add **Board** view
2. Group by: **Status**
3. Now you see columns: Draft → Sent → Paid → Overdue

---

## Example Walkthrough

**You just finished a project.**

1. Open Invoices database
2. Click **+ New** → "New Invoice" template
3. Select **Client**: Sarah's Design Co.
4. Select **Project**: Website Redesign
5. **Issue Date**: Today
6. **Due Date**: +14 days
7. **Line Items**: 
   ```
   - Homepage design
   - About page
   - Contact form setup
   ```
8. **Hours**: 15
9. **Rate**: $100
10. **Subtotal**: $1,500 (auto) 
11. **Tax**: $0 (if no tax)
12. **Total**: $1,500 (auto)
13. **Export** → **PDF**
14. Email to Sarah with PDF attached
15. Mark **Status**: Sent

**That's it.** Your client info, project details, and invoice all connected.

---

## Files

- `database-schema.json` — Technical schema (for nerds)
- `INVOICE-GENERATOR.md` — Full detailed docs
- This file — Quick setup guide
