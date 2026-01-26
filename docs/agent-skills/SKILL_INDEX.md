# Tectonic LaTeX Agent Skills Index

This directory contains modular agent skills for working with the Tectonic LaTeX document generation system. Each skill is a self-contained bundle of instructions, validation rules, and execution patterns.

## Available Skills

### 1. [LaTeX Compilation Skill](latex-compilation/SKILL.md)
**Purpose:** Compile LaTeX documents using the dev container environment  
**Use When:** User needs to build, compile, or generate PDFs from .tex files  
**Key Features:** Container verification, error diagnosis, output validation

### 2. [LaTeX Document Creation Skill](latex-document-creation/SKILL.md)
**Purpose:** Create new compliant LaTeX documents from templates  
**Use When:** User wants to create a new financial case study document  
**Key Features:** Template usage, brand compliance, legal disclaimers

### 3. [LaTeX Conversion Skill](latex-conversion/SKILL.md)
**Purpose:** Convert raw LaTeX files to repository-compliant format  
**Use When:** User provides non-compliant LaTeX that needs standardization  
**Key Features:** 7-phase workflow, validation gates, systematic transformation

### 4. [LaTeX Validation Skill](latex-validation/SKILL.md)
**Purpose:** Validate LaTeX documents for compliance and common errors  
**Use When:** User needs to check document quality before compilation  
**Key Features:** Pre-compilation checks, error pattern detection, legal compliance verification

## Skill Architecture

```
docs/agent-skills/
├── SKILL_INDEX.md                    # This file
├── latex-compilation/
│   ├── SKILL.md                      # Compilation skill
│   └── resources/
│       └── error-patterns.md
├── latex-document-creation/
│   ├── SKILL.md                      # Document creation skill
│   └── resources/
│       ├── template-guide.md
│       └── brand-colors.md
├── latex-conversion/
│   ├── SKILL.md                      # Conversion skill
│   └── resources/
│       ├── phase-checklist.md
│       └── validation-gates.md
└── latex-validation/
    ├── SKILL.md                      # Validation skill
    └── resources/
        └── compliance-checklist.md
```

## Progressive Disclosure Design

Each skill follows the three-level loading pattern:

1. **Level 1: Metadata (Always Loaded)**
   - Skill name, description, usage triggers
   - Loaded for skill discovery and intent matching

2. **Level 2: Instructions (Loaded on Trigger)**
   - Step-by-step procedures
   - Decision trees and validation gates
   - Common patterns and examples

3. **Level 3: Resources (Loaded on Reference)**
   - Detailed templates and checklists
   - Error pattern libraries
   - Troubleshooting guides

## Skill Selection Decision Tree

```
User request about LaTeX?
│
├─ Compiling existing .tex file? → latex-compilation
│
├─ Creating new document from scratch? → latex-document-creation
│
├─ Converting/fixing non-compliant LaTeX? → latex-conversion
│
└─ Checking for errors/compliance? → latex-validation
```

## Integration with Existing Documentation

These skills distill and modularize content from:
- `.agent/AGENT.md` - Overall project guidance
- `workflow/LLM_INSTRUCTIONS.md` - Quick reference
- `docs/process/LLM_WORKFLOW.md` - Detailed workflow
- `docs/latex/LATEX_STYLE_GUIDE.md` - Technical specification

**Benefits of Agent Skills:**
- **Modular:** Load only the skill needed for current task
- **Reusable:** Skills work independently and can be composed
- **Maintainable:** Update one skill without affecting others
- **Context-efficient:** Progressive loading saves tokens
- **Discoverable:** Clear metadata helps match intent to skill

## Usage Example

```
User: "Compile intelapple.tex"
Agent: Loads latex-compilation skill → Follows execution steps

User: "Create a new financial case study"
Agent: Loads latex-document-creation skill → Uses template workflow

User: "Fix this raw LaTeX file"
Agent: Loads latex-conversion skill → Executes 7-phase conversion

User: "Check if my document is compliant"
Agent: Loads latex-validation skill → Runs validation checks
```

## Maintenance Notes

- Keep skills focused on single responsibilities
- Update resources without modifying core skill logic
- Test skills independently before integration
- Version skill changes in metadata
- Document cross-skill dependencies if any

---

*Last Updated: 2026-01-19*  
*Based on: Tectonic LaTeX Project v2.0*  
*Skill Format: Claude Agent Skills Standard*
