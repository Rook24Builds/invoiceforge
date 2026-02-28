# Fix INVOICEFORGE Notion pages
$token = Get-Content "$env:USERPROFILE/.config/notion/api_key"
$h = @{
    Authorization = "Bearer $token"
    "Notion-Version" = "2022-06-28"
    "Content-Type" = "application/json"
}

$pageId = "31365823-28c7-81d5-81cc-de0fecd99b84"

# Clear existing blocks
Write-Host "Clearing START HERE..."
try {
    $existing = Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h
    foreach ($block in $existing.results) {
        if (-not $block.archived) {
            Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$($block.id)" -Headers $h -Method DELETE | Out-Null
        }
    }
    Write-Host "Cleared $($existing.results.Count) blocks"
} catch {}

# Add content using append
$body = @{
    children = @(
        @{
            object = "block"
            type = "callout"
            callout = @{
                rich_text = @(@{ type = "text"; text = @{ content = "Welcome to INVOICEFORGE! Follow these 5 steps to invoice clients in 60 seconds." } })
                icon = @{ type = "emoji"; emoji = "🚀" }
                color = "blue_background"
            }
        }
        @{ object = "block"; type = "divider"; divider = @{} }
        @{ object = "block"; type = "heading_2"; heading_2 = @{ rich_text = @(@{ type = "text"; text = @{ content = "Step 1: Add Your First Client" } }) } }
        @{ object = "block"; type = "numbered_list_item"; numbered_list_item = @{ rich_text = @(@{ type = "text"; text = @{ content = "Click Clients database" } }) } }
        @{ object = "block"; type = "numbered_list_item"; numbered_list_item = @{ rich_text = @(@{ type = "text"; text = @{ content = "Click + New to create a client" } }) } }
        @{ object = "block"; type = "numbered_list_item"; numbered_list_item = @{ rich_text = @(@{ type = "text"; text = @{ content = "Add: Name, Email, Hourly Rate (auto-fills on invoices!)" } }) } }
    )
} | ConvertTo-Json -Depth 10

$response = Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $body
Write-Host "Added content: $($response.results.Count) blocks"
