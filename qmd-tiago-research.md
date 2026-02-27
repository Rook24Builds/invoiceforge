# QMD + Tiago Forte Knowledge Management Research

## Executive Summary

Research on the QMD (Query Markdown) search engine and Tiago Forte's PARA methodology for potential OpenClaw memory system enhancements.

---

## 1. What is QMD?

**QMD** (qntx/qmd on GitHub) is a "Lightweight local search engine for AI agents in Rust." 

### Core Capabilities:
- **BM25 full-text search** - Classic ranking algorithm for keyword search
- **Vector semantic search** - Embedding-based similarity search  
- **Hybrid search** - Combines BM25 + vector + query expansion + reranking
- **RAG support** - Built-in question answering over documents
- **MCP server** - Model Context Protocol integration for AI tool use
- **CLI interface** - Collection management, search, embeddings

### Architecture:
```
qmd/          - Core Rust library (indexing, BM25, embeddings)
qmd-cli/      - CLI tool for collection management
qmd-mcp/      - MCP server for AI agent integration
```

### Key Commands:
```bash
qmd collection add ./docs --name my-docs --mask "**/*.md"  # Index markdown
qmd search "query" -n 5                                    # BM25 search
qmd vsearch "semantic query" -n 5                        # Vector search
qmd qsearch "hybrid query"                               # Hybrid search
qmd ask "question"                                       # RAG Q&A
qmd update                                               # Re-index all
```

### Is it just ripgrep?
**No - it's significantly more sophisticated:**
| Feature | ripgrep | QMD |
|---------|---------|-----|
| Keyword search | ✅ | ✅ (BM25) |
| Semantic search | ❌ | ✅ |
| Hybrid ranking | ❌ | ✅ |
| Query expansion | ❌ | ✅ |
| LLM reranking | ❌ | ✅ |
| RAG Q&A | ❌ | ✅ |
| Embeddings | ❌ | ✅ |
| MCP integration | ❌ | ✅ |

---

## 2. Tiago Forte's System (PARA Method)

Tiago Forte is known for building a "Second Brain" knowledge management system.

### PARA Methodology:
**P**rojects - Active work with deadlines  
**A**reas - Ongoing responsibilities (health, finances)  
**R**esources - Reference material  
**A**rchives - Completed/cold storage

### Key Concepts:
1. **Progressive Summarization** - Layered notes: raw → highlighted → summarized → atomic
2. **Daily Notes** - Fleeting capture (like OpenClaw's daily files)
3. **Permanent Notes** - Distilled knowledge (like MEMORY.md)
4. **Projects** - Task-oriented collections
5. **Regular Review** - Nightly/weekly consolidation

### File Organization:
```
knowledge-base/
├── Projects/
│   ├── active-project/
│   │   ├── notes.md
│   │   └── resources.md
├── Areas/
│   ├── health/
│   ├── finances/
├── Resources/
│   ├── books/
│   ├── articles/
└── Archives/
    └── old-projects/
```

---

## 3. Comparison: Current OpenClaw vs QMD+Tiago

| Aspect | Current OpenClaw | QMD+Tiago Approach |
|--------|-----------------|-------------------|
| **Storage** | `memory/YYYY-MM-DD.md` + `MEMORY.md` | Dedicated knowledge repo with PARA folders |
| **Indexing** | None (linear file scan) | BM25 + vector hybrid index |
| **Search** | Basic file glob/ripgrep | Semantic + keyword hybrid |
| **Daily notes** | Auto-generated | Intentional daily notes (fleeting) |
| **Consolidation** | Session-based compaction | Nightly LLM-powered review |
| **Organization** | Date-based only | Project/Area-based (PARA) |
| **Retrieval** | Full files or recent only | Ranked relevance, RAG Q&A |
| **AI access** | File reads | MCP tool integration |

### Key Differences:

**OpenClaw Current:**
- Simple, predictable
- Date-based organization
- Manual consolidation (session compaction)
- Linear search through files
- Works without external dependencies

**QMD+Tiago:**
- Requires QMD binary + potentially embedding models
- PARA folder structure (Projects/Areas/Resources/Archives)
- Automated nightly consolidation via cron
- Semantic search finds conceptually related content
- RAG allows question-answering over notes
- MCP server for tool integration

---

## 4. The Nightly Consolidation Concept

From the YouTube description:
> "Nightly memory consolidation (cron job) that: Reviews all chat sessions from the day, Identifies important info, Updates markdown files, Re-runs indexing"

### How it identifies "important information":
1. **LLM as judge** - Passes daily transcripts to LLM with prompt like:
   ```
   Review today's chats. Identify:
   - New projects initiated
   - Action items mentioned
   - Knowledge worth preserving
   - Updates to existing projects
   ```
2. **Structured extraction** - LLM outputs structured updates:
   - Add to Projects/X/notes.md
   - Update Areas/health/goals.md
   - Archive completed item from Projects/Y

3. **Progressive summarization** - Not just copying, but:
   - Summarizing long conversations
   - Linking related notes
   - Tagging with dates/context

### Is this "better compaction"?
**Yes, significantly:**
| Aspect | OpenClaw Compaction | Nightly Consolidation |
|--------|-------------------|---------------------|
| Trigger | Session end | Daily cron |
| What happens | Summarize into MEMORY.md | Extract to PARA folders |
| Granularity | One summary per session | Multiple atomic updates |
| Searchability | Lost detail | Preserved + structured |
| Organization | Date-stamped | Topic/project-based |

### Could OpenClaw do this?
**Yes, via:**
- **Hooks** - Post-session hook that queues for review
- **Cron job** - Separate process running daily
- **Heartbeat** - Agent "wakes up" periodically to do consolidation

---

## 5. Key Innovations Worth Borrowing

### ✅ High Value / Low Effort:
1. **Hybrid search concept** - BM25 + keyword matching
   - Could be implemented via simple BM25 library
   - No Rust/QMD dependency needed

2. **Nightly review** - Automated consolidation
   - Implement via cron + OpenClaw hook
   - LLM reviews daily notes → updates MEMORY.md

3. **PARA folder structure** - Optional folder organization
   - `memory/Projects/`, `memory/Areas/`, etc.
   - Backward compatible with existing files

### ✅ High Value / Medium Effort:
4. **RAG-style Q&A** - "What do I know about X?"
   - Requires embedding model or QMD integration
   - Could be MCP tool

5. **Semantic tagging** - Auto-categorize notes
   - LLM extracts tags during consolidation

### ⚠️ Overkill / High Effort:
6. **Full QMD integration** - Requires external binary
   - Adds deployment complexity
   - May not fit all OpenClaw use cases

7. **Real-time indexing** - Overkill for most personal use
   - Daily re-indexing sufficient

---

## 6. Recommendations for OpenClaw

### Immediate (No Code Changes):
1. **Adopt PARA structure** in `memory/` folder:
   ```
   memory/
   ├── Projects/      # Active work
   ├── Areas/         # Ongoing responsibilities  
   ├── Resources/     # Reference material
   ├── Archives/      # Old/cold
   └── daily/         # YYYY-MM-DD.md files
   ```

2. **Nightly consolidation script** (user implements):
   ```bash
   # cron job calls OpenClaw with special prompt
   openclaw --consolidate "Review yesterday's chats..."
   ```

### Short-term (Small Changes):
3. **Memory search skill** using BM25
   - Add `bm25` Python library dependency
   - Index memory files on startup
   - Provide hybrid search capability

4. **Consolidation hook**
   - Configurable post-session action
   - Queue important sessions for review

### Long-term (Consider):
5. **QMD MCP tool** - Optional integration
   - For users who want full semantic search
   - Not required, but available

---

## 7. Is This Worth Pursuing?

### ✅ Yes, if:
- You have extensive knowledge bases (1000+ notes)
- You struggle finding "that thing I mentioned 3 months ago"
- You want automated organization
- You don't mind occasional external dependencies

### ❌ No, if:
- Current file-based workflow works fine
- You prefer simple, inspectable systems
- You don't want additional binaries/services
- Your memory needs are light (<100 notes)

### Pragmatic Balance:
**Start with:**
1. PARA folder structure
2. Nightly consolidation via cron + OpenClaw hooks
3. Simple BM25-based search skill

**Evaluate QMD if:**
- Scale becomes an issue
- Semantic search becomes a must-have

---

## References

- QMD: https://github.com/qntx/qmd
- OpenClaw Engram (related): https://github.com/joshuaswarren/openclaw-engram
- pi-qmd: https://github.com/hjanuschka/pi-qmd
- Tiago Forte: https://fortelabs.com/ (Building a Second Brain)
- PARA Method: https://fortelabs.com/blog/para/

---

*Research completed: 2026-02-26*
