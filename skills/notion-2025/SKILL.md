# Notion API 2025-09-03

Updated Notion API skill for the 2025-09-03 version with data sources support.

## Key Changes from 2022-06-28

### Databases → Data Sources
- **Old:** Database operations used `database_id`
- **New:** Most operations now require `data_source_id`
- **Why:** Multi-source databases - one database can have multiple linked data sources

## Setup

1. Create integration at https://notion.so/my-integrations
2. Copy API key (starts with `secret_` or `ntn_`)
3. Store securely (NEVER commit to git):

```powershell
$env:NOTION_API_KEY = "ntn_your_key_here"
```

4. **CRITICAL:** Share target pages with integration
   - Go to page → "..." → "Add connections" → Select integration

## API Version Header

**Must use:** `Notion-Version: 2022-06-28` (stable)

The 2025-09-03 version adds data_sources but requires migration. Use 2022-06-28 unless you specifically need multi-source databases.

## Common Operations

### Get Data Source ID from Database

```powershell
$headers = @{ 
  Authorization = "Bearer $env:NOTION_API_KEY"
  "Notion-Version" = "2022-06-28"
}

# Get database info - returns data_sources array
$db = Invoke-RestMethod -Uri "https://api.notion.com/v1/databases/DATABASE_ID" -Headers $headers
$dataSourceId = $db.data_sources[0].id
```

### Query a Database (Data Source)

```powershell
$headers = @{ 
  Authorization = "Bearer $env:NOTION_API_KEY"
  "Notion-Version" = "2022-06-28"
  "Content-Type" = "application/json"
}

$body = @{
  filter = @{ property = "Status"; select = @{ equals = "Active" } }
} | ConvertTo-Json -Depth 3

# Use data_source_id, not database_id
$results = Invoke-RestMethod -Uri "https://api.notion.com/v1/data_sources/$dataSourceId/query" -Method POST -Headers $headers -Body $body
```

### Create Page in Database

```powershell
$body = @{
  parent = @{ database_id = "DATABASE_ID" }  # Still uses database_id
  properties = @{
    Name = @{ title = @(@{ text = @{ content = "New Item" } }) }
    Status = @{ select = @{ name = "Todo" } }
  }
} | ConvertTo-Json -Depth 5

$page = Invoke-RestMethod -Uri "https://api.notion.com/v1/pages" -Method POST -Headers $headers -Body $body
```

### Get Page Content (Blocks)

```powershell
$blocks = Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/PAGE_ID/children" -Headers $headers
```

### Add Blocks to Page

```powershell
$body = @{
  children = @(
    @{
      object = "block"
      type = "heading_1"
      heading_1 = @{
        rich_text = @(@{ text = @{ content = "Section Title" } })
      }
    },
    @{
      object = "block"
      type = "paragraph"
      paragraph = @{
        rich_text = @(@{ text = @{ content = "Content here" } })
      }
    }
  )
} | ConvertTo-Json -Depth 5

Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/PAGE_ID/children" -Method PATCH -Headers $headers -Body $body
```

### Create Database (Inline)

```powershell
$body = @{
  parent = @{ page_id = "PAGE_ID" }
  title = @(@{ text = @{ content = "My Database" } })
  is_inline = $true
  properties = @{
    Name = @{ title = @{} }
    Status = @{ select = @{ options = @(
      @{ name = "Todo"; color = "red" }
      @{ name = "Done"; color = "green" }
    )}}
    Date = @{ date = @{} }
  }
} | ConvertTo-Json -Depth 5

$db = Invoke-RestMethod -Uri "https://api.notion.com/v1/databases" -Method POST -Headers $headers -Body $body
```

### Search

```powershell
$body = @{
  query = "page title"
  filter = @{ value = "page"; property = "object" }
} | ConvertTo-Json

$results = Invoke-RestMethod -Uri "https://api.notion.com/v1/search" -Method POST -Headers $headers -Body $body
```

## Property Types Reference

| Type | Format |
|------|--------|
| Title | `@{ title = @(@{ text = @{ content = "..." } }) }` |
| Rich Text | `@{ rich_text = @(@{ text = @{ content = "..." } }) }` |
| Select | `@{ select = @{ name = "Option" } }` |
| Multi-select | `@{ multi_select = @(@{ name = "A" }, @{ name = "B" }) }` |
| Number | `@{ number = 42 }` |
| Date | `@{ date = @{ start = "2024-01-15" } }` |
| Checkbox | `@{ checkbox = $true }` |
| URL | `@{ url = "https://..." }` |
| Email | `@{ email = "a@b.com" }` |
| Relation | `@{ relation = @(@{ id = "page_id" }) }` |

## Security

⚠️ **NEVER commit API keys to git**

**Bad:**
```powershell
$token = "ntn_..."  # Hardcoded in script
```

**Good:**
```powershell
$token = $env:NOTION_API_KEY  # From environment
# Or:
$token = Get-Content ~/.config/notion/api_key  # From file (add to .gitignore)
```

**Add to .gitignore:**
```
*.ps1
molo_manager*.py
create_notion*.ps1
.config/notion/
secrets/
```

## Rate Limits

- ~3 requests/second average
- Burst: 100 requests per second

## Common Errors

| Error | Cause | Fix |
|-------|-------|-----|
| 401 | Bad token or not shared | Verify token, share page with integration |
| 404 | Page/database not found | Check ID is correct, page is shared |
| 400 | Bad request body | Check JSON structure, property types |
| 403 | No permission | Integration needs write access |

## Links

- Full docs: https://developers.notion.com/docs/getting-started
- Upgrade guide: https://developers.notion.com/guides/get-started/upgrade-guide-2025-09-03
- Reference: https://developers.notion.com/reference/intro
