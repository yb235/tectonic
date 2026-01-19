# LaTeX Workflow Automation Skill

This is a Claude Agent Skill that automates the complete workflow for generating and editing LaTeX documents in this repository, specifically designed for financial case study reports.

## What is a Claude Agent Skill?

Agent Skills are modular, reusable bundles of instructions that extend Claude's core functionality. They work like plug-ins or "mini-capability packs" that teach Claude exactly how to handle domain-specific, repeatable tasks.

## What This Skill Does

This skill implements a comprehensive 7-phase workflow that:

1. **Phase 0: Pre-Flight** - Loads context and validates source files
2. **Phase 1: Preamble** - Sets up packages, colors, and legal disclaimers
3. **Phase 2: Structure** - Normalizes headings and document hierarchy
4. **Phase 3: Tables** - Converts tables to compliant float environments
5. **Phase 4: Figures** - Standardizes charts and figure formatting
6. **Phase 5: Legal** - Ensures all legal disclaimers are present
7. **Phase 6: Validation** - Runs automated checks and compiles PDF

## When to Use

This skill automatically activates when you:
- Generate new LaTeX documents for financial case studies
- Convert raw LaTeX files to repository-compliant format
- Edit existing `.tex` files in the repository
- Create tables, figures, or charts in LaTeX documents
- Validate LaTeX documents for compliance
- Compile and troubleshoot LaTeX documents

## Key Features

- ✅ **Critical Rules Enforcement** - Never violates non-negotiable rules
- ✅ **Legal Compliance** - Ensures all disclaimers are present
- ✅ **Automated Validation** - Runs comprehensive checks before compilation
- ✅ **Error Prevention** - Detects common mistakes before compilation
- ✅ **Template-Based** - Uses proven templates for consistency
- ✅ **Best Practices** - Based on 150+ hours of debugging experience

## How It Works

The skill follows a systematic approach:

1. **Read** existing documentation and templates
2. **Validate** source files and structure
3. **Transform** content to match repository standards
4. **Check** for errors and compliance issues
5. **Compile** to generate PDF output
6. **Report** results and quality metrics

## Referenced Documentation

This skill synthesizes guidance from:
- `/workflow/LLM_INSTRUCTIONS.md` - Prioritized workflow guide
- `/docs/process/LLM_WORKFLOW.md` - Detailed 7-phase workflow
- `/docs/latex/LATEX_STYLE_GUIDE.md` - Comprehensive style guide
- `/docs/latex/LATEX_CHECKLIST.md` - Validation checklist
- `/templates/template.tex` - Base template structure
- `/templates/intelapple.tex` - Reference example document

## Installation

This skill is automatically available when working in this repository. No installation is required.

For use with Claude Desktop or Claude Code:
1. Copy the `.github/agents/skills` directory to your skills location
2. Claude will automatically detect and load the skill
3. Use natural language to invoke the skill

## Example Usage

### Example 1: Create New Document
```
Create a new financial case study document for Tesla's battery technology
```

The skill will:
- Set up the proper preamble with brand colors
- Create title page with legal disclaimers
- Structure executive summary and TOC
- Provide templates for tables and charts
- Validate compliance before compilation

### Example 2: Convert Raw LaTeX
```
Convert this raw LaTeX file to follow our repository standards
```

The skill will:
- Execute the complete 7-phase workflow
- Transform all non-compliant elements
- Run automated validation checks
- Compile and generate quality report

### Example 3: Add Content
```
Add a competitive analysis table comparing three companies
```

The skill will:
- Use the mandatory table template
- Generate unique label automatically
- Apply proper styling and formatting
- Ensure compliance with style guide

## Quality Assurance

Documents processed with this skill achieve:
- 🎯 Zero compilation errors
- 🎯 100% validation check pass rate
- 🎯 Professional visual quality
- 🎯 Legal compliance confirmation
- 🎯 Quality score ≥ 80/100

## Critical Rules

The skill enforces these non-negotiable rules:

### ❌ Never Use
- `\captionof{table}` or `\captionof{figure}` (use float environments)
- Institutional color names like `msblue` (use `brandblue`)
- `width=\textwidth` for tables (use `max width=\textwidth`)
- Unescaped special characters `& $ % _` outside tables

### ✅ Always Use
- Legal disclaimers (front cover box, watermark, footer)
- Formal float environments (`\begin{table}[H]`, `\begin{figure}[H]`)
- Unique labels following convention (`tab:name`, `fig:name`)
- Brand colors with neutral names

## Validation Commands

The skill uses these commands for automated validation:

```bash
# Check for forbidden packages
grep -n "\\usepackage{colortbl}" *.tex

# Find illegal captions
grep -n "\\captionof{" *.tex

# Check label uniqueness
grep "\\label{" *.tex | cut -d'{' -f2 | cut -d'}' -f1 | sort | uniq -d

# Verify legal disclaimers
grep "EDUCATIONAL CASE STUDY" *.tex
```

## Troubleshooting

### Common Issues

**Issue: Compilation fails with "Misplaced alignment tab"**
- Cause: Unescaped `&` in text
- Solution: Escape as `\&`

**Issue: Tables have wrong font size**
- Cause: Using `width=` instead of `max width=`
- Solution: Change to `max width=\textwidth`

**Issue: Figures not auto-numbered**
- Cause: Using `\captionof{figure}`
- Solution: Use `\begin{figure}[H]` with `\caption{}`

## Version History

- **v1.0.0** (2026-01-19) - Initial release
  - Complete 7-phase workflow implementation
  - Comprehensive validation checks
  - Error prevention and detection
  - Quality metrics and reporting

## Contributing

To improve this skill:
1. Update the `SKILL.md` file with enhanced instructions
2. Test changes with sample LaTeX documents
3. Update version number and changelog
4. Commit changes to repository

## License

This skill is part of the tectonic repository and follows the same license terms.

## Support

For questions or issues:
1. Check the referenced documentation in `/docs` and `/workflow`
2. Review example templates in `/templates`
3. Examine the `SKILL.md` file for detailed instructions
4. Consult the LATEX_STYLE_GUIDE.md for comprehensive guidance

## About

- **Author:** James Bian
- **Purpose:** Automate LaTeX workflow for financial case study documents
- **Based on:** 150+ hours of debugging real LaTeX documents
- **Optimized for:** LLM agents (GPT-4, Claude, etc.)
- **Last Updated:** 2026-01-19
