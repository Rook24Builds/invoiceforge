# Notion Template: Freelancer Command Center

## 🚀 NEW: Auto Invoice Generator
**Generate invoices directly in Notion** — no more jumping to Canva. Track clients, projects, and create PDF-ready invoices in 60 seconds, all connected.

- Track billable hours vs. rates
- Auto-calculate subtotal, tax, and total
- One-click PDF export
- Everything linked: Client → Project → Invoice

**See `SETUP.md` for the 3-minute setup guide.**

---

## Database Structure

### 1. Clients Database
**Properties:**
- Name (Title)
- Status (Select: Active, Prospective, Paused, Former)
- Industry (Select)
- Contact Email (Email)
- Phone (Phone)
- Notes (Text)
- Projects (Relation → Projects database)
- Invoices (Relation → Invoices database)
- Lifetime Value (Rollup: Sum of invoices)
- Last Contact (Date)

**Views:**
- All Clients (default)
- Active Clients
- Needs Follow-up (Last Contact > 30 days)
- High Value (Lifetime Value > $5000)

### 2. Projects Database
**Properties:**
- Name (Title)
- Client (Relation → Clients)
- Status (Select: Planning, Active, Review, Completed, Cancelled)
- Priority (Select: High, Medium, Low)
- Start Date (Date)
- Due Date (Date)
- Budget (Number)
- Description (Text)
- Tasks (Relation → Tasks database)

**Views:**
- Kanban by Status
- Calendar by Due Date
- Active Projects (Status = Active)
- Due This Week

### 3. Invoices Database
**Properties:**
- Invoice # (Title)
- Client (Relation → Clients)
- Project (Relation → Projects)
- Amount (Number/Currency)
- Issue Date (Date)
- Due Date (Date)
- Status (Select: Draft, Sent, Paid, Overdue, Cancelled)
- Payment Date (Date)
- Notes (Text)

**Views:**
- All Invoices
- Outstanding (Status = Sent)
- Overdue
- Paid (This Month)
- Revenue by Client

### 4. Tasks Database
**Properties:**
- Task (Title)
- Project (Relation → Projects)
- Status (Select: To Do, In Progress, Done)
- Priority (Select)
- Due Date (Date)
- Assignee (Person)

### 5. Dashboard Page
Embedded views:
- Pending invoices total (sum)
- Active projects count
- This week's tasks
- Clients needing follow-up

---

## How to Set Up (for Customer)

1. **Duplicate this template** to your Notion workspace
2. **Add your first client** — click "New" in Clients view
3. **Link projects** to that client
4. **Create invoices** linked to projects
5. **Use Canva templates** to send professional invoices

## Pricing Psychology
Positioning as "system" not "template" — implies ongoing value, not one-time asset.
