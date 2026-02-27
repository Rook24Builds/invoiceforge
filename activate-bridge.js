/**
 * VU Bridge Activator with Project Context
 * 
 * USAGE:
 * // Activate for specific project
 * const vu = activateViberBridge('session-123', 'viber-universal');
 * 
 * // Casual chat - no capture
 * const vu = activateViberBridge('session-456');
 * 
 * // Switch projects mid-session
 * setProjectContext('openclaw');
 */

const { ViberBridge } = require('./viber-bridge');

// Global bridge instance
let activeBridge: any = null;

function activateViberBridge(sessionId: string, project?: string) {
  const proj = project || 'general';
  const active = proj !== 'general';
  
  console.log('🧬 VIBER Universal Bridge');
  console.log('   Session:', sessionId);
  console.log('   Project:', proj);
  console.log('   Status:', active ? '🔴 RECORDING' : '⚪ IDLE');
  console.log('');
  
  activeBridge = new ViberBridge(sessionId, proj);
  
  if (active) {
    console.log('✅ VU Bridge ACTIVE');
    console.log('   Capturing: blockers, decisions, insights, accomplishments');
    console.log('   Filtering: casual chat ignored');
    console.log('');
  } else {
    console.log('✅ VU Bridge IDLE');
    console.log('   Not capturing - set project to activate');
    console.log('   Example: setProjectContext("viber-universal")');
    console.log('');
  }
  
  return activeBridge;
}

function setProjectContext(project: string) {
  if (activeBridge) {
    activeBridge.setProject(project);
    console.log(`[VU Bridge] Switched to: ${project}`);
  } else {
    console.log('⚠️  VU Bridge not initialized. Call activateViberBridge first.');
  }
}

function getActiveBridge() {
  return activeBridge;
}

function analyzeMessage(message: string) {
  if (!activeBridge) {
    return null;
  }
  return activeBridge.analyzeAndRecord(message);
}

function endViberSession() {
  if (activeBridge) {
    activeBridge.endSession();
    activeBridge = null;
    console.log('✅ VU Session ended');
  }
}

module.exports = {
  activateViberBridge,
  setProjectContext,
  getActiveBridge,
  analyzeMessage,
  endViberSession
};
