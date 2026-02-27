/**
 * OpenClaw ↔ VIBER Universal Bridge
 * Consciousness layer for OpenClaw sessions
 * 
 * Watches conversation, detects actionable items,
 * auto-creates VU session notes and tasks.
 * 
 * Location: C:/Users/rainmaker/.openclaw/viber-bridge.ts
 * Activated: Per session
 * 
 * Pattern: Bridge Pattern - connects OpenClaw to VU SQLite truth
 */

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const Database = require('better-sqlite3');

// VU Project Path
const VU_ROOT = 'C:/dev/viber-universal';
const VU_DB = path.join(VU_ROOT, '.viber/state.db');
const SESSION_NOTES_FILE = path.join(VU_ROOT, '.viber/session-notes.json');

interface DetectedPattern {
  type: 'blocker' | 'decision' | 'insight' | 'accomplishment' | 'scope_creep' | 'none';
  confidence: number;
  content: string;
  suggestedNote: string;
}

interface SessionNote {
  id: string;
  type: 'accomplishment' | 'blocker' | 'decision' | 'insight' | 'critical';
  content: string;
  timestamp: string;
  sessionId: string;
  source: 'openclaw';
  project?: string;
}

/**
 * ViberBridge - Connects OpenClaw to VU
 * 
 * Usage in OpenClaw:
 * const bridge = new ViberBridge(sessionId);
 * bridge.analyzeAndRecord(userMessage);
 */
export class ViberBridge {
  private sessionId: string;
  private db: any;
  private notes: SessionNote[] = [];
  private currentProject: string = 'general';
  private active: boolean = false;

  constructor(sessionId: string, project?: string) {
    this.sessionId = sessionId;
    this.currentProject = project || 'general';
    this.active = !!project && project !== 'general';
    
    // Connect to VU database
    try {
      this.db = new Database(VU_DB);
      console.log('[VU Bridge] Connected to', VU_DB);
    } catch (e) {
      console.error('[VU Bridge] Failed to connect to VU database:', e);
      this.db = null;
    }
    
    // Initialize session
    this.initializeSession();
  }

  /**
   * Initialize session in VU
   */
  private initializeSession(): void {
    try {
      // Create session record in VU
      if (this.db) {
        this.db.prepare(`
          INSERT OR IGNORE INTO agents (id, role, taskId, status, model, startTime)
          VALUES (?, ?, ?, 'working', ?, ?)
        `).run(
          `openclaw-${this.sessionId}`,
          'openclaw-bridge',
          'SESSION',
          'openclaw/kimi-k2.5',
          new Date().toISOString()
        );
      }
      
      // Initialize session notes file
      this.loadExistingNotes();
      
      console.log(`[VU Bridge] Session ${this.sessionId} initialized`);
    } catch (e) {
      console.error('[VU Bridge] Init error:', e);
    }
  }

  /**
   * Analyze message with PROJECT CONTEXT FILTERING
   * Only captures work-related content for active projects
   */
  analyzeAndRecord(message: string, forceProject?: string): DetectedPattern | null {
    // Skip if not in active work mode
    const projectContext = forceProject || this.currentProject;
    
    if (!this.shouldCapture(message, projectContext)) {
      return null;
    }

    const pattern = this.analyzeMessage(message);
    
    if (pattern.type !== 'none') {
      // Add project context to note
      pattern.suggestedNote = `[${projectContext.toUpperCase()}] ${pattern.suggestedNote}`;
      this.recordNote(pattern, projectContext);
      console.log(`[VU Bridge:${projectContext}] 🎯 ${pattern.type}: ${pattern.suggestedNote.substring(0, 50)}...`);
    }
    
    return pattern;
  }

  /**
   * FILTER: Should this message be captured?
   */
  private shouldCapture(message: string, project: string): boolean {
    // Skip if no active project
    if (project === 'general' || !this.active) {
      return false;
    }
    
    const lower = message.toLowerCase();
    
    // BLOCK: Casual conversation patterns
    const casualPatterns = [
      /^(hey|hi|hello|yo|what's up|how's it going|good morning|good evening)/i,
      /^(man|dude|bro|homeboy)/i,
      /^(nice|cool|awesome|great|lol|haha)/i,
      /^(thanks|thank you|appreciate|cheers)/i,
    ];
    
    for (const pattern of casualPatterns) {
      if (pattern.test(lower)) {
        return false; // Casual chat, skip
      }
    }
    
    // BLOCK: Question-only messages (not actionable)
    const questionOnly = /^(what|how|why|when|where|who|can you|could you)\s+.*\?$/i;
    if (questionOnly.test(message)) {
      return false; // Just asking, not working
    }
    
    // ALLOW: Work-related keywords
    const workKeywords = [
      /build|create|implement|fix|bug|error|broken/i,
      /task|mission|project|code|database|api|system/i,
      /safety|rollback|backup|scope|architecture|design/i,
      /agent|spawn|execute|run|test|deploy/i,
      /viber|vu|universal|orca|overlord/i,
    ];
    
    const hasWorkKeywords = workKeywords.some(p => p.test(lower));
    
    // ALLOW: Strong pattern matches (blocker/decision)
    const strongPatterns = [
      /shit.*broke|broken|bug|error|fail|crash/i,
      /let's.*(use|do|try)|we should|decided/i,
      /fixed|built|created|implemented|completed/i,
    ];
    
    const hasStrongPattern = strongPatterns.some(p => p.test(lower));
    
    // Capture if work keywords OR strong patterns
    return hasWorkKeywords || hasStrongPattern;
  }

  /**
   * Set current project context
   * Call this when switching projects
   */
  setProject(project: string): void {
    this.currentProject = project;
    this.active = project !== 'general';
    console.log(`[VU Bridge] Project set: ${project} (${this.active ? 'ACTIVE' : 'IDLE'})`);
  }

  /**
   * Get current project
   */
  getProject(): string {
    return this.currentProject;
  }

  /**
   * Pattern detection (same as ConversationMonitor)
   */
  private analyzeMessage(message: string): DetectedPattern {
    const lower = message.toLowerCase();
    
    // BLOCKER - High priority
    const blockerPatterns = [
      /shit.*broke|broken|bug|error|fail|crash|not working/i,
      /can't|cannot|unable to|stuck on/i,
      /problem|issue|broke|doesn't work|blocking/i,
      /preventing|stuck|what.*wrong|why.*broke/i,
    ];
    
    for (const pattern of blockerPatterns) {
      if (pattern.test(message)) {
        return {
          type: 'blocker',
          confidence: 0.85,
          content: message,
          suggestedNote: this.extractBlocker(message)
        };
      }
    }

    // DECISION
    const decisionPatterns = [
      /let's\s+(use|do|go with|try)|we should|decided to/i,
      /going to\s+(use|implement|add)|chosen|selected/i,
      /i think we should|how about we|let's just/i,
      /will use|decided on|picking/i,
    ];
    
    for (const pattern of decisionPatterns) {
      if (pattern.test(message)) {
        return {
          type: 'decision',
          confidence: 0.75,
          content: message,
          suggestedNote: this.extractDecision(message)
        };
      }
    }

    // INSIGHT
    const insightPatterns = [
      /i (learned|realized|discovered|figured out)/i,
      /realized that|turns out|just learned|makes sense/i,
      /now i understand|i see|aha|oh right/i,
      /the reason|because of|explains why/i,
    ];
    
    for (const pattern of insightPatterns) {
      if (pattern.test(message)) {
        return {
          type: 'insight',
          confidence: 0.70,
          content: message,
          suggestedNote: this.extractInsight(message)
        };
      }
    }

    // ACCOMPLISHMENT
    const accomplishmentPatterns = [
      /fixed|built|created|implemented|completed/i,
      /got.*working|working now|solved|done|finished/i,
      /just.*(added|built|fixed|created)/i,
      /successfully|verified|confirmed/i,
    ];
    
    for (const pattern of accomplishmentPatterns) {
      if (pattern.test(message)) {
        return {
          type: 'accomplishment',
          confidence: 0.80,
          content: message,
          suggestedNote: this.extractAccomplishment(message)
        };
      }
    }

    // SCOPE CREEP
    const scopeCreepPatterns = [
      /also.*want|additionally|by the way|while we're at it/i,
      /what about|should we also|we could also|another thing/i,
      /speaking of|that reminds me|oh and/i,
    ];
    
    for (const pattern of scopeCreepPatterns) {
      if (pattern.test(message)) {
        return {
          type: 'scope_creep',
          confidence: 0.65,
          content: message,
          suggestedNote: `Scope consideration: ${message.substring(0, 80)}`
        };
      }
    }

    return {
      type: 'none',
      confidence: 0,
      content: message,
      suggestedNote: ''
    };
  }

  // Extractors
  private extractBlocker(msg: string): string {
    // Extract the core problem
    const sentences = msg.split(/[.!?]/);
    for (const s of sentences) {
      if (/broke|bug|error|fail|not work|problem|issue/i.test(s)) {
        return s.trim().substring(0, 100);
      }
    }
    return msg.substring(0, 100);
  }

  private extractDecision(msg: string): string {
    const sentences = msg.split(/[.!?]/);
    for (const s of sentences) {
      if (/let's|we should|decided|will use|going to/i.test(s)) {
        return s.trim().substring(0, 100);
      }
    }
    return msg.substring(0, 100);
  }

  private extractInsight(msg: string): string {
    const sentences = msg.split(/[.!?]/);
    for (const s of sentences) {
      if (/learned|realized|discovered|figured|makes sense/i.test(s)) {
        return s.trim().substring(0, 100);
      }
    }
    return msg.substring(0, 100);
  }

  private extractAccomplishment(msg: string): string {
    const sentences = msg.split(/[.!?]/);
    for (const s of sentences) {
      if (/fixed|built|completed|solved|working|done/i.test(s)) {
        return s.trim().substring(0, 100);
      }
    }
    return msg.substring(0, 100);
  }

  /**
   * Record note with PROJECT CONTEXT
   */
  private recordNote(pattern: DetectedPattern, project: string): void {
    const note: SessionNote = {
      id: `note-${Date.now()}`,
      type: pattern.type as any,
      content: `[${project}] ${pattern.suggestedNote}`,
      timestamp: new Date().toISOString(),
      sessionId: this.sessionId,
      source: 'openclaw'
    };

    this.notes.push(note);
    
    // Only save if we're tracking this project
    if (project !== 'general') {
      // Write to file (for session end processing)
      this.saveNotesToFile();
      
      // Write directly to VU database (immediate persistence)
      this.saveNoteToDatabase(note, project);
      
      // For blockers: create task immediately
      if (pattern.type === 'blocker' && pattern.confidence >= 0.80) {
        this.createTaskFromBlocker(pattern, project);
      }
    }
  }

  /**
   * Save notes to session-notes.json
   */
  private saveNotesToFile(): void {
    try {
      const data = {
        sessionId: this.sessionId,
        notes: this.notes,
        startedAt: this.notes[0]?.timestamp || new Date().toISOString(),
        source: 'openclaw'
      };
      
      fs.writeFileSync(SESSION_NOTES_FILE, JSON.stringify(data, null, 2));
    } catch (e) {
      console.error('[VU Bridge] File write error:', e);
    }
  }

  /**
   * Save note directly to VU database with PROJECT
   */
  private saveNoteToDatabase(note: SessionNote, project: string): void {
    if (!this.db) return;
    
    try {
      // Store in agent_messages table as note
      this.db.prepare(`
        INSERT INTO agent_messages (id, fromRole, toRole, subject, content, timestamp, priority, read)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
      `).run(
        note.id,
        'openclaw',
        'orca',
        `note:${note.type}:${project}`,
        note.content,
        note.timestamp,
        note.type === 'blocker' ? 'high' : 'normal',
        0
      );
      
      console.log(`[VU Bridge:${project}] 💾 Saved to DB: ${note.type}`);
    } catch (e) {
      console.error('[VU Bridge] DB write error:', e);
    }
  }

  /**
   * For high-confidence blockers: create P0 task immediately with PROJECT
   */
  private createTaskFromBlocker(pattern: DetectedPattern, project: string): void {
    if (!this.db) return;
    
    try {
      const taskId = `VBR-UN-AUTO-${Date.now().toString(36).substr(-6).toUpperCase()}`;
      
      this.db.prepare(`
        INSERT INTO missions (task_id, title, justification, description, status, logic_status, probability, created_at, updated_at)
        VALUES (?, ?, ?, ?, 'backlog', 'peak', 0.95, datetime('now'), datetime('now'))
      `).run(
        taskId,
        `[${project}] BLOCKER: ${pattern.suggestedNote.substring(0, 50)}`,
        `Auto-generated from OpenClaw session. Project: ${project}`,
        `Pattern: ${pattern.content}\nProject: ${project}\nDetected: ${new Date().toISOString()}\nSession: ${this.sessionId}`
      );
      
      console.log(`[VU Bridge:${project}] 🚨 Created P0 task: ${taskId}`);
      
      // Update dashboard
      this.emitDashboardEvent('task_created', { taskId, project, type: 'blocker' });
    } catch (e) {
      console.error('[VU Bridge] Task creation error:', e);
    }
  }

  /**
   * Emit event to dashboard
   */
  private emitDashboardEvent(type: string, data: any): void {
    // Would emit to SSE/events system
    console.log(`[VU Bridge] 📡 Dashboard event: ${type}`, data);
  }

  /**
   * Load existing notes if resuming
   */
  private loadExistingNotes(): void {
    try {
      if (fs.existsSync(SESSION_NOTES_FILE)) {
        const data = JSON.parse(fs.readFileSync(SESSION_NOTES_FILE, 'utf-8'));
        if (data.sessionId === this.sessionId) {
          this.notes = data.notes || [];
        }
      }
    } catch (e) {
      // No existing notes
    }
  }

  /**
   * Get summary of session
   */
  getSummary(): { notes: number; byType: Record<string, number> } {
    const byType: Record<string, number> = {};
    this.notes.forEach(n => {
      byType[n.type] = (byType[n.type] || 0) + 1;
    });
    
    return {
      notes: this.notes.length,
      byType
    };
  }

  /**
   * End session - triggers TaskGenerator
   */
  endSession(): void {
    console.log('[VU Bridge] 📋 Session ending...');
    
    const summary = this.getSummary();
    console.log(`[VU Bridge] Notes captured: ${summary.notes}`);
    console.log(`[VU Bridge] By type:`, summary.byType);
    
    // Write final handoff
    this.saveNotesToFile();
    
    // Close database
    if (this.db) {
      this.db.close();
    }
    
    console.log('[VU Bridge] ✅ Session ended. View tasks at http://localhost:1576');
  }
}

/**
 * Quick usage for OpenClaw integration
 * 
 * USAGE:
 * initViberBridge('session-123', 'viber-universal')  // Activate for VU work
 * analyzeWithViber(message)                            // Only captures work
 * 
 * initViberBridge('session-456', 'general')           // Deactivate - no capture
 */
let bridge: ViberBridge | null = null;

export function initViberBridge(sessionId: string, project?: string): ViberBridge {
  bridge = new ViberBridge(sessionId, project);
  console.log(`[VU Bridge] Initialized: ${project || 'general'}`);
  
  if (!project || project === 'general') {
    console.log('   Mode: IDLE - Not capturing (set project to activate)');
  } else {
    console.log('   Mode: ACTIVE - Capturing work for', project);
  }
  
  return bridge;
}

export function setProjectContext(project: string): void {
  if (bridge) {
    bridge.setProject(project);
  } else {
    console.log('[VU Bridge] Not initialized. Call initViberBridge first.');
  }
}

export function getViberBridge(): ViberBridge | null {
  return bridge;
}

export function setProjectContext(project: string): void {
  if (bridge) {
    bridge.setProject(project);
  } else {
    console.log('[VU Bridge] Not initialized. Call initViberBridge first.');
  }
}

export function analyzeWithViber(message: string): DetectedPattern | null {
  if (!bridge) {
    // Silent fail - bridge not active
    return null;
  }
  return bridge.analyzeAndRecord(message);
}

/**
 * Check if we're in active work mode
 */
export function isViberActive(): boolean {
  return bridge !== null && bridge.getProject() !== 'general';
}

export function endViberSession(): void {
  if (bridge) {
    bridge.endSession();
    bridge = null;
  }
}

// Export types
export { DetectedPattern, SessionNote };
