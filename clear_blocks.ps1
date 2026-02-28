# Delete all blocks from START HERE page
$pageId = "31365823-28c7-81d5-81cc-de0fecd99b84"
$headers = @{
    "Authorization" = "Bearer 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"
    "Notion-Version" = "2022-06-28"
}

# Get existing blocks
$url = "https://api.notion.com/v1/blocks/$pageId/children"
$response = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 30
$blocks = $response.results
Write-Host "Found $($blocks.Count) blocks to delete"

# Delete each block
$count = 0
foreach ($block in $blocks) {
    $blockId = $block.id
    $deleteUrl = "https://api.notion.com/v1/blocks/$blockId"
    Invoke-RestMethod -Uri $deleteUrl -Headers $headers -Method Delete -TimeoutSec 10 | Out-Null
    $count++
    Write-Host "Deleted $count / $($blocks.Count)"
}
Write-Host "All blocks deleted"
