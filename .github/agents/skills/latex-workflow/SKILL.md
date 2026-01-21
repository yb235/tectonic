---
name: latex-workflow-automation
description: Automates LaTeX document generation and editing for financial case study reports, following repository-specific style guides, compliance rules, and 7-phase workflow for raw LaTeX to compliant templates.
version: "1.0.0"
author: James Bian
tags: [latex, document-generation, financial-reports, case-studies, workflow-automation]
dependencies: [pdflatex, grep, bash]
---

# LaTeX Workflow Automation Skill

## Overview

This skill automates the complete workflow for generating and editing LaTeX documents in this repository, specifically designed for financial case study reports. It implements a comprehensive 7-phase workflow that transforms raw LaTeX files into repository-compliant documents following strict style guides, legal requirements, and technical standards.

## When to Use This Skill

Use this skill when:
- Generating new LaTeX documents for financial case studies
- Converting raw LaTeX files to repository-compliant format
- Editing existing `.tex` files in the repository
- Creating tables, figures, or charts in LaTeX documents
- Validating LaTeX documents for compliance
- Compiling and troubleshooting LaTeX documents
- Ensuring legal disclaimers and branding are correct

## Key Documentation Files

This skill references and implements:
1. **workflow/LLM_INSTRUCTIONS.md** - Prioritized, action-oriented workflow guide
2. **docs/process/LLM_WORKFLOW.md** - Complete 7-phase conversion workflow
3. **docs/latex/LATEX_STYLE_GUIDE.md** - Comprehensive technical reference
4. **docs/latex/LATEX_CHECKLIST.md** - Pre-compilation validation checklist
5. **templates/template.tex** - Base template structure
6. **templates/intelapple.tex** - Reference example document

## 🚨 PRIORITY 0: CRITICAL RULES (NEVER VIOLATE)

These rules are **non-negotiable** and will cause compilation failure or legal issues if violated:

### Legal & Compliance
- ❌ **NEVER** use color names that imply real institutions (e.g., `msblue` → use `brandblue`)
- ✅ **ALWAYS** include legal disclaimers (front cover box, watermark, footer)
- ✅ **ALWAYS** update `COPYRIGHT_AND_LICENSE_AUDIT.md` when changing colors/fonts

### Special Characters (Compilation Killers)
```latex
✅ CORRECT              ❌ WRONG
\&                      &
\$                      $
\%                      %
\_                      _
```
**Rule:** These characters **OUTSIDE TABLES** must always be escaped. This is the #1 cause of compilation failure.

### Table & Figure Numbering
```latex
✅ CORRECT Pattern:
\begin{table}[H]
\centering
\caption{Descriptive Title}
\label{tab:unique_name}
...content...
\end{table}

❌ FORBIDDEN Patterns:
\captionof{table}{Title}      % No automatic numbering
\begin{center}...\captionof    % Environment interference
```

**Rule:** **ALWAYS** use formal float environments (`\begin{table}`, `\begin{figure}`) with `\caption{}` and `\label{}`. **NEVER** use `\captionof{}` unless inside `multicols` (rare exception).

## Complete 7-Phase Workflow

### PHASE 0: Pre-Flight Preparation

**Success Criteria:**
- ✅ All required reference documents read
- ✅ Work directory created with correct structure
- ✅ Source file validated (not corrupted)

**Actions:**
1. Read required documentation in order:
   - docs/latex/LATEX_STYLE_GUIDE.md (all sections)
   - docs/legal/COPYRIGHT_AND_LICENSE_AUDIT.md
   - docs/latex/LATEX_CHECKLIST.md
   - templates/template.tex (preamble structure)

2. Extract key requirements:
   - Brand colors: `brandblue=#003366`, `brandaccent=#008EC7`, `lightgrey=#F3F3F3`, `textgrey=#6A6A6A`, `tableheader=#E6E6E6`
   - Forbidden terms: Any reference to real financial institutions
   - Required disclaimers: Front cover box + diagonal watermark + footer text

3. Create work environment if needed:
   ```bash
   mkdir -p work/PROJECT_NAME/{source,output,logs}
   ```

**Validation Gate:**
- Can you recite the 5 brand color names and hex values?
- Can you list the 4 mandatory legal disclaimer components?
- Do you understand why `\captionof` is forbidden?

### PHASE 1: Preamble & Package Setup

**Success Criteria:**
- ✅ All required packages loaded in correct order
- ✅ Brand colors defined with neutral names
- ✅ Legal watermark configured
- ✅ Header/footer formatted correctly

**Key Actions:**
1. Use template preamble from `templates/template.tex`
2. Verify package checklist (geometry, xcolor[table], booktabs, tikz, pgfplots, float, caption, etc.)
3. Add compatibility fix for array/colortbl
4. Define brand colors with exact hex values
5. Configure diagonal watermark
6. Set up header/footer with legal disclaimers

**Validation Commands:**
```bash
# Check for forbidden packages
grep -n "\\usepackage{colortbl}" *.tex

# Find institutional color names
grep -nE "definecolor\{(ms|gs|citi)" *.tex

# Verify watermark exists
grep -n "watermarktext" *.tex
```

### PHASE 2: Document Structure & Hierarchy

**Success Criteria:**
- ✅ All headings use proper LaTeX commands (not `\textbf{}`)
- ✅ Maximum depth is `\subsection{}` (no deeper)
- ✅ No duplicate sections detected
- ✅ Executive summary precedes TOC

**Key Actions:**
1. Convert pseudo-headings: `\textbf{Title}` → `\subsection{Title}`
2. Remove manual numbering from section titles
3. Check for excessive nesting (no `\subsubsection`)
4. Detect and remove duplicate sections
5. Verify document structure:
   - Title page with legal disclaimer
   - Executive summary (multicols)
   - Table of contents
   - Main content wrapped in `\begin{maincontent}`

**Validation Commands:**
```bash
# Find pseudo-headings
grep -n "^\\\\textbf{.*}$" *.tex

# Find duplicate sections
grep "\\subsection{" *.tex | sort | uniq -d

# Check for excessive nesting
grep -n "\\subsubsection" *.tex
```

### PHASE 3: Tables & Captions

**Success Criteria:**
- ✅ All tables use `\begin{table}[H]` with `\caption` and `\label`
- ✅ NO `\captionof{table}` anywhere
- ✅ All labels follow naming convention: `\label{tab:descriptive_name}`
- ✅ All tables have `\tablefont` and `max width=\textwidth`

**Mandatory Table Template:**
```latex
\begin{table}[H]
\centering
\caption{Descriptive Title Here}
\label{tab:unique_descriptive_name}
\rowcolors{2}{msgrey}{white}
\tablefont
\begin{adjustbox}{max width=\textwidth}  % NOTE: max width, NOT width
\begin{tabular}{p{0.25\linewidth}p{0.25\linewidth}p{0.25\linewidth}p{0.25\linewidth}}
\toprule
\textbf{Header 1} & \textbf{Header 2} & \textbf{Header 3} & \textbf{Header 4} \\
\midrule
Content & Content & Content & Content \\
\bottomrule
\end{tabular}
\end{adjustbox}
\par\vspace{0.1cm}  % NOTE: \par is REQUIRED
{\tiny Source: Your Source Here}
\end{table}
```

**Key Points:**
- `max width=\textwidth` → Scales DOWN if needed, never UP
- `\tablefont` → Sets consistent `\footnotesize` for all tables
- `\par\vspace{0.1cm}` → Forces source text below table

**Validation Commands:**
```bash
# Check for illegal captionof usage
grep "\\captionof{table}" *.tex

# Find incorrect width usage
grep "adjustbox}{width=" *.tex

# Check label uniqueness
grep "\\label{tab:" *.tex | cut -d'{' -f2 | cut -d'}' -f1 | sort | uniq -d
```

### PHASE 4: Figures & Charts

**Success Criteria:**
- ✅ All figures use `\begin{figure}[H]` with `\caption` and `\label`
- ✅ NO `\captionof{figure}` anywhere
- ✅ All charts use semantic styles (msstyle, compactchart, divergingstyle)
- ✅ NO hardcoded colors in chart bodies

**Chart Width Guidelines:**
| Data Points | Width | Bar Width | Spacing |
|-------------|-------|-----------|---------|
| 2-3 | `8-10cm` | `25pt` | `enlarge x limits={abs=1cm}` |
| 4-5 | `10-12cm` | `20pt` | `enlarge x limits=0.15` |
| 6-8 | `12-14cm` | `15pt` | Auto |
| 9+ | `0.95\textwidth` | `12-15pt` | Auto |

**Complete Chart Template:**
```latex
\begin{figure}[H]
\centering
\caption{Chart Title}
\label{fig:descriptive_name}
\begin{tikzpicture}
\begin{axis}[
    ybar,
    height=6cm,
    width=10cm,
    bar width=20pt,
    symbolic x coords={A, B, C, D, E},
    xtick=data,
    % CRITICAL: ALL font sizes must be \footnotesize
    xticklabel style={font=\footnotesize},
    yticklabel style={font=\footnotesize},
    ylabel={Metric Name},
    ylabel style={font=\footnotesize},
    nodes near coords,
    nodes near coords style={font=\footnotesize, font=\bfseries, color=white},
    legend style={at={(0.5,-0.15)}, anchor=north, legend columns=-1, draw=none, font=\footnotesize},
    ymajorgrids=true,
    grid style={dotted, gray}
]
\addplot[fill=brandblue] coordinates {(A,10) (B,20) (C,30) (D,25) (E,15)};
\legend{Series Name}
\end{axis}
% CRITICAL: Position notes INSIDE tikzpicture
\pgfplotsset{
    after end axis/.append code={
        \node[anchor=north, font=\tiny, text width=10cm, align=center] 
        at (current axis.south) [yshift=-1.5cm] {
            Source: Your Source Here
        };
    }
}
\end{tikzpicture}
\end{figure}
```

**Font Size Rule:** **EVERYTHING** in charts uses `\footnotesize` except sources (use `\tiny`). **NEVER** use `\tiny` for data labels.

**Validation Commands:**
```bash
# Check for illegal captionof usage
grep "\\captionof{figure}" *.tex

# Find hardcoded colors
grep "addplot\[.*fill=.*!.*\]" *.tex

# Count semantic style usage
grep -E "(msstyle|compactchart|divergingstyle)" *.tex | wc -l
```

### PHASE 5: Legal Compliance & Branding

**Success Criteria:**
- ✅ Front cover legal disclaimer box present
- ✅ Diagonal watermark configured
- ✅ Footer disclaimer text present
- ✅ NO references to real financial institutions in branding

**Front Cover Disclaimer (CRITICAL):**
```latex
\vspace{0.5cm}
\begin{tcolorbox}[colback=lightgrey, colframe=lightgrey, boxrule=0pt, sharp corners, left=6pt, right=6pt, top=6pt, bottom=6pt]
\textbf{EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES}\\[0.2cm]
\textbf{NOTICE:} This document is a fictional research report created solely for educational and graphic design portfolio purposes.
\begin{enumerate}[leftmargin=*]
    \item \textbf{NOT FINANCIAL ADVICE:} The ratings, price targets, and investment conclusions are hypothetical.
    \item \textbf{FICTIONAL DATA:} All data are simulated or based on unverified public rumors.
    \item \textbf{ATTRIBUTION \& DESIGN:} Inspired by industry-standard formats for design proficiency demonstration.
    \item \textbf{NO LIABILITY:} The author shall not be held liable for decisions made based on this content.
\end{enumerate}
\end{tcolorbox}
```

**Validation Commands:**
```bash
# Scan for institutional branding violations
grep -niE "(morgan stanley|goldman sachs|jp ?morgan|citigroup|bank of america)" *.tex

# Verify footer disclaimer
grep "EDUCATIONAL CASE STUDY" *.tex
```

### PHASE 6: Validation & Compilation

**Success Criteria:**
- ✅ All validation checks pass
- ✅ Document compiles without errors
- ✅ PDF output is professional quality

**Comprehensive Validation Script:**
```bash
#!/bin/bash
FILE="$1"
ERRORS=0

# Phase 1: Preamble
if grep -q "\\usepackage{colortbl}" "$FILE"; then
    echo "❌ CRITICAL: colortbl package detected"
    ERRORS=$((ERRORS+1))
fi

# Phase 3: Tables
ILLEGAL_CAPTIONS=$(grep -c "\\captionof{table}" "$FILE" 2>/dev/null || echo 0)
if [ "$ILLEGAL_CAPTIONS" -gt 0 ]; then
    echo "❌ CRITICAL: $ILLEGAL_CAPTIONS illegal \\captionof{table} found"
    ERRORS=$((ERRORS+1))
fi

BAD_WIDTH=$(grep -c "adjustbox}{width=" "$FILE" 2>/dev/null || echo 0)
if [ "$BAD_WIDTH" -gt 0 ]; then
    echo "❌ CRITICAL: $BAD_WIDTH tables using 'width=' instead of 'max width='"
    ERRORS=$((ERRORS+1))
fi

# Phase 4: Figures
ILLEGAL_FIG_CAPTIONS=$(grep -c "\\captionof{figure}" "$FILE" 2>/dev/null || echo 0)
if [ "$ILLEGAL_FIG_CAPTIONS" -gt 0 ]; then
    echo "❌ CRITICAL: $ILLEGAL_FIG_CAPTIONS illegal \\captionof{figure} found"
    ERRORS=$((ERRORS+1))
fi

# Phase 5: Legal
if ! grep -q "EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES" "$FILE"; then
    echo "❌ CRITICAL: Legal disclaimer missing"
    ERRORS=$((ERRORS+1))
fi

if [ "$ERRORS" -eq 0 ]; then
    echo "✅ ALL CHECKS PASSED - Ready to compile"
    exit 0
else
    echo "❌ VALIDATION FAILED - $ERRORS critical issues found"
    exit 1
fi
```

**Compilation Commands:**
```bash
# Two-pass compilation for TOC and cross-references
pdflatex -interaction=nonstopmode document.tex
pdflatex -interaction=nonstopmode document.tex

# Check for errors
grep -A5 "^!" compile.log
```

### PHASE 7: Final Handoff

**Actions:**
1. Organize output files
2. Create conversion report
3. Generate document statistics
4. Calculate quality score
5. Create handoff checklist

## Common Error Patterns & Solutions

| Error Message | Root Cause | Solution |
|---------------|------------|----------|
| `Misplaced alignment tab character &` | Unescaped & in text | Escape as `\&` |
| `Missing $ inserted` | Unescaped $ or % | Escape as `\$` or `\%` |
| `Undefined control sequence` | Typo or missing package | Check spelling, add package |
| `Runaway argument` | Blank line in options | Remove blank lines in `\addplot[...]` |
| `colormap undefined` | Missing colormap definition | Use built-in: `viridis`, `hot`, `bluered` |

## Quick Reference Commands

```bash
# Context Gathering (Phase 0)
grep "\\label{" file.tex                    # Find existing labels
grep "\\subsection{" file.tex | sort | uniq -d  # Find duplicates

# Validation (Phase 6)
grep -n "\\usepackage{colortbl}" *.tex      # Check forbidden packages
grep -nE "definecolor\{(ms|gs|citi)" *.tex  # Find institutional colors
grep -n "\\captionof{" *.tex                # Find illegal captions
grep -n "fill=.*!" *.tex                    # Find hardcoded colors
grep -nE "[^\\](&|\$|%)" *.tex              # Check unescaped chars

# Document Statistics
echo "Sections: $(grep -c '\\section{' *.tex)"
echo "Tables: $(grep -c '\\begin{table}' *.tex)"
echo "Figures: $(grep -c '\\begin{figure}' *.tex)"
```

## Decision Framework

**When to proceed automatically:**
- Clear pattern matches template examples
- Style guide provides explicit rule
- Change is purely mechanical (e.g., color name substitution)

**When to flag for human review:**
- Ambiguous content structure
- Complex nested environments
- Data accuracy concerns
- Legal interpretation needed

**When to stop and request clarification:**
- Source file severely malformed
- Conflicting requirements detected
- Missing critical information

## Example Usage

**Example 1: Create new LaTeX document**
```
User: "Create a new financial case study document for Apple's M4 chip analysis"

Agent Actions:
1. Read templates/template.tex for base structure
2. Apply Phase 0-1: Set up preamble with brand colors
3. Create title page with legal disclaimers
4. Set up executive summary structure
5. Add TOC and main content sections
6. Validate against checklist
```

**Example 2: Convert raw LaTeX to compliant format**
```
User: "Convert this raw LaTeX file to follow our repository standards"

Agent Actions:
1. Execute complete 7-phase workflow
2. Phase 0: Validate source file
3. Phase 1-5: Apply all transformations
4. Phase 6: Run validation and compile
5. Phase 7: Generate conversion report
```

**Example 3: Add table to existing document**
```
User: "Add a financial comparison table to section 3"

Agent Actions:
1. Read existing document for labels and structure
2. Apply mandatory table template
3. Generate unique label: tab:financial_comparison
4. Use max width=\textwidth for adjustbox
5. Add source citation with \par\vspace pattern
6. Validate no duplicate labels exist
```

## Resources

All referenced documentation is available in this repository:
- `/workflow/LLM_INSTRUCTIONS.md` - Quick reference guide
- `/docs/process/LLM_WORKFLOW.md` - Detailed 7-phase workflow
- `/docs/latex/LATEX_STYLE_GUIDE.md` - Complete style guide
- `/docs/latex/LATEX_CHECKLIST.md` - Validation checklist
- `/templates/template.tex` - Base template
- `/templates/intelapple.tex` - Reference example

## Success Metrics

A successfully processed document should achieve:
- ✅ Zero compilation errors
- ✅ All validation checks passed
- ✅ Professional visual quality
- ✅ Legal compliance confirmed
- ✅ Consistent styling throughout
- ✅ Quality score ≥ 80/100

## Notes

- This skill implements best practices from 150+ hours of debugging real LaTeX documents
- The workflow is optimized for LLM agents (GPT-4, Claude, etc.)
- All rules are based on actual compilation failures and legal requirements
- The 7-phase structure ensures systematic validation at each step
