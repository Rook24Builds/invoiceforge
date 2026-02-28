$token = Get-Content "$env:USERPROFILE/.config/notion/api_key"
$h = @{
    Authorization = "Bearer $token"
    "Notion-Version" = "2022-06-28"
    "Content-Type" = "application/json"
}

$clientsDb = "31365823-28c7-813c-84cb-eaaa695284ed"
$projectsDb = "31365823-28c7-8139-9ae7-f997be5a661b"
$invoicesDb = "31365823-28c7-81f1-a8e1-de27706822c6"

Write-Host "=== FIXING SAMPLE DATA ==="

# Get existing client IDs
$existingClients = Invoke-RestMethod -Uri "https://api.notion.com/v1/databases/$clientsDb/query" -Headers $h -Method POST
$clientMap = @{}
foreach ($c in $existingClients.results) {
    $name = ($c.properties.Name.title | ForEach-Object { $_.plain_text }) -join "" -replace " \(Sample\)", ""
    $clientMap[$name] = $c.id
    Write-Host "Found client: $name (ID: $($c.id))"
}

$acmeId = $clientMap["Acme Corporation"]
$creativeId = $clientMap["Creative Studio"]

# 1. ADD 3 MORE CLIENTS
Write-Host "`nAdding 3 more clients..."

# Client 3: TechStart Inc
$body = @{
    parent = @{ database_id = $clientsDb }
    properties = @{
        Name = @{ title = @(@{ text = @{ content = "TechStart Inc (Sample)" } }) }
        "Contact Email" = @{ email = "billing@techstart.com" }
        Phone = @{ phone_number = "555-0103" }
        Industry = @{ select = @{ name = "Technology" } }
        Status = @{ select = @{ name = "Active" } }
        Notes = @{ rich_text = @(@{ text = @{ content = "Y Combinator startup, fast-growing" } }) }
    }
} | ConvertTo-Json -Depth 10
$r = Invoke-RestMethod -Uri "https://api.notion.com/v1/pages" -Headers $h -Method POST -Body $body
$techId = $r.id
Write-Host "Created TechStart Inc (ID: $techId)"

# Client 4: GreenLeaf Design
$body = @{
    parent = @{ database_id = $clientsDb }
    properties = @{
        Name = @{ title = @(@{ text = @{ content = "GreenLeaf Design (Sample)" } }) }
        "Contact Email" = @{ email = "payables@greenleaf.com" }
        Phone = @{ phone_number = "555-0104" }
        Industry = @{ select = @{ name = "Design" } }
        Status = @{ select = @{ name = "Active" } }
    }
} | ConvertTo-Json -Depth 10
$r = Invoke-RestMethod -Uri "https://api.notion.com/v1/pages" -Headers $h -Method POST -Body $body
$greenId = $r.id
Write-Host "Created GreenLeaf Design (ID: $greenId)"

# Client 5: Metro Logistics
$body = @{
    parent = @{ database_id = $clientsDb }
    properties = @{
        Name = @{ title = @(@{ text = @{ content = "Metro Logistics (Sample)" } }) }
        "Contact Email" = @{ email = "finance@metrolog.com" }
        Phone = @{ phone_number = "555-0105" }
        Industry = @{ select = @{ name = "Logistics" } }
        Status = @{ select = @{ name = "Active" } }
    }
} | ConvertTo-Json -Depth 10
$r = Invoke-RestMethod -Uri "https://api.notion.com/v1/pages" -Headers $h -Method POST -Body $body
$metroId = $r.id
Write-Host "Created Metro Logistics (ID: $metroId)"

# 2. ADD 7 MORE PROJECTS
Write-Host "`nAdding 7 more projects..."

$projects = @(
    @{Name="Mobile App"; Client=$techId; Status="Active"; Budget=15000; Priority="High"; Desc="iOS/Android native app development"},
    @{Name="Brand Identity"; Client=$greenId; Status="Completed"; Budget=8500; Priority="Medium"; Desc="Logo, colors, typography, brand book"},
    @{Name="E-commerce Migration"; Client=$metroId; Status="On Hold"; Budget=25000; Priority="High"; Desc="Shopify Plus migration"},
    @{Name="SEO Campaign"; Client=$creativeId; Status="Active"; Budget=5000; Priority="Low"; Desc="Technical SEO and content strategy"},
    @{Name="Product Photos"; Client=$acmeId; Status="Draft"; Budget=3200; Priority="Medium"; Desc="50 product shots with editing"},
    @{Name="CRM Integration"; Client=$techId; Status="Active"; Budget=12000; Priority="High"; Desc="Salesforce API integration"},
    @{Name="Q1 Marketing"; Client=$greenId; Status="Sent"; Budget=6500; Priority="Medium"; Desc="Digital campaign management"}
)

$projectIds = @{}
foreach ($p in $projects) {
    $body = @{
        parent = @{ database_id = $projectsDb }
        properties = @{
            Name = @{ title = @(@{ text = @{ content = $p.Name + " (Sample)" } }) }
            Client = @{ relation = @(@{ id = $p.Client }) }
            Status = @{ select = @{ name = $p.Status } }
            Budget = @{ number = $p.Budget }
            Priority = @{ select = @{ name = $p.Priority } }
            Description = @{ rich_text = @(@{ text = @{ content = $p.Desc } }) }
        }
    } | ConvertTo-Json -Depth 10
    
    $r = Invoke-RestMethod -Uri "https://api.notion.com/v1/pages" -Headers $h -Method POST -Body $body
    $projectIds[$p.Name] = $r.id
    Write-Host "Created: $($p.Name) (Sample)"
}

# 3. ADD 8 MORE INVOICES
Write-Host "`nAdding 8 more invoices..."

# Get Website Redesign project ID for linking
$siteRedesign = Invoke-RestMethod -Uri "https://api.notion.com/v1/databases/$projectsDb/query" -Headers $h -Method POST
$websiteId = $null
foreach ($r in $siteRedesign.results) {
    $name = ($r.properties.Name.title | ForEach-Object { $_.plain_text }) -join ""
    if ($name -like "*Website*") {
        $websiteId = $r.id
        break
    }
}

$invoices = @(
    @{Num="INV-003"; Client=$creativeId; Amount=2400; Status="Sent"; Due="2024-03-30"; Issued="2024-03-01"},
    @{Num="INV-004"; Client=$techId; Amount=7500; Status="Paid"; Due="2024-02-15"; Issued="2024-02-01"},
    @{Num="INV-005"; Client=$greenId; Amount=4250; Status="Overdue"; Due="2024-01-30"; Issued="2024-01-15"},
    @{Num="INV-006"; Client=$metroId; Amount=5800; Status="Draft"; Due="2024-04-15"; Issued="2024-03-20"},
    @{Num="INV-007"; Client=$acmeId; Amount=12500; Status="Sent"; Due="2024-03-25"; Issued="2024-03-05"},
    @{Num="INV-008"; Client=$creativeId; Amount=3200; Status="Paid"; Due="2024-02-28"; Issued="2024-02-01"},
    @{Num="INV-009"; Client=$techId; Amount=9800; Status="Sent"; Due="2024-04-10"; Issued="2024-03-15"},
    @{Num="INV-010"; Client=$greenId; Amount=1600; Status="Draft"; Due="2024-04-20"; Issued="2024-03-25"}
)

foreach ($inv in $invoices) {
    $body = @{
        parent = @{ database_id = $invoicesDb }
        properties = @{
            "Invoice #" = @{ title = @(@{ text = @{ content = $inv.Num } }) }
            Client = @{ relation = @(@{ id = $inv.Client }) }
            Amount = @{ number = $inv.Amount }
            Status = @{ select = @{ name = $inv.Status } }
            "Due Date" = @{ date = @{ start = $inv.Due } }
            "Issue Date" = @{ date = @{ start = $inv.Issued } }
        }
    }
    if ($websiteId) {
        $body.properties.Project = @{ relation = @(@{ id = $websiteId }) }
    }
    $bodyJson = $body | ConvertTo-Json -Depth 10
    
    $r = Invoke-RestMethod -Uri "https://api.notion.com/v1/pages" -Headers $h -Method POST -Body $bodyJson
    Write-Host "Created: $($inv.Num)"
}

Write-Host "`n=== DONE ==="
Write-Host "Checking final counts..."
$finalClients = Invoke-RestMethod -Uri "https://api.notion.com/v1/databases/$clientsDb/query" -Headers $h -Method POST
$finalProjects = Invoke-RestMethod -Uri "https://api.notion.com/v1/databases/$projectsDb/query" -Headers $h -Method POST
$finalInvoices = Invoke-RestMethod -Uri "https://api.notion.com/v1/databases/$invoicesDb/query" -Headers $h -Method POST

Write-Host "Clients: $($finalClients.results.Count)"
Write-Host "Projects: $($finalProjects.results.Count)"
Write-Host "Invoices: $($finalInvoices.results.Count)"
