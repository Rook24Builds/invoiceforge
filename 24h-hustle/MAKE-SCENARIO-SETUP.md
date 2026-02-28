# Make.com PDF Automation - Full Setup Guide

## Overview

This guide walks you through setting up automated PDF generation from your INVOICEFORGE invoices.

**What it does:**
1. Watches your INVOICEFORGE Invoices database
2. When status changes to "Sent" → triggers automation
3. Pulls invoice data + line items + client info
4. Generates PDF using Google Docs template
5. Saves PDF back to your Notion invoice

**Time:** 15 minutes  
**Cost:** $0 (Make free tier: 1,000 ops/month)

---

## Prerequisites

- Make.com account (free): https://make.com
- Google account (for Docs): https://docs.new
- Your INVOICEFORGE Notion template (already set up)

---

## Step 1: Create Google Doc Template (5 min)

1. Go to https://docs.new
2. Create your invoice layout:

```
INVOICE {{invoice_number}}

FROM:
[Your Name/Company]
[Your Address]
[Your Email]

BILL TO:
{{client_name}}
{{client_address}}
{{client_email}}

Date: {{issue_date}}
Due Date: {{due_date}}

| Description | Hours | Rate | Amount |
|-------------|-------|------|--------|
{{#each line_items}}
| {{task_description}} | {{hours}} | ${{hourly_rate}} | ${{amount}} |
{{/each}}

Subtotal: ${{subtotal}}
Tax ({{tax_percent}}%): ${{tax_amount}}
Total Due: ${{total}}

Thank you for your business!
```

3. Style it (fonts, colors, your logo)
4. File → Save as "INVOICEFORGE Template"
5. Note the Document ID from URL: `https://docs.google.com/document/d/DOCUMENT_ID/edit`

---

## Step 2: Import Make Scenario (2 min)

**Option A: Import JSON (Recommended)**

1. Download `INVOICEFORGE-PDF-Generator.json` from this package
2. In Make.com: Scenarios → Import Blueprint
3. Upload the JSON file
4. Scenario appears in your workspace

**Option B: Build Manually**

Follow the module-by-module guide below.

---

## Step 3: Configure Notion Connection (3 min)

1. In Make scenario, click the first Notion module
2. Click "Add" → "Create a connection"
3. Name: "INVOICEFORGE Notion"
4. Paste your Notion API token
   - Get from: https://www.notion.so/my-integrations → "View" → "Internal Integration Token"
5. Click "Save"
6. Select your INVOICEFORGE Invoices database

**Find your database IDs:**
- Open database in Notion
- Look at URL: `https://www.notion.so/DB_ID?v=...`
- Copy the DB_ID part

---

## Step 4: Configure Google Docs (3 min)

1. In Make scenario, click Google Docs module
2. Click "Add" → "Create a connection"
3. Sign in with Google
4. Grant permissions for Google Docs
5. In the module, paste your Template Document ID (from Step 1)

---

## Step 5: Map Data Fields (2 min)

In the Google Docs module, map these fields:

| Merge Tag | Source |
|-----------|--------|
| `{{invoice_number}}` | Invoice # → title |
| `{{client_name}}` | Client → Name |
| `{{client_email}}` | Client → Contact Email |
| `{{client_address}}` | Client → Address |
| `{{issue_date}}` | Invoice → Issue Date |
| `{{due_date}}` | Invoice → Due Date |
| `{{subtotal}}` | Invoice → Amount |
| `{{tax_percent}}` | Invoice → Tax Percent |
| `{{tax_amount}}` | Invoice → Tax (formula) |
| `{{total}}` | Invoice → Total (formula) |
| `{{line_items}}` | Work Log → Query results |

---

## Step 6: Test (5 min)

1. Turn on scenario (toggle in Make)
2. In Notion, create or open an invoice
3. Add line items via Work Log relations
4. Set Tax Percent (e.g., 8)
5. Change Status to "Sent"
6. Wait 10-30 seconds
7. Check Notion → PDF files property should show generated PDF
8. Success!

---

## Troubleshooting

**PDF not appearing:**
- Check Make.com execution log (click "Run once")
- Verify Notion database IDs are correct
- Ensure template merge tags match exactly

**Wrong data in PDF:**
- Check field mappings in Google Docs module
- Verify Work Log entries are linked to invoice
- Make sure client is linked to invoice

**Scenario not triggering:**
- Status must EXACTLY match "Sent" (case sensitive)
- Scenario must be toggled ON
- Database must be shared with integration

---

## Optional: Add Email Sending

Add these modules after Step 6:

7. **Gmail → Send Email**
   - To: {{client_email}}
   - Subject: "Invoice {{invoice_number}} - Due {{due_date}}"
   - Attach PDF from step 6

8. **Notion → Update Page**
   - Set "Emailed" checkbox = true

---

## Monthly Usage

Make free tier: 1,000 operations/month
- Each invoice = ~7 operations
- **~140 invoices/month free**

If you need more: Make Core plan ($9/month) = 10,000 ops

---

## Support

Questions? Email: rookbuilds24@grr.la

---

**You're now generating PDFs automatically from Notion!**
