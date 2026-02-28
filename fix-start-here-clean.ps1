# Fix START HERE - Clean version, no emojis in JSON
$token = Get-Content "$env:USERPROFILE/.config/notion/api_key"
$h = @{
    Authorization = "Bearer $token"
    "Notion-Version" = "2022-06-28"
    "Content-Type" = "application/json"
}

$pageId = "31365823-28c7-81d5-81cc-de0fecd99b84"

# Clear
Write-Host "Clearing..."
$existing = Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h
foreach ($block in $existing.results) {
    if (-not $block.archived) {
        Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$($block.id)" -Headers $h -Method DELETE -ErrorAction SilentlyContinue | Out-Null
    }
}
Write-Host "Adding content..."

# Welcome
$json = '{"children":[{"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"Welcome to INVOICEFORGE! This is your complete invoicing system. Follow these steps to go from zero to paid invoice in 5 minutes."}}],"color":"blue_background"}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

# Divider
$json = '{"children":[{"object":"block","type":"divider","divider":{}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

# STEP 1
$json = '{"children":[{"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Step 1: Add Your First Client"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Your client information auto-fills on every invoice you create for them. Set it up once, use it forever."}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click the Clients database"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click + New in the top right"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Fill in: Client Name, Email, Phone, Company, Address"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Set Default Hourly Rate - this auto-fills on invoices for this client"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click away to save - you now have a client ready to invoice!"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"PRO TIP: The Hourly Rate and Tax Rate you set here auto-populate every invoice. No more typing the same numbers over and over."}}],"color":"yellow_background"}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

# STEP 2
$json = '{"children":[{"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Step 2: Create a Project"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Projects organize your work. Link hours, tasks, and invoices to specific projects so clients know exactly what they are paying for."}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Go to the Projects database"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click + New and enter Project Name (example: Website Redesign)"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Select your Client from the dropdown"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Set Status to Active and Project Timeline dates"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Add Project Description so you remember what this covers"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"PRO TIP: The Project Total automatically sums all your linked Work Log hours. Watch it grow as you log time!"}}],"color":"yellow_background"}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

# STEP 3
$json = '{"children":[{"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Step 3: Log Your Work Hours"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"This is where the magic happens. Every hour you log becomes a line item on your invoice. Be specific - clients love detailed invoices."}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Open the Work Log database"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click + New and select your Project from the dropdown"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Write a detailed Task Description (this becomes the invoice line item)"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Set Date and enter Hours (use decimals: 2.5 for 2h 30m)"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Amount auto-calculates: Hours x Hourly Rate = Total"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"PRO TIP: Log hours DAILY while the work is fresh. Task descriptions like Fixed bug on homepage become line items clients actually understand and approve."}}],"color":"yellow_background"}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

# STEP 4
$json = '{"children":[{"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Step 4: Generate Your Invoice"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Time to get paid. Link your logged work and watch the invoice total calculate automatically."}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Go to the Invoices database"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click + New - Invoice Number auto-generates"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Select your Client from dropdown - Name, Email, Hourly Rate ALL auto-fill"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Select your Project from dropdown"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"In Line Items property, link the Work Log tasks you want to bill"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Watch Total auto-calculate from the linked tasks"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Tax and Total calculate automatically. Your invoice is ready!"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"MAGIC: Subtotal, Tax, and Total all calculate automatically. Just link your Work Log tasks and the invoice builds itself."}}],"color":"purple_background"}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

# STEP 5
$json = '{"children":[{"object":"block","type":"heading_2","heading_2":{"rich_text":[{"type":"text","text":{"content":"Step 5: Export and Send"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Your invoice looks professional and includes all the details clients need to pay you."}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Open your completed invoice"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Click three dots in top right"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Select Export and choose PDF format"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Download the PDF with your logo and line items"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"Email to your client and update Status to Sent"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null
$json = '{"children":[{"object":"block","type":"numbered_list_item","numbered_list_item":{"rich_text":[{"type":"text","text":{"content":"When paid, update Status to Paid and enter Payment Date"}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

$json = '{"children":[{"object":"block","type":"callout","callout":{"rich_text":[{"type":"text","text":{"content":"DONE! Now your Dashboard shows revenue, outstanding invoices, and everything is tracked."}}],"color":"green_background"}}]}'
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

$json = '{"children":[{"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"Delete the sample data and start adding your own. The structure is already built for you."}}]}}]}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/$pageId/children" -Headers $h -Method PATCH -Body $json | Out-Null

Write-Host "DONE - CONTENT REBUILT"
