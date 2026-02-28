# Rebuild Dashboard with embedded views in CORRECT order
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

Write-Host "Rebuilding with embedded database views..."

# Database IDs
$clientsDb = "31365823-28c7-813c-84cb-eaaa695284ed"
$projectsDb = "31365823-28c7-8139-9ae7-f997be5a661b"
$worklogDb = "31465823-28c7-81e8-bf20-ddcb317c2af0"
$invoicesDb = "31365823-28c7-81f1-a8e1-de27706822c6"

# Build entire page in correct order with embedded views
$body = @"
{"children":[
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Your INVOICEFORGE Command Center. Track revenue, invoices, and payments in one place."}}],"color":"blue_background"}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Quick Links"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Clients "},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":"- Manage customers"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Projects "},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":"- Track work"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Work Log "},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":"- Log hours"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Invoices "},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":"- Create and send"}}]}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Key Metrics"}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Revenue: Filter Invoices by Status = Paid. Shows total income."}}],"color":"green_background"}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Outstanding: Filter by Status = Sent. Invoices waiting for payment."}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Overdue: Filter by Status = Overdue. Needs immediate attention."}}],"color":"red_background"}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Drafts: Invoices not yet sent. Review before sending."}}],"color":"gray_background"}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Live Views"}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"These embedded views update automatically. Click any row to see details."}}],"color":"blue_background"}},
    {"object":"block","type":"link_to_page","link_to_page":{"type":"database_id","database_id":"$projectsDb"}},
    {"object":"block","type":"link_to_page","link_to_page":{"type":"database_id","database_id":"$invoicesDb"}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Active Work"}}]}},
    {"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Projects with Status = Active are your current work. Log hours to track billable time."}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Quick Start: Add hours in Work Log today. Select Active project and log what you did."}}],"color":"purple_background"}}
]}
"@

Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $body | Out-Null
Write-Host "DONE - Dashboard rebuilt with embedded views"
