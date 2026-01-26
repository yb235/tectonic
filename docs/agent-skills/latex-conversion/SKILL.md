---
name: latex-conversion
description: Convert raw, non-compliant LaTeX files into repository-compliant format through a systematic 7-phase workflow with validation gates. Use when fixing existing LaTeX that doesn't meet standards.
usage: |
  - "Fix this LaTeX file to be compliant"
  - "Convert this raw LaTeX to our format"
  - "Make this document follow our standards"
  - "Clean up this LaTeX code"
version: 1.0.0
priority: high
---

# LaTeX Conversion Skill

## Overview

This skill systematically converts raw, non-compliant LaTeX documents into repository-compliant format through a structured 7-phase workflow. Each phase includes validation gates to ensure quality and prevent cascading errors.

**Core Principle:** Validate before proceeding to next phase.

## When to Use

Trigger this skill when the user:
- Provides a raw LaTeX file that needs standardization
- Reports that a document doesn't compile or follow standards
- Requests cleanup or compliance fixes for existing LaTeX
- Has a document that uses different formatting conventions

## Prerequisites

- Source LaTeX file available (`.tex` file)
- Write access to create work directory structure
- Access to reference documentation in `docs/`
- Dev container available for validation and compilation

## The 7-Phase Workflow

### Phase 0: Pre-Flight Preparation

**Goal:** Load context and initialize work environment

**Actions:**
1. Read required documentation:
   - `docs/latex/LATEX_STYLE_GUIDE.md` (focus on sections 0A-0D)
   - `docs/legal/COPYRIGHT_AND_LICENSE_AUDIT.md` (section 7)
   - `templates/template.tex` (lines 1-250: preamble)

2. Extract key requirements:
   - Brand colors: `brandblue=#003366`, `brandaccent=#008EC7`, etc.
   - Forbidden: Real institutional references
   - Required: Legal disclaimers, watermark, footer
   - Table format: `\begin{table}[H]` with `\caption` and `\label`
   - Figure format: `\begin{figure}[H]` with `\caption` and `\label`

3. Create work environment:
```bash
mkdir -p work/PROJECT_NAME/{source,output,logs}
cp incoming/raw_file.tex work/PROJECT_NAME/source/original.tex
touch work/PROJECT_NAME/progress_checklist.md
```

4. Initialize progress tracker:
```markdown
# Conversion Progress: PROJECT_NAME

## Phase Status
- [x] Phase 0: Pre-flight
- [ ] Phase 1: Preamble Compliance
- [ ] Phase 2: Content Structure
- [ ] Phase 3: Tables & Figures
- [ ] Phase 4: Charts & Graphics
- [ ] Phase 5: Legal Compliance
- [ ] Phase 6: Validation & Compilation
- [ ] Phase 7: Final Handoff

## Issues Log
(Track deviations, errors, decisions)
```

**Validation Gate:**
- [ ] Can recite 5 brand color names and hex values
- [ ] Can list 4 mandatory legal disclaimer components
- [ ] Understand why `\captionof` is forbidden
- [ ] Work directory structure created successfully

**Proceed only if all checks pass.**

---

### Phase 1: Preamble & Package Setup

**Goal:** Build compliant LaTeX preamble

**Actions:**

1. **Replace/standardize document class:**
```latex
% Use this standard
\documentclass[10pt,letterpaper]{article}
```

2. **Load packages in correct order:**
```latex
% Encoding & fonts (first)
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{lmodern}

% Page layout
\usepackage[margin=1in]{geometry}
\usepackage{fancyhdr}

% Graphics & colors
\usepackage{graphicx}
\usepackage[table]{xcolor}  % Note: [table] option, NOT colortbl package

% Tables
\usepackage{booktabs}
\usepackage{adjustbox}
\usepackage{array}

% Charts
\usepackage{pgfplots}
\usepackage{tikz}
\pgfplotsset{compat=1.18}

% Layout
\usepackage{multicol}
\usepackage{tcolorbox}
\usepackage{caption}

% Misc
\usepackage{hyperref}
```

3. **Define brand colors (with neutral names):**
```latex
\definecolor{brandblue}{HTML}{003366}
\definecolor{brandaccent}{HTML}{008EC7}
\definecolor{lightgrey}{HTML}{F3F3F3}
\definecolor{textgrey}{HTML}{6A6A6A}
\definecolor{tableheader}{HTML}{E6E6E6}
```

4. **Configure legal watermark:**
```latex
\usepackage{eso-pic}
\AddToShipoutPictureBG{
    \AtPageCenter{
        \makebox[0pt]{
            \rotatebox{45}{
                \textcolor{lightgrey!60}{
                    \fontsize{80}{96}\selectfont
                    SAMPLE: FICTIONAL DATA
                }
            }
        }
    }
}
```

5. **Configure footer:**
```latex
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\cfoot{\tiny\color{textgrey}EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES}
\rfoot{\thepage}
```

**Validation Gate:**
```bash
# Check for forbidden colortbl package
grep "usepackage{colortbl}" document.tex
# Expected: Empty

# Check for institutional color names
grep -E "definecolor\{(ms|gs|citi)" document.tex
# Expected: Empty

# Check watermark present
grep "SAMPLE: FICTIONAL DATA" document.tex
# Expected: Found
```

**Proceed only if all checks pass.**

---

### Phase 2: Document Structure

**Goal:** Normalize heading hierarchy and eliminate duplicates

**Actions:**

1. **Fix heading hierarchy:**
```bash
# Find pseudo-headings (bold text used as headings)
grep "\\textbf{.*}" document.tex

# Convert to proper headings:
# Major topics → \section{}
# Subtopics → \subsection{}
# Inline emphasis → Keep as \textbf{}
```

2. **Remove excessive nesting:**
```latex
% WRONG: Too deep
\subsubsection{Deep Topic}

% RIGHT: Flatten
\subsection{Deep Topic}
```

3. **Find and fix duplicate sections:**
```bash
# Find duplicates
grep "\\subsection{" document.tex | sort | uniq -d

# Decision: Remove or merge duplicates
```

4. **Standardize paragraph spacing:**
```latex
% CORRECT: One blank line between paragraphs
First paragraph.

Second paragraph.

% REMOVE unnecessary \vspace{} between normal paragraphs
% KEEP \vspace{} only around tables/figures
```

**Validation Gate:**
```bash
# No duplicate subsections
grep "\\subsection{" document.tex | sort | uniq -d
# Expected: Empty

# No excessive nesting
grep "\\subsubsection" document.tex
# Expected: Empty (or minimal, justified uses only)

# Proper spacing
grep -A1 "\\subsection" document.tex | grep "vspace"
# Expected: Minimal results (only justified spacing)
```

**Proceed only if checks pass.**

---

### Phase 3: Tables & Captions

**Goal:** Convert all tables to compliant float environments

**Actions:**

1. **Find non-compliant table patterns:**
```bash
# Find captionof usage
grep -n "\\captionof{table}" document.tex

# Find tables without float environments
grep -B5 "\\begin{tabular}" document.tex | grep -v "\\begin{table}"
```

2. **Convert each table to standard format:**
```latex
% WRONG:
\captionof{table}{Title}
\begin{tabular}{lll}
...
\end{tabular}

% RIGHT:
\begin{table}[H]
\centering
\caption{Descriptive Title}
\label{tab:unique_name}
\rowcolors{2}{lightgrey}{white}
\tablefont
\begin{adjustbox}{max width=\textwidth}
\begin{tabular}{p{0.33\linewidth}p{0.33\linewidth}p{0.33\linewidth}}
\toprule
\textbf{Header 1} & \textbf{Header 2} & \textbf{Header 3} \\
\midrule
Data & Data & Data \\
\bottomrule
\end{tabular}
\end{adjustbox}
\par\vspace{0.1cm}
{\tiny Source: Data source here}
\end{table}
```

3. **Fix table sizing:**
```bash
# Find fixed-width tables
grep "adjustbox.*width=\\\\textwidth" document.tex

# Change to: max width=\textwidth
```

4. **Add missing labels:**
```latex
% Every table needs a unique label
\label{tab:descriptive_name}
```

**Validation Gate:**
```bash
# No captionof for tables (except inside multicols with proper setup)
grep "\\captionof{table}" document.tex | grep -v "captionsetup"
# Expected: Empty

# All tables have labels
# Count tables
grep "\\begin{table}" document.tex | wc -l
# Count labels  
grep "\\label{tab:" document.tex | wc -l
# Expected: Counts should match

# No duplicate labels
grep "\\label{tab:" document.tex | sort | uniq -d
# Expected: Empty

# All use max width
grep "adjustbox.*width=" document.tex | grep -v "max width"
# Expected: Empty
```

**Proceed only if checks pass.**

---

### Phase 4: Charts & Graphics

**Goal:** Standardize chart formatting and positioning

**Actions:**

1. **Find non-compliant chart patterns:**
```bash
# Find captionof usage for figures
grep -n "\\captionof{figure}" document.tex

# Find charts without float environments
grep -B10 "\\begin{axis}" document.tex | grep -v "\\begin{figure}"
```

2. **Convert each chart to standard format:**
```latex
% WRONG:
\captionof{figure}{Title}
\begin{tikzpicture}
...
\end{tikzpicture}

% RIGHT:
\begin{figure}[H]
\centering
\caption{Chart Title}
\label{fig:unique_name}
\begin{tikzpicture}
\begin{axis}[
    ybar,
    width=12cm,
    height=6cm,
    bar width=20pt,
    % All fonts: \footnotesize
    xticklabel style={font=\footnotesize},
    yticklabel style={font=\footnotesize},
    ylabel style={font=\footnotesize},
    nodes near coords style={font=\footnotesize, color=white},
    ymajorgrids=true,
    grid style={dotted, gray}
]
\addplot[fill=brandblue] coordinates {...};
\legend{Series Name}
\end{axis}
% Source note INSIDE tikzpicture
\pgfplotsset{
    after end axis/.append code={
        \node[anchor=north, font=\tiny, text width=12cm, align=center] 
        at (current axis.south) [yshift=-1.5cm] {
            Source: Data source
        };
    }
}
\end{tikzpicture}
\end{figure}
```

3. **Standardize font sizes:**
```bash
# Find charts with inconsistent fonts
grep -A20 "\\begin{axis}" document.tex | grep "font=\\\\tiny"

# Change ALL chart fonts to \footnotesize (except source which is \tiny)
```

4. **Move source notes inside tikzpicture:**
```bash
# Find external source notes
grep -A5 "\\end{tikzpicture}" document.tex | grep "Source:"

# Move inside using pgfplotsset after end axis pattern
```

**Validation Gate:**
```bash
# No captionof for figures
grep "\\captionof{figure}" document.tex | grep -v "captionsetup"
# Expected: Empty

# All figures have labels
grep "\\begin{figure}" document.tex | wc -l
grep "\\label{fig:" document.tex | wc -l
# Expected: Counts match

# No duplicate labels
grep "\\label{fig:" document.tex | sort | uniq -d
# Expected: Empty

# All chart labels use \footnotesize
grep -A20 "\\begin{axis}" document.tex | grep "font=" | grep -v "footnotesize" | grep -v "tiny"
# Expected: Empty (or only justified exceptions)
```

**Proceed only if checks pass.**

---

### Phase 5: Legal Compliance

**Goal:** Add all required legal elements and remove institutional references

**Actions:**

1. **Add front page disclaimer box:**
```latex
% After cover page, before executive summary
\vspace{1cm}
\begin{tcolorbox}[colback=yellow!10, colframe=brandblue, boxrule=2pt]
    \textbf{EDUCATIONAL DISCLAIMER}
    \begin{enumerate}
        \item This is a FICTIONAL case study for educational purposes
        \item NOT investment advice or recommendation
        \item Data may be simulated or aggregated from public sources
        \item No affiliation with any financial institution
    \end{enumerate}
\end{tcolorbox}
\vspace{1cm}
```

2. **Verify watermark present** (from Phase 1)

3. **Verify footer present** (from Phase 1)

4. **Remove institutional references:**
```bash
# Find institutional branding
grep -ni "morgan stanley\|goldman sachs\|citigroup" document.tex

# Replace with neutral terms or remove
# "Morgan Stanley analysis" → "Industry analysis"
# "Goldman Sachs estimates" → "Market estimates"
```

5. **Fix institutional color names:**
```bash
# Find problematic color names
grep -n "msblue\|gsgreen\|citiblue" document.tex

# Replace with neutral names
# msblue → brandblue
# gsgreen → brandaccent
```

**Validation Gate:**
```bash
# No institutional names
grep -i "morgan stanley\|goldman\|citi\|jpmorgan" document.tex
# Expected: Empty (or only in footnotes/citations with disclaimers)

# No institutional color names
grep "definecolor{ms\|definecolor{gs\|definecolor{citi" document.tex
# Expected: Empty

# Disclaimer box present
grep "EDUCATIONAL DISCLAIMER" document.tex
# Expected: Found

# Watermark present
grep "SAMPLE: FICTIONAL DATA" document.tex
# Expected: Found

# Footer present
grep "EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES" document.tex
# Expected: Found
```

**Proceed only if checks pass.**

---

### Phase 6: Validation & Compilation

**Goal:** Verify document compiles and passes all quality checks

**Actions:**

1. **Run comprehensive pre-compilation checks:**
```bash
# Check for unescaped special characters
grep -P '(?<!\\)[\$%&]' document.tex | grep -v "begin{tabular}"

# Check for blank lines in axis options
grep -A20 "\\begin{axis}\[" document.tex | grep -B5 "^\s*$"

# Check all validation gates from previous phases
```

2. **Compile document (use latex-compilation skill):**
```bash
# In dev container
cd /workspaces/tectonic/work/PROJECT_NAME/source
latexmk -pdf -interaction=nonstopmode document.tex
```

3. **Check compilation results:**
```bash
# Count errors
grep -c "^!" document.log

# Check warnings
grep -E "(Warning)" document.log | wc -l

# Verify PDF generated
ls -lh document.pdf
```

4. **Visual quality checks:**
- [ ] All tables have similar font sizes
- [ ] All chart data labels readable at 100% zoom
- [ ] All captions centered
- [ ] Source citations below tables/charts
- [ ] No chart legends overlapping data
- [ ] No text overflowing margins
- [ ] Watermark visible but not distracting
- [ ] Disclaimer box prominent on first page
- [ ] Footer on every page

**Validation Gate:**
- [ ] Zero compilation errors
- [ ] Fewer than 10 significant warnings
- [ ] PDF generated successfully
- [ ] File size reasonable (not 0 bytes, not unusually large)
- [ ] Visual checks passed

**If validation fails:** Debug and fix issues, return to relevant phase.

---

### Phase 7: Final Handoff

**Goal:** Package outputs and create documentation

**Actions:**

1. **Create conversion report:**
```bash
cat > work/PROJECT_NAME/CONVERSION_REPORT.md << 'EOF'
# Conversion Report: PROJECT_NAME

## Summary
**Source:** incoming/raw_file.tex  
**Output:** work/PROJECT_NAME/source/document.tex  
**Status:** ✅ Complete  
**Date:** YYYY-MM-DD

## Changes Made

### Phase 1: Preamble
- Replaced XX packages
- Standardized YY color definitions
- Added legal watermark

### Phase 2: Structure
- Fixed XX pseudo-headings
- Removed YY duplicate sections
- Standardized paragraph spacing

### Phase 3: Tables
- Converted XX tables to float environments
- Fixed YY sizing issues (width → max width)
- Added ZZ missing labels

### Phase 4: Charts
- Converted XX charts to float environments
- Standardized font sizes (all → \footnotesize)
- Moved YY source notes inside tikzpicture

### Phase 5: Legal
- Added disclaimer box
- Removed XX institutional references
- Fixed YY color names (ms* → brand*)

### Phase 6: Validation
- Compilation: ✅ Success
- Errors: 0
- Warnings: XX (all acceptable)
- PDF size: XX MB

## Quality Score: XX/100

### Scoring Breakdown:
- Compilation: 25/25
- Structure: 20/20
- Tables: 15/15
- Charts: 15/15
- Legal: 20/20
- Visual: 5/5

## Remaining Items
- [ ] Review executive summary for accuracy
- [ ] Verify all data sources cited
- [ ] Final visual proofread

## Notes
(Any special considerations or known issues)
EOF
```

2. **Create backups:**
```bash
cp work/PROJECT_NAME/source/document.tex work/PROJECT_NAME/source/document_final.tex
cp work/PROJECT_NAME/source/document.pdf output/document_final.pdf
```

3. **Archive work:**
```bash
tar -czf work/PROJECT_NAME_complete_$(date +%Y%m%d).tar.gz work/PROJECT_NAME/
```

**Validation Gate:**
- [ ] Conversion report created
- [ ] Quality score ≥ 70/100
- [ ] All phases marked complete
- [ ] Backups created
- [ ] PDF in output directory

**Conversion complete!**

## Decision Trees

### Should I Use Conversion Skill?

```
Does LaTeX file exist already?
├─ YES → Is it compliant?
│   ├─ NO → Use conversion skill
│   └─ YES → Use compilation skill only
│
└─ NO → Use document-creation skill
```

### Which Phase Do I Start At?

```
What's the main issue?
├─ Preamble/packages wrong → Start at Phase 1
├─ Structure messy → Start at Phase 2 (but check Phase 1 first)
├─ Tables use captionof → Start at Phase 3
├─ Charts poorly formatted → Start at Phase 4
├─ Missing disclaimers → Start at Phase 5
├─ Won't compile → Start at Phase 6 (validation)
└─ Everything looks OK → Start at Phase 0 (systematic review)
```

## Troubleshooting

### Problem: Validation gate fails in early phase

**Solution:** Do NOT proceed. Fix issues before continuing. Cascading errors waste more time than careful phase-by-phase work.

### Problem: Compilation fails in Phase 6 despite passing earlier gates

**Cause:** Interaction between fixes in different phases

**Solution:**
1. Check log file for specific error
2. Return to relevant phase
3. Re-validate that phase
4. Recompile

### Problem: Visual checks fail but compilation succeeds

**Cause:** LaTeX generated valid PDF but formatting is wrong

**Solution:**
1. Review specific failing visual check
2. Return to relevant phase (Phase 3 for tables, Phase 4 for charts)
3. Apply fixes
4. Recompile and re-check

### Problem: Can't find all institutional references

**Solution:**
```bash
# Use case-insensitive search with more patterns
grep -i -n "morgan\|stanley\|goldman\|sachs\|citi\|jpmorgan\|chase" document.tex
```

## Resources

- **Phase Checklist:** See `resources/phase-checklist.md` for printable checklist
- **Validation Gates:** See `resources/validation-gates.md` for complete gate criteria
- **Full Workflow:** See `/docs/process/LLM_WORKFLOW.md` for 1373-line detailed version

## Related Skills

- **latex-validation:** Run before conversion to assess scope of work
- **latex-compilation:** Used in Phase 6 for compilation
- **latex-document-creation:** Alternative if starting from scratch is easier

## Success Metrics

- [ ] All 7 phases completed
- [ ] All validation gates passed
- [ ] Conversion report created
- [ ] Quality score ≥ 70/100
- [ ] PDF compiles without errors
- [ ] Visual checks passed
- [ ] Total time < 30 minutes for typical document

---

*Skill Version: 1.0.0*  
*Last Updated: 2026-01-19*  
*Compatibility: Tectonic LaTeX Project v2.0+*  
*Based on: docs/process/LLM_WORKFLOW.md (7-phase system)*
