$token = Get-Content "$env:USERPROFILE/.config/notion/api_key"
$h = @{
    Authorization = "Bearer $token"
    "Notion-Version" = "2022-06-28"
    "Content-Type" = "application/json"
}

$pageId = "31365823-28c7-819f-a898-d10fd5f56aed"

# Clear blocks
$blocks = Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h
Write-Host "Clearing $($blocks.results.Count) existing blocks..."
foreach ($block in $blocks.results) {
    try { Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$($block.id)" -Headers $h -Method DELETE | Out-Null } catch {}
}

$projectsDb = "31365823-28c7-8139-9ae7-f997be5a661b"
$invoicesDb = "31365823-28c7-81f1-a8e1-de27706822c6"
$worklogDb = "31465823-28c7-81e8-bf20-ddcb317c2af0"

$body = @'
{"children":[
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Your INVOICEFORGE Command Center. Track revenue, invoices, and payments in one place."}}],"color":"blue_background"}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Quick Links"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Clients"},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":" - Manage customers"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Projects"},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":" - Track work"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Work Log"},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":" - Log hours"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Invoices"},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":" - Create and send"}}]}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Key Metrics"}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Revenue: Open Invoices, filter Status = Paid, sum Total column"}}],"color":"green_background"}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Outstanding: Filter Invoices by Status = Sent to see money waiting"}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Overdue: Filter Status = Overdue - needs immediate attention"}}],"color":"red_background"}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Active Projects: Go to Projects, filter Status = Active"}}],"color":"purple_background"}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"How to Create Custom Views"}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Step-by-step guides for creating filtered views:"}}],"color":"blue_background"}},
    {"object":"block","type":"heading_3","heading_3":{"rich_text":[{"type":"text","text":{"content":"View 1: Paid Invoices"}}]}},
    {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Open the Invoices database"}}]}},
    {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click the Filter button (funnel icon)"}}]}},
    {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Add filter: Status equals Paid"}}]}},
    {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Sum the Total column for total revenue"}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Save this view as Paid Invoice Report"}}],"color":"green_background"}},
    {"object":"block","type":"heading_3","heading_3":{"rich_text":[{"type":"text","text":{"content":"View 2: Outstanding Payments"}}]}},
    {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Open the Invoices database"}}]}},
    {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click the Filter button"}}]}},
    {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Add filter: Status equals Sent"}}]}},
    {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Sum Total to see money waiting to be collected"}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Save view as Outstanding Payments"}}],"color":"yellow_background"}},
    {"object":"block","type":"heading_3","heading_3":{"rich_text":[{"type":"text","text":{"content":"View 3: Overdue Invoices"}}]}},
    {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Open Invoices database"}}]}},
    {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Add filter: Status equals Overdue"}}]}},
    {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Add filter: Due Date is before Today"}}]}},
    {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Sort by Due Date ascending (oldest first)"}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Save view as Overdue - Action Required"}}],"color":"red_background"}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Quick Start"}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Add hours in Work Log today. Select an Active project and log your work. The template includes sample data to help you learn the system."}}],"color":"purple_background"}}
]}
'}

$result = Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $body
Write-Host "Dashboard rebuilt - $($result.results.Count) blocks"
