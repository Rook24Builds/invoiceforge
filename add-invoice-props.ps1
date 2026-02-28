$token = Get-Content "$env:USERPROFILE/.config/notion/api_key"
$h = @{
    Authorization = "Bearer $token"
    "Notion-Version" = "2022-06-28"
    "Content-Type" = "application/json"
}

$invoicesDb = "31365823-28c7-81f1-a8e1-de27706822c6"

Write-Host "=== ADDING PROPERTIES TO INVOICES ==="

# 1. Add Tax % (number, percent format)
$body1 = '{"properties":{"Tax Percent":{"number":{"format":"percent"}}}}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/databases/$invoicesDb" -Headers $h -Method PATCH -Body $body1
Write-Host "Added: Tax Percent"

# 2. Add Tax (formula) - Amount * Tax% / 100
$body2 = '{"properties":{"Tax":{"formula":{"expression":"prop(\"Amount\") * prop(\"Tax Percent\") / 100"}}}}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/databases/$invoicesDb" -Headers $h -Method PATCH -Body $body2
Write-Host "Added: Tax (formula)"

# 3. Add PDF (files)
$body3 = '{"properties":{"PDF":{"files":{}}}}'
Invoke-RestMethod -Uri "https://api.notion.com/v1/databases/$invoicesDb" -Headers $h -Method PATCH -Body $body3
Write-Host "Added: PDF (files)"

Write-Host "Done!"
