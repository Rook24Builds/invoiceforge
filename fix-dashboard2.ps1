# Fix Dashboard - NO emojis to avoid encoding issues
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
        Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$($block.id)" -Headers $h -Method DELETE | Out-Null
    }
}

# Welcome
$json = '{"children":[{"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Your INVOICEFORGE Dashboard. Track revenue, outstanding invoices, and overdue payments."}}],"color":"blue_background"}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
Write-Host "Welcome added"

# Metrics heading
$json = '{"children":[{"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Key Metrics"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

# Revenue
$json = '{"children":[{"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Revenue: View Invoices database with Paid filter"}}],"color":"green_background"}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

# Outstanding
$json = '{"children":[{"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Outstanding: Check Sent invoices"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

# Overdue
$json = '{"children":[{"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Overdue: Filter Invoices by Overdue status"}}],"color":"red_background"}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

# Divider
$json = '{"children":[{"object":"block","type":"divider","divider":{}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

# Quick Links
$json = '{"children":[{"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Quick Links"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

# Bullets
$json = '{"children":[{"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Clients - Manage your clients"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Projects - Track active work"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Work Log - Log your hours"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Invoices - Create and send"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

Write-Host "DASHBOARD REBUILT"
