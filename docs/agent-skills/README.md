# Agent Skills - Tectonic LaTeX Workflows

This directory contains modular **agent skills** that package the Tectonic LaTeX project's workflows into reusable, composable units following the [Claude Agent Skills](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview) standard.

## Quick Start

### For AI Agents

**Starting a task?** Follow this decision tree:

```
What do you need to do?
│
├─ Compile a .tex file → Use latex-compilation skill
├─ Create new document → Use latex-document-creation skill
├─ Fix non-compliant LaTeX → Use latex-conversion skill
└─ Check compliance → Use latex-validation skill
```

**How to use a skill:**

1. Read the skill: `docs/agent-skills/{skill-name}/SKILL.md`
2. Check "When to Use" section to confirm it's right
3. Follow "Execution Steps" in order
4. Check validation gates before proceeding
5. Report results to user

### For Developers

**Integrating skills into your AI system?**

1. Read: [IMPLEMENTATION_GUIDE.md](./IMPLEMENTATION_GUIDE.md)
2. Start with manual skill loading (simplest)
3. Implement progressive loading (optimal)
4. Add intent matching (automated skill selection)

## What's Inside

### Core Documentation

- **[SKILL_INDEX.md](./SKILL_INDEX.md)** - Master index of all available skills
- **[IMPLEMENTATION_GUIDE.md](./IMPLEMENTATION_GUIDE.md)** - Complete integration guide for developers
- **README.md** - This file

### Skills

Each skill has its own directory with:
- `SKILL.md` - Metadata + executable instructions
- `resources/` - Additional reference materials (optional)

| Skill | Purpose | Priority | Lines |
|-------|---------|----------|-------|
| [latex-compilation](./latex-compilation/SKILL.md) | Compile LaTeX in containers | Critical | 450 |
| [latex-document-creation](./latex-document-creation/SKILL.md) | Create compliant documents | High | 600 |
| [latex-conversion](./latex-conversion/SKILL.md) | Fix non-compliant LaTeX | High | 750 |
| [latex-validation](./latex-validation/SKILL.md) | Validate compliance | Medium | 700 |

## Architecture

### Progressive Disclosure

Skills use three-level loading to save context tokens:

**Level 1: Metadata (Always Loaded)**
```yaml
---
name: latex-compilation
description: Compile LaTeX documents...
usage: |
  - "Compile this file"
  - "Build PDF"
---
```

**Level 2: Instructions (Loaded on Trigger)**
```markdown
## Execution Steps

### Step 1: Check Container
...

### Step 2: Navigate
...
```

**Level 3: Resources (Loaded on Reference)**
```
resources/
├── error-patterns.md
├── visual-checklist.md
└── container-troubleshooting.md
```

### Skill Composition

Skills can be combined for complex workflows:

```
User: "Create and compile a new case study"

Agent workflow:
  1. Use latex-document-creation
     └─ Creates structure from template
  
  2. Use latex-validation
     └─ Checks compliance
  
  3. Use latex-compilation
     └─ Generates PDF
```

## Relationship to Existing Documentation

Agent skills **distill** existing comprehensive documentation:

```
┌─────────────────────────────────────────────────────────────┐
│ Comprehensive Reference Documentation                       │
├─────────────────────────────────────────────────────────────┤
│ .agent/AGENT.md                  → 770 lines                │
│ workflow/LLM_INSTRUCTIONS.md     → 540 lines                │
│ docs/process/LLM_WORKFLOW.md     → 1373 lines               │
│ docs/latex/LATEX_STYLE_GUIDE.md  → 2000+ lines              │
└─────────────────────────────────────────────────────────────┘
                         ↓ Extracted & Packaged
┌─────────────────────────────────────────────────────────────┐
│ Modular Agent Skills (Executable Workflows)                 │
├─────────────────────────────────────────────────────────────┤
│ latex-compilation                → 450 lines                │
│ latex-document-creation          → 600 lines                │
│ latex-conversion                 → 750 lines                │
│ latex-validation                 → 700 lines                │
└─────────────────────────────────────────────────────────────┘
```

**Benefits:**
- ✅ **Modular**: Load only what you need
- ✅ **Executable**: Clear step-by-step instructions
- ✅ **Validated**: Validation gates at each phase
- ✅ **Maintainable**: Update one skill independently
- ✅ **Composable**: Combine skills for complex tasks

**Original docs remain as:**
- Comprehensive reference material
- Historical context and rationale
- Detailed technical specifications
- Learning resources

## Usage Patterns

### Pattern 1: Direct Execution

**User provides clear task:**

```
User: "Compile intelapple.tex"

Agent:
  1. Identifies: latex-compilation skill
  2. Loads: latex-compilation/SKILL.md
  3. Executes: Steps 1-8 sequentially
  4. Reports: Success/failure with details
```

### Pattern 2: Validation First

**User wants quality assurance:**

```
User: "Check this document before compiling"

Agent:
  1. Uses: latex-validation skill
  2. Runs: All compliance checks
  3. Reports: Issues found
  4. If clean: Offers to compile with latex-compilation
```

### Pattern 3: End-to-End

**User wants complete workflow:**

```
User: "Convert this raw LaTeX and compile it"

Agent:
  1. Uses: latex-conversion skill (Phases 0-7)
  2. Uses: latex-validation skill (verify quality)
  3. Uses: latex-compilation skill (generate PDF)
  4. Reports: Complete with conversion report + PDF
```

### Pattern 4: Iterative Refinement

**User needs fixes:**

```
User: "This won't compile, fix it"

Agent:
  1. Uses: latex-compilation skill
     └─ Fails with error details
  
  2. Uses: latex-validation skill
     └─ Identifies specific issues
  
  3. Applies fixes from validation results
  
  4. Uses: latex-compilation skill (retry)
     └─ Succeeds
```

## Best Practices

### For AI Agents Using Skills

✅ **DO:**
- Read entire skill before starting
- Follow steps sequentially
- Check validation gates before proceeding
- Report detailed results to user
- Compose skills for complex workflows

❌ **DON'T:**
- Skip steps or reorder arbitrarily
- Ignore validation gate failures
- Proceed with partial information
- Assume context from previous tasks
- Mix instructions from multiple skills

### For Developers Integrating Skills

✅ **DO:**
- Parse YAML frontmatter for metadata
- Implement progressive loading
- Cache skill metadata
- Log skill usage and errors
- Version control skills with code

❌ **DON'T:**
- Load entire skill into context unnecessarily
- Hardcode skill selection logic
- Modify skills during execution
- Skip error handling
- Ignore version numbers

## Examples

### Example 1: Simple Compilation

```bash
# Agent reads: latex-compilation/SKILL.md
# Agent executes:

# Step 1: Check container
cat /etc/os-release | grep Debian  # ✅ In container

# Step 4: Compile
latexmk -pdf -interaction=nonstopmode intelapple.tex

# Step 6: Verify
ls -lh intelapple.pdf  # ✅ 2.3 MB

# Agent reports:
# "✅ Compilation successful. PDF generated: intelapple.pdf (2.3 MB)"
```

### Example 2: Document Creation

```bash
# Agent reads: latex-document-creation/SKILL.md
# Agent executes:

# Step 1: Gather requirements
# Agent asks user: "What's the topic? Ticker? Main sections?"

# Step 2: Copy template
mkdir -p work/intel_analysis
cp templates/template.tex work/intel_analysis/source/document.tex

# Step 3: Customize metadata
# Agent edits: \reporttitle{INTC}{Intel Analysis}{...}

# Step 10: Compile
latexmk -pdf document.tex

# Agent reports:
# "✅ Document created and compiled. Ready for content."
```

### Example 3: Conversion Workflow

```bash
# Agent reads: latex-conversion/SKILL.md
# Agent executes all 7 phases:

# Phase 0: Setup
mkdir -p work/conversion/
cp incoming/raw.tex work/conversion/source/original.tex

# Phase 1: Fix preamble (validation gate passed)
# Phase 2: Fix structure (validation gate passed)
# Phase 3: Fix tables (validation gate passed)
# Phase 4: Fix charts (validation gate passed)
# Phase 5: Add legal disclaimers (validation gate passed)
# Phase 6: Compile (validation gate passed)
# Phase 7: Create report

# Agent reports:
# "✅ Conversion complete. Quality score: 85/100. Report: work/conversion/CONVERSION_REPORT.md"
```

## Testing Skills

### Manual Testing

```bash
# Test each skill with sample data
cd /home/runner/work/tectonic/tectonic

# Test compilation
docs/agent-skills/latex-compilation/SKILL.md → Execute with templates/intelapple.tex

# Test validation
docs/agent-skills/latex-validation/SKILL.md → Execute with any .tex file

# Verify success criteria met
```

### Automated Testing

```bash
# Create test suite
tests/test_agent_skills.sh

# Run against all skills
./tests/test_agent_skills.sh --all

# Expected: All skills pass validation
```

## Contributing

### Adding a New Skill

1. **Identify workflow** that needs packaging
2. **Create directory:** `docs/agent-skills/new-skill/`
3. **Write SKILL.md** with YAML frontmatter
4. **Add resources** if needed
5. **Update SKILL_INDEX.md**
6. **Test with real agent**
7. **Document in IMPLEMENTATION_GUIDE.md**

### Updating a Skill

1. **Increment version** in YAML frontmatter
2. **Update instructions** as needed
3. **Test changes** with real scenarios
4. **Document breaking changes** in skill notes
5. **Update related skills** if dependencies changed

## Support

### Getting Help

📖 **Documentation:**
- Start with [SKILL_INDEX.md](./SKILL_INDEX.md) for overview
- Read [IMPLEMENTATION_GUIDE.md](./IMPLEMENTATION_GUIDE.md) for integration
- Check individual SKILL.md files for specific tasks

🔧 **Troubleshooting:**
- Each skill has "Troubleshooting" section
- Check "Common Errors" in skill resources
- Review validation gate criteria

📚 **Reference:**
- Original docs in `/.agent/`, `/workflow/`, `/docs/`
- Style guides in `/docs/latex/`
- Process workflows in `/docs/process/`

### Reporting Issues

**Skill doesn't work:**
- Note which skill and step number
- Share input provided to skill
- Include error messages
- Suggest fix if known

**Missing workflow:**
- Describe task not covered
- Explain current manual process
- Propose skill structure

## Version History

- **v1.0.0** (2026-01-19)
  - Initial release with 4 core skills
  - Based on existing workflow documentation
  - Implements Claude Agent Skills standard
  - Progressive disclosure architecture

## License

Same license as parent project (see repository root).

---

**Quick Links:**
- [SKILL_INDEX.md](./SKILL_INDEX.md) - All available skills
- [IMPLEMENTATION_GUIDE.md](./IMPLEMENTATION_GUIDE.md) - Integration guide
- [latex-compilation/SKILL.md](./latex-compilation/SKILL.md) - Compilation workflow
- [latex-document-creation/SKILL.md](./latex-document-creation/SKILL.md) - Document creation
- [latex-conversion/SKILL.md](./latex-conversion/SKILL.md) - Conversion workflow
- [latex-validation/SKILL.md](./latex-validation/SKILL.md) - Validation checks

*For comprehensive reference documentation, see parent directory `/docs/`*
