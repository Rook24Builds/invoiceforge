# Sub-Agent Tool Safety Preamble

**MANDATORY: Read this before making ANY tool calls.**

## Required Parameters - NO EXCEPTIONS

When calling tools, you MUST provide all required parameters or the tool will fail.

| Tool | Required Params | Optional |
|------|-----------------|----------|
| `read` | `file_path` (string) | `limit`, `offset` |
| `write` | `file_path` + `content` (both strings) | none |
| `edit` | `file_path` + `oldText` + `newText` | none |
| `exec` | `command` (string) | `workdir`, `timeout`, `background` |
| `web_search` | `query` (string) | `count`, `country` |
| `web_fetch` | `url` (string) | `extractMode`, `maxChars` |
| `memory_search` | `query` (string) | `maxResults` |

## Common Failures to AVOID

❌ `read` without `file_path` → FAILS
❌ `write` with only `file_path`, no `content` → FAILS  
❌ `edit` with wrong `oldText` (must match EXACTLY) → FAILS
❌ Wrong param names (e.g., `path` instead of `file_path` for some tools) → CHECK SCHEMA

## Before You Call Any Tool:

1. Verify the tool name is spelled correctly
2. Identify ALL required parameters
3. Confirm you have values for each
4. Double-check parameter names match exactly (case-sensitive)

---

**Now proceed with the task:**
