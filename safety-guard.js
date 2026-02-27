/**
 * EvidenceSentry - My Big TOE validator for OpenClaw
 * Simple premise checker before destructive actions
 */

class EvidenceSentry {
  constructor(context = {}) {
    this.context = context;
    this.premises = [];
  }

  /**
   * Validate an action before execution
   * Returns PEAK, SLOPE, or VALLEY based on confidence
   */
  validate(action) {
    const { type, target, destructive = false } = action;
    
    // Calculate confidence score (0-100)
    let confidence = 50; // Baseline
    
    // Check for destructive flags
    if (destructive || ['rm', 'delete', 'remove'].some(d => type.includes(d))) {
      confidence -= 30;
    }
    
    // Check if target was recently accessed (has evidence)
    if (this.hasRecentEvidence(target)) {
      confidence += 20;
    }
    
    // Check for force override
    if (this.context.force) {
      confidence = 100;
    }
    
    // Determine Reality Surface
    let status, message;
    if (confidence >= 80) {
      status = 'PEAK';
      message = `High confidence (${confidence}%). Proceeding.`;
    } else if (confidence >= 40) {
      status = 'SLOPE';
      message = `Medium confidence (${confidence}%). Review recommended.`;
    } else {
      status = 'VALLEY';
      message = `Low confidence (${confidence}%). Use --force to proceed, or verify premises.`;
    }
    
    return { status, confidence, message, action };
  }
  
  /**
   * Check if we have recent evidence about this target
   */
  hasRecentEvidence(target) {
    // Check session history for recent file access
    // This would integrate with session context in real usage
    return this.context.recentFiles?.some(f => target.includes(f)) || false;
  }
  
  /**
   * Log premise check to memory
   */
  log(premise) {
    const timestamp = new Date().toISOString();
    const logEntry = {
      timestamp,
      ...premise
    };
    
    // In real usage, append to memory file
    console.log(`[Premise Check] ${timestamp}: ${JSON.stringify(logEntry)}`);
    return logEntry;
  }
}

/**
 * Quick guard function for immediate use
 */
function guardDestructive(action, context = {}) {
  const sentry = new EvidenceSentry(context);
  const result = sentry.validate(action);
  
  if (result.status === 'VALLEY' && !context.force) {
    return {
      proceed: false,
      warning: result.message,
      hint: "Use context.force = true or check the file first"
    };
  }
  
  return { proceed: true, confidence: result.confidence };
}

// Export for use
module.exports = { EvidenceSentry, guardDestructive };

/** 
 * USAGE EXAMPLES:
 * 
 * // Before writing a file
 * const check = guardDestructive({
 *   type: 'write',
 *   target: 'important-config.json',
 *   destructive: true
 * });
 * 
 * if (!check.proceed) {
 *   return check.warning; // Blocks the action
 * }
 * 
 * // With force flag
 * guardDestructive({...}, { force: true }); // Always proceeds
 */
