$token = Get-Content "$env:USERPROFILE/.config/notion/api_key"
$h = @{
    Authorization = "Bearer $token"
    "Notion-Version" = "2022-06-28"  
    "Content-Type" = "application/json"
}

$pageId = "31365823-28c7-819f-a898-d10fd5f56aed"

# Test with just link_to_page
$body = @'
{"children":[
    {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Your INVOICEFORGE Command Center"}}],"color":"blue_background"}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Quick Links"}}]}},
    {"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Clients "},"annotations":{"bold":true,"color":"blue"}},{"type":"text","text":{"content":"- Manage customers"}}]}},
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Embedded Databases"}}]}},
    {"object":"block","type":"link_to_page","link_to_page":{"type":"database_id","database_id":"31365823-28c7-8139-9ae7-f997be5a661b"}}
]}
'@

$result = Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $body
Write-Host "Success - added $($result.results.Count) blocks"
