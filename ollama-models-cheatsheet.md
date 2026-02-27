/**
 * Ollama CLOUD API Integration
 * VBR-UN-316: Agent model configuration via Ollama.com API
 * 
 * Uses Ollama.com cloud API (NOT local models)
 * Requires OLLAMA_API_KEY environment variable
 * 
 * Endpoint: https://api.ollama.com/v1
 * 
 * QUICK REFERENCE:
 * ============
 * 
 * Prerequisites:
 *   export OLLAMA_API_KEY="your-key-here"
 *   
 *   Or set in OpenClaw config (already configured)
 * 
 * Implementation (writes code):
 *   viber agent run -t TASK --role implementation
 *   → Uses: qwen3-coder:30b via Ollama Cloud API
 *   → Model runs on Ollama's infrastructure, not your machine
 * 
 * Refactor (cleans code):
 *   viber agent run -t TASK --role refactor
 *   → Uses: deepseek-coder:6.7b via Ollama Cloud API
 * 
 * Review (analyzes code):
 *   viber agent run -t TASK --role review
 *   → Uses: deepseek-r1:1.5b via Ollama Cloud API
 * 
 * Test (generates tests):
 *   viber agent run -t TASK --role test
 *   → Uses: qwen3-coder:30b via Ollama Cloud API
 * 
 * Docs (writes docs):
 *   viber agent run -t TASK --role docs
 *   → Uses: llama3.2:3b via Ollama Cloud API
 * 
 * CUSTOM MODEL:
 *   viber agent run -t TASK --role implementation --model llama3.2:3b
 * 
 * COST TRACKING:
 *   implementation: ~$0.002 per 1K tokens
 *   refactor: ~$0.001 per 1K tokens
 *   review: ~$0.0005 per 1K tokens
 *   docs: ~$0.0005 per 1K tokens
 * 
 * YOUR AVAILABLE MODELS (via API):
 *   qwen3-coder:30b    - 30B params, best for coding
 *   deepseek-coder:6.7b - 6.7B params, code specialist
 *   deepseek-r1:1.5b   - 1.5B params, reasoning model
 *   llama3.2:3b        - 3B params, general purpose
 * 
 * NO LOCAL MODELS. NO MACHINE SLOWDOWN.
 * Everything runs on Ollama's cloud infrastructure.
 */
