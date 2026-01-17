# siRNA.tex LaTeX Compliance Checklist

This checklist validates that siRNA.tex complies with the LaTeX Style Guide and template requirements.

## ✅ CRITICAL FIXES REQUIRED

### 0A. Branding & Legal Compliance
- [ ] **REMOVE** all references to "Morgan Stanley" branding
  - [ ] Replace `msblue`, `msbrightblue`, `msgrey`, `mstextgrey`, `mstableheader` → `brandblue`, `brandaccent`, `lightgrey`, `textgrey`, `tableheader`
  - [ ] Update header from "Morgan Stanley | RESEARCH" → "James Bian | Design Portfolio: Financial Case Study"
  - [ ] Update footer from "Morgan Stanley Research" → "James Bian Research"
  - [ ] Update right header from "ASIA PACIFIC INSIGHT" → "TECH VISION" (or relevant category)

- [ ] **ADD** mandatory legal disclaimer box (Section 0B requirement)
  - [ ] Front cover disclaimer box after title
  - [ ] Diagonal watermark on every page
  - [ ] Footer disclaimer: "EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES"

**Risk Level:** CRITICAL - Trademark/trade dress violation

### 0B. Package Compatibility
- [ ] **REMOVE** `\usepackage{colortbl}` (causes conflicts with xcolor[table])
- [ ] **ADD** `\usepackage[table]{xcolor}` instead
- [ ] **ADD** `\usepackage{tabularx}` for flexible table columns
- [ ] **ADD** `\usepackage{changepage}` for adjustwidth (maincontent environment)
- [ ] **ADD** `\usepackage{eso-pic}` for watermark
- [ ] **ADD** array/colortbl compatibility fix:
```latex
\makeatletter
\let\insert@pcolumn\insert@column
\makeatother
```

### 0C. Table & Figure Numbering
- [ ] **CONVERT** all `\captionof{table}` → `\begin{table}[H]...\caption...\end{table}`
- [ ] **CONVERT** all `\captionof{figure}` → `\begin{figure}[H]...\caption...\end{figure}`
- [ ] **ADD** unique `\label{tab:name}` or `\label{fig:name}` after every caption
- [ ] **VERIFY** no duplicate labels exist

**Current Issues Found:**
```bash
grep "\\captionof" siRNA.tex
# Lines: 241, 276, 390, 436, 532, 684, 819, 945, 1123, 1287
```

### 0D. Caption Centering
- [ ] **ADD** global `\captionsetup{justification=centering, font=normalsize, labelfont=bf}` in preamble
- [ ] **VERIFY** all captions are centered in PDF output

### 1. Document Hierarchy
- [ ] **NO** standalone `\textbf{Title}` used as headings (use `\subsection{}`)
- [ ] **NO** manually numbered headings like "1. Topic"
- [ ] Maximum depth is `\subsection{}` (no `\subsubsection{}`)

### 2. Paragraph Styling
- [ ] **ONE** blank line between paragraphs (no more, no less)
- [ ] **NO** manual `\vspace{}` between regular paragraphs
- [ ] `\vspace{0.5cm}` only before/after major visual elements (tables, charts)

### 3. Table Formatting
All tables must follow this structure:

```latex
\begin{table}[H]
\centering
\caption{Table Title}
\label{tab:unique_name}
\tablefont                              % REQUIRED
\begin{adjustbox}{max width=\textwidth} % max width, NOT width
\rowcolors{2}{lightgrey}{white}
\begin{tabular}{...}
...
\end{tabular}
\end{adjustbox}
\par\vspace{0.1cm}                      % REQUIRED: \par forces line break
{\tiny Source: James Bian Research}
\end{table}
```

**Issues to Fix:**
- [ ] All tables use `\tablefont` before adjustbox
- [ ] All tables use `max width=\textwidth` (NOT `width=`)
- [ ] All table sources use `\par\vspace{0.1cm}` before source text
- [ ] All tables have proper `\label{tab:...}`

### 4. Chart Formatting
All charts must follow this structure:

```latex
\begin{figure}[H]
\centering
\caption{Chart Title}
\label{fig:unique_name}
\begin{tikzpicture}
\begin{axis}[
    msstyle,  % or compactchart, comparestyle, divergingstyle
    width=10cm,  % Fixed width for sparse data
    ...
]
\addplot[fill=brandblue] coordinates {...};
\end{axis}
\end{tikzpicture}
\par\vspace{0.1cm}
{\tiny Source: James Bian Research}
\end{figure}
```

**Issues to Fix:**
- [ ] All charts use semantic styles (`msstyle`, `compactchart`, `comparestyle`, `divergingstyle`)
- [ ] Charts with 2-3 data points use fixed widths (8-12cm), not percentage-based
- [ ] All chart elements use `\footnotesize` (never `\tiny` for data labels)
- [ ] Notes/sources positioned inside or below figure with `\par\vspace{0.1cm}`
- [ ] All charts have proper `\label{fig:...}`

### 5. Chart Color Consistency
- [ ] **NO** hardcoded colors like `fill=blue` in chart bodies
- [ ] **ALL** charts use approved palette colors:
  - `brandblue` (primary)
  - `brandaccent` (highlights)
  - `lightgrey` (backgrounds)
  - `textgrey` (secondary text)

### 6. Legend Positioning
- [ ] Global legend style configured in preamble:
```latex
every axis/.append style={
    legend style={at={(0.5,-0.15)}, anchor=north, legend columns=-1, draw=none, font=\footnotesize}
}
```
- [ ] No legends overlapping chart content

### 7. Executive Summary Structure
- [ ] Executive summary appears BEFORE table of contents
- [ ] TOC NOT wrapped in `tcolorbox`
- [ ] Wide summary tables use full-width format (outside `multicols`)
- [ ] Column widths sum to ≤1.0 of `\textwidth`

### 8. Common Compilation Errors Prevention
- [ ] **NO** blank lines inside `\addplot[...]` option blocks
- [ ] **ALL** colormaps defined (e.g., `RdYlGn`) if used
- [ ] Newline before every `\begin{...}` environment
- [ ] `%` escaped as `\%` in text (except in tikz coordinates)
- [ ] `$` escaped as `\$` for currency values
- [ ] `&` escaped as `\&` in text (except in tabular)

### 9. Custom Environments
- [ ] `\begin{maincontent}...\end{maincontent}` wraps main body (narrower margins)
- [ ] `\estimatesbox{}` used for "What's Changed" sections
- [ ] `\ratingbox{}` or `\dualratingbox{}` used for stock ratings

---

## 🔍 VALIDATION COMMANDS

Run these commands BEFORE compilation:

```bash
# 1. Check for illegal captionof usage
grep "\\captionof" siRNA.tex

# 2. Verify table format consistency
grep "\\begin{table}" siRNA.tex | wc -l
grep "\\caption{" siRNA.tex | wc -l
# These counts should match!

# 3. Find missing labels
grep "\\caption{.*}" siRNA.tex -A1 | grep -v "\\label"

# 4. Find duplicate labels
grep "\\label{" siRNA.tex | sort | uniq -d

# 5. Check for old color names
grep -E "(msblue|msbrightblue|msgrey|mstextgrey|mstableheader)" siRNA.tex

# 6. Find pseudo-headings
grep -n "^\\\\textbf{" siRNA.tex

# 7. Check for duplicate subsections
grep "\\subsection{" siRNA.tex | sort | uniq -d

# 8. Verify colortbl removed
grep "colortbl" siRNA.tex

# 9. Check for width= instead of max width=
grep "width=\\\\textwidth" siRNA.tex
```

---

## ✅ PRE-SUBMISSION CHECKLIST

Before finalizing the document:

- [ ] All validation commands run successfully
- [ ] PDF compiles without errors
- [ ] All captions are centered
- [ ] All tables and figures are numbered sequentially
- [ ] Watermark appears on all pages
- [ ] Legal disclaimer visible on first page
- [ ] No "Morgan Stanley" or institutional branding present
- [ ] All sources cite "James Bian Research"
- [ ] TOC shows proper hierarchy (Section → Subsection only)

---

## 📊 SPECIFIC ISSUES IN siRNA.tex

### Found Issues (From Initial Scan):

1. **Line 1-2**: Header says "MORGAN STANLEY RESEARCH"
   - Fix: Update to "James Bian | Design Portfolio: Financial Case Study"

2. **Lines 26-30**: Old color definitions (msblue, etc.)
   - Fix: Rename to brandblue, brandaccent, lightgrey, textgrey, tableheader
   - Fix: Adjust hex values slightly from any exact institutional match

3. **Lines 36-48**: Header/footer branding
   - Fix: Remove all "Morgan Stanley" references

4. **Line 91**: Missing legal disclaimer box
   - Fix: Add mandatory disclaimer after `\reporttitle`

5. **Missing**: Diagonal watermark
   - Fix: Add watermark code in preamble

6. **Missing**: `\usepackage{eso-pic}`, `\usepackage{changepage}`, `\usepackage{tabularx}`
   - Fix: Add these packages

7. **Line 10**: Uses `\usepackage{colortbl}` causing conflicts
   - Fix: Remove and use `\usepackage[table]{xcolor}` instead

8. **Multiple locations**: Uses `\captionof{table}` and `\captionof{figure}`
   - Fix: Convert to proper `\begin{table}[H]` and `\begin{figure}[H]` environments

9. **Multiple locations**: Charts use old `msstyle` without updated colors
   - Fix: Update pgfplotsset to use brandblue/brandaccent

10. **Missing**: `\captionsetup{}` in preamble
    - Fix: Add caption formatting configuration

---

## 📝 PRIORITY ORDER

1. **CRITICAL (Legal)**: Branding removal + legal disclaimers
2. **CRITICAL (Compilation)**: Package compatibility fixes
3. **HIGH**: Table/figure numbering system
4. **HIGH**: Color palette updates
5. **MEDIUM**: Caption centering
6. **MEDIUM**: Chart style updates
7. **LOW**: Minor spacing adjustments

---

## 🎯 EXPECTED OUTCOME

After all fixes, siRNA.tex should:
- Compile without errors
- Have neutral branding (James Bian, not Morgan Stanley)
- Include legal disclaimers and watermark
- Have sequential table/figure numbering
- Use consistent color palette
- Follow all template formatting rules
- Be ready for portfolio presentation
