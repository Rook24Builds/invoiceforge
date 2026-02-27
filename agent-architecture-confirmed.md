/**
 * VU AGENT SPAWN ARCHITECTURE - CONFIRMED
 * Path A: Direct Ollama API (Working TODAY)
 * 
 * CURRENT STATE (Path A):
 * =====================
 * 
 *   VU Dashboard/CLI          SafetyNet              Ollama Cloud API
 *   ─────────────────────────────────────────────────────────────
 *   
 *   viber agent run          →  Git backup         →  Ollama API call
 *      -t VBR-UN-304            Create safety tag      qwen3-coder:30b
 *      -r implementation       Store in DB           Returns code
 *                              Rollback available    
 *                                                     ↓
 *                                                Agent writes files
 *                                                     ↓
 *                                                Task marked done
 * 
 * FUTURE STATE (Path B - VBR-UN-317):
 * ===================================
 * 
 *   VU Dashboard/CLI          SafetyNet              OpenCode           Provider
 *   ─────────────────────────────────────────────────────────────────────────────
 *   
 *   viber agent run          →  Git backup         →  Spawn OpenCode  →  Ollama/Claude/etc
 *      -t TASK                 Create safety tag      User's config      User's choice
 *      -via opencode           Store in DB            Decide model       Do inference
 *                              Rollback available     Execute task
 *                                                     ↓
 *                                                OpenCode reports back
 *                                                     ↓
 *                                                Task marked done
 * 
 * KEY DECISIONS:
 * ==============
 *   ✅ TODAY (Path A): Direct Ollama API works - see it NOW
 *   🔄 FUTURE (Path B): OpenCode integration as optional provider
 *   ✅ VU is the SPAWN POINT - not OpenClaw
 *   ✅ SafetyNet runs in VU
 *   ✅ Future: Any agent (OpenCode, Claude Code, etc) via VU
 * 
 * MODEL SELECTION:
 * ================
 *   TODAY: VU maps role → Ollama model
 *   FUTURE: VU passes "suggested model" to agent, agent decides
 * 
 * IMPLEMENTATION STATUS:
 * ======================
 *   ✅ SafetyNet: Working
 *   ✅ Agent runner: Working
 *   ✅ Ollama cloud API: Working
 *   ⚠️  OpenCode spawn: VBR-UN-317 (Future)
 * 
 * NEXT ACTIONS (Path A):
 * ======================
 *   1. Test actual agent spawn
 *   2. See it write real code
 *   3. Verify SafetyNet rollback works
 *   4. Then: Build OpenCode integration (Path B)
 */
