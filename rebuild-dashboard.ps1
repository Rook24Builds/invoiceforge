# Rebuild Dashboard in correct order
$token = Get-Content "$env:USERPROFILE/.config/notion/api_key"
$h = @{
    Authorization = "Bearer $token"
    "Notion-Version" = "2022-06-28"
    "Content-Type" = "application/json"
}

$pageId = "31365823-28c7-819f-a898-d10fd5f56aed"

Write-Host "Clearing Dashboard..."
$existing = Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h
foreach ($block in $existing.results) {
    if (-not $block.archived) {
        Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$($block.id)" -Headers $h -Method DELETE -ErrorAction SilentlyContinue | Out-Null
    }
}

Write-Host "Rebuilding in correct order..."

# Database URLs
$clientsUrl = "https://www.notion.so/31365823-28c7-813c-84cb-eaaa695284ed"
$projectsUrl = "https://www.notion.so/31365823-28c7-8139-9ae7-f997be5a661b"
$worklogUrl = "https://www.notion.so/31465823-28c7-81e8-bf20-ddcb317c2af0"
$invoicesUrl = "https://www.notion.so/31365823-28c7-81f1-a8e1-de27706822c6"

# Build entire page in one request - correct order
$body = @"
{"children":[
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Your INVOICEFORGE Command Center. Track revenue, invoices, and payments in one place."}}],"color":"blue_background"}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Quick Links - Jump to Any Database"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Clients "},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":"- Manage your customers"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Projects "},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":"- Track active work"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Work Log "},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":"- Log hours and tasks"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Invoices "},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":"- Create and send invoices"}}]}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Key Metrics"}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Revenue: Filter Invoices by Status = Paid. This shows your total income from completed payments."}}],"color":"green_background"}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Outstanding: Filter by Status = Sent. These are invoices waiting for payment - follow up on these!"}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Overdue: Filter by Status = Overdue. These need immediate attention."}}],"color":"red_background"}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Drafts: Invoices not yet sent. Review these before sending to clients."}}],"color":"gray_background"}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Active Work"}}]}},
    {"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Projects with Status = Active are your current work. Add hours to Work Log to track billable time."}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Quick Start: Add hours in Work Log today. Select your Active project and log what you did."}}],"color":"purple_background"}}
]}
"@

Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $body | Out-Null
Write-Host "DONE - Dashboard rebuilt in correct order"
