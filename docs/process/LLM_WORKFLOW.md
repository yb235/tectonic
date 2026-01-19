# LLM Workflow: Raw LaTeX → Compliant Template

**Purpose:** This workflow guides an LLM agent through converting a raw LaTeX file into a repository-compliant document. Each phase includes explicit validation gates, success criteria, and error handling procedures.

**Target Audience:** LLM agents processing financial case study documents  
**Expected Time:** 15-25 minutes for typical document (10-20 pages)  
**Critical Principle:** Validate before proceeding to next phase

---

## PHASE 0: Pre-Flight Preparation

### Task: Load Context & Initialize Work Environment

**Success Criteria:**
- ✅ All required reference documents read
- ✅ Work directory created with correct structure
- ✅ Source file validated (not corrupted)

**Actions:**

1. **Read required documentation in this order:**
   ```
   Priority 1 (CRITICAL - Read First):
   - docs/latex/LATEX_STYLE_GUIDE.md (all sections, focus on Section 0A-0D)
   - docs/legal/COPYRIGHT_AND_LICENSE_AUDIT.md (Section 7)
   
   Priority 2 (Validation Rules):
   - docs/latex/LATEX_CHECKLIST.md (complete checklist)
   - templates/template.tex (lines 1-250: preamble structure)
   
   Priority 3 (Reference Examples):
   - templates/intelapple.tex (lines 1-100: header setup, lines 100-300: content patterns)
   ```

2. **For siRNA-specific jobs, additionally read:**
   ```
   - docs/latex/siRNA_CHECKLIST.md
   - templates/examples/siRNA.tex (reference patterns only)
   ```

3. **Extract key requirements:**
   - Brand colors: `brandblue=#003366`, `brandaccent=#008EC7`, `lightgrey=#F3F3F3`, `textgrey=#6A6A6A`, `tableheader=#E6E6E6`
   - Forbidden terms: Any reference to real financial institutions (Morgan Stanley, Goldman Sachs, etc.)
   - Required disclaimers: Front cover box + diagonal watermark + footer text
   - Table format: `\begin{table}[H]` with `\caption` and `\label` (NEVER `\captionof`)
   - Figure format: `\begin{figure}[H]` with `\caption` and `\label` (NEVER `\captionof`)

4. **Create work environment:**
   ```bash
   # Create directory structure
   mkdir -p work/PROJECT_NAME/{source,output,logs}
   
   # Copy raw file to work directory
   cp incoming/raw_YYYYMMDD_project.tex work/PROJECT_NAME/source/original.tex
   
   # Create tracking file
   touch work/PROJECT_NAME/progress_checklist.md
   ```

5. **Initialize progress tracker (progress_checklist.md):**
   ```markdown
   # Conversion Progress: PROJECT_NAME
   
   ## Phase Status
   - [ ] Phase 0: Pre-flight (Context Loaded)
   - [ ] Phase 1: Preamble Compliance
   - [ ] Phase 2: Content Structure
   - [ ] Phase 3: Tables & Figures
   - [ ] Phase 4: Charts & Graphics
   - [ ] Phase 5: Legal Compliance
   - [ ] Phase 6: Validation & Compilation
   
   ## Issues Log
   (Track all deviations, errors, or decisions here)
   ```

**Validation Gate:**
- [ ] Can you recite the 5 brand color names and hex values?
- [ ] Can you list the 4 mandatory legal disclaimer components?
- [ ] Do you understand why `\captionof` is forbidden?
- [ ] Is the work directory structure created successfully?

**Error Handling:**
- If source file is corrupted: Document in progress_checklist.md, request replacement
- If reference documents missing: STOP - cannot proceed without style guide
- If work directory creation fails: Check permissions, try alternative path

**Proceed to Phase 1 only if all validation checks pass.**

---

## PHASE 1: Preamble & Package Setup

### Task: Build Compliant LaTeX Preamble

**Success Criteria:**
- ✅ All required packages loaded in correct order
- ✅ Brand colors defined with neutral names
- ✅ Legal watermark configured
- ✅ Header/footer formatted correctly

**Actions:**

1. **Copy template preamble skeleton:**
   - Start with `templates/template.tex` lines 1-100
   - Preserve all package load order (critical for compatibility)

2. **Verify package checklist:**
   ```latex
   Required packages (in order):
   ✓ \documentclass[10pt, a4paper]{article}
   ✓ \usepackage[a4paper, top=2.2cm, bottom=2.5cm, left=1.4cm, right=1.4cm, headheight=1.5cm]{geometry}
   ✓ \usepackage[T1]{fontenc}
   ✓ \usepackage[scaled]{helvet}
   ✓ \usepackage[table]{xcolor}  ← NOTE: [table] option required
   ✓ \usepackage{graphicx}
   ✓ \usepackage{tcolorbox}
   ✓ \usepackage{booktabs}
   ✗ NEVER include \usepackage{colortbl}  ← Causes conflicts
   ✓ \usepackage{array}
   ✓ \usepackage{tabularx}
   ✓ \usepackage{fancyhdr}
   ✓ \usepackage{tikz}
   ✓ \usepackage{pgfplots}
   ✓ \usepackage{float}
   ✓ \usepackage{caption}
   ✓ \usepackage{multicol}
   ✓ \usepackage{adjustbox}
   ✓ \usepackage{titlesec}
   ✓ \usepackage{enumitem}
   ✓ \usepackage{changepage}
   ✓ \usepackage{eso-pic}
   ```

3. **Add compatibility fix (CRITICAL):**
   ```latex
   % Fix for array/colortbl compatibility issue with p columns
   \makeatletter
   \let\insert@pcolumn\insert@column
   \makeatother
   ```

4. **Define brand colors (exact values required):**
   ```latex
   % --- BRAND COLORS ---
   \definecolor{brandblue}{HTML}{003366}
   \definecolor{brandaccent}{HTML}{008EC7}
   \definecolor{lightgrey}{HTML}{F3F3F3}
   \definecolor{textgrey}{HTML}{6A6A6A}
   \definecolor{tableheader}{HTML}{E6E6E6}
   ```

5. **Configure watermark:**
   ```latex
   \newcommand{\watermarktext}{SAMPLE: FICTIONAL DATA / DESIGN CASE STUDY}
   \AddToShipoutPictureBG{%
       \begin{tikzpicture}[remember picture,overlay]
           \node[opacity=0.12, rotate=35, scale=3, text=gray] at (current page.center) {\bfseries \watermarktext};
       \end{tikzpicture}%
   }
   ```

6. **Set up header/footer:**
   ```latex
   \lhead{
       \raisebox{-5pt}[0pt][0pt]{%
           {\fontsize{14}{14}\selectfont\bfseries James Bian}%
           \hspace{0.2cm}\textcolor{black}{|}\hspace{0.2cm}%
           {\fontsize{9}{9}\selectfont\bfseries Design Portfolio: Financial Case Study}%
       }\\[0.1cm]
       {\color{textgrey}\fontsize{9}{9}\selectfont \today}
   }
   \rhead{{\color{brandaccent}\bfseries\fontsize{11}{11}\selectfont TECH VISION}}
   \lfoot{\color{textgrey}\fontsize{9}{9}\selectfont James Bian Research}
   \cfoot{\color{textgrey}\fontsize{7}{7}\selectfont EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES}
   \rfoot{\bfseries\thepage}
   ```

7. **Add caption configuration:**
   ```latex
   \captionsetup{justification=centering, font=normalsize, labelfont=bf}
   ```

8. **Add chart styles:**
   ```latex
   \pgfplotsset{
       compat=1.18,
       /pgfplots/ybar legend/.style={area legend},
       every axis/.append style={
           legend style={at={(0.5,-0.15)}, anchor=north, legend columns=-1, draw=none, font=\footnotesize}
       },
       msstyle/.style={...},  % Copy from template.tex
       compactchart/.style={...},
       divergingstyle/.style={...},
   }
   ```

**Validation Gate:**
- [ ] Run grep to confirm no `\usepackage{colortbl}` exists
- [ ] Run grep to confirm no color names contain institutional references (ms, gs, citi, etc.)
- [ ] Verify watermark command is present
- [ ] Check footer contains "EDUCATIONAL CASE STUDY" disclaimer

**Automated Checks:**
```bash
# Check for forbidden packages
grep -n "\\usepackage{colortbl}" work/PROJECT_NAME/source/*.tex

# Check for institutional color names
grep -nE "definecolor\{(ms|gs|citi|morgan|stanley)" work/PROJECT_NAME/source/*.tex

# Verify watermark exists
grep -n "watermarktext" work/PROJECT_NAME/source/*.tex
```

**Error Handling:**
- If colortbl found: Remove immediately, document in progress log
- If institutional color names found: Rename to brand* equivalents
- If watermark missing: Add from template

**Update progress_checklist.md:** Mark Phase 1 complete

---

## PHASE 2: Document Structure & Hierarchy

### Task: Normalize Heading Structure & Remove Duplicates

**Success Criteria:**
- ✅ All headings use proper LaTeX commands (not `\textbf{}`)
- ✅ Maximum depth is `\subsection{}` (no deeper)
- ✅ No duplicate sections detected
- ✅ Executive summary precedes TOC
- ✅ Main content wrapped in `\begin{maincontent}`

**Actions:**

1. **Scan for pseudo-headings (common LLM error):**
   ```bash
   # Find standalone bold text that should be headings
   grep -n "^\\\\textbf{.*}$" work/PROJECT_NAME/source/*.tex
   ```
   
   **Pattern to fix:**
   ```latex
   ❌ WRONG:
   \textbf{Market Overview}
   
   ✅ CORRECT:
   \subsection{Market Overview}
   ```

2. **Scan for manually numbered headings:**
   ```bash
   grep -nE "\\(section|subsection)\{[0-9]+\." work/PROJECT_NAME/source/*.tex
   ```
   
   **Pattern to fix:**
   ```latex
   ❌ WRONG:
   \subsection{1. Introduction}
   
   ✅ CORRECT:
   \subsection{Introduction}
   ```

3. **Check for excessive nesting:**
   ```bash
   grep -n "\\subsubsection" work/PROJECT_NAME/source/*.tex
   ```
   
   **Decision tree:**
   - If `\subsubsection` found → Convert to `\subsection{}`
   - If content needs more structure → Use bold inline text instead

4. **Detect duplicate sections:**
   ```bash
   # Extract all section titles
   grep "\\\\subsection{" work/PROJECT_NAME/source/*.tex | sed 's/.*subsection{\(.*\)}/\1/' | sort | uniq -d
   ```
   
   **If duplicates found:**
   - Compare content of both instances
   - Keep the more complete version
   - Document removal in progress log

5. **Verify executive summary placement:**
   ```latex
   Document structure should be:
   
   \begin{document}
   
   % Title page with legal disclaimer box
   \reporttitle{TICKER}{Title}{Subtitle}
   
   % Legal disclaimer (CRITICAL)
   \begin{tcolorbox}[colback=lightgrey, ...]
   \textbf{EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES}
   ...
   \end{tcolorbox}
   
   % Executive summary (two-column format)
   \begin{multicols}{2}
   \subsection*{Executive Summary}
   ...
   \end{multicols}
   
   % Table of contents
   \newpage
   \tableofcontents
   
   % Main content (narrower margins)
   \newpage
   \begin{maincontent}
   \section{Introduction}
   ...
   \end{maincontent}
   
   \end{document}
   ```

6. **Fix paragraph spacing:**
   ```bash
   # Find excessive blank lines
   grep -n "^$" work/PROJECT_NAME/source/*.tex | awk -F: '{print $1}' | uniq -c | awk '$1 > 2 {print}'
   ```
   
   **Pattern to enforce:**
   - ONE blank line between paragraphs
   - NO blank lines within paragraphs
   - NO `\vspace{}` between regular paragraphs

**Validation Gate:**
- [ ] Run `grep "\\textbf{" | grep -v "\\subsection"` returns no standalone headings
- [ ] Run `grep "\\subsubsection"` returns empty
- [ ] Check TOC (.toc file if generated) for no duplicate numbering
- [ ] Verify executive summary appears before `\tableofcontents`
- [ ] Verify `\begin{maincontent}` wraps main body

**Error Handling:**
- If structure is severely malformed: Document issues, may require manual intervention
- If duplicates cannot be resolved automatically: Flag for human review in progress log
- If executive summary missing: Create placeholder structure

**Update progress_checklist.md:** Mark Phase 2 complete

---

## PHASE 3: Tables & Captions

### Task: Convert to Auto-Numbered Float Environments

**Success Criteria:**
- ✅ All tables use `\begin{table}[H]` with `\caption` and `\label`
- ✅ NO `\captionof{table}` anywhere in document
- ✅ All labels follow naming convention: `\label{tab:descriptive_name}`
- ✅ All tables have `\tablefont` and `max width=\textwidth`
- ✅ All source citations use `\par\vspace{0.1cm}` pattern

**Actions:**

1. **Scan for illegal caption methods:**
   ```bash
   grep -n "\\captionof{table}" work/PROJECT_NAME/source/*.tex
   ```

2. **Conversion pattern for each table:**
   
   **BEFORE (illegal):**
   ```latex
   \begin{center}
   \captionof{table}{Revenue Breakdown}
   \tablefont
   \begin{adjustbox}{width=\textwidth}
   \begin{tabular}{lrr}
   ...
   \end{tabular}
   \end{adjustbox}
   \vspace{0.1cm}
   {\tiny Source: Company Reports}
   \end{center}
   ```
   
   **AFTER (correct):**
   ```latex
   \begin{table}[H]
   \centering
   \caption{Revenue Breakdown}
   \label{tab:revenue_breakdown}
   \tablefont
   \begin{adjustbox}{max width=\textwidth}
   \begin{tabular}{lrr}
   ...
   \end{tabular}
   \end{adjustbox}
   \par\vspace{0.1cm}
   {\tiny Source: Company Reports}
   \end{table}
   ```

3. **Generate unique labels:**
   - Extract table caption text
   - Convert to lowercase
   - Replace spaces with underscores
   - Prefix with `tab:`
   - Example: "Market Share Analysis" → `\label{tab:market_share_analysis}`

4. **Check for label conflicts:**
   ```bash
   grep "\\label{tab:" work/PROJECT_NAME/source/*.tex | cut -d'{' -f2 | cut -d'}' -f1 | sort | uniq -d
   ```
   
   **If duplicates found:**
   - Append numeric suffix: `tab:financials_2`, `tab:financials_3`
   - Document in progress log

5. **Fix adjustbox usage:**
   ```bash
   # Find incorrect width= usage
   grep -n "adjustbox}{width=" work/PROJECT_NAME/source/*.tex
   ```
   
   **Replace ALL instances:**
   - `width=\textwidth` → `max width=\textwidth`
   - `width=\linewidth` → `max width=\linewidth`

6. **Fix source citations:**
   ```bash
   # Find tables with source citations
   grep -B5 "Source:" work/PROJECT_NAME/source/*.tex | grep -A5 "\\end{adjustbox}"
   ```
   
   **Ensure pattern:**
   ```latex
   \end{adjustbox}
   \par\vspace{0.1cm}              % ← CRITICAL: \par must come first
   {\tiny Source: Data Provider}
   ```

7. **Verify table font:**
   ```bash
   # Check each table has \tablefont
   grep -A15 "\\begin{table}" work/PROJECT_NAME/source/*.tex | grep "\\tablefont"
   ```
   
   **If missing:** Add `\tablefont` immediately after `\centering` and before `\begin{adjustbox}`

**Validation Gate:**
- [ ] `grep -c "\\captionof{table}"` returns 0
- [ ] `grep -c "\\begin{table}\[H\]"` equals expected table count
- [ ] All tables have matching `\label{tab:*}`
- [ ] No duplicate labels exist
- [ ] All tables use `max width` not `width`

**Automated Validation Script:**
```bash
#!/bin/bash
echo "=== Table Validation ==="
echo "Illegal captionof usage: $(grep -c "\\captionof{table}" *.tex)"
echo "Proper table environments: $(grep -c "\\begin{table}\[H\]" *.tex)"
echo "Missing labels: $(grep "\\begin{table}" *.tex | grep -v "\\label{tab:" | wc -l)"
echo "Duplicate labels: $(grep "\\label{tab:" *.tex | cut -d'{' -f2 | cut -d'}' -f1 | sort | uniq -d | wc -l)"
echo "Incorrect width usage: $(grep -c "adjustbox}{width=" *.tex)"
```

**Error Handling:**
- If table structure is too complex: Document in progress log, may need manual review
- If label generation creates invalid characters: Sanitize (remove special chars, keep alphanumeric + underscore)
- If source citation missing: Add placeholder comment `% TODO: Add source`

**Update progress_checklist.md:** Mark Phase 3 complete

---

## PHASE 4: Figures & Charts

### Task: Standardize Chart Formatting & Numbering

**Success Criteria:**
- ✅ All figures use `\begin{figure}[H]` with `\caption` and `\label`
- ✅ NO `\captionof{figure}` anywhere
- ✅ All charts use semantic styles (msstyle, compactchart, divergingstyle)
- ✅ NO hardcoded colors in chart bodies
- ✅ All legends positioned consistently below charts
- ✅ Source notes inside tikzpicture using `after end axis`

**Actions:**

1. **Scan for illegal figure captions:**
   ```bash
   grep -n "\\captionof{figure}" work/PROJECT_NAME/source/*.tex
   ```

2. **Conversion pattern for charts:**
   
   **BEFORE:**
   ```latex
   \begin{center}
   \captionof{figure}{Market Growth}
   \begin{tikzpicture}
   \begin{axis}[ybar, fill=blue!50, ...]
   ...
   \end{axis}
   \end{tikzpicture}
   \end{center}
   ```
   
   **AFTER:**
   ```latex
   \begin{figure}[H]
   \centering
   \caption{Market Growth}
   \label{fig:market_growth}
   \begin{tikzpicture}
   \begin{axis}[msstyle, width=10cm, ...]
   \addplot[fill=brandblue] coordinates {...};
   \legend{Revenue}
   \end{axis}
   \pgfplotsset{
       after end axis/.append code={
           \node[anchor=north, font=\tiny, text width=10cm, align=center] 
                at (current axis.south) [yshift=-1.5cm] {
               Source: Market Research.
           };
       }
   }
   \end{tikzpicture}
   \end{figure}
   ```

3. **Replace hardcoded colors with semantic styles:**
   
   **Decision tree for chart styles:**
   ```
   Is the chart showing single-metric trend?
   → Use msstyle (single brandblue fill)
   
   Is the chart comparing 2-3 categories?
   → Use compactchart (brandblue + brandaccent)
   
   Is the chart showing bad-to-good data (ratings, risk levels)?
   → Use divergingstyle (red-yellow-green gradient)
   
   Is the chart showing multiple series over time?
   → Use comparestyle (brandblue, brandaccent, gray cycle)
   ```

4. **Fix chart dimensions:**
   ```bash
   # Find charts with percentage-based widths
   grep -n "width=.*\\\\linewidth" work/PROJECT_NAME/source/*.tex
   grep -n "width=.*\\\\textwidth" work/PROJECT_NAME/source/*.tex
   ```
   
   **Guideline:**
   - Sparse data (2-5 bars): Use fixed `width=8cm` or `width=10cm`
   - Dense data (10+ bars): Can use `width=0.8\textwidth`
   - Add `enlarge x limits=0.5` for sparse data

5. **Standardize legend placement:**
   ```latex
   % Add to every axis environment:
   legend style={at={(0.5,-0.15)}, anchor=north, legend columns=-1, draw=none, font=\footnotesize}
   ```
   
   **Or rely on global default (already set in preamble)**

6. **Move source notes inside tikzpicture:**
   
   **BEFORE:**
   ```latex
   \end{tikzpicture}
   {\tiny Source: Data Provider}
   ```
   
   **AFTER:**
   ```latex
   \end{axis}
   \pgfplotsset{
       after end axis/.append code={
           \node[anchor=north, font=\tiny, text width=10cm, align=center] 
                at (current axis.south) [yshift=-1.5cm] {
               Source: Data Provider.
           };
       }
   }
   \end{tikzpicture}
   ```

7. **Verify font sizes:**
   - Data labels: `\footnotesize` (NEVER `\tiny`)
   - Legend text: `\footnotesize`
   - Source notes: `\tiny`
   - Axis labels: `\footnotesize`

**Validation Gate:**
- [ ] `grep -c "\\captionof{figure}"` returns 0
- [ ] All charts use one of: msstyle, compactchart, divergingstyle, comparestyle
- [ ] No `fill=blue!50` or similar hardcoded colors in chart bodies
- [ ] All figures have `\label{fig:*}`
- [ ] Source notes positioned consistently

**Automated Checks:**
```bash
#!/bin/bash
echo "=== Chart Validation ==="
echo "Illegal captionof usage: $(grep -c "\\captionof{figure}" *.tex)"
echo "Proper figure environments: $(grep -c "\\begin{figure}\[H\]" *.tex)"
echo "Hardcoded colors in charts: $(grep "addplot\[.*fill=.*!.*\]" *.tex | wc -l)"
echo "Charts using semantic styles: $(grep -E "(msstyle|compactchart|divergingstyle)" *.tex | wc -l)"
```

**Error Handling:**
- If chart style unclear: Default to `msstyle` and document in progress log
- If legend overlaps data: Adjust `yshift` value in legend positioning
- If source note missing: Add placeholder `% TODO: Add source`

**Update progress_checklist.md:** Mark Phase 4 complete

---

## PHASE 5: Legal Compliance & Branding

### Task: Insert Required Disclaimers & Remove Institutional References

**Success Criteria:**
- ✅ Front cover legal disclaimer box present
- ✅ Diagonal watermark configured (from Phase 1)
- ✅ Footer disclaimer text present
- ✅ NO references to real financial institutions in branding
- ✅ Document headers use "James Bian" branding

**Actions:**

1. **Insert front cover disclaimer (CRITICAL):**
   
   **Location:** Immediately after `\reporttitle{}` and before executive summary
   
   ```latex
   \reporttitle{TICKER}{Document Title}{Subtitle}
   
   \vspace{0.5cm}
   \begin{tcolorbox}[colback=lightgrey, colframe=lightgrey, boxrule=0pt, sharp corners, left=6pt, right=6pt, top=6pt, bottom=6pt]
   \textbf{EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES}\\[0.2cm]
   \textbf{NOTICE:} This document is a fictional research report created solely for educational and graphic design portfolio purposes.
   \begin{enumerate}[leftmargin=*]
       \item \textbf{NOT FINANCIAL ADVICE:} The ratings (e.g., "OVERWEIGHT"), price targets, and investment conclusions contained herein are hypothetical. This is not a recommendation to buy or sell any security.
       \item \textbf{FICTIONAL DATA:} All "Research Estimates," yield percentages, and financial tables are simulated or based on unverified public rumors. They do not represent factual corporate performance or professional financial modeling.
       \item \textbf{ATTRIBUTION \& DESIGN:} The visual layout and structure of this report are inspired by industry-standard equity research formats for the purpose of demonstrating document design proficiency. This document is not affiliated with, sponsored by, or endorsed by any financial institution.
       \item \textbf{NO LIABILITY:} The author (James Bian) shall not be held liable for any financial losses or decisions made based on the fictional content of this sample project.
   \end{enumerate}
   \end{tcolorbox}
   ```

2. **Verify watermark (should exist from Phase 1):**
   ```bash
   grep -n "AddToShipoutPictureBG" work/PROJECT_NAME/source/*.tex
   ```

3. **Scan for institutional branding violations:**
   ```bash
   # Case-insensitive search for real firm names
   grep -niE "(morgan stanley|goldman sachs|jp ?morgan|citigroup|bank of america|wells fargo|ubs|credit suisse|deutsche bank|barclays)" work/PROJECT_NAME/source/*.tex
   ```
   
   **If found in:**
   - **Headers/footers:** Replace with "James Bian Research"
   - **Color names:** Replace with `brandblue`, `brandaccent`, etc.
   - **Content body (discussing companies):** OK to keep (nominative fair use)
   - **Branding/affiliation context:** Remove or rephrase as "industry-standard format"

4. **Verify footer disclaimer:**
   ```latex
   \cfoot{\color{textgrey}\fontsize{7}{7}\selectfont EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES}
   ```

5. **Check header branding:**
   ```latex
   \lhead{
       ...{\fontsize{9}{9}\selectfont\bfseries Design Portfolio: Financial Case Study}...
   }
   \lfoot{\color{textgrey}\fontsize{9}{9}\selectfont James Bian Research}
   ```

**Validation Gate:**
- [ ] Front cover disclaimer box present with all 4 enumerated points
- [ ] Watermark command exists in preamble
- [ ] No institutional names in headers/footers/color names
- [ ] Footer contains "EDUCATIONAL CASE STUDY" text

**Error Handling:**
- If disclaimer missing: Add from template (this is non-negotiable)
- If institutional references found: Document each occurrence, replace systematically
- If unclear whether reference is OK: Err on side of removing it

**Update progress_checklist.md:** Mark Phase 5 complete

---

## PHASE 6: Validation & Compilation

### Task: Run Automated Checks & Compile PDF

**Success Criteria:**
- ✅ All validation checks pass
- ✅ Document compiles without errors
- ✅ PDF output is professional quality
- ✅ No TOC inconsistencies

**Actions:**

1. **Run comprehensive validation suite:**
   
   ```bash
   #!/bin/bash
   # Save as: validate_document.sh
   
   echo "========================================="
   echo "LaTeX Document Validation Suite"
   echo "========================================="
   
   FILE="$1"
   ERRORS=0
   
   # Phase 1 checks: Preamble
   echo -e "\n[Phase 1] Preamble Compliance"
   if grep -q "\\usepackage{colortbl}" "$FILE"; then
       echo "❌ CRITICAL: colortbl package detected (causes conflicts)"
       ERRORS=$((ERRORS+1))
   else
       echo "✅ No colortbl conflicts"
   fi
   
   if grep -qE "definecolor\{(ms|gs|citi|morgan|stanley)" "$FILE"; then
       echo "❌ CRITICAL: Institutional color names detected"
       ERRORS=$((ERRORS+1))
   else
       echo "✅ Neutral color names used"
   fi
   
   # Phase 2 checks: Structure
   echo -e "\n[Phase 2] Document Structure"
   PSEUDO_HEADINGS=$(grep -c "^\\\\textbf{.*}$" "$FILE" 2>/dev/null || echo 0)
   if [ "$PSEUDO_HEADINGS" -gt 0 ]; then
       echo "⚠️  WARNING: $PSEUDO_HEADINGS pseudo-headings found (should use \\subsection)"
       ERRORS=$((ERRORS+1))
   else
       echo "✅ No pseudo-headings"
   fi
   
   DEEP_NESTING=$(grep -c "\\subsubsection" "$FILE" 2>/dev/null || echo 0)
   if [ "$DEEP_NESTING" -gt 0 ]; then
       echo "⚠️  WARNING: Excessive nesting (subsubsection) detected"
   else
       echo "✅ Heading depth compliant"
   fi
   
   # Phase 3 checks: Tables
   echo -e "\n[Phase 3] Table Compliance"
   ILLEGAL_CAPTIONS=$(grep -c "\\captionof{table}" "$FILE" 2>/dev/null || echo 0)
   if [ "$ILLEGAL_CAPTIONS" -gt 0 ]; then
       echo "❌ CRITICAL: $ILLEGAL_CAPTIONS illegal \\captionof{table} found"
       ERRORS=$((ERRORS+1))
   else
       echo "✅ All tables use proper float environments"
   fi
   
   BAD_WIDTH=$(grep -c "adjustbox}{width=" "$FILE" 2>/dev/null || echo 0)
   if [ "$BAD_WIDTH" -gt 0 ]; then
       echo "❌ CRITICAL: $BAD_WIDTH tables using 'width=' instead of 'max width='"
       ERRORS=$((ERRORS+1))
   else
       echo "✅ All tables use 'max width'"
   fi
   
   # Phase 4 checks: Figures
   echo -e "\n[Phase 4] Figure Compliance"
   ILLEGAL_FIG_CAPTIONS=$(grep -c "\\captionof{figure}" "$FILE" 2>/dev/null || echo 0)
   if [ "$ILLEGAL_FIG_CAPTIONS" -gt 0 ]; then
       echo "❌ CRITICAL: $ILLEGAL_FIG_CAPTIONS illegal \\captionof{figure} found"
       ERRORS=$((ERRORS+1))
   else
       echo "✅ All figures use proper float environments"
   fi
   
   # Phase 5 checks: Legal
   echo -e "\n[Phase 5] Legal Compliance"
   if grep -q "EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES" "$FILE"; then
       echo "✅ Legal disclaimer present"
   else
       echo "❌ CRITICAL: Legal disclaimer missing"
       ERRORS=$((ERRORS+1))
   fi
   
   if grep -q "AddToShipoutPictureBG" "$FILE"; then
       echo "✅ Watermark configured"
   else
       echo "❌ CRITICAL: Watermark missing"
       ERRORS=$((ERRORS+1))
   fi
   
   # Summary
   echo -e "\n========================================="
   if [ "$ERRORS" -eq 0 ]; then
       echo "✅ ALL CHECKS PASSED - Ready to compile"
       exit 0
   else
       echo "❌ VALIDATION FAILED - $ERRORS critical issues found"
       echo "Fix errors before proceeding to compilation"
       exit 1
   fi
   ```

2. **Run validation:**
   ```bash
   bash validate_document.sh work/PROJECT_NAME/source/converted.tex
   ```

3. **If validation passes, compile PDF:**
   ```bash
   cd work/PROJECT_NAME/source
   
   # First pass
   pdflatex -interaction=nonstopmode converted.tex 2>&1 | tee ../logs/compile_pass1.log
   
   # Second pass (for TOC and cross-references)
   pdflatex -interaction=nonstopmode converted.tex 2>&1 | tee ../logs/compile_pass2.log
   
   # Check for errors
   if [ $? -eq 0 ]; then
       echo "✅ Compilation successful"
       mv converted.pdf ../output/PROJECT_NAME_final.pdf
   else
       echo "❌ Compilation failed - check logs"
       exit 1
   fi
   ```

4. **Analyze compilation log for warnings:**
   ```bash
   # Extract critical warnings
   grep -E "(Overfull|Underfull|Missing|Undefined)" ../logs/compile_pass2.log > ../logs/warnings.txt
   
   # Count issues
   echo "Overfull hboxes: $(grep -c 'Overfull' ../logs/warnings.txt)"
   echo "Undefined references: $(grep -c 'Undefined' ../logs/warnings.txt)"
   echo "Missing characters: $(grep -c 'Missing' ../logs/warnings.txt)"
   ```

5. **Visual PDF inspection checklist:**
   - [ ] Title page has legal disclaimer box
   - [ ] Watermark visible on all pages (faint diagonal text)
   - [ ] Executive summary appears before TOC
   - [ ] TOC has proper numbering (no duplicates)
   - [ ] All tables are centered and readable
   - [ ] All table captions are centered
   - [ ] All charts have legends below them
   - [ ] Footer disclaimer visible on every page
   - [ ] No text running into margins
   - [ ] Consistent spacing throughout

6. **Create final documentation:**
   ```bash
   # Generate conversion report
   cat > work/PROJECT_NAME/CONVERSION_REPORT.md << EOF
   # Conversion Report: PROJECT_NAME
   
   **Date:** $(date +%Y-%m-%d)
   **Status:** ✅ Complete / ⚠️ Needs Review / ❌ Failed
   
   ## Source File
   - Original: incoming/raw_YYYYMMDD_project.tex
   - Size: $(wc -l < incoming/raw_YYYYMMDD_project.tex) lines
   
   ## Output File
   - Converted: work/PROJECT_NAME/source/converted.tex
   - Size: $(wc -l < work/PROJECT_NAME/source/converted.tex) lines
   - PDF: work/PROJECT_NAME/output/PROJECT_NAME_final.pdf
   
   ## Changes Applied
   
   ### Preamble (Phase 1)
   - [ ] Packages loaded in correct order
   - [ ] Brand colors defined
   - [ ] Watermark configured
   - [ ] Headers/footers formatted
   
   ### Structure (Phase 2)
   - Pseudo-headings converted: X instances
   - Duplicate sections removed: X instances
   - Executive summary repositioned: Yes/No
   
   ### Tables (Phase 3)
   - Tables converted to float environments: X
   - Labels added: X
   - Source citations fixed: X
   
   ### Figures (Phase 4)
   - Figures converted to float environments: X
   - Charts reformatted: X
   - Semantic styles applied: X
   
   ### Legal (Phase 5)
   - Disclaimer box added: Yes/No
   - Institutional references removed: X instances
   
   ### Validation (Phase 6)
   - Validation checks passed: X/Y
   - Compilation status: Success/Failed
   - Warnings: X overfull hboxes, Y undefined refs
   
   ## Issues Requiring Manual Review
   (List any items that could not be fixed automatically)
   
   ## Recommendations
   (Any suggestions for further improvement)
   EOF
   ```

**Validation Gate:**
- [ ] Validation script exits with code 0
- [ ] PDF compiles successfully (exit code 0)
- [ ] No undefined references in log
- [ ] Visual inspection checklist complete

**Error Handling:**

**Compilation Errors - Decision Tree:**

```
Error Type: "! Misplaced alignment tab character &"
→ Cause: Unescaped & in text
→ Fix: Find and escape as \&
→ Search: grep -n "[^\\]&" file.tex

Error Type: "! Undefined control sequence"
→ Cause: Missing package or typo in command
→ Fix: Check package list, verify command spelling
→ Search: Check error line number in log

Error Type: "! Missing $ inserted"
→ Cause: Unescaped $ or math mode issues
→ Fix: Escape $ as \$ or wrap math in $...$
→ Search: grep -n "[^\\]\$" file.tex

Error Type: "! Package pgfplots Error: colormap 'RdYlGn' is undefined"
→ Cause: Colormap not defined in preamble
→ Fix: Add colormap definition from template.tex

Error Type: "! Extra }, or forgotten \endgroup"
→ Cause: Mismatched braces
→ Fix: Count braces, check for missing {
→ Tool: Use editor's brace matching

Error Type: Overfull \hbox warnings
→ Cause: Table or text too wide
→ Fix: Adjust column widths, add line breaks
→ Acceptable: <10 warnings OK, >20 needs attention
```

**If compilation fails:**
1. Examine error line number in log file
2. Check error pattern against decision tree above
3. Fix issue and recompile
4. Document error and fix in CONVERSION_REPORT.md
5. Maximum 3 compilation attempts - if still failing, flag for manual review

**Update progress_checklist.md:** Mark Phase 6 complete

---

## PHASE 7: Final Handoff

### Task: Package Outputs & Document Results

**Success Criteria:**
- ✅ All output files organized correctly
- ✅ Conversion report complete
- ✅ Source files backed up
- ✅ Ready for human review

**Actions:**

1. **Organize output directory:**
   ```bash
   # Final structure should be:
   work/PROJECT_NAME/
   ├── source/
   │   ├── original.tex (raw input)
   │   └── converted.tex (processed output)
   ├── output/
   │   └── PROJECT_NAME_final.pdf
   ├── logs/
   │   ├── compile_pass1.log
   │   ├── compile_pass2.log
   │   └── warnings.txt
   ├── progress_checklist.md
   └── CONVERSION_REPORT.md
   ```

2. **Create backup:**
   ```bash
   cp work/PROJECT_NAME/source/converted.tex templates/backups/PROJECT_NAME_$(date +%Y%m%d).tex
   ```

3. **Generate statistics:**
   ```bash
   cat >> work/PROJECT_NAME/CONVERSION_REPORT.md << EOF
   
   ## Document Statistics
   
   - Total pages: $(pdfinfo work/PROJECT_NAME/output/PROJECT_NAME_final.pdf | grep Pages | awk '{print $2}')
   - Tables: $(grep -c "\\begin{table}" work/PROJECT_NAME/source/converted.tex)
   - Figures: $(grep -c "\\begin{figure}" work/PROJECT_NAME/source/converted.tex)
   - Sections: $(grep -c "\\section{" work/PROJECT_NAME/source/converted.tex)
   - Subsections: $(grep -c "\\subsection{" work/PROJECT_NAME/source/converted.tex)
   - Word count (approx): $(detex work/PROJECT_NAME/source/converted.tex | wc -w)
   EOF
   ```

4. **Quality score calculation:**
   ```bash
   QUALITY_SCORE=100
   
   # Deduct points for issues
   VALIDATION_FAILS=$(grep "❌" work/PROJECT_NAME/logs/validation.log | wc -l)
   WARNINGS=$(grep -c "Overfull" work/PROJECT_NAME/logs/compile_pass2.log)
   UNDEFINED=$(grep -c "Undefined" work/PROJECT_NAME/logs/compile_pass2.log)
   
   QUALITY_SCORE=$((QUALITY_SCORE - VALIDATION_FAILS*10 - WARNINGS*2 - UNDEFINED*5))
   
   echo "Quality Score: $QUALITY_SCORE/100" >> work/PROJECT_NAME/CONVERSION_REPORT.md
   
   if [ "$QUALITY_SCORE" -ge 90 ]; then
       echo "Grade: A - Excellent" >> work/PROJECT_NAME/CONVERSION_REPORT.md
   elif [ "$QUALITY_SCORE" -ge 80 ]; then
       echo "Grade: B - Good" >> work/PROJECT_NAME/CONVERSION_REPORT.md
   elif [ "$QUALITY_SCORE" -ge 70 ]; then
       echo "Grade: C - Acceptable" >> work/PROJECT_NAME/CONVERSION_REPORT.md
   else
       echo "Grade: D - Needs Improvement" >> work/PROJECT_NAME/CONVERSION_REPORT.md
   fi
   ```

5. **Create handoff checklist for human review:**
   ```markdown
   ## Human Review Checklist
   
   ### Content Accuracy
   - [ ] All original content preserved (no data loss)
   - [ ] Tables display correct numbers
   - [ ] Charts accurately represent data
   - [ ] No formatting artifacts (weird spacing, broken lines)
   
   ### Legal Compliance
   - [ ] Disclaimer box prominent on first page
   - [ ] Watermark visible but not distracting
   - [ ] No real institutional affiliations implied
   
   ### Visual Quality
   - [ ] Professional appearance
   - [ ] Consistent typography
   - [ ] Appropriate color usage
   - [ ] Readable at standard zoom
   
   ### Technical Quality
   - [ ] PDF searchable (text not rasterized)
   - [ ] Hyperlinks working (if any)
   - [ ] Bookmarks/TOC functional
   
   ### Completeness
   - [ ] All sections from original present
   - [ ] No "TODO" comments left in output
   - [ ] Source citations complete
   ```

6. **Final status update:**
   ```bash
   # Update master tracking file (if exists)
   echo "$(date +%Y-%m-%d): PROJECT_NAME conversion complete - Score: $QUALITY_SCORE/100" >> work/conversion_log.txt
   ```

**Validation Gate:**
- [ ] CONVERSION_REPORT.md is complete
- [ ] Output directory structure is correct
- [ ] Backup created successfully
- [ ] Quality score calculated

**Proceed to human review if:**
- Quality score < 80
- Validation checks flagged for manual review
- Complex content that requires subject matter verification

---

## APPENDIX A: Common Error Patterns & Solutions

### A.1 Compilation Errors

| Error Message | Root Cause | Solution | Prevention |
|--------------|------------|----------|------------|
| `! Misplaced alignment tab character &` | Unescaped & in text | Escape as `\&` | Run grep before compile |
| `! Missing $ inserted` | Unescaped $ or math error | Escape as `\$` or fix math | Validate special chars |
| `! Undefined control sequence` | Typo or missing package | Check spelling, add package | Use template preamble |
| `! Extra }, or forgotten \endgroup` | Mismatched braces | Count braces, use editor tools | Validate syntax |
| `! Package pgfplots Error: colormap undefined` | Missing colormap definition | Add from template | Copy full preamble |
| `! LaTeX Error: Environment ... undefined` | Missing package | Add required package | Check package list |
| `Overfull \hbox` (warning) | Content too wide | Adjust widths, break lines | Use max width |

### A.2 Structural Issues

| Issue | Symptom | Fix | Detection |
|-------|---------|-----|-----------|
| Pseudo-headings | Bold text instead of `\subsection` | Convert to proper command | `grep "^\\textbf{"` |
| Duplicate sections | Same title appears twice | Remove or merge | `grep "\\subsection{" \| uniq -d` |
| Excessive nesting | `\subsubsection` used | Flatten to `\subsection` | `grep "\\subsubsection"` |
| Missing executive summary | No summary before TOC | Add from template | Manual check |
| TOC after content | Wrong order | Reorder sections | Manual check |

### A.3 Table/Figure Issues

| Issue | Symptom | Fix | Detection |
|-------|---------|-----|-----------|
| `\captionof` usage | No auto-numbering | Convert to float | `grep "\\captionof"` |
| Missing labels | Can't cross-reference | Add `\label{}` | Check for `\label` after `\caption` |
| Duplicate labels | Compile warning | Rename with suffix | `grep "\\label{" \| uniq -d` |
| Width vs max width | Font scaling | Change to `max width` | `grep "width=\\textwidth"` |
| Source beside table | Layout issue | Add `\par` before | Visual inspection |

### A.4 Chart Issues

| Issue | Symptom | Fix | Detection |
|-------|---------|-----|-----------|
| Hardcoded colors | Inconsistent palette | Use semantic styles | `grep "fill=.*!"` |
| Legend overlap | Can't read legend | Adjust position/yshift | Visual inspection |
| Wide bar spacing | Sparse data looks weird | Use fixed width, enlarge limits | Visual inspection |
| Tiny labels | Unreadable text | Change to `\footnotesize` | Visual inspection |
| Missing source | No attribution | Add via `after end axis` | Check chart structure |

---

## APPENDIX B: Quick Reference Commands

### B.1 Validation Commands

```bash
# Check for illegal packages
grep -n "\\usepackage{colortbl}" *.tex

# Find institutional color names
grep -nE "definecolor\{(ms|gs|citi)" *.tex

# Locate pseudo-headings
grep -n "^\\\\textbf{.*}$" *.tex

# Find duplicate sections
grep "\\subsection{" *.tex | sort | uniq -d

# Check for illegal captions
grep -n "\\captionof{" *.tex

# Find hardcoded chart colors
grep -n "fill=.*!" *.tex

# Check for unescaped special characters
grep -nE "[^\\](&|\$|%)" *.tex

# Count document elements
echo "Sections: $(grep -c '\\section{' *.tex)"
echo "Subsections: $(grep -c '\\subsection{' *.tex)"
echo "Tables: $(grep -c '\\begin{table}' *.tex)"
echo "Figures: $(grep -c '\\begin{figure}' *.tex)"

# Check label uniqueness
grep "\\label{" *.tex | cut -d'{' -f2 | cut -d'}' -f1 | sort | uniq -d
```

### B.2 Compilation Commands

```bash
# Standard two-pass compilation
pdflatex -interaction=nonstopmode document.tex
pdflatex -interaction=nonstopmode document.tex

# Compilation with detailed logging
pdflatex -interaction=nonstopmode -file-line-error document.tex 2>&1 | tee compile.log

# Check PDF info
pdfinfo document.pdf

# Extract text for word count
detex document.tex | wc -w

# Find compilation errors
grep -A5 "^!" compile.log

# Extract warnings
grep -E "(Overfull|Underfull|Warning)" compile.log > warnings.txt
```

### B.3 Template Snippets

**Legal Disclaimer Box:**
```latex
\begin{tcolorbox}[colback=lightgrey, colframe=lightgrey, boxrule=0pt, sharp corners]
\textbf{EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES}\\[0.2cm]
\textbf{NOTICE:} This document is fictional...
\end{tcolorbox}
```

**Table Template:**
```latex
\begin{table}[H]
\centering
\caption{Table Title}
\label{tab:descriptive_name}
\tablefont
\begin{adjustbox}{max width=\textwidth}
\begin{tabular}{lrr}
\toprule
Column 1 & Column 2 & Column 3 \\
\midrule
Data & Data & Data \\
\bottomrule
\end{tabular}
\end{adjustbox}
\par\vspace{0.1cm}
{\tiny Source: Data Provider}
\end{table}
```

**Chart Template:**
```latex
\begin{figure}[H]
\centering
\caption{Chart Title}
\label{fig:descriptive_name}
\begin{tikzpicture}
\begin{axis}[msstyle, width=10cm]
\addplot[fill=brandblue] coordinates {(2023,100) (2024,120)};
\legend{Revenue}
\end{axis}
\end{tikzpicture}
\end{figure}
```

---

## APPENDIX C: LLM-Specific Guidelines

### C.1 Context Management

**Token Budget Allocation:**
- Phase 0 (Context loading): 30% of budget
- Phases 1-5 (Active work): 50% of budget
- Phase 6-7 (Validation/Handoff): 20% of budget

**When to re-read references:**
- If uncertain about a specific rule → Re-read relevant section of LATEX_STYLE_GUIDE.md
- If validation fails → Re-read LATEX_CHECKLIST.md
- If compilation errors → Re-read LATEX_COMPILATION_DETAILS.md

**Information priority:**
- Critical: Brand colors, legal disclaimers, forbidden practices
- Important: Table/figure formatting, chart styles, heading hierarchy
- Reference: Specific examples, edge cases

### C.2 Decision-Making Framework

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
- Missing critical information (e.g., project name)

### C.3 Quality Assurance

**Self-validation checklist (before marking phase complete):**
1. Did I run the automated validation commands?
2. Did I check the output against the expected pattern?
3. Did I document any deviations in the progress log?
4. Did I update the progress checklist?
5. Are there any edge cases I didn't handle?

**Common LLM mistakes to avoid:**
- Don't assume structure from partial reads - always verify
- Don't batch changes without validation between phases
- Don't skip validation gates to save time
- Don't guess at ambiguous requirements - flag them
- Don't leave TODOs without documenting them

---

## APPENDIX D: Workflow Optimization Tips

### D.1 Parallel Processing Opportunities

**Can be done in parallel:**
- Reading multiple reference documents (Phase 0)
- Scanning for different error patterns (Phase 2-4)
- Multiple grep searches for validation

**Must be sequential:**
- Preamble setup before content conversion
- Structure fixes before table/figure conversion
- All edits before compilation
- First compilation before second compilation

### D.2 Caching Strategies

**Generate once, reuse:**
- Brand color definitions
- Legal disclaimer text
- Table template skeleton
- Chart style configurations
- Validation script

**Regenerate each time:**
- Labels (must be unique to content)
- Progress tracking
- Compilation logs
- Quality scores

### D.3 Performance Benchmarks

**Expected timing (approximate):**
- Phase 0: 2-3 minutes
- Phase 1: 1-2 minutes
- Phase 2: 3-5 minutes
- Phase 3: 5-8 minutes (most time-intensive)
- Phase 4: 4-6 minutes
- Phase 5: 1-2 minutes
- Phase 6: 2-3 minutes (plus compilation time)
- Phase 7: 1 minute

**Total: 19-30 minutes for typical document**

**If taking significantly longer:**
- Check for infinite loops in search/replace
- Verify file I/O is working efficiently
- Consider if document is atypically large or complex

---

## CHANGELOG

**2026-01-18: Version 2.0 - LLM-Optimized Rewrite**
- Complete restructure into phase-based workflow
- Added explicit validation gates between phases
- Added success criteria for each phase
- Added error handling procedures and decision trees
- Added automated validation scripts
- Added comprehensive appendices with quick reference
- Added LLM-specific guidelines for context management
- Increased specificity of all instructions
- Added concrete examples for all conversion patterns

**Previous (Version 1.0):**
- Basic 9-step workflow
- Limited validation guidance
- Implicit assumptions about LLM knowledge
