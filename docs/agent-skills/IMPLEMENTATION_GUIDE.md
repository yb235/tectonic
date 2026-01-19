# Agent Skills Implementation Guide

This guide explains how to use the Tectonic LaTeX agent skills in your AI workflow systems.

## Overview

The Tectonic LaTeX project has packaged its workflows into **modular agent skills** following the Claude Agent Skills standard. These skills enable AI agents to perform complex LaTeX document generation and compliance tasks with progressive context loading.

## What Are Agent Skills?

Agent skills are filesystem-based bundles that:
- **Encapsulate procedural knowledge** for specific tasks
- **Load progressively** to save context tokens (metadata → instructions → resources)
- **Compose together** for complex workflows
- **Remain maintainable** through modular architecture

## Available Skills

| Skill Name | Purpose | When to Use |
|------------|---------|-------------|
| **latex-compilation** | Compile LaTeX in containers | Building PDFs, troubleshooting compilation |
| **latex-document-creation** | Create new compliant docs | Starting from scratch |
| **latex-conversion** | Fix non-compliant LaTeX | Converting raw/legacy files |
| **latex-validation** | Check compliance & quality | Pre-compilation validation |

## Skill Architecture

```
docs/agent-skills/
├── SKILL_INDEX.md                    # Master index (this guide)
├── latex-compilation/
│   ├── SKILL.md                      # Metadata + instructions
│   └── resources/                    # Additional resources
├── latex-document-creation/
│   ├── SKILL.md
│   └── resources/
├── latex-conversion/
│   ├── SKILL.md
│   └── resources/
└── latex-validation/
    ├── SKILL.md
    └── resources/
```

## How to Use Agent Skills

### Option 1: Direct Reference (Manual)

Agents can read skills directly from the filesystem:

```
1. User makes request: "Compile intelapple.tex"
2. Agent identifies relevant skill: latex-compilation
3. Agent reads: docs/agent-skills/latex-compilation/SKILL.md
4. Agent follows instructions in skill
5. Agent executes workflow steps
```

**Advantages:**
- Simple implementation
- No infrastructure required
- Works with any AI system

**Disadvantages:**
- Agent must manually select skill
- Full skill loaded into context (not progressive)

### Option 2: Progressive Loading (Advanced)

For systems supporting progressive disclosure:

```
1. Load ALL skill metadata (YAML frontmatter only)
2. User request → Match intent to skill via usage patterns
3. Load selected skill instructions (SKILL.md body)
4. Load resources only if referenced during execution
```

**Advantages:**
- Context-efficient (loads only what's needed)
- Scales to many skills
- Follows Claude Agent Skills standard

**Disadvantages:**
- Requires parser for YAML frontmatter
- Needs intent matching logic

### Option 3: Tool-Based (Integration)

For AI systems with tool/function support:

```python
# Pseudo-code example
def use_skill(skill_name: str, context: dict) -> str:
    """Execute an agent skill with given context"""
    skill_path = f"docs/agent-skills/{skill_name}/SKILL.md"
    instructions = parse_skill(skill_path)
    return execute_with_instructions(instructions, context)

# Agent calls tool
result = use_skill("latex-compilation", {"file": "intelapple.tex"})
```

**Advantages:**
- Clean abstraction
- Trackable execution
- Easy to add new skills

**Disadvantages:**
- Requires tool infrastructure
- Agent must know when to use tool

## Usage Examples

### Example 1: Simple Compilation

**User:** "Compile intelapple.tex"

**Agent Flow:**
1. Recognize: LaTeX compilation task
2. Load skill: `latex-compilation/SKILL.md`
3. Follow Step 1: Check container status
4. Follow Step 2-8: Navigate, compile, verify
5. Report results to user

### Example 2: Create New Document

**User:** "Create a financial case study about Intel"

**Agent Flow:**
1. Recognize: New document creation
2. Load skill: `latex-document-creation/SKILL.md`
3. Follow Step 1: Gather requirements (ask user)
4. Follow Step 2-11: Copy template, customize, compile
5. Hand off completed structure to user

### Example 3: Fix Non-Compliant File

**User:** "Fix this LaTeX file to be compliant" + provides file

**Agent Flow:**
1. Recognize: Conversion/compliance task
2. Load skill: `latex-conversion/SKILL.md`
3. Follow Phase 0-7: Systematic conversion workflow
4. At each phase: Run validation gates
5. Generate conversion report
6. Deliver compliant document

### Example 4: Skill Composition

**User:** "Create and compile a new case study"

**Agent Flow:**
1. Use `latex-document-creation` to create structure
2. Use `latex-validation` to check quality
3. Use `latex-compilation` to generate PDF
4. Report completion with PDF location

## Intent Matching Patterns

To automatically select the right skill, match user intent against usage patterns:

```yaml
# From latex-compilation/SKILL.md
usage: |
  - "Compile intelapple.tex"
  - "Build the PDF from this LaTeX file"
  - "Generate the document"
  - "Fix compilation errors"
  - "Why isn't my .tex file compiling?"
```

**Matching Logic:**
- Keywords: "compile", "build", "generate PDF", "compilation error"
- Context: User has .tex file, wants PDF output
- → Select: `latex-compilation`

```yaml
# From latex-conversion/SKILL.md  
usage: |
  - "Fix this LaTeX file to be compliant"
  - "Convert this raw LaTeX to our format"
  - "Make this document follow our standards"
  - "Clean up this LaTeX code"
```

**Matching Logic:**
- Keywords: "fix", "convert", "compliant", "standards", "clean up"
- Context: User has non-compliant LaTeX
- → Select: `latex-conversion`

## Integration with Existing Documentation

The agent skills **distill and modularize** existing documentation:

```
Existing Docs → Agent Skills
├── .agent/AGENT.md → Packaged into 4 skills
├── workflow/LLM_INSTRUCTIONS.md → Referenced by skills
├── docs/process/LLM_WORKFLOW.md → Converted to latex-conversion skill
└── docs/latex/LATEX_STYLE_GUIDE.md → Referenced in resources
```

**Benefits:**
- Skills provide executable workflows
- Original docs remain as comprehensive reference
- No duplication - skills reference original docs for details

## Skill Development Workflow

### Creating a New Skill

1. **Identify the workflow pattern**
   - What task is this skill for?
   - What are the inputs/outputs?
   - What are the steps?

2. **Create skill directory**
   ```bash
   mkdir -p docs/agent-skills/skill-name/resources
   ```

3. **Write SKILL.md with frontmatter**
   ```markdown
   ---
   name: skill-name
   description: What this skill does
   usage: |
     - "Example trigger 1"
     - "Example trigger 2"
   version: 1.0.0
   priority: high/medium/low
   ---
   
   # Skill Name
   
   ## Overview
   ...
   
   ## When to Use
   ...
   
   ## Execution Steps
   ...
   ```

4. **Add to SKILL_INDEX.md**

5. **Test with real agent**

6. **Iterate based on usage**

### Updating an Existing Skill

1. **Update version number** in YAML frontmatter
2. **Modify instructions** as needed
3. **Add to resources/** if new reference material
4. **Update SKILL_INDEX.md** if major changes
5. **Test updated skill**

## Best Practices

### For Skill Authors

1. **Keep skills focused** - One skill, one task type
2. **Write step-by-step** - Clear, executable instructions
3. **Include decision trees** - Help agents choose correctly
4. **Provide examples** - Show successful execution
5. **Add validation gates** - Prevent errors early
6. **Reference, don't duplicate** - Link to detailed docs

### For Skill Users (Agents)

1. **Read metadata first** - Understand what skill does
2. **Follow steps sequentially** - Don't skip or reorder
3. **Check validation gates** - Don't proceed if failed
4. **Use decision trees** - For branching logic
5. **Consult resources** - When instructions reference them
6. **Report issues** - If skill doesn't work as expected

### For Integration Developers

1. **Parse YAML frontmatter** - For progressive loading
2. **Implement intent matching** - Automate skill selection
3. **Cache skill metadata** - Avoid repeated file reads
4. **Log skill execution** - Track which skills used when
5. **Handle errors gracefully** - Fallback to manual selection
6. **Monitor performance** - Optimize slow skills

## Troubleshooting

### Problem: Agent doesn't know which skill to use

**Solution:** 
- Improve intent matching patterns
- Add more usage examples to YAML frontmatter
- Provide explicit skill selection option to user

### Problem: Skill instructions are too long

**Solution:**
- Move detailed content to resources/
- Reference existing documentation instead of duplicating
- Split into multiple focused skills if appropriate

### Problem: Skills not composing well together

**Solution:**
- Define clear input/output contracts for each skill
- Add "Related Skills" section showing composition patterns
- Create meta-skill that orchestrates multiple skills

### Problem: Skills get out of sync with codebase

**Solution:**
- Version control skills with code
- Update skills when changing workflows
- Test skills regularly with actual tasks

## Testing Agent Skills

### Manual Testing

```bash
# 1. Read skill manually
cat docs/agent-skills/latex-compilation/SKILL.md

# 2. Execute steps manually
# Follow each step in order

# 3. Verify success criteria
# Check that all validation gates pass
```

### Automated Testing

```bash
# Create test harness
# tests/test_agent_skills.sh

#!/bin/bash
# Test latex-compilation skill
echo "Testing latex-compilation skill..."
cd /workspaces/tectonic
cp templates/template.tex /tmp/test.tex

# Execute skill steps programmatically
# (Validate each step succeeds)

echo "✅ All skill tests passed"
```

### Agent Testing

```
Prompt AI agent with test scenarios:
1. "Compile templates/intelapple.tex"
2. "Create a new case study about Topic X"
3. "Fix this non-compliant LaTeX: [paste]"
4. "Check if my document is compliant"

Verify:
- Agent selects correct skill
- Agent follows steps in order
- Agent completes task successfully
```

## Migration Guide

### From .agent/AGENT.md to Agent Skills

**Old Approach:**
```
Agent reads entire .agent/AGENT.md (770 lines)
→ All context loaded upfront
→ Agent must find relevant section
```

**New Approach:**
```
Agent reads skill metadata (10 lines)
→ Agent matches intent to skill
→ Agent loads only relevant skill (200-300 lines)
→ Agent references resources if needed
```

**Benefits:**
- 60-70% reduction in context usage
- Faster task identification
- Clearer execution flow

### From Manual Instructions to Skills

**Before:**
```
User: "Compile this file"
Agent: Reads entire workflow documentation
Agent: Tries to extract compilation steps
Agent: May miss critical requirements (container check)
```

**After:**
```
User: "Compile this file"
Agent: Loads latex-compilation skill
Agent: Follows structured steps with validation
Agent: Guaranteed to check container first (Priority 0)
```

## Metrics and Monitoring

### Success Metrics for Skills

- **Completion Rate:** % of tasks completed successfully
- **Error Rate:** % of tasks that fail validation or execution
- **Time to Complete:** Average execution time per skill
- **Context Usage:** Tokens consumed per skill invocation
- **Skill Selection Accuracy:** % of times correct skill chosen

### Monitoring Skill Health

```python
# Example monitoring structure
{
  "skill_name": "latex-compilation",
  "invocations": 150,
  "successes": 142,
  "failures": 8,
  "avg_duration_seconds": 45,
  "avg_tokens_used": 2500,
  "common_errors": [
    "container_not_started: 5",
    "file_not_found: 2",
    "compilation_error: 1"
  ]
}
```

## Future Enhancements

### Planned Skills

1. **latex-table-generation** - Generate tables from data
2. **latex-chart-generation** - Generate charts from data
3. **latex-style-checking** - Deep style analysis
4. **latex-citation-management** - Bibliography handling

### Planned Features

1. **Skill versioning** - Multiple versions of same skill
2. **Skill dependencies** - Skills that require other skills
3. **Skill marketplace** - Share skills across projects
4. **Skill analytics** - Usage tracking and optimization

## Support and Feedback

### Getting Help

1. **Read skill documentation** - SKILL.md for each skill
2. **Check SKILL_INDEX.md** - Master reference
3. **Review original docs** - Comprehensive guides in `/docs`
4. **Check examples** - Each skill includes usage examples

### Reporting Issues

**Skill doesn't work as expected:**
- Note which skill and which step failed
- Provide input/context given to skill
- Share error messages or unexpected output
- Suggest improvements to skill instructions

**Missing workflow:**
- Describe the task not covered by existing skills
- Explain current manual process
- Suggest how it could be structured as a skill

## Conclusion

The Tectonic LaTeX agent skills provide a modular, maintainable way to package complex workflows for AI agents. By following the Claude Agent Skills standard, these skills enable:

✅ **Progressive disclosure** - Load only what's needed  
✅ **Clear structure** - Step-by-step executable instructions  
✅ **Validation gates** - Catch errors early  
✅ **Composability** - Combine skills for complex tasks  
✅ **Maintainability** - Update one skill without affecting others

Start with the **latex-compilation** skill for a simple integration, then expand to other skills as needed.

---

*Implementation Guide Version: 1.0.0*  
*Last Updated: 2026-01-19*  
*Compatible With: Claude Agent Skills Standard*  
*Project: Tectonic LaTeX v2.0+*
