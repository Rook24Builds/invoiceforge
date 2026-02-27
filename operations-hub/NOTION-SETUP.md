# Rook24Ops Notion Setup Guide

**Page Link:** https://www.notion.so/ROOK24OPS-3146582328c78080a363e5def3eababd

---

## Step 1: Add Database - 📊 Products

**Type:** Inline Database

**Columns:**
| Property | Type | Options |
|----------|------|---------|
| Name | Title | - |
| Status | Select | Live 🟢, Building 🟡, Idea ⚪, Archived 🔴 |
| Price | Number | Dollar $ |
| Gumroad URL | URL | - |
| GitHub Repo | URL | - |
| Notion Template | URL | - |
| Sales | Number | Number |
| Revenue | Number | Dollar $ |
| Last Update | Date | - |

**Add First Row:**
```
Name: INVOICEFORGE
Status: Live 🟢
Price: $19
Gumroad: https://rook24.gumroad.com/l/invoiceforge
GitHub: https://github.com/Rook24Builds/invoiceforge
Notion: https://www.notion.so/INVOICEFORGE-3136582328c781a19132d659caf58fd7?source=copy_link
Sales: 0
Revenue: $0
Last Update: Today
```

---

## Step 2: Add Database - 🐦 Social Accounts

**Type:** Inline Database

**Columns:**
| Property | Type | Options |
|----------|------|---------|
| Platform | Title | - |
| Handle | Text | - |
| URL | URL | - |
| Status | Select | Active 🟢, Setup 🟡, Needs Work 🔴 |
| Followers | Number | Number |
| Bio | Text | - |
| Password | Text | (hint/reference) |
| Last Post | Date | - |

**Add Rows:**
```
Platform: X/Twitter
Handle: @Rook24Builds
URL: https://twitter.com/Rook24Builds
Status: Active 🟢
Followers: 0
Bio: Building digital products in 24h. Current: INVOICEFORGE
Password: [in vault]
Last Post: Never

Platform: LinkedIn
Handle: Rook24Builds
URL: https://linkedin.com/company/rook24builds
Status: Setup 🟡
Followers: 0
Bio: 
Password: [in vault]
Last Post: Never

Platform: Indie Hackers
Handle: @Rook24Builds
URL: https://indiehackers.com/Rook24Builds
Status: Active 🟢
Followers: 1
Bio: Building in public | 24h product launches
Password: [same as twitter]
Last Post: 2026-02-26

Platform: Reddit
Handle: u/Rook24Builds
URL: 
Status: Setup 🟡
Followers: 0
Bio: 
Password: [in vault]
Last Post: Never

Platform: GitHub
Handle: Rook24Builds
URL: https://github.com/Rook24Builds
Status: Active 🟢
Followers: 0
Bio: Building digital products
Password: [in vault]
Last Post: Today
```

---

## Step 3: Add Database - 🗓️ Content Calendar

**Type:** Inline Database (Calendar View + Table View)

**Columns:**
| Property | Type | Options |
|----------|------|---------|
| Date | Date | - |
| Platform | Relation | → Social Accounts |
| Content Type | Select | Launch, Tips, BTS, Update, Value Comment |
| Topic | Title | - |
| Status | Select | Ready ✅, Posted ✅, Scheduled 📅, Idea 💡 |
| Link to File | URL | - |
| Engagement | Number | Number |
| Notes | Text | - |

**Add Rows:**
```
Date: 2026-02-27
Platform: X/Twitter
Content Type: Launch
Topic: INVOICEFORGE Launch Thread
Status: Ready ✅
Link: [local file]
Notes: 5-tweet thread ready

Date: 2026-02-27
Platform: LinkedIn
Content Type: Launch
Topic: INVOICEFORGE Professional Launch
Status: Ready ✅
Link: [local file]
Notes: ROI-focused messaging

Date: 2026-02-27
Platform: Reddit
Content Type: Value Comment
Topic: r/freelance invoice tips
Status: Ready ✅
Link: [local file]
Notes: 3 comments, subtle mentions

Date: 2026-02-28
Platform: Indie Hackers
Content Type: Update
Topic: 24h Build Complete Story
Status: Ready ✅
Link: [local file]
Notes: Pivot story, transparency

Date: 2026-02-28
Platform: X/Twitter
Content Type: BTS
Topic: Build process screenshots
Status: Idea 💡
Notes: Notion DB structure

Date: 2026-03-01
Platform: LinkedIn
Content Type: Tips
Topic: Freelance automation tools
Status: Idea 💡
Notes: 5 tools every freelancer needs
```

---

## Step 4: Add Section - 💰 Sales Dashboard

**Type:** Callout or Simple Table

```
Total Revenue: $0
Total Sales: 0
Conversion Rate: N/A
Best Channel: TBD
Avg Time to First Sale: TBD
```

---

## Step 5: Add Section - 🔗 Quick Links

**Type:** Toggle List

**INVOICEFORGE Toggle:**
- Gumroad: https://rook24.gumroad.com/l/invoiceforge
- GitHub: https://github.com/Rook24Builds/invoiceforge
- GitHub Pages: https://rook24builds.github.io/invoiceforge/
- Notion Template: https://www.notion.so/INVOICEFORGE-3136582328c781a19132d659caf58fd7?source=copy_link

**Operations Toggle:**
- GitHub Workspace: https://github.com/Rook24Builds/workspace
- Gumroad Dashboard: https://gumroad.com/dashboard
- Notion: https://www.notion.so/Rook24Bbuilds-3146582328c7800cb58ad2f7490657e6

---

## Step 6: Add Section - 📝 Notes & Ideas

**Type:** Simple bullet list

- [ ] Next product idea: Client Onboarding System
- [ ] Marketing test: A/B test Twitter hooks
- [ ] Improvement: Add dashboard to INVOICEFORGE
- [ ] Channel to test: YouTube Shorts for build recaps

---

## Step 7: Add Section - 🛠️ Tools & Access

**Type:** Simple Table

| Tool | Account | Status | Notes |
|------|---------|--------|-------|
| Gumroad | rook24 | ✅ Active | Main revenue |
| GitHub | Rook24Builds | ✅ Active | Code repos |
| Notion | Rook24Bbuilds | ✅ Active | Templates |
| X/Twitter | @Rook24Builds | ✅ Active | Main social |
| LinkedIn | Rook24Builds | 🟡 Setup | Company page |
| Indie Hackers | Rook24Builds | ✅ Active | Building in public |
| Reddit | u/Rook24Builds | 🟡 Setup | Karma building |

---

**Once done, your Rook24Ops is LIVE and ready to use! 🎯**
