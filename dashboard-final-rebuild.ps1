$token = Get-Content "$env:USERPROFILE/.config/notion/api_key"
$h = @{
    Authorization = "Bearer $token"
    "Notion-Version" = "2022-06-28"
    "Content-Type" = "application/json"
}

$pageId = "31365823-28c7-819f-a898-d10fd5f56aed"

# Clear existing blocks first
$blocks = Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h
foreach ($block in $blocks.results) {
    try {
        Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$($block.id)" -Headers $h -Method DELETE | Out-Null
    } catch {}
}

Write-Host "Building complete Dashboard..."

$body = @'
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
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Revenue: Filter Invoices by Status = Paid. Sum the Total column for total income earned."}}],"color":"green_background"}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Outstanding: Filter by Status = Sent. These are invoices waiting for payment."}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Overdue: Filter by Status = Overdue. Needs immediate attention."}}],"color":"red_background"}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Drafts: Invoices not yet sent. Review before sending to clients."}}],"color":"gray_background"}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Live Database Views"}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Below are linked database views. Click to open and apply filters."}}],"color":"blue_background"}},
    {"object":"block","type":"heading_3","heading_3":{"rich_text":[{"type":"text","text":{"content":"Active Projects"}}]}},
    {"object":"block","type":"link_to_page","link_to_page":{"type":"database_id","database_id":"31365823-28c7-8139-9ae7-f997be5a661b"}},
    {"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Filter by Status = Active to see current workload"},"annotations":{"italic":true,"color":"gray"}}]}},
    {"object":"block","type":"heading_3","heading_3":{"rich_text":[{"type":"text","text":{"content":"Recent Invoices"}}]}},
    {"object":"block","type":"link_to_page","link_to_page":{"type":"database_id","database_id":"31365823-28c7-81f1-a8e1-de27706822c6"}},
    {"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Filter by Status (Paid, Sent, Overdue) to see specific views"},"annotations":{"italic":true,"color":"gray"}}]}},
    {"object":"block","type":"heading_3","heading_3":{"rich_text":[{"type":"text","text":{"content":"Work Log"}}]}},
    {"object":"block","type":"link_to_page","link_to_page":{"type":"database_id","database_id":"31465823-28c7-81e8-bf20-ddcb317c2af0"}},
    {"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"All logged hours grouped by project"},"annotations":{"italic":true,"color":"gray"}}]}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Quick Start"}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Add hours in Work Log today. Select an Active project and log what you worked on."}}],"color":"purple_background"}}
]}
'@

$result = Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $body
Write-Host "Dashboard complete with $($result.results.Count) blocks"
