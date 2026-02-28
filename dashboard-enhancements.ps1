$token = Get-Content "$env:USERPROFILE/.config/notion/api_key"
$h = @{
    Authorization = "Bearer $token"
    "Notion-Version" = "2022-06-28"
    "Content-Type" = "application/json"
}

$pageId = "31365823-28c7-819f-a898-d10fd5f56aed"

# We'll insert content after the welcome callout (first block)
# First, let's get current blocks to find insertion point
$blocks = Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h

$welcomeBlockId = $blocks.results[0].id
Write-Host "Found welcome block: $welcomeBlockId"

# Add Financial Stats callout after welcome
$body = @'
{"children":[{"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"$4,850 Total Revenue | $0 Outstanding | $0 Overdue | 3 Active Projects"},"annotations":{"bold":true}}],"color":"green_background"}}]}
'@

Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $body | Out-Null
Write-Host "Added Financial Stats callout"

# Add Sample Data Tutorial toggle at the end
$body2 = @'
{"children":[
    {"object":"block","type":"divider","divider":{}},
    {"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Sample Data Walkthrough"}}]}},
    {"object":"block","type":"toggle","toggle":{"rich_text":[{"type":"text","text":{"content":"How to Use the Sample Data (Click to Expand)"},"annotations":{"bold":true}}],"children":[
        {"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"This template includes sample data to help you understand the system:"},"annotations":{"bold":true}}]}},
        {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"5 Sample Clients"},"annotations":{"bold":true}},{"type":"text","text":{"content":" - See how client information is structured"}}]}},
        {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"8 Sample Projects"},"annotations":{"bold":true}},{"type":"text","text":{"content":" - Mix of Active, Completed, and On Hold statuses"}}]}},
        {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"10 Sample Invoices"},"annotations":{"bold":true}},{"type":"text","text":{"content":" - Examples of Paid, Sent, Draft, and Overdue states"}}]}},
        {"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"3 Work Log Entries"},"annotations":{"bold":true}},{"type":"text","text":{"content":" - Linked to Website Redesign project"}}]}},
        {"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Once you understand the structure, delete the sample entries and add your own data!"},"annotations":{"italic":true}}]}},
        {"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Pro Tip: Keep one sample project/invoice as reference until you're comfortable with the system."}}],"color":"blue_background"}}
    ]}}
]}
'@

Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $body2 | Out-Null
Write-Host "Added Sample Data Walkthrough toggle"
Write-Host "Done - Dashboard enhanced"
