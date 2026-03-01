# TOOLS.md - Local Notes + API Cheat Sheets

## Notion API - COMPLETE REFERENCE
*Ingested from developers.notion.com - Everything I need to never fuck this up again*

---

### BASE URL
```
https://api.notion.com
```
All requests require HTTPS.

---

### REQUIRED HEADERS
```json
{
  "Authorization": "Bearer YOUR_API_SECRET",
  "Notion-Version": "2022-06-28"  // or "2025-09-03" for multi-source DBs
}
```

---

### UUID FORMAT (CRITICAL!)
- IDs are **UUIDv4** with hyphens: `31365823-28c7-813c-84cb-eaaa695284ed`
- You can omit hyphens in URLs, but API responses always include them
- **NEVER** hardcode assumed property names - query the database schema first

---

### CORE ENDPOINTS

#### Databases (Legacy - Pre-2025-09-03)
| Action | Method | Endpoint |
|--------|--------|----------|
| Query | POST | `/v1/databases/{database_id}/query` |
| Create | POST | `/v1/databases` |
| Update | PATCH | `/v1/databases/{database_id}` |
| Get | GET | `/v1/databases/{database_id}` |

#### Data Sources (2025-09-03+)
| Action | Method | Endpoint |
|--------|--------|----------|
| Query | POST | `/v1/data_sources/{data_source_id}/query` |
| Get | GET | `/v1/data_sources/{data_source_id}` |
| Update | PATCH | `/v1/data_sources/{data_source_id}` |

#### Pages
| Action | Method | Endpoint |
|--------|--------|----------|
| Create | POST | `/v1/pages` |
| Get | GET | `/v1/pages/{page_id}` |
| Update | PATCH | `/v1/pages/{page_id}` |
| Delete | DELETE | `/v1/pages/{page_id}` |

#### Blocks
| Action | Method | Endpoint |
|--------|--------|----------|
| Get children | GET | `/v1/blocks/{block_id}/children` |
| Append children | PATCH | `/v1/blocks/{block_id}/children` |
| Delete | DELETE | `/v1/blocks/{block_id}` |

#### Search
| Action | Method | Endpoint |
|--------|--------|----------|
| Search | POST | `/v1/search` |

---

### PROPERTY VALUE TYPES (WHEN CREATING PAGES)

Every property must use the correct **value object structure**:

```json
// title (for page titles)
"Name": { "title": [{ "text": { "content": "Page Title" } }] }

// rich_text
"Description": { "rich_text": [{ "text": { "content": "Some text" } }] }

// number
"Price": { "number": 42.50 }

// select
"Status": { "select": { "name": "In Progress" } }

// multi_select
"Tags": { "multi_select": [{ "name": "Urgent" }, { "name": "Bug" }] }

// date
"Due Date": { "date": { "start": "2024-03-15" } }

// checkbox
"Done": { "checkbox": true }

// email
"Email": { "email": "user@example.com" }

// phone_number
"Phone": { "phone_number": "555-0100" }

// url
"Website": { "url": "https://example.com" }

// relation (link to other pages)
"Client": { "relation": [{ "id": "page-uuid-here" }] }

// people (users)
"Assignee": { "people": [{ "id": "user-uuid-here" }] }

// formula (READ-ONLY - can't set, only computed)
// "Total": { "formula": { "string": "result" } }

// rollup (READ-ONLY - can't set, only computed)
// "Sum": { "rollup": { "number": 100 } }

// status (new property type)
"Status": { "status": { "name": "In progress" } }
```

---

### COMMON MISTAKE PREVENTION

#### ❌ WRONG - Using database_id in POST body after 2025-09-03
```json
"parent": { "database_id": "abc-123" }
```

#### ✅ CORRECT - Using data_source_id
```json
"parent": { "data_source_id": "abc-123" }
```

#### ❌ WRONG - Guessing property names
```json
"Email": { "rich_text": [{ "text": { "content": "test@test.com" } }] }
// Actual property might be named "email" (lowercase, type email)
```

#### ✅ CORRECT - Query schema first
```powershell
$schema = Invoke-RestMethod -Uri "https://api.notion.com/v1/databases/$dbId" -Headers $headers
# Check $schema.properties to see actual names and types
```

#### ❌ WRONG - Using empty string
```json
"Notes": { "rich_text": [{ "text": { "content": "" } }] }
// NOTION API REJECTS EMPTY STRINGS
```

#### ✅ CORRECT - Use null or omit
```json
"Notes": { "rich_text": [] }  // or just omit the property entirely
```

---

### DISCOVERY FIRST - ALWAYS

Before creating entries, **GET THE ACTUAL SCHEMA**:

```powershell
# 1. Get database schema
$db = Invoke-RestMethod -Uri "https://api.notion.com/v1/databases/$databaseId" -Headers $headers

# 2. List all properties and their types
foreach ($prop in $db.properties.PSObject.Properties) {
    Write-Host "$($prop.Name): $($prop.Value.type)"
}

# 3. Then build your create payload based on ACTUAL types
```

---

### PAGINATION

Endpoints returning lists support pagination:

```json
{
  "object": "list",
  "results": [...],
  "has_more": true,
  "next_cursor": "cursor-value-here",
  "type": "page"
}
```

To get next page:
```json
{
  "start_cursor": "cursor-value-from-previous-response",
  "page_size": 100  // max 100
}
```

---

### ERROR HANDLING

Common errors and what they mean:

| Error | Cause | Fix |
|-------|-------|-----|
| `validation_error` | Wrong property name or type | Query schema first |
| `object_not_found` | ID doesn't exist or no permissions | Check ID format (UUID w/ hyphens) and sharing |
| `conflict_error` | Concurrent modification | Retry with fresh data |
| `rate_limited` | Too many requests | Implement exponential backoff |

---

### LINKED DATABASES LIMITATION

Linked databases (inline views of existing databases) **CANNOT** be queried via API until converted to standalone. Only the source database can be queried.

---

### 2025-09-03 BREAKING CHANGES

1. **Multi-source databases** - Databases can have multiple data sources
2. **data_source_id replaces database_id** in most POST/PATCH bodies
3. **Search filters** - `value` must be `"data_source"` not `"database"` when filtering by object type
4. **Webhooks** - new event types: `data_source.created`, `data_source.moved`, etc.

---

### RELATIONS & DUAL_PROPERTIES

When creating bidirectional relations:

```json
// When creating the relation property
{
  "Related Tasks": {
    "relation": {
      "data_source_id": "other-db-uuid",
      "type": "dual_property",
      "synced_property_name": "Parent Project"  // Name of reverse link
    }
  }
}
```

---

## Tool Usage Guidelines (CRITICAL)

### Required vs Optional Parameters

**ALWAYS provide required parameters.** Tools will fail without them.

| Tool | Required Parameters | Common Mistakes |
|------|---------------------|-----------------|
| `read` | `file_path` OR `path` (string) | ❌ Calling without any path argument |
| `write` | `file_path` OR `path` + `content` | ❌ Omitting content, wrong parameter names |
| `edit` | `file_path` OR `path` + `oldText` + `newText` | ❌ Using wrong oldText (must match exactly) |
| `exec` | `command` | ❌ None (always required) |
| `web_search` | `query` | ❌ None (always required) |
| `web_fetch` | `url` | ❌ None (always required) |
| `memory_search` | `query` | ❌ None (always required) |

### Parameter Name Aliases (For Sub-Agents)

Some tools accept **either** of two parameter names:
- `read`: accepts `file_path` OR `path`
- `write`: accepts `file_path` OR `path`
- `edit`: accepts `file_path` OR `path`

**Sub-agents**: Always use the primary name shown in the system prompt (`file_path` for read/write/edit).

### Tool Call Failure Pattern (FIXED)

**Problem**: `read tool called without path` errors in embedded agents.
**Cause**: Sub-agents not providing required `file_path` parameter.
**Solution**: ALL tool calls must include required params. Check the system prompt for each tool's schema.

### Sub-Agent Tool Safety Workaround

OpenClaw's minimal prompt mode for sub-agents omits tool schemas. Models may guess wrong.

**Solution:** Always prepend `SUBAGENT-PREAMBLE.md` to sub-agent tasks:
```
sessions_spawn task:"READ SUBAGENT-PREAMBLE.md FIRST.

Then: [actual task]"
```

This preamble documents required params and common failures for all tools.

### Debugging Tool Failures

1. Check the exact error message — it usually says what's missing
2. Verify parameter names match the system prompt (case-sensitive!)
3. Required params: if the tool fails, you likely missed one
4. Sub-agents: validate your tool calls before sending them

---

## Local Setup

### Cameras
- None configured

### SSH
- None configured

### TTS
- Preferred voice: TBD
- Default speaker: TBD

---

*Last updated: 2026-02-27 - Notion API reference fully ingested*
