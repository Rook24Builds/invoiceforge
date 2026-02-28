# 🧾 INVOICEFORGE — Auto-Generating Invoice System

> **From hours worked → invoice sent in 60 seconds**

---

## 📋 Table of Contents

- [What is INVOICEFORGE?](#what-is-invoiceforge)
- [Quick Start (5-Minute Setup)](#-quick-start-5-minute-setup)
- [How to Add Clients](#how-to-add-clients)
- [How to Add Projects](#how-to-add-projects)
- [How to Log Work Hours](#how-to-log-work-hours)
- [How to Generate an Invoice](#how-to-generate-an-invoice)
- [How to Export & Share](#how-to-export--share-your-invoice)
- [Technical Appendix](#-technical-appendix-for-nerds)

---

## What is INVOICEFORGE?

**INVOICEFORGE** is a complete client management system built in Notion where everything is connected: **Clients → Projects → Invoices**. Enter your hours once, get auto-calculated totals, export a PDF in 60 seconds.

### 🎯 The Problem It Solves

**Before INVOICEFORGE:**
1. 📁 Open Notion → Find project hours
2. 📊 Open Sheets → Calculate totals
3. 🎨 Open Canva/Google Docs → Design invoice
4. 📋 Copy-paste client info
5. 🧮 Do math in your head
6. 📤 Export & send
7. **15 minutes wasted. Every. Single. Invoice.**

**With INVOICEFORGE:**
1. ⭐ Click "Invoices" database
2. ➕ Create new invoice
3. 👤 Select client → Auto-links info
4. 📁 Select project → Auto-links work
5. ⏱️ Enter hours → **Rate auto-fills**
6. 💰 **Totals calculate automatically**
7. 📤 **Export PDF → Send**
8. **60 seconds. Done.**

---

## 🚀 Quick Start (5-Minute Setup)

> **Welcome! Let's get you invoicing.**

### Step 1: Duplicate the Template ⭐

1. Click the "Duplicate" button in the top right
2. Choose your Notion workspace
3. Wait 10 seconds for the full import

💡 **Tip:** The template comes pre-loaded with sample data. Don't delete it yet—use it to explore!

---

### Step 2: Explore the Sample Data (2 minutes)

Click around the databases to see how everything connects:

| Database | What to Check |
|----------|---------------|
| **Clients** | 5 sample clients with rates, contact info, status |
| **Projects** | Active projects linked to clients |
| **Invoices** | Auto-calculating totals, linked clients |
| **Time Logs** | Hours tracked per project |

🔍 **Notice:** When you click "Sarah Chen" in an invoice, you see ALL her invoices and projects.

---

### Step 3: Customize for You (2 minutes)

1. Open **Clients** database
2. Delete the sample clients (or keep as reference)
3. Add your first real client: Click **+ New**
4. Fill in at minimum: Name, Email, Rate

✅ **You're ready to invoice!**

---

## How to Add Clients

> 🔔 **Pro Tip:** Set up clients BEFORE you start tracking time. You'll thank yourself later.

### Quick Add:

1. Go to **Clients** database
2. Click **+ New** (top right or bottom of list)
3. Fill these fields:

| Field | Why It Matters | Example |
|-------|----------------|---------|
| **Client Name** | Shows in all dropdowns | "Sarah's Design Co." |
| **Email** | For quick reference | sarah@designco.com |
| **Rate** | **Auto-fills on invoices!** | $150/hr |
| **Payment Terms** | Reminds you when to expect payment | Net 15, Net 30 |
| **Status** | Track active vs prospective clients | Active |

📸 **[Screenshot: Client database view with sample data]**

---

### Client Status Guide:

| Status | Meaning | Action Needed |
|--------|---------|---------------|
| 🟢 **Active** | Currently working together | Track time, bill regularly |
| 🟡 **Prospective** | In talks, not started yet | Follow up, send proposals |
| 🔴 **Paused** | On hold for any reason | Check in monthly |
| ⚫ **Inactive** | Not currently working | Archive, keep for records |

---

## How to Add Projects

Projects link to clients and track your progress. Each project becomes an invoice line item.

### Creating a Project:

1. Go to **Projects** database
2. Click **+ New**
3. Fill in:

| Field | Why It Matters | Example |
|-------|----------------|---------|
| **Project Name** | Shows on invoices | "Website Redesign" |
| **Client** | 🔗 **Links to client DB** | Select from dropdown |
| **Status** | Track your progress | Planning → Active → Review → Completed |
| **Budget** | Track against client estimate | $5,000 |
| **Due Date** | Keeps you on track | Mar 15 |

📸 **[Screenshot: Projects database view]**

---

### Project Status Workflow:

```
Planning → Active → Review → Completed
   ↑_________↓ (can bounce back if revisions)
```

- **Planning:** Proposal accepted, not started
- **Active:** Currently working on it
- **Review:** Delivered, waiting for feedback
- **Completed:** Done, ready to invoice!

> 🔔 **Pro Tip:** Only mark "Completed" when you're 100% done. That's your cue to invoice!

---

## How to Log Work Hours

Track time as you go, or batch at end of day. Either way, time logs connect to projects for easy invoicing.

### Method 1: Quick Time Log (Recommended)

1. Go to **Time Logs** database
2. Click **+ New**
3. Fill:

| Field | How to Use | Example |
|-------|------------|---------|
| **Date** | When you did the work | Today |
| **Project** | 🔗 Links to project | Select from dropdown |
| **Hours** | How long you worked | 3.5 |
| **Description** | What you did | "Homepage wireframes" |
| **Billable?** | Toggle ON/OFF | 💰 ON |

📸 **[Screenshot: Time Log entry form]**

---

### Method 2: Log From Project Page

1. Open a **Project** page
2. Scroll to the bottom
3. Look for "Related Time Logs"
4. Click **+ Add New Time Log**
5. Hours automatically connect to this project

---

### Time Logging Best Practices:

✅ **DO:**
- Log daily or every few days (don't wait 2 weeks!)
- Add descriptions you'll recognize later
- Mark non-billable time separately

❌ **DON'T:**
- Wait until invoice day to remember hours
- Log vague descriptions ("worked on stuff")
- Forget to mark billable time

> 🔔 **Pro Tip:** Log time RIGHT after you finish a task while it's fresh!

---

## How to Generate an Invoice

### The 60-Second Invoice Workflow

**Scenario:** You just finished a project. Time to get paid!

---

### Step-by-Step:

**1. Open Invoices Database**

📁 Click **Invoices** in your sidebar

---

**2. Create New Invoice**

➕ Click **+ New** (top right)

📸 **[Screenshot: New invoice button]**

---

**3. Link Client & Project**

| Field | Action | What Happens |
|-------|--------|--------------|
| **Client** | Select from dropdown | 👤 Client info links automatically |
| **Project** | Select from dropdown | 📁 Project details auto-fill |
| **Rate** | **Auto-fills from client!** | 💰 Uses client's stored rate |

---

**4. Add Invoice Details**

| Field | Your Input | Auto? |
|-------|------------|-------|
| **Invoice #** | INV-001, INV-002... | Manual |
| **Issue Date** | Today | Manual |
| **Due Date** | Today + payment terms | Manual |
| **Status** | Draft | Manual |
| **Hours** | Total billable hours | Manual |
| **Rate** | Your hourly/project rate | ✅ Auto-filled! |
| **Line Items** | Description of work | Manual |

---

**5. Watch the Magic Happen** ✨

| Field | Formula | Result |
|-------|---------|--------|
| **Subtotal** | Hours × Rate | ✅ **Auto-calculated** |
| **Tax** | Subtotal × Tax Rate | ✅ **Auto-calculated** |
| **Total** | Subtotal + Tax | ✅ **Auto-calculated** |

📸 **[Screenshot: Invoice with auto-calculated totals]**

---

**6. Review & Mark Status**

- 🔘 Change **Status** from "Draft" to "Ready to Send"
- 📝 Review all details look correct
- ✅ Check the Total amount

---

## How to Export & Share Your Invoice

### Option A: Quick Notion Export (Fastest)

**Best for:** Urgent invoices, simple formatting

1. Open the invoice you want to export
2. Click **⋯** (three dots, top right)
3. Select **Export**
4. Choose format:
   - **PDF** → Best for emails
   - **Markdown** → For other apps
   - **HTML** → For web

📸 **[Screenshot: Export menu]**

---

**5. Click Export & Download**

📂 Your PDF downloads automatically

---

**6. Send the Invoice**

- 📧 Attach to email
- 💬 Share in client Slack
- ☁️ Upload to shared drive

⚠️ **Remember to mark status "Sent" after sending!**

---

### Option B: Pretty Invoice Template (Best Looking)

**Best for:** First impressions, brand-conscious clients

1. Go to your **Invoice Template** page (pre-built in the template)
2. Click **⋯ → Duplicate**
3. Copy values from your invoice database:
   - Invoice number
   - Client details
   - Line items
   - Totals
4. Customize colors/add logo if desired
5. Export → PDF → Send

---

### Professional Email Template

```
Subject: Invoice [INV-XXX] - [Project Name]

Hi [Client Name],

I hope you're doing well! 

Attached is Invoice [INV-XXX] for [Project Name]. 

Summary:
• Hours: [X]
• Rate: $[X]/hr
• Total: $[X]
• Due Date: [Date]

Payment can be made via [PayPal/Venmo/Bank Transfer].

Please let me know if you have any questions!

Thanks again for the opportunity to work together.

Best,
[Your Name]
```

---

## Invoice Status Workflow

Track your money from creation to payment:

| Status | Meaning | Next Step |
|--------|---------|-----------|
| 📝 **Draft** | Created, not sent yet | Review & send |
| 📤 **Sent** | Sent to client, waiting | Follow up in 1 week |
| ✅ **Paid** | Money received! | Archive |
| ⚠️ **Overdue** | Past due date | Send reminder |

> 🔔 **Pro Tip:** Check your "Sent" invoices weekly. Follow up on anything past due.

---

---

# 🔧 Technical Appendix (For Nerds)

> *Welcome, tinkerers. Here's how the sausage is made.*

---

## Database Architecture

### Four Core Databases

```
┌─────────────────────────────────────────────────────────────┐
│                      INVOICEFORGE SYSTEM                   │
└─────────────────────────────────────────────────────────────┘
                              │
        ┌─────────────┬───────┴───────┬─────────────┐
        ▼             ▼               ▼             ▼
   ┌────────┐    ┌────────┐      ┌────────┐    ┌──────────┐
   │Clients │◄──►│Projects│◄────►│Invoices│    │Time Logs │
   └────┬───┘    └───┬────┘      └──┬─────┘    └────┬─────┘
        │            │              │               │
        └────────────┴──────────────┴───────────────┘
                    (RELATIONS)
```

### Database Relationships

| Database | Relates To | Relationship Type |
|----------|------------|-------------------|
| **Clients** | Projects, Invoices | One-to-Many |
| **Projects** | Clients, Time Logs, Invoices | Many-to-One, Many-to-Many |
| **Invoices** | Clients, Projects | Many-to-One |
| **Time Logs** | Projects | Many-to-One |

---

## Formula Properties Reference

### Invoice Formulas

| Property | Formula | Purpose |
|----------|---------|---------|
| **Subtotal** | `prop("Hours") * prop("Rate")` | Calculates base cost |
| **Tax Amount** | `prop("Subtotal") * prop("Tax Rate")` | Calculates tax |
| **Total** | `prop("Subtotal") + prop("Tax Amount")` | Final amount due |

#### Formula Breakdown:

```
Subtotal:
  prop("Hours")     → References Hours property
  *                   → Multiplication
  prop("Rate")      → References Rate property

Example: Hours: 10 × Rate: $150 = Subtotal: $1,500
```

```
Tax Amount:
  prop("Subtotal")       → Uses calculated subtotal
  * 
  prop("Tax Rate")       → References tax rate (e.g., 0.08)

Example: $1,500 × 0.08 = $120
```

```
Total:
  prop("Subtotal") + prop("Tax Amount")
  
Example: $1,500 + $120 = $1,620
```

---

### Rollup Properties

| Database | Rollup | Purpose |
|----------|--------|---------|
| **Clients** | Total Invoiced | Sums all linked invoice totals |
| **Clients** | Active Projects | Counts non-completed projects |
| **Projects** | Total Hours | Sums hours from linked time logs |
| **Projects** | Latest Update | Shows most recent time log date |

#### Rollup Configuration:

```
Client → Invoices (relation)
         ↓
         Total (rollup)
         → Relation: Invoices
         → Property: Total
         → Calculation: Sum
```

---

## Property Types Used

| Property | Type | Use Case |
|----------|------|----------|
| Name/Title | Title | Primary identifier |
| Status | Select | Workflow tracking |
| Client/Project | Relation | Database linking |
| Rate/Hours/Budget | Number | Calculations |
| Email/Phone | Email/Phone | Contact info |
| Notes | Text | Free-form notes |
| Issue/Due Date | Date | Scheduling |
| Billable? | Checkbox | Time tracking toggle |
| Subtotal/Tax/Total | Formula | Auto-calculation |
| Lifetime Value | Rollup | Aggregated data |

---

## View Configurations

### Recommended Views

**Invoices Database:**
```
1. All Invoices (Table view - default)
2. By Status (Board view - grouped by Status)
3. Overdue (Table view - filtered: Status = Overdue)
4. This Month (Table view - filtered: Issue Date = This Month)
5. Paid (Table view - filtered: Status = Paid)
```

**Projects Database:**
```
1. All Projects (Table view)
2. By Status (Board view - grouped by Status)
3. Active Only (Table view - filtered: Status = Active)
4. Due This Week (Timeline view - filtered: Due Date < 7 days)
```

---

## Database Schema (JSON)

```json
{
  "databases": [
    {
      "name": "Clients",
      "properties": [
        { "name": "Name", "type": "title" },
        { "name": "Status", "type": "select", "options": ["Active", "Prospective", "Paused", "Inactive"] },
        { "name": "Industry", "type": "select" },
        { "name": "Email", "type": "email" },
        { "name": "Rate", "type": "number", "format": "dollar" },
        { "name": "Payment Terms", "type": "select", "options": ["Net 7", "Net 15", "Net 30", "Net 45"] },
        { "name": "Projects", "type": "relation", "database": "Projects" },
        { "name": "Invoices", "type": "relation", "database": "Invoices" },
        { "name": "Lifetime Value", "type": "rollup", "relation": "Invoices", "function": "sum" }
      ]
    },
    {
      "name": "Projects",
      "properties": [
        { "name": "Name", "type": "title" },
        { "name": "Client", "type": "relation", "database": "Clients" },
        { "name": "Status", "type": "select", "options": ["Planning", "Active", "Review", "Completed"] },
        { "name": "Budget", "type": "number", "format": "dollar" },
        { "name": "Due Date", "type": "date" },
        { "name": "Time Logs", "type": "relation", "database": "Time Logs" },
        { "name": "Total Hours", "type": "rollup", "relation": "Time Logs", "function": "sum" }
      ]
    },
    {
      "name": "Invoices",
      "properties": [
        { "name": "Invoice #", "type": "title" },
        { "name": "Client", "type": "relation", "database": "Clients" },
        { "name": "Project", "type": "relation", "database": "Projects" },
        { "name": "Status", "type": "select", "options": ["Draft", "Sent", "Paid", "Overdue"] },
        { "name": "Issue Date", "type": "date" },
        { "name": "Due Date", "type": "date" },
        { "name": "Hours", "type": "number" },
        { "name": "Rate", "type": "number", "format": "dollar" },
        { "name": "Subtotal", "type": "formula", "expression": "prop(\"Hours\") * prop(\"Rate\")" },
        { "name": "Tax Rate", "type": "number", "format": "percent" },
        { "name": "Tax Amount", "type": "formula", "expression": "prop(\"Subtotal\") * prop(\"Tax Rate\")" },
        { "name": "Total", "type": "formula", "expression": "prop(\"Subtotal\") + prop(\"Tax Amount\")" }
      ]
    },
    {
      "name": "Time Logs",
      "properties": [
        { "name": "Date", "type": "date" },
        { "name": "Project", "type": "relation", "database": "Projects" },
        { "name": "Hours", "type": "number" },
        { "name": "Description", "type": "text" },
        { "name": "Billable", "type": "checkbox" }
      ]
    }
  ]
}
```

---

## Customization Ideas

**Want to extend INVOICEFORGE?**

| Modification | How To | Difficulty |
|--------------|--------|------------|
| Add expenses | New database: "Expenses", link to Projects | Easy |
| Track proposals | Add "Proposals" database, add "Proposal" status to Projects | Easy |
| Client portal view | Create linked view, share with client | Medium |
| Payment tracking | Add "Payment Date", "Payment Method" properties | Easy |
| Recurring invoices | Use Notion's duplicate + templates | Easy |
| Multi-currency | Add "Currency" select, adjust formulas | Advanced |

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Totals not calculating | Check that Hours and Rate are number type, not text |
| Client doesn't appear in dropdown | Make sure client is added to Clients database |
| Rate not auto-filling | Ensure Rate property exists on Client, and relation is set |
| Export looks weird | Try Markdown export, or use the Invoice Template page |
| Formulas broken | Don't modify formula syntax—copy exactly as provided |

---

## Files & Assets

```
operations-hub/
└── content/
    ├── invoiceforge-readme.md        ← You are here
    ├── notion-template/
    │   ├── database-schema.json     ← Full schema
    │   ├── INVOICE-GENERATOR.md     ← Detailed workflow
    │   ├── SAMPLE-DATA.md           ← Sample data reference
    │   └── SETUP.md                 ← Quick setup guide
    └── canva-invoices/
        └── templates/               ← Canva invoice templates

```

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| v1.0.0 | 2024-XX-XX | Initial release with 4 core databases |

---

**Built with ♜ by INVOICEFORGE**

*Strategy + Execution. Fast.*

---

**Questions?** Open an issue or email support.

**Found this helpful?** Share it with a freelancer friend!
