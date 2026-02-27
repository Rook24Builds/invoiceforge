/**
 * VU ARCHITECTURE - CONFIRMED
 * 
 * PRIMARY INTERFACE: OpenCode
 * BACKEND/ORCHESTRATOR: VU (VIBER Universal)
 * 
 * ============================================
 * 
 * USER WORKFLOW:
 * ==============
 *   1. User opens terminal → runs `opencode`
 *   2. Inside OpenCode: "@viber spawn VBR-UN-304"
 *   3. OpenCode calls VU API: POST /api/spawn
 *   4. VU handles SafetyNet → Spawns agent
 *   5. Agent executes → Reports to VU
 *   6. VU updates status → Dashboard reflects
 *   7. User can also use `viber dashboard` to see status
 * 
 * VU ROLES:
 * =========
 *   • Task management (SQLite truth)
 *   • SafetyNet (git backup before spawn)
 *   • Agent orchestration (spawn, monitor, kill)
 *   • Rollback (restore from SafetyNet)
 *   • Dashboard (web UI for visibility)
 * 
 * OPENCODE ROLES:
 * ================
 *   • User interface (where you type)
 *   • VU client (calls VU API)
 *   • Can also BE the agent (if configured)
 *   • Uses YOUR configured providers (Ollama, etc)
 *
 * INSTALLATION:
 * =============
 *   Project-based: cd my-project && npm install @viber/core
 *   Per-project VU instance
 *   Shared: Global install possible but project is default
 * 
 * API ENDPOINTS (what we need to build):
 * =======================================
 *   POST /api/agent/spawn
 *     { taskId, role, model?, provider? }
 *     → { agentId, status, backupTag }
 *   
 *   GET  /api/agent/status/{agentId}
 *     → { status, output, filesChanged }
 *   
 *   POST /api/rollback/{backupTag}
 *     → { success, restoredTo }
 *   
 *   GET  /api/tasks
 *     → { tasks: [...] }
 *   
 *   POST /api/session/notes
 *     { notes: [...] }
 *     → { tasksCreated: [...] }
 * 
 * CURRENT STATE:
 * ==============
 *   ✅ CLI commands work: viber agent run, viber rollback, etc
 *   ⚠️  API endpoints: Need to build server
 *   🔄 OpenCode integration: Plugin or custom commands
 * 
 * NEXT BUILD:
 * ===========
 *   1. VU API Server (Express/Fastify) on port 1576
 *   2. OpenCode plugin or wrapper commands
 *   3. Test: OpenCode → VU API → Agent spawn
 */
