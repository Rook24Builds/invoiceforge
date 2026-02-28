$token = Get-Content "$env:USERPROFILE/.config/notion/api_key"
$h = @{
    Authorization = "Bearer $token"
    "Notion-Version" = "2022-06-28"
    "Content-Type" = "application/json"
}

$clientsDb = "31365823-28c7-813c-84cb-eaaa695284ed"
$projectsDb = "31365823-28c7-8139-9ae7-f997be5a661b"
$invoicesDb = "31365823-28c7-81f1-a8e1-de27706822c6"

Write-Host "=== ADDING MISSING SAMPLE DATA ==="

# Get existing clients
$existingClients = Invoke-RestMethod -Uri "https://api.notion.com/v1/databases/$clientsDb/query" -Headers $h -Method POST
$clientIds = @{}
foreach ($c in $existingClients.results) {
    $name = ($c.properties.Name.title | ForEach-Object { $_.plain_text }) -join ""
    $cleanName = $name -replace " \(Sample\)", ""
    $clientIds[$cleanName] = $c.id
}
Write-Host "Found $($existingClients.results.Count) existing clients"

# 1. ADD 3 MORE CLIENTS
Write-Host "`nAdding clients 3-5..."

$body1 = '{"parent":{"database_id":"' + $clientsDb + '"},"properties":{"Name":{"title":[{"text":{"content":"TechStart Inc (Sample)"}}]},"Email":{"email":"billing@techstart.com"},"Phone":{"rich_text":[{"text":{"content":"555-0103"}}]},"Company":{"rich_text":[{"text":{"content":"TechStart Inc"}}]},"Address":{"rich_text":[{"text":{"content":"789 Innovation Way, Austin TX"}}]},"Hourly Rate":{"number":95},"Tax Rate":{"number":8}}}'
$r1 = Invoke-RestMethod -Uri "https://api.notion.com/v1/pages" -Headers $h -Method POST -Body $body1
$clientIds["TechStart Inc"] = $r1.id
Write-Host "  Created: TechStart Inc"

$body2 = '{"parent":{"database_id":"' + $clientsDb + '"},"properties":{"Name":{"title":[{"text":{"content":"GreenLeaf Design (Sample)"}}]},"Email":{"email":"payables@greenleaf.com"},"Phone":{"rich_text":[{"text":{"content":"555-0104"}}]},"Company":{"rich_text":[{"text":{"content":"GreenLeaf Design Studio"}}]},"Address":{"rich_text":[{"text":{"content":"456 Garden Ave, Portland OR"}}]},"Hourly Rate":{"number":85},"Tax Rate":{"number":0}}}'
$r2 = Invoke-RestMethod -Uri "https://api.notion.com/v1/pages" -Headers $h -Method POST -Body $body2
$clientIds["GreenLeaf Design"] = $r2.id
Write-Host "  Created: GreenLeaf Design"

$body3 = '{"parent":{"database_id":"' + $clientsDb + '"},"properties":{"Name":{"title":[{"text":{"content":"Metro Logistics (Sample)"}}]},"Email":{"email":"finance@metrolog.com"},"Phone":{"rich_text":[{"text":{"content":"555-0105"}}]},"Company":{"rich_text":[{"text":{"content":"Metro Logistics Group"}}]},"Address":{"rich_text":[{"text":{"content":"321 Commerce St, Chicago IL"}}]},"Hourly Rate":{"number":110},"Tax Rate":{"number":10}}}'
$r3 = Invoke-RestMethod -Uri "https://api.notion.com/v1/pages" -Headers $h -Method POST -Body $body3
$clientIds["Metro Logistics"] = $r3.id
Write-Host "  Created: Metro Logistics"

# 2. ADD 7 MORE PROJECTS
Write-Host "`nAdding projects 2-8..."
$acmeId = $clientIds["Acme Corporation"]
$creativeId = $clientIds["Creative Studio"]
$techId = $clientIds["TechStart Inc"]
$greenId = $clientIds["GreenLeaf Design"]
$metroId = $clientIds["Metro Logistics"]

$projectList = @(
    @{Name="Mobile App Development"; Client=$techId; Status="Active"; Budget=15000; Type="Development"; Start="2024-03-15"; End="2024-06-30"; Desc="iOS and Android app development"},
    @{Name="Brand Identity Package"; Client=$greenId; Status="Completed"; Budget=8500; Type="Design"; Start="2024-01-10"; End="2024-02-28"; Desc="Logo, colors, brand guidelines"},
    @{Name="E-commerce Migration"; Client=$metroId; Status="On Hold"; Budget=25000; Type="Development"; Start="2024-04-01"; End="2024-07-15"; Desc="Migrate to Shopify Plus"},
    @{Name="SEO Audit and Strategy"; Client=$creativeId; Status="Active"; Budget=5000; Type="Strategy"; Start="2024-03-01"; End="2024-04-30"; Desc="SEO analysis and roadmap"},
    @{Name="Product Photography"; Client=$acmeId; Status="Draft"; Budget=3200; Type="Creative"; Start="2024-05-01"; End="2024-05-15"; Desc="50 product shots"},
    @{Name="CRM Integration"; Client=$techId; Status="Active"; Budget=12000; Type="Development"; Start="2024-04-01"; End="2024-05-30"; Desc="Salesforce API integration"},
    @{Name="Marketing Campaign"; Client=$greenId; Status="Sent"; Budget=6500; Type="Marketing"; Start="2024-02-15"; End="2024-03-31"; Desc="Q1 digital campaign"}
)

foreach ($proj in $projectList) {
    $body = '{"parent":{"database_id":"' + $projectsDb + '"},"properties":{"Name":{"title":[{"text":{"content":"' + $proj.Name + ' (Sample)"}}]},"Client":{"relation":[{"id":"' + $proj.Client + '"}]},"Status":{"select":{"name":"' + $proj.Status + '"}},"Budget":{"number":' + $proj.Budget + '},"Project Type":{"select":{"name":"' + $proj.Type + '"}},"Start Date":{"date":{"start":"' + $proj.Start + '"}},"End Date":{"date":{"start":"' + $proj.End + '"}},"Project Description":{"rich_text":[{"text":{"content":"' + $proj.Desc + '"}}]}}}'
    $null = Invoke-RestMethod -Uri "https://api.notion.com/v1/pages" -Headers $h -Method POST -Body $body
    Write-Host "  Created: $($proj.Name)"
}

# 3. ADD 8 MORE INVOICES
Write-Host "`nAdding invoices 3-10..."
$allProjects = Invoke-RestMethod -Uri "https://api.notion.com/v1/databases/$projectsDb/query" -Headers $h -Method POST
$projId = $allProjects.results[0].id

$invoiceList = @(
    @{Num="INV-003"; Client=$creativeId; Amount=2400; Status="Sent"; Due="2024-03-30"; Issued="2024-03-01"; Sub=2400; Tax=192},
    @{Num="INV-004"; Client=$techId; Amount=7500; Status="Paid"; Due="2024-02-15"; Issued="2024-02-01"; Sub=7500; Tax=600},
    @{Num="INV-005"; Client=$greenId; Amount=4250; Status="Overdue"; Due="2024-01-30"; Issued="2024-01-15"; Sub=4250; Tax=340},
    @{Num="INV-006"; Client=$metroId; Amount=5800; Status="Draft"; Due="2024-04-15"; Issued="2024-03-20"; Sub=5800; Tax=580},
    @{Num="INV-007"; Client=$acmeId; Amount=12500; Status="Sent"; Due="2024-03-25"; Issued="2024-03-05"; Sub=12500; Tax=1000},
    @{Num="INV-008"; Client=$creativeId; Amount=3200; Status="Paid"; Due="2024-02-28"; Issued="2024-02-01"; Sub=3200; Tax=256},
    @{Num="INV-009"; Client=$techId; Amount=9800; Status="Sent"; Due="2024-04-10"; Issued="2024-03-15"; Sub=9800; Tax=784},
    @{Num="INV-010"; Client=$greenId; Amount=1600; Status="Draft"; Due="2024-04-20"; Issued="2024-03-25"; Sub=1600; Tax=128}
)

foreach ($inv in $invoiceList) {
    $body = '{"parent":{"database_id":"' + $invoicesDb + '"},"properties":{"Invoice #":{"rich_text":[{"text":{"content":"' + $inv.Num + '"}}]},"Amount":{"number":' + $inv.Amount + '},"Status":{"status":{"name":"' + $inv.Status + '"}},"Due Date":{"date":{"start":"' + $inv.Due + '"}},"Date Issued":{"date":{"start":"' + $inv.Issued + '"}},"Subtotal":{"number":' + $inv.Sub + '},"Tax":{"number":' + $inv.Tax + '},"Total":{"number":' + ($inv.Sub + $inv.Tax) + '},"Client":{"relation":[{"id":"' + $inv.Client + '"}]},"Project":{"relation":[{"id":"' + $projId + '"}]}}}'
    $null = Invoke-RestMethod -Uri "https://api.notion.com/v1/pages" -Headers $h -Method POST -Body $body
    Write-Host "  Created: $($inv.Num)"
}

Write-Host "`n=== DONE ==="
