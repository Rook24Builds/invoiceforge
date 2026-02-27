/**
 * AGENT ARCHITECTURE CLARIFICATION
 * VBR-UN-317: Agent Provider Integration (DOCUMENTATION)
 * 
 * USER SAID: "OpenCode handles the providers, VU spawns agents"
 * 
 * CORRECT ARCHITECTURE:
 * =====================
 * 
 *   VU (Orchestrator)        OpenCode (Agent Runtime)      Provider (Ollama/Anthropic/etc)
 *   ─────────────────────────────────────────────────────────────────────────────────
 *   
 *   viber agent run          →  Spawns OpenCode process  →  OpenCode uses configured provider
 *      -t TASK                  - Task: VBR-UN-304         - User's provider in OpenCode config
 *      -r implementation        - Role: implementation       - Could be Ollama, Anthropic, etc
 *      --via opencode             
 *   
 *   VU doesn't care WHAT       OpenCode handles            Provider handles
 *   provider OpenCode uses     model selection, API calls,  the actual inference
 *                              streaming, etc              
 * 
 * USER'S SETUP:
 * =============
 *   OpenCode is already configured with Ollama API key
 *   OpenCode decides which model to use
 *   VU just spawns OpenCode and passes tasks
 * 
 * VU'S JOB:
 * =========
 *   - SafetyNet backup before spawn
 *   - Spawn OpenCode process
 *   - Pass task context
 *   - Monitor execution
 *   - SafetyNet rollback on failure
 *   
 * OPENCODE'S JOB:
 * ===============
 *   - Read user's provider config
 *   - Choose appropriate model
 *   - Make API calls
 *   - Stream responses
 *   - Write files
 *   - Report back
 * 
 * THIS IS THE RIGHT WAY:
 * VU is the **system**, OpenCode is the **tool**.
 *
 * CURRENT STATUS:
 * ===============
 *   ✅ VBR-UN-314: SafetyNet spawner
 *   ✅ VBR-UN-315: Agent runner structure
 *   ⚠️  VBR-UN-316: Direct Ollama API (WRONG - should spawn OpenCode)
 *   🔄 VBR-UN-317: Integrate OpenCode spawn (NEXT)
 * 
 * NEXT BUILD:
 * ===========
 *   Change agent-runner.ts to spawn OpenCode CLI instead of Ollama fetch()
 *   OpenCode already has Ollama configured
 *   VU passes task via stdin or temp file
 *   OpenCode executes and reports back
 * 
 * PRESERVATION:
 * =============
 *   The model mapping I built (implementation=qwen3-coder, etc) 
 *   can be passed as HINTS to OpenCode, but OpenCode makes final call
 *   based on user's provider configuration.
 */
