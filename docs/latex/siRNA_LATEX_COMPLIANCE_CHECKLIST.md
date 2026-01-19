# siRNA.tex LaTeX Style Guide Compliance Checklist

**Created:** 2026-01-17  
**Purpose:** Comprehensive validation checklist for siRNA.tex against LATEX_STYLE_GUIDE.md

---

## 0A. BRANDING & LEGAL COMPLIANCE (CRITICAL)

### Color Palette
- [ ] All color variables use neutral names (brandblue, brandaccent, lightgrey, textgrey, tableheader)
- [ ] NO institutional prefixes (ms*, gs*, etc.)
- [ ] Color values match approved palette:
  ```latex
  brandblue: #003366
  brandaccent: #008EC7
  lightgrey: #F3F3F3
  textgrey: #6A6A6A
  tableheader: #E6E6E6
  ```

### Legal Disclaimers (ALL REQUIRED)
- [ ] Front cover legal notice box present after title
- [ ] Diagonal watermark on all pages (12% opacity)
- [ ] Footer disclaimer: "EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES"
- [ ] Header says "Design Portfolio: Financial Case Study" (not generic text)
- [ ] No affiliation claims with real institutions

---

## 0B. TABLE & FIGURE NUMBERING SYSTEM (CRITICAL)

### Tables
- [ ] ALL tables use `\begin{table}[H]...\caption...\end{table}` format
- [ ] NO `\captionof{table}` commands (except rare multicols exceptions)
- [ ] ALL captions have unique `\label{tab:descriptive_name}`
- [ ] Labels are descriptive (not tab:table1, tab:table2, etc.)
- [ ] No duplicate labels exist

### Figures
- [ ] ALL figures use `\begin{figure}[H]...\caption...\end{figure}` format
- [ ] NO `\captionof{figure}` commands (except rare multicols exceptions)
- [ ] ALL captions have unique `\label{fig:descriptive_name}`
- [ ] Labels are descriptive (not fig:chart1, fig:graph2, etc.)
- [ ] No duplicate labels exist

### Validation Commands
```bash
# Check for illegal captionof usage
grep "\\captionof" siRNA.tex

# Verify table/caption count matches
grep "\\begin{table}" siRNA.tex | wc -l
grep "\\caption{" siRNA.tex | wc -l

# Find missing labels
grep "\\caption{.*}" siRNA.tex -A1 | grep -v "\\label"

# Find duplicate labels (CRITICAL)
grep "\\label{" siRNA.tex | sort | uniq -d
```

---

## 0C. CAPTION CENTERING

- [ ] Global `\captionsetup{justification=centering, font=normalsize, labelfont=bf}` in preamble
- [ ] All captions are centered in compiled PDF
- [ ] If using `\captionof` inside `\begin{center}`, add local `\captionsetup{justification=centering}` before it

---

## 1. DOCUMENT HIERARCHY & PARAGRAPH STYLING

### Heading Structure
- [ ] NO standalone `\textbf{Title}` used as headings (use `\subsection{}`)
- [ ] NO manually numbered headings like "1. Topic" or "2. Analysis"
- [ ] Maximum depth is `\subsection{}` (no `\subsubsection{}`)
- [ ] `\section{}` used for major topics (3-5 per document)
- [ ] `\subsection{}` used for subtopics with multiple paragraphs
- [ ] `\textbf{}` used only for inline emphasis within paragraphs

### Paragraph Spacing
- [ ] ONE blank line between paragraphs (consistent throughout)
- [ ] NO manual `\vspace{}` between regular paragraphs
- [ ] `\vspace{0.5cm}` only before/after major visual elements (tables, charts)
- [ ] NO `\vspace{}` after `\subsection{}` headers (natural spacing is correct)

### Duplicate Prevention
- [ ] No duplicate subsection titles (check with grep)
- [ ] No copy-paste remnants or redundant content blocks

```bash
# Find duplicate subsections
grep "\\subsection{" siRNA.tex | sort | uniq -d
```

### Executive Summary
- [ ] Executive summary appears BEFORE table of contents
- [ ] Executive summary matches final content (not stale from early drafts)
- [ ] Key metrics consistent across executive summary and main sections

---

## 2. TABLE FORMATTING (CRITICAL)

### Standard Table Template
Every table MUST follow this structure:

```latex
\begin{table}[H]
\centering
\caption{Descriptive Title}
\label{tab:unique_name}
\rowcolors{2}{lightgrey}{white}
\tablefont                              % REQUIRED before adjustbox
\begin{adjustbox}{max width=\textwidth} % max width, NOT width
\begin{tabular}{...}
...
\end{tabular}
\end{adjustbox}
\par\vspace{0.1cm}                      % REQUIRED: \par forces line break
{\tiny Source: James Bian Research}
\end{table}
```

### Table Checklist
- [ ] ALL tables have `\tablefont` before `\begin{adjustbox}`
- [ ] ALL tables use `max width=\textwidth` (NOT `width=\textwidth`)
- [ ] ALL table sources use `\par\vspace{0.1cm}` before source text (prevents side-by-side)
- [ ] ALL tables use `\rowcolors{2}{lightgrey}{white}` for alternating colors
- [ ] ALL tables are inside `\begin{table}[H]` float environment
- [ ] Standard `tabular` used (NOT `tabularx` due to colortbl conflicts)
- [ ] Column widths use `p{...}` format summing to ~0.9-1.0 linewidth

### Preamble Requirements
- [ ] `\newcommand{\tablefont}{\footnotesize}` defined
- [ ] `mstable` and `mstablescaled` environments defined
- [ ] Array/colortbl compatibility fix present:
  ```latex
  \makeatletter
  \let\insert@pcolumn\insert@column
  \makeatother
  ```

---

## 3. SPECIAL CHARACTERS & TEXT SAFETY

### Critical Escapes
- [ ] ALL ampersands in text are `\&` (not `&`)
- [ ] ALL dollar signs are `\$` (not `$`)
- [ ] ALL percentages are `\%` (not `%`)
- [ ] ALL underscores in text are `\_` (not `_`)
- [ ] NO unescaped special characters in section headers
- [ ] NO unescaped special characters in custom command arguments

### Common Violations
```bash
# Find unescaped ampersands (dangerous!)
grep -n "[^\\]&" siRNA.tex | grep -v "tabular\|align"

# Find unescaped dollar signs
grep -n "[^\\]\$[0-9]" siRNA.tex

# Find unescaped percentages  
grep -n "[0-9]%" siRNA.tex | grep -v "\\%"
```

---

## 4. CHART FORMATTING (PGFPLOTS)

### Chart Dimensions
- [ ] 2-3 data points: Fixed width 8-10cm
- [ ] 4-5 data points: Fixed width 10-12cm
- [ ] 6+ data points: Can use `width=0.95\textwidth` or fixed 14cm
- [ ] Heatmaps/3D: Fixed `width=12cm` for proper colorbar

### Bar Width Scaling
- [ ] 2-3 bars: `bar width=25pt` maximum
- [ ] 4-6 bars: `bar width=20pt`
- [ ] 7+ bars: `bar width=15pt`
- [ ] `enlarge x limits` specified to control spacing

### Font Consistency (CRITICAL - All charts)
- [ ] `ylabel style={font=\footnotesize}`
- [ ] `xlabel style={font=\footnotesize}`
- [ ] `xticklabel style={font=\footnotesize}`
- [ ] `yticklabel style={font=\footnotesize}`
- [ ] `nodes near coords style={font=\footnotesize, font=\bfseries}` (NO \tiny!)
- [ ] `legend style={font=\footnotesize}`
- [ ] `title style={font=\footnotesize}` (if used)
- [ ] `colorbar style={ticklabel style={font=\footnotesize}}` (for heatmaps)

### Legend Positioning
- [ ] ALL charts have explicit legend position (not relying on defaults)
- [ ] Preferred: Below chart, centered: `at={(0.5,-0.15)}, anchor=north`
- [ ] Horizontal layout: `legend columns=-1`
- [ ] Font size: `\footnotesize` (not \tiny)
- [ ] No legend overlapping data

### Notes/Sources Positioning
- [ ] Notes positioned INSIDE tikzpicture using `\pgfplotsset{after end axis/.append code={...}}`
- [ ] Text width matches chart width
- [ ] Font size: `\tiny` for sources
- [ ] Proper `yshift` for spacing from chart

### Semantic Chart Styles
- [ ] Charts use predefined styles: `msstyle`, `compactchart`, `comparestyle`, or `divergingstyle`
- [ ] NO ad-hoc color definitions in chart body (use semantic styles)
- [ ] Colors match approved palette

### Multi-AddPlot Error Prevention
- [ ] Color-coded bars use single `\addplot` with color mapping OR
- [ ] Multiple `\addplot` commands use `forget plot` directive (except first)
- [ ] Stacked bar charts properly use `ybar stacked` with multiple addplots

### Colormap Definition
- [ ] RdYlGn colormap defined in preamble if used
- [ ] No undefined colormaps referenced

---

## 5. COMPILATION ERROR PREVENTION

### Common Errors to Avoid
- [ ] NO blank lines inside `\addplot[...]` options blocks
- [ ] NO undefined colormaps
- [ ] Newline BEFORE all `\begin{...}` environments
- [ ] Percentages in symbolic coordinates escaped: `\%`
- [ ] Dollar signs for currency escaped: `\$`
- [ ] NO unmatched braces in any command

### Package Compatibility
- [ ] `\usepackage[table]{xcolor}` used (NOT separate colortbl)
- [ ] NO `\usepackage{colortbl}` present
- [ ] Array/colortbl compatibility fix present
- [ ] Float package loaded: `\usepackage{float}`
- [ ] Caption package loaded with settings: `\usepackage{caption}`

---

## 6. GLOBAL PGFPLOTS SETTINGS

### Required Preamble Settings
- [ ] `\pgfplotsset{compat=1.18}` specified
- [ ] `ybar legend/.style={area legend}` defined (prevents double-pad legends)
- [ ] Default legend positioning defined in `every axis/.append style`
- [ ] RdYlGn colormap defined
- [ ] Custom cycle list defined for multi-series charts
- [ ] Semantic styles defined: msstyle, compactchart, comparestyle, divergingstyle

---

## 7. DOCUMENT STRUCTURE

### Preamble Order
- [ ] Document class: `\documentclass[10pt, a4paper]{article}`
- [ ] Geometry settings
- [ ] Font encoding and family
- [ ] Color packages (xcolor with [table] option)
- [ ] Graphics and plotting packages
- [ ] Float and caption packages
- [ ] Multi-column and adjustbox packages
- [ ] Custom commands and environments
- [ ] Color definitions
- [ ] Page header/footer setup
- [ ] Watermark setup
- [ ] Chart style definitions

### Document Body Order
- [ ] Title block with `\reporttitle`
- [ ] Legal disclaimer box
- [ ] Rating box and estimates box
- [ ] Executive summary (BEFORE TOC)
- [ ] Table of contents
- [ ] Main content sections
- [ ] Appendices (if any)

### Environments
- [ ] `maincontent` environment defined for narrower main text
- [ ] `mstable` and `mstablescaled` environments defined
- [ ] All custom environments properly opened and closed

---

## 8. CROSS-REFERENCING

### Label Usage
- [ ] All tables referenced with `\ref{tab:name}` where appropriate
- [ ] All figures referenced with `\ref{fig:name}` where appropriate
- [ ] All labels follow naming convention: `tab:descriptive_name` or `fig:descriptive_name`
- [ ] NO generic labels like `tab:1` or `fig:chart`

---

## 9. MULTICOLS ENVIRONMENT

### Usage
- [ ] Executive summary uses `\begin{multicols}{2}` properly
- [ ] Main content sections use multicols where appropriate
- [ ] Tables/figures inside multicols use proper float environments
- [ ] Wide tables/figures moved outside multicols to full-width

---

## 10. FINAL PRE-COMPILATION CHECKS

### Validation Commands
```bash
# 1. Check for captionof usage
grep "\\captionof" siRNA.tex

# 2. Verify label uniqueness
grep "\\label{" siRNA.tex | sort | uniq -d

# 3. Check for unescaped special characters
grep -n "[^\\]&" siRNA.tex | grep -v "tabular\|align"
grep -n "[0-9]%" siRNA.tex | grep -v "\\%"

# 4. Find duplicate subsections
grep "\\subsection{" siRNA.tex | sort | uniq -d

# 5. Verify table formatting
grep -A2 "begin{table}" siRNA.tex | grep -E "(tablefont|max width)"

# 6. Check chart font consistency
grep -A20 "begin{axis}" siRNA.tex | grep "font=" | grep -v "footnotesize"
```

### Visual Inspection (After Compilation)
- [ ] All table fonts are consistent size
- [ ] All chart fonts are legible (not too small)
- [ ] All captions are centered
- [ ] All tables are numbered sequentially
- [ ] All figures are numbered sequentially
- [ ] Legend placement is professional (not overlapping data)
- [ ] Chart spacing is appropriate (not too wide for sparse data)
- [ ] Sources appear below tables/charts (not beside them)
- [ ] Watermark appears on all pages
- [ ] Footer disclaimer visible on all pages
- [ ] No content overflows page margins

---

## SUMMARY: CRITICAL MUST-FIX ITEMS

### P0 - Compilation Blockers
1. Unescaped ampersands in text
2. Undefined colormaps
3. Blank lines in axis options
4. Missing package dependencies

### P1 - Legal/Branding
1. Neutral color names only
2. All legal disclaimers present
3. No institutional affiliation claims

### P2 - Professional Quality
1. Table font consistency (tablefont + max width)
2. Figure/table numbering with labels
3. Chart font sizes (all \footnotesize, no \tiny)
4. Caption centering
5. Legend positioning
6. Source text positioning (\par\vspace)

### P3 - Style Compliance
1. Paragraph spacing consistency
2. Heading hierarchy
3. No duplicate sections
4. Executive summary before TOC

---

**Total Checklist Items:** 150+  
**Estimated Review Time:** 30-45 minutes  
**Recommended Approach:** Tackle by section (0A → 10) systematically
