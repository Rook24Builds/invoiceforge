$token = Get-Content "$env:USERPROFILE/.config/notion/api_key"
$h = @{
    Authorization = "Bearer $token"
    "Notion-Version" = "2022-06-28"
    "Content-Type" = "application/json"
}

$pageId = "31365823-28c7-819f-a898-d10fd5f56aed"

# Clear and rebuild in correct order
Write-Host "Clearing Dashboard..."
$blocks = Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h
foreach ($block in $blocks.results) {
    try { Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$($block.id)" -Headers $h -Method DELETE | Out-Null } catch {}
}

Write-Host "Rebuilding with enhancements..."

# IMPORTANT: No emojis in JSON - use ASCII only
$body = @'
{"children":[
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Your INVOICEFORGE Command Center. Track revenue, invoices, and payments."}}],"color":"blue_background"}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"$4,850 Total Revenue | $0 Outstanding | $0 Overdue | 3 Active Projects"},"annotations":{"bold":true}}],"color":"green_background"}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Quick Start"}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Add hours in Work Log. Select an Active project and log your work today."}}],"color":"purple_background"}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Quick Links"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Clients "},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":"- Manage customers"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Projects "},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":"- Track work"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Work Log "},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":"- Log hours"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Invoices "},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":"- Create and send"}}]}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Key Metrics"}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Revenue: Filter Invoices by Status = Paid. Sum Total column for income."}}],"color":"green_background"}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Outstanding: Filter Status = Sent. See money waiting for payment."}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Overdue: Filter Status = Overdue. Needs immediate attention."}}],"color":"red_background"}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Drafts: Invoices not yet sent. Review before sending."}}],"color":"gray_background"}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Live Data Views"}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Click below to view databases. Use filters to see specific data."}}],"color":"blue_background"}},
    {"object":"block","type":"heading_3","heading_3":{"rich_text":[{"type":"text","text":{"content":"View Clients Database"}}]}},
    {"object":"block","type":"heading_3","heading_3":{"rich_text":[{"type":"text","text":{"content":"View Projects Database"}}]}},
    {"object":"block","type":"heading_3","heading_3":{"rich_text":[{"type":"text","text":{"content":"View Work Log Database"}}]}},
    {"object":"block","type":"heading_3","heading_3":{"rich_text":[{"type":"text","text":{"content":"View Invoices Database"}}]}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Sample Data Walkthrough"}}]}},
    {"object":"block","type":"toggle","toggle":{"rich_text":[{"type":"text","text":{"content":"How to Use the Sample Data (Click to Expand)"},"annotations":{"bold":true}}],"children":[
        {"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"This template includes sample data to help you learn the system:"},"annotations":{"bold":true}}]}},
        {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"5 Sample Clients"},"annotations":{"bold":true}},{"type":"text","text":{"content":" - Manage client information for Acme Corp, Global Tech, etc."}}]}},
        {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"8 Sample Projects"},"annotations":{"bold":true}},{"type":"text","text":{"content":" - Mix of Active, Completed, and On Hold statuses"}}]}},
        {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"10 Sample Invoices"},"annotations":{"bold":true}},{"type":"text","text":{"content":" - Examples of Paid, Sent, Draft, and Overdue states"}}]}},
        {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"3 Work Log Entries"},"annotations":{"bold":true}},{"type":"text","text":{"content":" - Tasks linked to Website Redesign project"}}]}},
        {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Pro Tip: Browse the sample data to understand how everything connects. Then delete samples and add your own!"}}],"color":"blue_background"}}
    ]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Ready to start? Delete the sample entries and add your first client!"}}],"color":"green_background"}}
]}
'@

$result = Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $body
Write-Host "DONE - Dashboard rebuilt with enhancements"
Write-Host "Added $($result.results.Count) blocks"
