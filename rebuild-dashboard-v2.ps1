# Quick Dashboard rebuild
$token = Get-Content "$env:USERPROFILE/.config/notion/api_key" -ErrorAction SilentlyContinue
if (-not $token) { $token = $env:NOTION_API_KEY }
$h = @{
    Authorization = "Bearer $token"
    "Notion-Version" = "2022-06-28"
    "Content-Type" = "application/json"
}

$pageId = "31365823-28c7-819f-a898-d10fd5f56aed"
$projectsDb = "31365823-28c7-8139-9ae7-f997be5a661b"  
$invoicesDb = "31365823-28c7-81f1-a8e1-de27706822c6"
$worklogDb = "31465823-28c7-81e8-bf20-ddcb317c2af0"

# Get and delete blocks
$blocks = Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h
Write-Host "Found $($blocks.results.Count) blocks"

foreach ($block in $blocks.results) {
    try {
        Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$($block.id)" -Headers $h -Method DELETE | Out-Null
    } catch {}
}

# Build new content - clean and simple with inline database links
$jsonBody = @"
{"children":[
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Your INVOICEFORGE Command Center. Track revenue, invoices, and payments."}}],"color":"blue_background","icon":{"type":"emoji","emoji":"📊"}}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Quick Links"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Clients"},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":" - Manage customers"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Projects"},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":" - Track work"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Work Log"},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":" - Log hours"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Invoices"},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":" - Create and send"}}]}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Live Database Views"}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Below are live database views. Click to see all data and apply filters."}}],"color":"blue_background","icon":{"type":"emoji","emoji":"💡"}}},
    {"object":"block","type":"heading_3","heading_3":{"rich_text":[{"type":"text","text":{"content":"Active Projects"}}]}},
    {"object":"block","type":"link_to_page","link_to_page":{"type":"database_id","database_id":"$projectsDb"}},
    {"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Tip: Filter by Status = Active to see current workload"},"annotations":{"italic":true,"color":"gray"}}]}},
    {"object":"block","type":"heading_3","heading_3":{"rich_text":[{"type":"text","text":{"content":"Recent Invoices"}}]}},
    {"object":"block","type":"link_to_page","link_to_page":{"type":"database_id","database_id":"$invoicesDb"}},
    {"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Tip: Filter by Status for Paid, Sent, Overdue views"},"annotations":{"italic":true,"color":"gray"}}]}},
    {"object":"block","type":"heading_3","heading_3":{"rich_text":[{"type":"text","text":{"content":"Work Log Entries"}}]}},
    {"object":"block","type":"link_to_page","link_to_page":{"type":"database_id","database_id":"$worklogDb"}},
    {"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Tip: See all logged hours by project"},"annotations":{"italic":true,"color":"gray"}}]}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Quick Start"}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Add hours in Work Log today. Select a project and log what you worked on."}}],"color":"purple_background","icon":{"type":"emoji","emoji":"🚀"}}}
]}
"@

$result = Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $jsonBody
Write-Host "Done"
