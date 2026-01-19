# Agent Skills Quick Reference

**Choose your skill in 3 seconds:**

```
┌─────────────────────────────────────────────────────────────┐
│  What do you need to do?                                    │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  📄 Compile existing .tex file                              │
│     → latex-compilation/SKILL.md                            │
│                                                              │
│  ✨ Create NEW document from scratch                        │
│     → latex-document-creation/SKILL.md                      │
│                                                              │
│  🔧 Fix/convert NON-COMPLIANT LaTeX                         │
│     → latex-conversion/SKILL.md                             │
│                                                              │
│  ✅ Check compliance BEFORE compiling                       │
│     → latex-validation/SKILL.md                             │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## Skill Summary Cards

### 🔨 latex-compilation
**When:** User says "compile", "build", "generate PDF"  
**Input:** .tex file path  
**Output:** PDF file + status report  
**Key Step:** ALWAYS check container first (Priority 0)  
**Time:** ~1 minute  
**Lines:** 450

### 📝 latex-document-creation
**When:** User says "create new", "start fresh", "new case study"  
**Input:** Topic, ticker, sections  
**Output:** Compliant .tex structure + initial PDF  
**Key Step:** Copy template, customize, validate legal  
**Time:** ~5 minutes  
**Lines:** 600

### 🔄 latex-conversion
**When:** User says "fix", "convert", "make compliant"  
**Input:** Non-compliant .tex file  
**Output:** Compliant .tex + conversion report  
**Key Step:** 7 phases with validation gates  
**Time:** ~15 minutes  
**Lines:** 750

### ✅ latex-validation
**When:** User says "check", "validate", "is this compliant?"  
**Input:** .tex file  
**Output:** Validation report with issues  
**Key Step:** 3-level checks (critical, quality, best practice)  
**Time:** ~30 seconds  
**Lines:** 700

## Common Workflows

### Workflow 1: Simple Compilation
```
User: "Compile intelapple.tex"
↓
Use: latex-compilation
↓
Result: PDF generated
```

### Workflow 2: New Document
```
User: "Create case study about Intel"
↓
Use: latex-document-creation
↓
Result: Structured .tex + initial PDF
```

### Workflow 3: Fix Existing
```
User: "This file doesn't meet standards"
↓
Use: latex-conversion (7 phases)
↓
Result: Compliant .tex + report
```

### Workflow 4: Quality Assurance
```
User: "Check before I compile"
↓
Use: latex-validation
↓
If issues: Fix them
↓
Use: latex-compilation
↓
Result: Validated + compiled PDF
```

### Workflow 5: End-to-End
```
User: "Convert and compile this"
↓
Use: latex-conversion
↓
Use: latex-validation
↓
Use: latex-compilation
↓
Result: Complete pipeline executed
```

## Skill Features at a Glance

| Feature | Compilation | Creation | Conversion | Validation |
|---------|-------------|----------|------------|------------|
| Container check | ✅ Priority 0 | ✅ Step 10 | ✅ Phase 6 | ❌ Not needed |
| Validation gates | ✅ Pre/post | ✅ Step 9 | ✅ Every phase | ✅ Built-in |
| Error diagnosis | ✅ Pattern match | ✅ On fail | ✅ All phases | ✅ 3 levels |
| Legal compliance | ❌ Assumes present | ✅ Built-in | ✅ Phase 5 | ✅ Level 1 check |
| Example code | ✅ 3 examples | ✅ 2 examples | ✅ 3 examples | ✅ 3 examples |
| Decision trees | ✅ 2 trees | ✅ 2 trees | ✅ 3 trees | ✅ 2 trees |

## Integration Cheat Sheet

### Option 1: Manual (Simplest)
```python
skill = read_file("docs/agent-skills/latex-compilation/SKILL.md")
execute(skill)
```

### Option 2: Progressive (Recommended)
```python
# Load metadata only
metadata = load_all_skill_metadata()

# Match intent
skill = match_intent(user_input, metadata)

# Load instructions
instructions = load_skill_body(skill)

# Execute
result = execute(instructions)
```

### Option 3: Tool-Based (Advanced)
```python
@tool
def use_skill(name: str, context: dict):
    return execute_skill(name, context)

# Agent calls
result = use_skill("latex-compilation", {"file": "doc.tex"})
```

## Troubleshooting Guide

| Problem | Check First | Solution |
|---------|-------------|----------|
| Skill not working | Is SKILL.md present? | Verify file exists |
| Wrong skill selected | Review usage patterns | Update intent matching |
| Steps unclear | Read examples | Follow example pattern |
| Validation fails | Check gates | Fix issues before proceeding |
| Compilation errors | Container running? | Start container first |

## File Locations

```
docs/agent-skills/
├── README.md                           ← Start here
├── SKILL_INDEX.md                      ← All skills listed
├── IMPLEMENTATION_GUIDE.md             ← Integration guide
├── AGENT_SKILLS_SUMMARY.md             ← Complete summary
├── QUICK_REFERENCE.md                  ← This file
│
├── latex-compilation/
│   └── SKILL.md                        ← Compilation skill
│
├── latex-document-creation/
│   └── SKILL.md                        ← Creation skill
│
├── latex-conversion/
│   └── SKILL.md                        ← Conversion skill
│
└── latex-validation/
    └── SKILL.md                        ← Validation skill
```

## Key Concepts

### Progressive Disclosure
- **Level 1:** Metadata only (10 lines)
- **Level 2:** Instructions (400-700 lines)
- **Level 3:** Resources (as needed)

### Validation Gates
- Check criteria before proceeding
- Prevents cascading errors
- Clear pass/fail status

### Skill Composition
- Use multiple skills in sequence
- Output of one → input of next
- Build complex workflows

### Version Control
- Each skill has version number
- Update skills independently
- Track breaking changes

## Best Practices

✅ **DO:**
- Read entire skill before starting
- Follow steps in order
- Check validation gates
- Compose skills for complex tasks

❌ **DON'T:**
- Skip steps
- Ignore failed gates
- Mix skills arbitrarily
- Modify skills during execution

## Metrics

### Context Efficiency
- **Before:** 5,000+ tokens (full AGENT.md)
- **After:** 3,000-4,500 tokens (single skill)
- **Savings:** 30-40%

### Workflow Clarity
- **Before:** Interpret general guidelines
- **After:** Follow explicit steps
- **Improvement:** Structured execution

### Maintenance
- **Before:** Update 770-line monolithic doc
- **After:** Update single 400-700 line skill
- **Improvement:** Independent updates

## Next Steps

1. **First Time User?** Read [README.md](./README.md)
2. **Need Integration?** Read [IMPLEMENTATION_GUIDE.md](./IMPLEMENTATION_GUIDE.md)
3. **Ready to Use?** Pick a skill and follow its SKILL.md
4. **Want Details?** Read [AGENT_SKILLS_SUMMARY.md](./AGENT_SKILLS_SUMMARY.md)

---

**Version:** 1.0.0  
**Last Updated:** 2026-01-19  
**Quick Access:** This is your fastest way to find the right skill
