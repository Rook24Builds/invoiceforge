# Create Rook24Ops Databases (Safe Script)
# DO NOT COMMIT THIS FILE TO GIT

$token = $env:NOTION_API_KEY  # Set before running
if (-not $token) {
    Write-Error "Set `$env:NOTION_API_KEY first"
    exit 1
}

$parentPage = "31465823-28c7-8080-a363-e5def3eababd"  # Rook24Ops
$h = @{
    Authorization = "Bearer $token"
    "Notion-Version" = "2022-06-28"
    "Content-Type" = "application/json"
}

# 1. Products Database
$body = @{
    parent = @{ page_id = $parentPage }
    title = @(@{ text = @{ content = "📊 Products" } })
    is_inline = $true
    properties = @{
        Name = @{ title = @{} }
        Status = @{ select = @{ options = @(
            @{ name = "Live"; color = "green" }
            @{ name = "Building"; color = "yellow" }
            @{ name = "Idea"; color = "gray" }
            @{ name = "Archived"; color = "red" }
        )}}
        Price = @{ number = @{ format = "dollar" } }
        "Gumroad URL" = @{ url = @{} }
        "GitHub Repo" = @{ url = @{} }
        "Notion Template" = @{ url = @{} }
        Sales = @{ number = @{ format = "number" } }
        Revenue = @{ number = @{ format = "dollar" } }
        "Last Update" = @{ date = @{} }
    }
} | ConvertTo-Json -Depth 5

try {
    $productsDb = Invoke-RestMethod -Uri "https://api.notion.com/v1/databases" -Method POST -Headers $h -Body $body
    Write-Host "✓ Created Products DB: $($productsDb.id)"
} catch {
    Write-Error "Failed to create Products DB: $($_.Exception.Message)"
}

# 2. Social Accounts Database
$body = @{
    parent = @{ page_id = $parentPage }
    title = @(@{ text = @{ content = "🐦 Social Accounts" } })
    is_inline = $true
    properties = @{
        Platform = @{ title = @{} }
        Handle = @{ rich_text = @{} }
        URL = @{ url = @{} }
        Status = @{ select = @{ options = @(
            @{ name = "Active"; color = "green" }
            @{ name = "Setup"; color = "yellow" }
            @{ name = "Needs Work"; color = "red" }
        )}}
        Followers = @{ number = @{ format = "number" } }
        Bio = @{ rich_text = @{} }
        Password = @{ rich_text = @{} }
        "Last Post" = @{ date = @{} }
    }
} | ConvertTo-Json -Depth 5

try {
    $socialDb = Invoke-RestMethod -Uri "https://api.notion.com/v1/databases" -Method POST -Headers $h -Body $body
    Write-Host "✓ Created Social Accounts DB: $($socialDb.id)"
} catch {
    Write-Error "Failed to create Social DB: $($_.Exception.Message)"
}

# 3. Content Calendar Database (with Calendar view)
$body = @{
    parent = @{ page_id = $parentPage }
    title = @(@{ text = @{ content = "🗓️ Content Calendar" } })
    is_inline = $true
    properties = @{
        Date = @{ date = @{ } }
        Topic = @{ title = @{} }
        Platform = @{ relation = @{ database_id = $socialDb.id } }
        "Content Type" = @{ select = @{ options = @(
            @{ name = "Launch"; color = "red" }
            @{ name = "Tips"; color = "blue" }
            @{ name = "BTS"; color = "purple" }
            @{ name = "Update"; color = "green" }
            @{ name = "Value Comment"; color = "gray" }
        )}}
        Status = @{ select = @{ options = @(
            @{ name = "Idea"; color = "gray" }
            @{ name = "Ready"; color = "yellow" }
            @{ name = "Scheduled"; color = "blue" }
            @{ name = "Posted"; color = "green" }
        )}}
        Engagement = @{ number = @{ format = "number" } }
        Notes = @{ rich_text = @{} }
    }
} | ConvertTo-Json -Depth 5

try {
    $calendarDb = Invoke-RestMethod -Uri "https://api.notion.com/v1/databases" -Method POST -Headers $h -Body $body
    Write-Host "✓ Created Content Calendar DB: $($calendarDb.id)"
} catch {
    Write-Error "Failed to create Calendar DB: $($_.Exception.Message)"
}

Write-Host "`n🎉 Rook24Ops databases created!"
Write-Host "Go to https://www.notion.so/ROOK24OPS-3146582328c78080a363e5def3eababd to view"
