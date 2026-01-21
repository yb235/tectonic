# LaTeX Workflow Automation

This repository includes a comprehensive Claude Agent Skill that automates the LaTeX editing workflow for financial case study documents.

## What is This?

The **LaTeX Workflow Automation Skill** is a modular, reusable bundle of instructions that teaches AI agents (like Claude) how to:
- Generate compliant LaTeX documents from scratch
- Convert raw LaTeX files to repository standards
- Edit existing documents following strict style guides
- Validate documents for compliance and legal requirements
- Compile and troubleshoot LaTeX documents

## Quick Start

### For Claude Users

When working with LaTeX documents in this repository, simply describe what you need in natural language:

```
"Create a new financial case study document for Apple's M4 chip"
"Convert this raw LaTeX file to follow our repository standards"
"Add a comparative table showing revenue data for three companies"
"Validate this document and tell me what needs to be fixed"
```

The skill will automatically activate and guide the workflow through all required phases.

### For Developers

The skill is located in `.github/agents/skills/latex-workflow/` and includes:

- **SKILL.md** - Main skill definition with complete workflow
- **README.md** - Detailed overview and usage guide
- **QUICK_REFERENCE.md** - Fast reference card
- **EXAMPLES.md** - 8 concrete use case examples
- **validate.sh** - Automated validation script

## Skill Capabilities

### ✅ Document Generation
- Sets up proper preamble with all required packages
- Defines brand colors and legal disclaimers
- Structures document with executive summary, TOC, and main content
- Applies consistent styling throughout

### ✅ Document Conversion
- Transforms raw LaTeX to repository-compliant format
- Converts illegal patterns to proper float environments
- Fixes table and figure formatting
- Ensures legal compliance
- Runs comprehensive validation

### ✅ Content Creation
- Tables: Auto-generates compliant table templates
- Figures: Creates properly formatted charts
- Labels: Generates unique labels automatically
- Citations: Adds source attributions correctly

### ✅ Validation & Quality
- Checks for forbidden packages and patterns
- Validates legal disclaimers present
- Ensures all special characters escaped
- Verifies table/figure numbering
- Calculates quality scores

## The 7-Phase Workflow

The skill implements a systematic 7-phase workflow:

1. **Phase 0: Pre-Flight** - Load context, validate source files
2. **Phase 1: Preamble** - Setup packages, colors, legal disclaimers
3. **Phase 2: Structure** - Normalize headings, remove duplicates
4. **Phase 3: Tables** - Convert to compliant float environments
5. **Phase 4: Figures** - Standardize charts and graphics
6. **Phase 5: Legal** - Ensure all legal disclaimers present
7. **Phase 6: Validation** - Run automated checks and compile

Each phase has clear success criteria and validation gates.

## Critical Rules Enforced

The skill enforces these non-negotiable rules:

### ❌ Never Use
- `\captionof{table}` or `\captionof{figure}` (use float environments instead)
- Institutional color names like `msblue` (use `brandblue` instead)
- `width=\textwidth` for tables (use `max width=\textwidth`)
- Unescaped special characters `& $ % _` outside tables
- Package `colortbl` (causes conflicts)

### ✅ Always Use
- Legal disclaimers (front cover box, watermark, footer)
- Formal float environments (`\begin{table}[H]`, `\begin{figure}[H]`)
- Unique labels following convention (`tab:name`, `fig:name`)
- Brand colors with neutral names
- `\tablefont` for all tables

## Documentation Structure

```
tectonic/
├── .github/agents/skills/latex-workflow/  # Skill location
│   ├── SKILL.md                           # Main skill definition
│   ├── README.md                          # Usage guide
│   ├── QUICK_REFERENCE.md                 # Fast reference
│   ├── EXAMPLES.md                        # Use case examples
│   └── validate.sh                        # Validation script
├── workflow/
│   └── LLM_INSTRUCTIONS.md                # Prioritized workflow guide
├── docs/
│   ├── process/
│   │   └── LLM_WORKFLOW.md                # Detailed 7-phase workflow
│   └── latex/
│       ├── LATEX_STYLE_GUIDE.md           # Comprehensive style guide
│       └── LATEX_CHECKLIST.md             # Validation checklist
└── templates/
    ├── template.tex                       # Base template
    └── intelapple.tex                     # Reference example
```

## Running Validation Manually

You can run the validation script directly:

```bash
# Validate a document
./.github/agents/skills/latex-workflow/validate.sh document.tex

# Example output
✅ ALL CRITICAL CHECKS PASSED - Ready to compile
```

The script checks:
- Preamble compliance (packages, colors)
- Document structure (headings, duplicates)
- Table compliance (float environments, labels)
- Figure compliance (charts, colors)
- Legal compliance (disclaimers, watermark)
- Special character escaping

## Example Use Cases

### 1. Create New Document
```
User: "Create a new case study for Tesla's battery technology"

Skill:
- Sets up compliant preamble
- Adds legal disclaimers
- Structures document sections
- Provides table/chart templates
- Validates before compilation
```

### 2. Convert Raw LaTeX
```
User: "Convert this raw LaTeX to our standards"

Skill:
- Executes complete 7-phase workflow
- Transforms all non-compliant elements
- Fixes tables, figures, structure
- Adds legal disclaimers
- Compiles and generates quality report
```

### 3. Add Content
```
User: "Add a comparison table for three companies"

Skill:
- Uses mandatory table template
- Generates unique label
- Applies proper formatting
- Validates compliance
```

See `EXAMPLES.md` for 8 detailed use case examples.

## Quality Metrics

Documents processed with this skill achieve:
- 🎯 Zero compilation errors
- 🎯 100% validation check pass rate
- 🎯 Professional visual quality
- 🎯 Legal compliance confirmation
- 🎯 Quality score ≥ 80/100

## Benefits

### For Content Creators
- ✅ Automated compliance checking
- ✅ Consistent styling without manual effort
- ✅ Legal disclaimers automatically included
- ✅ Faster document creation

### For Reviewers
- ✅ Standardized quality checks
- ✅ Automated validation reports
- ✅ Clear compliance metrics
- ✅ Reduced review time

### For the Repository
- ✅ Consistent document quality
- ✅ Reduced compilation errors
- ✅ Better maintainability
- ✅ Auditable processes

## Learning Resources

### Quick References
- **QUICK_REFERENCE.md** - Critical rules, templates, commands
- **workflow/LLM_INSTRUCTIONS.md** - Prioritized workflow guide

### Detailed Guides
- **docs/process/LLM_WORKFLOW.md** - Complete 7-phase workflow
- **docs/latex/LATEX_STYLE_GUIDE.md** - Comprehensive style guide
- **docs/latex/LATEX_CHECKLIST.md** - Validation checklist

### Examples
- **EXAMPLES.md** - 8 concrete use case scenarios
- **templates/intelapple.tex** - Reference document

## Contributing

To improve the skill:

1. Edit `.github/agents/skills/latex-workflow/SKILL.md`
2. Update version number and test with sample documents
3. Update documentation files as needed
4. Submit changes with clear description

## Technical Details

### Skill Format
- **Format:** Claude Agent Skills specification
- **Location:** `.github/agents/skills/latex-workflow/`
- **Loading:** Progressive (Metadata → Instructions → Resources)
- **Activation:** Automatic for LaTeX-related tasks

### Dependencies
- `pdflatex` - LaTeX compiler
- `grep` - Pattern matching
- `bash` - Shell scripting

### Version
- **Current:** v1.0.0
- **Last Updated:** 2026-01-19
- **Author:** James Bian

## Support

For questions or issues:
1. Check the skill README: `.github/agents/skills/latex-workflow/README.md`
2. Review quick reference: `.github/agents/skills/latex-workflow/QUICK_REFERENCE.md`
3. Examine examples: `.github/agents/skills/latex-workflow/EXAMPLES.md`
4. Consult the comprehensive style guide: `docs/latex/LATEX_STYLE_GUIDE.md`

## License

This skill is part of the tectonic repository and follows the same license terms.

---

**Note:** This skill is based on 150+ hours of debugging real LaTeX documents and implements best practices for financial case study report generation.
