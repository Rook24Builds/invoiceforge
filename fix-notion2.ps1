# Fix START HERE - Direct JSON approach
$token = Get-Content "$env:USERPROFILE/.config/notion/api_key"
$h = @{
    Authorization = "Bearer $token"
    "Notion-Version" = "2022-06-28"
    "Content-Type" = "application/json"
}

$pageId = "31365823-28c7-81d5-81cc-de0fecd99b84"

# Welcome callout
$json = '{"children":[{"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Welcome to INVOICEFORGE! Follow these 5 steps to invoice clients in 60 seconds."}}],"icon":{"emoji":"🚀","type":"emoji"},"color":"blue_background"}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
Write-Host "✅ Welcome added"

# Divider
$json = '{"children":[{"object":"block","type":"divider","divider":{}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
Write-Host "✅ Divider added"

# Step 1 heading
$json = '{"children":[{"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Step 1: Add Your First Client 👤"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
Write-Host "✅ Step 1 heading added"

# Step 1 items
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click Clients database on this page"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click + New to create a client"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Add: Name, Email, and Hourly Rate (auto-fills on invoices!)"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
Write-Host "✅ Step 1 complete"

# Step 2
$json = '{"children":[{"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Step 2: Create a Project 📋"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click Projects database"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Select your client from dropdown"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
Write-Host "✅ Step 2 complete"

# Step 3
$json = '{"children":[{"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Step 3: Log Your Work Hours ⏱️"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click Work Log database"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Select your Project, add Date, Hours, Task Description"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
Write-Host "✅ Step 3 complete"

# Step 4
$json = '{"children":[{"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Step 4: Create Invoice 💰"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click Invoices database"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Link Client, Project, and Work Log tasks"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Total auto-calculates from linked tasks!"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
Write-Host "✅ Step 4 complete"

# Step 5
$json = '{"children":[{"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Step 5: Export & Send 📤"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Open your invoice"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click 3 dots → Export → PDF"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Email PDF to your client"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
Write-Host "✅ Step 5 complete"

# Pro tip
$json = '{"children":[{"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Pro Tip: Task descriptions become line items on your invoice. Be specific!"}}],"icon":{"emoji":"💡","type":"emoji"}}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

Write-Host "✅ START HERE REBUILT SUCCESSFULLY"
