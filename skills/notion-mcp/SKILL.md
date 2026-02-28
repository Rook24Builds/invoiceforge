# Notion MCP Skill

Model Context Protocol (MCP) integration for Notion — gives AI tools full workspace access via OAuth.

## Overview

Notion MCP is a **hosted MCP server** that exposes Notion as tools for AI assistants. Unlike REST API which requires manual token management, MCP uses OAuth and provides structured tool calling.

**MCP Endpoint:** `https://mcp.notion.com/mcp`  
**Auth:** OAuth via Notion (same permissions as your account)

## Quick Setup

### For OpenClaw Integration

1. **Add MCP Server to config:**
   OpenClaw needs an MCP client. Check if supported:
   ```json
   // openclaw.json MCP section (if available)
   {
     "mcp": {
       "servers": [{
         "name": "notion",
         "url": "https://mcp.notion.com/mcp",
         "transport": "http"
       }]
     }
   }
   ```

2. **Alternative: Use Claude Code / Cursor**
   ```bash
   # Claude Code
   claude mcp add --transport http notion https://mcp.notion.com/mcp
   # Then: /mcp to authenticate via OAuth
   ```

3. **Manual OAuth Flow:**
   - Go to Notion → Settings → Connections → Add MCP
   - Or initiate from AI tool

## Tools Available (via MCP)

MCP exposes Notion operations as structured tools:

| Tool | Description |
|------|-------------|
| `search_pages` | Search across all Notion pages |
| `get_page` | Retrieve page metadata and content |
| `get_database` | Query database schema and entries |
| `query_database` | Filter/sort database entries |
| `create_page` | Create new pages |
| `update_page` | Update page properties |
| `append_blocks` | Add content blocks to pages |
| `delete_block` | Remove blocks |

## Usage Pattern

**REST API (old way):**
```powershell
$token = "ntn_..."
$h = @{ Authorization = "Bearer $token"; "Notion-Version" = "2022-06-28" }
Invoke-RestMethod -Uri ".../databases/$id/query" -Headers $h
```

**MCP way (preferred):**
```
[Tool Call]
→ notion.query_database
  database_id: "3146..."
  filter: { property: "Status", select: { equals: "Done" } }
```

## When to Use MCP vs REST vs Browser

| Scenario | Use |
|----------|-----|
| Bulk data operations | **MCP** (structured, fast) |
| Complex queries with relations | **MCP** (better schema handling) |
| Inline database access | **MCP** (2025-09 API handles these better) |
| Checking visual formatting | **Browser** (human confirmation) |
| Page icon/cover changes | **Browser** (MCP limited on images) |
| REST fallback | Only if MCP unavailable |

## OpenClaw Integration Status

⚠️ **Current:** OpenClaw may not natively support MCP clients yet.

**Workarounds:**
1. Use Claude Code with MCP for heavy Notion work
2. Request OpenClaw MCP support: `openclaw gateway --mcp-enable`
3. Hybrid: MCP for data ops, REST for quick calls, Browser for visuals

## Migration Notes

- **Inline databases:** MCP handles these better than REST
- **Relations/Rollups:** MCP gives better introspection
- **Auth:** OAuth instead of token management
- **Performance:** Structured tool calls vs HTTP roundtrips

## References

- [Notion MCP Docs](https://developers.notion.com/guides/mcp/mcp)
- [Get Started](https://developers.notion.com/docs/get-started-with-mcp)
- [MCP Protocol](https://modelcontextprotocol.io/introduction)
