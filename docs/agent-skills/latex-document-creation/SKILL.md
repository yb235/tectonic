---
name: latex-document-creation
description: Create new compliant LaTeX financial case study documents from templates with proper branding, legal disclaimers, and formatting standards. Use when starting a new document from scratch.
usage: |
  - "Create a new financial case study document"
  - "Start a new LaTeX document about [topic]"
  - "Generate a case study template"
  - "Set up a new compliant document"
version: 1.0.0
priority: high
---

# LaTeX Document Creation Skill

## Overview

This skill guides the creation of new, compliant LaTeX documents for financial case studies using the Tectonic project's templates and standards. It ensures brand consistency, legal compliance, and proper document structure from the start.

**Core Principle:** Start with compliant templates, never build from scratch.

## When to Use

Trigger this skill when the user:
- Requests a new financial case study document
- Wants to create a document about a specific company/topic
- Asks to "start fresh" or "create from template"
- Needs a compliant document structure

## Prerequisites

- Access to `templates/template.tex` (master template)
- Access to `templates/intelapple.tex` (reference example)
- Brand colors and legal disclaimers defined
- Dev container available (for compilation)

## Execution Steps

### Step 1: Gather Requirements

**Ask the user to specify:**
1. **Document Topic:** Company/product being analyzed (e.g., "Intel/Apple Partnership")
2. **Ticker Symbol:** Stock ticker for cover page (e.g., "INTC")
3. **Main Sections:** Key areas to cover (e.g., "Technology Analysis", "Market Position")
4. **Target Length:** Approximate page count (typical: 15-25 pages)

**Validate Requirements:**
- [ ] Topic is clearly defined
- [ ] No real institutional branding required (use neutral terms)
- [ ] Educational/case study purpose (not investment advice)

### Step 2: Copy Master Template

```bash
# Create project directory structure
mkdir -p work/PROJECT_NAME/{source,output,logs}

# Copy template
cp templates/template.tex work/PROJECT_NAME/source/document.tex

# Create progress tracker
cat > work/PROJECT_NAME/progress_checklist.md << 'EOF'
# Document Creation Progress: PROJECT_NAME

## Status
- [x] Template copied
- [ ] Metadata customized
- [ ] Executive summary drafted
- [ ] Main sections created
- [ ] Tables/charts added
- [ ] Validation passed
- [ ] Compiled successfully

## Notes
(Track decisions and issues here)
EOF
```

### Step 3: Customize Document Metadata

**Edit the preamble (lines 1-250 of document.tex):**

```latex
% Update document title command (around line 230)
\newcommand{\reporttitle}[3]{
    \begin{tikzpicture}[remember picture, overlay]
        % ... existing watermark and cover page code ...
        
        % UPDATE THESE VALUES:
        \node[anchor=center] at (current page.center) [yshift=2cm] {
            {\Huge\bfseries\color{brandblue}#1}  % Ticker symbol
        };
        \node[anchor=center] at (current page.center) {
            {\Large\bfseries\color{brandblue}#2}  % Main title
        };
        \node[anchor=center] at (current page.center) [yshift=-1.5cm] {
            {\large\color{textgrey}#3}  % Subtitle
        };
    \end{tikzpicture}
}

% In the document body, call with your values:
\reporttitle{TICKER}{Main Title}{Subtitle}
```

**Example:**
```latex
\reporttitle{INTC}{Intel/Apple Foundry Partnership Analysis}{Strategic Assessment of 18A Process Technology}
```

### Step 4: Build Executive Summary Structure

**Insert after the cover page (after `\newpage`):**

```latex
\section*{Executive Summary}
\addcontentsline{toc}{section}{Executive Summary}

\begin{multicols}{2}

% Rating/Recommendation Boxes
\begin{tcolorbox}[colback=lightgrey, colframe=brandblue, title=Investment Rating]
    \textbf{CASE STUDY:} Educational Analysis\\
    \textbf{NOT FOR INVESTMENT PURPOSES}
\end{tcolorbox}

% Key Points
\subsection*{Key Findings}
\begin{itemize}
    \item [Bullet point 1]
    \item [Bullet point 2]
    \item [Bullet point 3]
    \item [Bullet point 4]
\end{itemize}

% Brief narrative (2-3 paragraphs)
This case study examines [brief introduction].

[Context paragraph]

[Conclusion paragraph]

\end{multicols}
```

**Validation:**
- [ ] Uses `multicols` environment correctly
- [ ] Includes educational disclaimer
- [ ] No institutional branding references

### Step 5: Create Main Section Structure

**Add sections based on user requirements:**

```latex
\newpage
\section{Section 1 Title}

Introduction paragraph for this section.

\subsection{Subsection 1.1}

Content here...

\subsection{Subsection 1.2}

Content here...

% Repeat for each major section
\newpage
\section{Section 2 Title}

...
```

**Section Guidelines:**
- Use `\section{}` for major topics (triggers page break)
- Use `\subsection{}` for subtopics (no page break)
- **NEVER** use `\subsubsection{}` (too deep, use bold text instead)
- Leave blank line between paragraphs
- Use `\vspace{0.3cm}` only around tables/figures

### Step 6: Add Placeholder Tables and Figures

**For each data point that needs a table:**

```latex
\begin{table}[H]
\centering
\caption{Descriptive Table Title}
\label{tab:unique_identifier}
\rowcolors{2}{lightgrey}{white}
\tablefont
\begin{adjustbox}{max width=\textwidth}
\begin{tabular}{p{0.3\linewidth}p{0.3\linewidth}p{0.3\linewidth}}
\toprule
\textbf{Column 1} & \textbf{Column 2} & \textbf{Column 3} \\
\midrule
Data 1 & Data 2 & Data 3 \\
Data 4 & Data 5 & Data 6 \\
\bottomrule
\end{tabular}
\end{adjustbox}
\par\vspace{0.1cm}
{\tiny Source: [Data source here]}
\end{table}
```

**Table Naming Convention:**
- `tab:company_metric` (e.g., `tab:intel_revenue`)
- `tab:section_topic` (e.g., `tab:market_share_comparison`)

**For each chart/visualization:**

```latex
\begin{figure}[H]
\centering
\caption{Chart Title}
\label{fig:unique_identifier}
\begin{tikzpicture}
\begin{axis}[
    ybar,
    width=12cm,
    height=6cm,
    bar width=20pt,
    symbolic x coords={Category A, Category B, Category C},
    xtick=data,
    xticklabel style={font=\footnotesize},
    yticklabel style={font=\footnotesize},
    ylabel={Metric Name},
    ylabel style={font=\footnotesize},
    nodes near coords,
    nodes near coords style={font=\footnotesize, color=white},
    ymajorgrids=true,
    grid style={dotted, gray}
]
\addplot[fill=brandblue] coordinates {(Category A,10) (Category B,20) (Category C,15)};
\legend{Series Name}
\end{axis}
\pgfplotsset{
    after end axis/.append code={
        \node[anchor=north, font=\tiny, text width=12cm, align=center] 
        at (current axis.south) [yshift=-1.5cm] {
            Source: [Data source here]
        };
    }
}
\end{tikzpicture}
\end{figure}
```

**Chart Naming Convention:**
- `fig:company_metric_chart` (e.g., `fig:intel_yield_progression`)
- `fig:section_visualization` (e.g., `fig:competitive_landscape`)

### Step 7: Add Table of Contents

**Insert before the first main section:**

```latex
\newpage

% TOC Header (boxed)
\begin{tcolorbox}[
    colback=lightgrey,
    colframe=lightgrey,
    boxrule=0pt,
    sharp corners,
    left=10pt, right=10pt, top=10pt, bottom=10pt
]
    {\color{brandblue}\Large\bfseries Table of Contents}
\end{tcolorbox}
\vspace{0.3cm}

% TOC Body (unboxed - must allow page breaks)
\renewcommand{\contentsname}{}
\setcounter{tocdepth}{2}
\tableofcontents

\newpage
```

**Critical Rule:** `\tableofcontents` must be UNBOXED (not inside tcolorbox) to allow page breaks.

### Step 8: Verify Legal Compliance

**Checklist:**
- [ ] Front page has educational disclaimer box
- [ ] Diagonal watermark: "SAMPLE: FICTIONAL DATA / DESIGN CASE STUDY"
- [ ] Footer on every page: "EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES"
- [ ] No references to real institutional branding (Morgan Stanley, Goldman Sachs, etc.)
- [ ] Brand colors use neutral names (`brandblue`, not `msblue`)

**The template includes these by default. Verify they are NOT removed.**

### Step 9: Pre-Compilation Validation

**Run these checks before first compilation:**

```bash
# Check for forbidden patterns
grep -n "\\captionof" work/PROJECT_NAME/source/document.tex
# Expected: Empty output (or only inside multicols with \captionsetup)

# Check for institutional branding
grep -nE "(Morgan Stanley|Goldman|msblue|gsgreen)" work/PROJECT_NAME/source/document.tex
# Expected: Empty output

# Check for duplicate labels
grep "\\label{" work/PROJECT_NAME/source/document.tex | sort | uniq -d
# Expected: Empty output

# Check for unescaped special characters (outside tables)
grep -P '(?<!\\)[\$%&]' work/PROJECT_NAME/source/document.tex | grep -v "begin{tabular}"
# Expected: Minimal output (only in tables)
```

**If any checks fail, fix before compiling.**

### Step 10: Initial Compilation

**Use latex-compilation skill:**
1. Ensure in dev container
2. Navigate to document location
3. Run: `latexmk -pdf -interaction=nonstopmode document.tex`
4. Verify PDF generates without errors

**Expected First Compile Results:**
- ✅ PDF generated
- ⚠️ Possible warnings about undefined references (normal for first pass)
- ⚠️ Possible overfull/underfull hbox warnings (cosmetic, acceptable)

### Step 11: Document Handoff

**Create project README:**

```bash
cat > work/PROJECT_NAME/README.md << 'EOF'
# PROJECT_NAME

## Overview
[Brief description of document topic]

## Status
**Created:** YYYY-MM-DD  
**Last Updated:** YYYY-MM-DD  
**Compilation Status:** ✅ Successful / ⚠️ Warnings / ❌ Errors  
**Page Count:** XX pages

## Structure
- Executive Summary
- [Section 1 name]
- [Section 2 name]
- [...]

## Next Steps
- [ ] Populate tables with real data
- [ ] Add charts/visualizations
- [ ] Refine executive summary
- [ ] Review for compliance
- [ ] Final compilation

## Files
- `source/document.tex` - Main LaTeX source
- `output/document.pdf` - Compiled PDF
- `logs/` - Compilation logs
- `progress_checklist.md` - Task tracking

## Compliance
- ✅ Legal disclaimers present
- ✅ Brand colors compliant
- ✅ Template-based structure
- ✅ No institutional branding
EOF
```

## Decision Trees

### Topic Appropriateness Check

```
Is topic a financial case study?
├─ YES → Is it educational (not investment advice)?
│   ├─ YES → Proceed with creation
│   └─ NO → Add stronger educational disclaimers
│
└─ NO → This skill may not be appropriate
    └─ Consider: Is this a general LaTeX document?
        └─ May need different template
```

### Section Structure Decision

```
Content needs organization?
├─ Major topic spanning 3+ pages?
│   └─ Use \section{} (triggers page break)
│
├─ Subtopic with 2-4 paragraphs?
│   └─ Use \subsection{} (no page break)
│
└─ Single paragraph emphasis?
    └─ Use \textbf{} inline (no heading)
```

## Examples

### Example 1: Creating Intel Case Study

**User Request:** "Create a financial case study document analyzing Intel's foundry business"

**Agent Actions:**

```bash
# Step 1: Requirements gathered
# Topic: Intel Foundry Business Analysis
# Ticker: INTC
# Sections: Market Position, Technology Assessment, Financial Impact
# Length: 20 pages

# Step 2: Copy template
mkdir -p work/intel_foundry_2026/{source,output,logs}
cp templates/template.tex work/intel_foundry_2026/source/document.tex

# Step 3: Customize metadata
# Edit document.tex:
\reporttitle{INTC}{Intel Foundry Business Analysis}{Strategic Assessment of IFS Division and 18A Technology}

# Steps 4-11: Follow structure creation...
```

**Agent Response:**
```
✅ Document created: work/intel_foundry_2026/source/document.tex
📄 Structure: Executive Summary + 3 main sections + TOC
🎨 Brand compliance: ✅ Neutral colors, legal disclaimers present
📋 Next: Populate with content, add tables/charts
```

### Example 2: Multi-Company Comparison

**User Request:** "Create a document comparing semiconductor foundries"

**Agent Actions:**
```bash
# Gathered requirements
# Topic: Foundry Competitive Landscape
# Ticker: SEMI
# Sections: Technology Nodes, Capacity, Market Share, Future Outlook
# Special: Multiple company comparison

# Created with emphasis on comparison tables
# Added placeholders for:
# - Table: Process node comparison (TSMC, Intel, Samsung)
# - Table: Capacity by geography
# - Chart: Market share evolution 2020-2026
# - Chart: CapEx comparison
```

## Troubleshooting

### Problem: Template file not found

**Solution:**
```bash
# Verify template exists
ls templates/template.tex

# If missing, this is a critical error - template is required
# Check repository integrity or restore from version control
```

### Problem: Compilation fails immediately after creation

**Cause:** Template may have been modified incorrectly

**Solution:**
1. Restore template from `templates/template.tex`
2. Re-apply customizations carefully
3. Test after each change

### Problem: Table of contents is empty

**Cause:** Compilation needs second pass to resolve references

**Solution:**
```bash
# Run compilation twice
latexmk -pdf -interaction=nonstopmode document.tex
latexmk -pdf -interaction=nonstopmode document.tex
```

### Problem: Colors look wrong

**Cause:** Color definitions may be overridden

**Solution:**
```bash
# Verify color definitions in preamble
grep "definecolor{brand" document.tex

# Should see:
# \definecolor{brandblue}{HTML}{003366}
# \definecolor{brandaccent}{HTML}{008EC7}
# \definecolor{lightgrey}{HTML}{F3F3F3}
# \definecolor{textgrey}{HTML}{6A6A6A}
# \definecolor{tableheader}{HTML}{E6E6E6}
```

## Resources

- **Template Reference:** See `resources/template-guide.md` for detailed template anatomy
- **Brand Colors:** See `resources/brand-colors.md` for approved color palette
- **Legal Requirements:** See `/docs/legal/COPYRIGHT_AND_LICENSE_AUDIT.md`
- **Style Guide:** See `/docs/latex/LATEX_STYLE_GUIDE.md` for comprehensive rules

## Related Skills

- **latex-compilation:** Use after creation to generate PDF
- **latex-validation:** Use to verify compliance before populating content
- **latex-conversion:** Not needed - starting fresh with compliant template

## Best Practices

1. **Always start with template** - Never build preamble from scratch
2. **Customize incrementally** - Change one thing, compile, verify
3. **Use placeholders** - Mark sections for data with `[TODO: ...]` comments
4. **Track progress** - Update progress_checklist.md regularly
5. **Validate early** - Run checks before adding significant content
6. **Keep executive summary generic** - Write it LAST after main content is complete

## Success Metrics

- [ ] Document created from template (not from scratch)
- [ ] All legal disclaimers present
- [ ] Brand colors use neutral names
- [ ] Structure follows template patterns
- [ ] Compiles without errors on first try
- [ ] Project directory properly organized
- [ ] Progress tracker initialized

---

*Skill Version: 1.0.0*  
*Last Updated: 2026-01-19*  
*Compatibility: Tectonic LaTeX Project v2.0+*  
*Template Base: templates/template.tex*
