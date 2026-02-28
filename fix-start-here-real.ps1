# Fix START HERE with REAL content
$token = Get-Content "$env:USERPROFILE/.config/notion/api_key"
$h = @{
    Authorization = "Bearer $token"
    "Notion-Version" = "2022-06-28"
    "Content-Type" = "application/json"
}

$pageId = "31365823-28c7-81d5-81cc-de0fecd99b84"

# Step 1: Clear existing
Write-Host "Clearing..."
$existing = Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h
foreach ($block in $existing.results) {
    if (-not $block.archived) {
        Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$($block.id)" -Headers $h -Method DELETE -ErrorAction SilentlyContinue | Out-Null
    }
}
Write-Host "Cleared. Adding real content..."

# Welcome
$json = '{"children":[{"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Welcome to INVOICEFORGE! This is your complete invoicing system. Follow these steps to go from zero to paid invoice in 5 minutes."}}],"icon":{"emoji":"🚀","type":"emoji"},"color":"blue_background"}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

# Divider
$json = '{"children":[{"object":"block","type":"divider","divider":{}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

# STEP 1
$json = '{"children":[{"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Step 1: Add Your First Client"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Your client information auto-fills on every invoice you create for them. Set it up once, use it forever."}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click the Clients database (link below or in the sidebar)"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click + New in the top right"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Fill in: Client Name, Email, Phone, Company, Address"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Set Default Hourly Rate - this auto-fills on invoices for this client"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click away to save - you now have a client ready to invoice!"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"PRO TIP: The Hourly Rate and Tax Rate you set here auto-populate every invoice. No more typing the same numbers over and over."}}],"icon":{"emoji":"💡","type":"emoji"},"color":"yellow_background"}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

# STEP 2
$json = '{"children":[{"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Step 2: Create a Project"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Projects organize your work. Link hours, tasks, and invoices to specific projects so clients know exactly what they are paying for."}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Go to the Projects database"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click + New and enter Project Name (e.g., Website Redesign)"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Select your Client from the dropdown - their hourly rate auto-fills"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Set Status to Active and Project Timeline dates"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Add Description so you remember what this project covers"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"PRO TIP: The Project Total rollup automatically sums all your Work Log hours. Watch it grow as you log time!"}}],"icon":{"emoji":"💡","type":"emoji"},"color":"yellow_background"}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

# STEP 3
$json = '{"children":[{"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Step 3: Log Your Work Hours"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"This is where the magic happens. Every hour you log becomes a line item on your invoice. Be specific - clients love detailed invoices."}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Open the Work Log database"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click + New and select your Project from dropdown"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Write a detailed Task Description: Initial consultation and requirements gathering"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Set Date and enter Hours (e.g., 2.5 for 2 hours 30 minutes)"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Amount auto-calculates: Hours x Project Hourly Rate = $375.00"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"PRO TIP: Log hours DAILY while the work is fresh in your mind. Task descriptions like Fixed CSS bug on homepage become line items clients actually understand."}}],"icon":{"emoji":"💡","type":"emoji"},"color":"yellow_background"}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

# STEP 4
$json = '{"children":[{"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Step 4: Generate Your Invoice"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Time to get paid. Link your logged work and watch the invoice total calculate automatically."}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Go to the Invoices database"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click + New - Invoice Number auto-generates (e.g., INV-001)"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Select your Client - Name, Email, Hourly Rate, Tax Rate ALL auto-fill"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Select your Project from dropdown"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"In the Line Items property, link the Work Log tasks you want to invoice"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Watch Total from Tasks roll up automatically - it sums all linked work"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Tax and Total auto-calculate. Done. Your invoice is ready to send."}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"MAGIC: Subtotal, Tax, and Total all calculate automatically. Just link your work log tasks and the invoice builds itself."}}],"icon":{"emoji":"✨","type":"emoji"},"color":"purple_background"}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

# STEP 5
$json = '{"children":[{"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Step 5: Export and Send"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Your invoice looks professional and includes all the details clients need to pay you."}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Open your completed invoice"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click the three dots (...) in the top right"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Select Export and choose PDF format"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Download the PDF - it includes your logo, line items, totals, everything"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Email to your client and update Status to Sent in Notion"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"When paid, update Status to Paid and enter Payment Date"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"DONE! Now your Dashboard shows revenue, outstanding invoices, and everything is tracked."}}],"icon":{"emoji":"🎉","type":"emoji"},"color":"green_background"}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

# FOOTER
$json = '{"children":[{"object":"block","type":"divider","divider":{}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"What Is Included"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"5 sample clients with realistic data"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"8 sample projects with different statuses"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"10 sample invoices (Draft, Sent, Paid, Overdue)"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"3 sample work log tasks linked to invoices"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"bulleted_list_item","bulleted_list_item":{"rich_text":[{"type":"text","text":{"content":"Auto-calculating formulas for all totals"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Delete the samples and start adding your own data. The structure is already built for you."}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

Write-Host "DONE - START HERE REBUILT WITH REAL CONTENT"
