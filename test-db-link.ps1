$token = Get-Content "$env:USERPROFILE/.config/notion/api_key"
$h = @{
    Authorization = "Bearer $token"
    "Notion-Version" = "2022-06-28"
    "Content-Type" = "application/json"
}

$pageId = "31365823-28c7-819f-a898-d10fd5f56aed"

# Build content - using child_database or inline_database instead of link_to_page
# Notion API can embed databases as blocks
$body = @'
{"children":[
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Your INVOICEFORGE Command Center. Track revenue, invoices, and payments."}}],"color":"blue_background"}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Quick Links"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Clients "},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":"- Manage customers"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Projects "},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":"- Track work"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Work Log "},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":"- Log hours"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Invoices "},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":"- Create and send"}}]}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Live Database Views"}}]}},
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Below are live previews of your databases. Click to see full data and apply filters."}}],"color":"blue_background"}},
    {"object":"block","type":"heading_3","heading_3":{"rich_text":[{"type":"text","text":{"content":"Active Projects"}}]}},
    {"object":"block","type":"link_to_page","link_to_page":{"type":"database_id","database_id":"31365823-28c7-8139-9ae7-f997be5a661b","database_id_str":"31365823-28c7-8139-9ae7-f997be5a661b"}},
    {"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Filter: Status = Active to see current workload"},"annotations":{"italic":true,"color":"gray"}}]}},
    {"object":"block","type":"heading_3","heading_3":{"rich_text":[{"type":"text","text":{"content":"Recent Invoices"}}]}},
    {"object":"block","type":"link_to_page","link_to_page":{"type":"database_id","database_id":"31365823-28c7-81f1-a8e1-de27706822c6"}},
    {"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Filter: Status = Paid, Sent, or Overdue"},"annotations":{"italic":true,"color":"gray"}}]}}
]}
'@

$result = Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $body
Write-Host "Done - $($result.results.Count) blocks added"
