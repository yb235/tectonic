# Tectonic LaTeX Style Guide

This guide defines the global styling rules to ensure visual consistency across all documents, specifically addressing table font sizing, package compatibility, and chart spacing.

---

## 📋 Change Log

### 2026-01-17: Branding/Palette Compliance (CRITICAL – LLM)
**Issue:** Legacy color variable names and palette values implied a specific institutional brand. This creates trade dress risk and legal ambiguity for commercial distribution.
**Fix Applied:** Renamed all `ms*` color variables to neutral names and slightly adjusted hex values to a generic palette. Updated the legal audit to reflect the change.
**Global Rules Established (LLM-CRITICAL):**
- **NEVER** introduce color names that imply a real institution or trademark (e.g., `msblue`). Use neutral names only.
- **ALWAYS** use the approved palette names: `brandblue`, `brandaccent`, `lightgrey`, `textgrey`, `tableheader`.
- **ALWAYS** update the legal audit when brand palette changes: `COPYRIGHT_AND_LICENSE_AUDIT.md`.
- **DO NOT** copy a real firm's palette or layout verbatim. If you must align to a style, make it clearly distinct.

### 2026-01-17: Table & Figure Numbering System (CRITICAL – Multi-Agent)
**Issue:** Inconsistent numbering methods across sections written by different agents. Some sections used `\captionof{table}` without labels (no automatic numbering), others used proper `\begin{table}[H]` with `\caption` (automatic numbering). Result: document had numbered tables in main content but unnumbered tables/figures in executive summary.
**Impact:** Unprofessional appearance, impossible to cross-reference ("see Table X"), numbering chaos when reordering content, violates academic/industry standards.
**Root Cause:** No established global rule for table/figure formatting. Different agents working on different sections independently chose different approaches:
- Agent A: `\begin{center}...\captionof{table}...` → No numbering
- Agent B: `\begin{table}[H]...\caption...` → Auto-numbered
- Agent C: Inline tikzpictures without figure environment → No numbering
**Fix Applied:** 
1. Converted ALL `\captionof{table}` to proper `\begin{table}[H]...\caption...\end{table}` (12 instances)
2. Converted ALL `\captionof{figure}` to proper `\begin{figure}[H]...\caption...\end{figure}` (16 instances)
3. Added unique `\label{}` to every table and figure for cross-referencing capability
4. Created comprehensive Section 0 in style guide with mandatory formatting rules, validation commands, and multi-agent coordination guidelines
**Files Updated:** `intelapple.tex` (28 caption conversions), `LATEX_STYLE_GUIDE.md` (new Section 0)
**Global Rules Established:**
- **ALWAYS** use `\begin{table}[H]` with `\caption` for tables (NEVER `\captionof`)
- **ALWAYS** use `\begin{figure}[H]` with `\caption` for figures (NEVER `\captionof`)
- **ALWAYS** add unique descriptive `\label{tab:name}` or `\label{fig:name}` after every caption
- **BEFORE submission:** Run validation commands to detect missing labels, duplicate labels, or illegal `\captionof` usage
- **Multi-agent coordination:** Search existing labels before creating new ones to avoid conflicts
**Result:** Document now has professional sequential numbering (Tables 1-12, Figures 1-16) that updates automatically when content is reordered

### 2026-01-17: Caption Centering – Global Configuration (CRITICAL)
**Issue:** Figure and table captions were not centered, appearing left-aligned despite global `\captionsetup` configuration. The root cause was specifically `\captionof` commands inside `\begin{center}` environments.
**Impact:** Unprofessional appearance with asymmetric titles that don't match industry standards for research reports.
**Root Cause:** 
1. Global `\captionsetup{justification=centering}` was added to preamble, but...
2. **THE KEY ISSUE:** `\captionof` inside `\begin{center}...\end{center}` blocks does NOT respect global caption settings due to environment interference
3. The `\begin{center}` environment's centering mechanism overrides the caption package's justification setting
4. Regular `\caption{}` commands in float environments worked fine; only `\captionof` in center blocks failed
**Fix Applied:** 
1. Added `\captionsetup{justification=centering}` immediately before each `\captionof` command that's inside a `\begin{center}` environment (13 locations)
2. This local override re-applies centering despite the environment interference
**Files Updated:** `intelapple.tex` (13 caption fixes), `LATEX_STYLE_GUIDE.md` (updated Section 7)
**Global Rules Established:**
- **ALWAYS** configure caption formatting globally in preamble: `\captionsetup{justification=centering, font=normalsize, labelfont=bf}`
- **CRITICAL:** When using `\captionof` inside `\begin{center}` blocks, add local `\captionsetup{justification=centering}` right before the `\captionof` command
- Regular `\caption{}` commands in float environments respect global settings automatically
- This is a known LaTeX quirk where environment-level centering interferes with caption package settings

### 2026-01-17: Document Hierarchy & Paragraph Styling Standards (CRITICAL)
**Issue:** Inconsistent heading hierarchy and paragraph spacing throughout document caused by unclear global rules. Documents mixed `\textbf{Title}` with `\subsection{Title}` creating visual inconsistency, TOC chaos, and broken numbering. Multiple sections were duplicated due to copy-paste during reorganization. Paragraph spacing was inconsistent with random `\vspace{}` commands scattered throughout.
**Impact:** Unprofessional appearance, confusing document structure, inflated page count (+3-5 pages from duplicates), inconsistent visual rhythm.
**Root Cause:** No established global rules for:
- When to use `\section{}` vs `\subsection{}` vs `\textbf{}`
- Paragraph spacing conventions
- How to prevent duplicate content during reorganization
**Fix Applied:** 
1. Created comprehensive Section 0 in style guide covering hierarchy decision tree, paragraph spacing rules, maximum depth standards, and duplicate prevention strategies
2. Fixed `intelapple.tex`: Converted 5 `\textbf{}` pseudo-headings to `\subsection{}`; removed ~200 lines of duplicate content (4 subsection blocks); standardized spacing
3. Created `LATEX_CHECKLIST.md` for pre-compilation validation
**Files Updated:** `LATEX_STYLE_GUIDE.md` (new Section 0), `intelapple.tex` (hierarchy fixes + duplicate removal), new file `LATEX_CHECKLIST.md`
**Global Rules Established:**
- **NEVER** use `\textbf{Title}` as standalone heading (use `\subsection{}`)
- **NEVER** number headings manually like "1. Topic" (use auto-numbering)
- ONE blank line between paragraphs, NO manual `\vspace{}` between regular paragraphs
- Maximum depth: `\subsection{}` (no `\subsubsection{}`)
- Use grep commands to find duplicates before finalizing: `grep "\\subsection{" file.tex | sort | uniq -d`

### 2026-01-17: Document Structure – Executive Summary & TOC (LLM-Specific)
**Issue:** The executive summary and table of contents (TOC) were laid out inconsistently. The TOC appeared before the executive summary, was boxed inside a `tcolorbox` that could not break across pages, and one risk table inside a two-column section overflowed into page margins.
**Fix Applied:** Re-ordered the document so that the full executive summary appears immediately after the title page, followed by a dedicated TOC page. Removed the `tcolorbox` wrapper from around `\tableofcontents`, keeping only a styled header box, and moved wide summary tables out of `multicols` with column widths expressed in fractions of `\textwidth` rather than `\linewidth`.
**Global Rules Established:** Executive summaries must precede the TOC, all multi-page TOCs must use bare `\tableofcontents` (never `\@starttoc` or a boxed environment), and wide 3–4 column risk tables in summaries should be full-width (outside `multicols`) with columns summing to ≤1.0 of `\textwidth`.

### 2026-01-16: Chart Color Drift Prevention (LLM-Specific)
**Issue:** Three charts drifted into a different color scheme because ad-hoc `fill=` colors were used instead of shared styles.  
**Fix Applied:** Added semantic pgfplots styles (`msstyle`, `compactchart`, `comparestyle`, `divergingstyle`) and updated `intelapple.tex` charts to call the right style per intent.  
**Global Rule Established:** Never hardcode colors inside chart bodies—pick the semantic style that matches the chart purpose to keep palettes consistent across documents.  

### 2026-01-16: Legend Placement Standard (LLM-Specific)
**Issue:** One chart left legend positioning to pgfplots defaults, so the legend overlapped the rightmost bar. Other charts were fine because they explicitly set `legend style={at=..., anchor=...}`.
**Fix Applied:** Added global legend defaults in the preamble (`every axis/.append style={legend style={at={(0.5,-0.15)}, anchor=north, legend columns=-1, draw=none, font=\footnotesize}}`) plus a reusable `mslegend` style. The problem chart now inherits sane defaults.
**Global Rule Established:** Never rely on pgfplots' default legend position. Always set a deterministic legend location (prefer below-centered, horizontal layout) via global defaults and override only when necessary.

### 2026-01-15: Table Source Text Positioning Fix
**Issue:** Source citations appearing beside tables instead of below them  
**Impact:** Unprofessional layout—source text wrapping to the right of narrow tables instead of appearing underneath  
**Root Cause:** When using `max width=\textwidth`, narrow tables don't fill the full line width. Without an explicit paragraph break, LaTeX treats the source text as inline content that flows horizontally beside the table.  
**Fix Applied:** Added `\par` before `\vspace` to force a paragraph break, ensuring source text always starts on a new line below the table regardless of table width.  
**Files Updated:** `intelapple.tex` (all tables with source citations)  
**Global Rule Established:** Always use `\par\vspace{0.1cm}` (not just `\vspace{0.1cm}`) before source text in tables

### 2026-01-15: Table Font Size Inconsistency Fix (CRITICAL)
**Issue:** Tables throughout the document had wildly different font sizes—some ridiculously large, others too small to read  
**Impact:** Unprofessional appearance, inconsistent readability, visual chaos  
**Root Cause:** Three compounding issues:
1. **`adjustbox` with `width=` instead of `max width=`** — This was the main culprit. `width=\textwidth` forces scaling of EVERYTHING (including fonts) to fit the specified width. Narrow tables get enlarged (bigger fonts), wide tables get shrunk (smaller fonts).
2. **Inconsistent use of `\tablefont`** — Some tables had `\tablefont` (which sets `\footnotesize`), others did not, causing random variation in base font sizes before any scaling.
3. **Duplicated content** — Several sections were copy-pasted, creating duplicate labels and inconsistent table formatting.

**Fix Applied:**
1. Changed all `{adjustbox}{width=\textwidth}` to `{adjustbox}{max width=\textwidth}` — This only scales DOWN if needed, never UP
2. Added `\tablefont` consistently to all tables before the `adjustbox` environment
3. Created reusable table environments `mstable` and `mstablescaled` in preamble
4. Fixed duplicate labels (`tab:risk_matrix_2`, `tab:ifs_financials_2`, `tab:sotp_2`)

**Files Updated:** `intelapple.tex` (all tables), this style guide (new Section 1.1)  
**Global Rules Established:**
- **NEVER** use `width=` in adjustbox for tables — always use `max width=`
- **ALWAYS** include `\tablefont` before `\begin{adjustbox}` in every table
- Use the standard table template (see Section 1.1)

### 2026-01-15: Global ybar Legend Double-Pad Fix
**Issue:** Bar chart legends displayed two color pads per entry (filled rectangle + line marker)  
**Impact:** Unprofessional legend appearance, visual clutter, inconsistent with chart style  
**Root Cause:** pgfplots' default `ybar` legend style renders both a line and a fill marker  
**Fix Applied:** Added global `/pgfplots/ybar legend/.style={area legend}` in preamble  
**Files Updated:** `intelapple.tex` (preamble), this style guide (new Section 6)  
**Systematic Approach:** Leveraged pgfplots' built-in `area legend` style rather than hardcoded coordinates  
**Key Lesson:** Always use library-provided styles before implementing custom solutions

### 2026-01-15: Chart Spacing, Font Consistency & Note Positioning Standards
**Issue:** Charts with 2-3 data points using percentage-based widths had excessive spacing, misaligned notes, and inconsistent font sizes  
**Impact:** Unprofessional appearance, illegible labels, disconnected source citations  
**Fix Applied:** Comprehensive Section 3 rewrite with mandatory formatting rules  
**Files Updated:** `intelapple.tex` (10 charts fixed), this style guide  
**Global Rules Established:**
1. Use fixed widths (8-12cm) for sparse data, not percentage-based
2. All chart elements must use `\footnotesize` (never `\tiny` for data labels)
3. Notes/sources positioned inside tikzpicture using `pgfplotsset` with `after end axis`
4. Bar widths scaled to data point count (25pt max for 2-3 bars)
5. Explicit `enlarge x limits` to control spacing
**Before/After:** Column spacing reduced by 60%, font legibility improved, professional alignment

### 2026-01-15: Critical Compilation Error Prevention Guide
**Issue:** Multiple compilation-breaking syntax errors identified during `intelapple.tex` debugging  
**Impact:** PDF generation failure with cryptic error messages  
**Fix Applied:** Added comprehensive Section 5 "Common Compilation Errors & Prevention"  
**Root Causes Documented:**
1. Blank lines inside `\addplot[...]` options blocks
2. Undefined colormaps (e.g., `RdYlGn`)
3. Missing newlines before `\begin{...}` environments
4. Unescaped `%` in symbolic coordinates
5. Unescaped `$` for currency values
**Global Rules Established:** See Section 5 for complete prevention checklist

### 2026-01-14: Critical Chart Rendering Fix
**Issue:** Multi-AddPlot Error causing incorrect chart rendering  
**Impact:** Charts with color-coded bars were displaying incorrectly with labels in boxes above bars  
**Fix Applied:** Added Section 4 documenting the root cause and three solution patterns  
**Files Updated:** `intelapple.tex` (Figure 5), this style guide  
**Global Rule Established:** Never use multiple `\addplot` for individual colored bars without `forget plot` directive

### 2026-01-14: Ampersand (`&`) Character Warning
**Issue:** Unescaped `&` in titles or text causing `! Misplaced alignment tab character &` errors.  
**Fix Applied:** Expanded Section 2 with more prominent warnings.  
**Global Rule Established:** All LLMs generating LaTeX must globally escape `&` as `\&` unless inside a `tabular` or `align` environment.

---

## 0A. Branding & Legal Compliance (CRITICAL – LLMs)

**This section is mandatory for all LLMs generating or editing LaTeX in this repo.**

### Required Actions

1. **Use neutral palette names only**
    - ✅ `brandblue`, `brandaccent`, `lightgrey`, `textgrey`, `tableheader`
    - ❌ No institutional prefixes (e.g., `ms`, `gs`, `citi`)

2. **Keep the palette distinct**
    - Avoid exact matches to known financial institution palettes.
    - Minor tweaks are required if any value could imply a specific brand.

3. **Update the legal audit on any palette or font change**
    - File: `COPYRIGHT_AND_LICENSE_AUDIT.md`
    - Document the new color values and any branding risk changes.

4. **Never imply affiliation**
    - Document copy, headers, or footers must not suggest endorsement by any real firm.

### Approved Palette (Current)

```latex
\definecolor{brandblue}{HTML}{003366}
\definecolor{brandaccent}{HTML}{008EC7}
\definecolor{lightgrey}{HTML}{F3F3F3}
\definecolor{textgrey}{HTML}{6A6A6A}
\definecolor{tableheader}{HTML}{E6E6E6}
```

**If you must change these values, update the legal audit immediately and re-run the compile.**

## 0B. Legal Disclaimers & Liability Protection (CRITICAL – LLMs)

**This section is mandatory for all LLMs generating or editing financial case study documents.**

### Why Legal Disclaimers Are Required

Documents that mimic professional financial research reports face three primary legal risks:

1. **Trademark/Trade Dress Infringement**: If the visual design closely resembles a specific institution's proprietary format, the institution could claim trade dress violation or consumer confusion.
2. **Financial Regulation Violations**: Documents containing investment ratings, price targets, or financial projections may trigger SEC/FINRA scrutiny if they appear to be actual investment advice from a licensed professional.
3. **Data Integrity Concerns**: AI-generated financial data (hallucinations) or unverified rumors presented as factual analysis could mislead readers and expose the author to liability.

### Mandatory Disclosure Components

Every document using this template **MUST** include:

#### 1. Front Cover Legal Notice (Required)

Place this disclosure box immediately after the title block, before the executive summary:

```latex
\begin{tcolorbox}[colback=lightgrey, colframe=lightgrey, boxrule=0pt, sharp corners, left=6pt, right=6pt, top=6pt, bottom=6pt]
\textbf{EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES}\\
\textbf{NOTICE:} This document is a fictional research report created solely for educational and graphic design portfolio purposes.
\begin{enumerate}[leftmargin=*]
    \item \textbf{NOT FINANCIAL ADVICE:} The ratings (e.g., "OVERWEIGHT"), price targets, and investment conclusions contained herein are hypothetical. This is not a recommendation to buy or sell any security.
    \item \textbf{FICTIONAL DATA:} All "Research Estimates," yield percentages, and financial tables are simulated or based on unverified public rumors. They do not represent factual corporate performance or professional financial modeling.
    \item \textbf{ATTRIBUTION \& DESIGN:} The visual layout and structure of this report are inspired by industry-standard equity research formats for the purpose of demonstrating document design proficiency. This document is not affiliated with, sponsored by, or endorsed by any financial institution.
    \item \textbf{NO LIABILITY:} The author (James Bian) shall not be held liable for any financial losses or decisions made based on the fictional content of this sample project.
\end{enumerate}
\end{tcolorbox}
```

#### 2. Diagonal Watermark on Every Page (Required)

In the preamble, after loading the `eso-pic` package:

```latex
\usepackage{eso-pic}

% --- DIAGONAL WATERMARK ---
\newcommand{\watermarktext}{SAMPLE: FICTIONAL DATA / DESIGN CASE STUDY}
\AddToShipoutPictureBG{%
    \begin{tikzpicture}[remember picture,overlay]
        \node[opacity=0.12, rotate=35, scale=3, text=gray] at (current page.center) {\bfseries \watermarktext};
    \end{tikzpicture}%
}
```

**Purpose**: Prevents screenshots of individual pages from being shared without context. The watermark makes it immediately clear that this is sample work, not a genuine research report.

#### 3. Footer Disclaimer on Every Page (Required)

Update the footer in the preamble:

```latex
\lfoot{\color{textgrey}\fontsize{9}{9}\selectfont James Bian Research}
\cfoot{\color{textgrey}\fontsize{7}{7}\selectfont EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES}
\rfoot{\bfseries\thepage}
```

#### 4. Header Branding Clarification (Required)

Update the left header to clarify portfolio intent:

```latex
\lhead{
    \raisebox{-5pt}[0pt][0pt]{% 
        {\fontsize{14}{14}\selectfont\bfseries James Bian}%
        \hspace{0.2cm}\textcolor{black}{|}\hspace{0.2cm}%
        {\fontsize{9}{9}\selectfont\bfseries Design Portfolio: Financial Case Study}%
    }\\[0.1cm]
    {\color{textgrey}\fontsize{9}{9}\selectfont \today}
}
```

**Change**: Original said "Thought Leadership"; now says "Design Portfolio: Financial Case Study" to clarify the document's purpose.

### Legal Defense Strategy

This multi-layered approach creates defensible documentation:

| Risk Factor | Defense Mechanism | Implementation |
|:---|:---|:---|
| **Trade Dress** | Explicit disaffiliation statement | Front cover disclaimer #3 |
| **SEC/FINRA** | "Not financial advice" + "Fictional data" | Front cover disclaimer #1 + #2, footer |
| **Consumer Confusion** | Diagonal watermark on every page | `eso-pic` watermark |
| **Misrepresentation** | No liability clause | Front cover disclaimer #4 |
| **Social Media Misuse** | Watermark prevents decontextualized screenshots | Diagonal watermark |

### Validation Checklist

Before distributing any document:

- [ ] Front cover disclosure box is present and unmodified
- [ ] Diagonal watermark appears on all pages at ~12% opacity
- [ ] Footer disclaimer is visible on all pages
- [ ] Header says "Design Portfolio: Financial Case Study" (not "Thought Leadership")
- [ ] No text in the document claims affiliation with any real financial institution
- [ ] Document clearly states data is fictional/hypothetical

### Cross-Reference

See `COPYRIGHT_AND_LICENSE_AUDIT.md` Section 7 for detailed legal analysis and case law references.

## 0. Table and Figure Numbering (CRITICAL – Multi-Agent Prevention)

### 0.0 The Global Numbering System

**CRITICAL for LLMs: This section added 2026-01-17 after detecting inconsistent numbering across sections written by different agents.**

#### THE PROBLEM: Inconsistent Numbering Methods

When different agents write different sections independently, they use different numbering approaches:
- ❌ Agent A uses `\captionof{table}` without labels → No automatic numbering
- ❌ Agent B uses `\begin{table}[H]` with `\caption` → Automatic numbering (Table 1, 2, 3...)
- ❌ Agent C uses `\begin{center}...\captionof{figure}` → No automatic numbering
- ❌ Result: Document has numbered tables in some sections, unnumbered in others → Unprofessional and impossible to cross-reference

#### THE SOLUTION: ALWAYS Use Formal Float Environments

**GLOBAL RULE: Use LaTeX's built-in automatic numbering system consistently throughout the entire document.**

### 0.1 Tables: Mandatory Format

```latex
\begin{table}[H]
\centering
\caption{Descriptive Title Here}
\label{tab:unique_identifier}
\rowcolors{2}{msgrey}{white}
\tablefont
\begin{tabular}{...}
...table content...
\end{tabular}
\par\vspace{0.1cm}
{\tiny Source: Your Source Here}
\end{table}
```

**Rules:**
1. ✅ **ALWAYS** use `\begin{table}[H]...\end{table}` (NEVER `\begin{center}` with `\captionof`)
2. ✅ **ALWAYS** use `\caption{...}` (NEVER `\captionof{table}{...}`)
3. ✅ **ALWAYS** add unique `\label{tab:descriptive_name}` immediately after caption
4. ✅ **ALWAYS** place `\centering` after `\begin{table}[H]`
5. ❌ **NEVER** use `\captionof{table}` unless inside `multicols` environment (rare exception)

### 0.2 Figures: Mandatory Format

```latex
\begin{figure}[H]
\centering
\caption{Descriptive Title Here}
\label{fig:unique_identifier}
\begin{tikzpicture}
...figure content...
\end{tikzpicture}
\end{figure}
```

**Rules:**
1. ✅ **ALWAYS** use `\begin{figure}[H]...\end{figure}` (NEVER `\begin{center}` with `\captionof`)
2. ✅ **ALWAYS** use `\caption{...}` (NEVER `\captionof{figure}{...}`)
3. ✅ **ALWAYS** add unique `\label{fig:descriptive_name}` immediately after caption
4. ✅ **ALWAYS** place `\centering` after `\begin{figure}[H]`
5. ❌ **NEVER** use `\captionof{figure}` unless inside `multicols` environment (rare exception)

### 0.3 Label Naming Conventions

**Use descriptive, hierarchical labels that indicate content:**

✅ **GOOD Labels:**
- `tab:apple_intel_roadmap` (immediately tells you what the table contains)
- `fig:ifs_breakeven` (clear what the figure shows)
- `tab:risk_assessment` (descriptive of content)
- `fig:capacity_share` (indicates the metric being visualized)

❌ **BAD Labels:**
- `tab:table1` (meaningless, breaks when tables are reordered)
- `fig:chart` (vague)
- `tab:comparison` (too generic, likely duplicates)
- `fig:graph2` (non-descriptive)

**Multi-Agent Rule:** When generating a new section, search existing labels first:
```bash
grep "\\label{tab:" filename.tex    # Find all table labels
grep "\\label{fig:" filename.tex    # Find all figure labels
```

### 0.4 Cross-Referencing

Once proper labels exist, you can reference them:

```latex
As shown in Table~\ref{tab:apple_intel_roadmap}, the timeline...
Figure~\ref{fig:ifs_breakeven} illustrates the path to profitability...
```

**Benefits:**
- LaTeX automatically updates numbers if tables/figures are reordered
- Clicking references in PDF jumps to the target
- Professional standard for technical documents

### 0.5 Exception: Multicols Environment

**ONLY exception:** Inside `\begin{multicols}{2}` environments, floats don't work properly. In this case:

```latex
\begin{multicols}{2}
...content...

\begin{table}[H]
\centering
\caption{Title Here}
\label{tab:name}
...table...
\end{table}

...more content...
\end{multicols}
```

Even in `multicols`, still use `\begin{table}[H]` with `\caption` (NOT `\captionof`).

### 0.6 Pre-Submission Validation Checklist

**Before finalizing ANY section, run these checks:**

```bash
# Check for illegal captionof usage (should be rare)
grep "\\captionof" yourfile.tex

# Verify all tables use proper format
grep "\\begin{table}" yourfile.tex | wc -l
grep "\\caption{" yourfile.tex | wc -l
# These counts should match!

# Check for missing labels
grep "\\caption{.*}" yourfile.tex -A1 | grep -v "\\label"
# Should return nothing if all captions have labels

# Find duplicate labels (CRITICAL)
grep "\\label{" yourfile.tex | sort | uniq -d
# Should return nothing
```

### 0.7 Why This Matters

**Consistency:** Document has professional sequential numbering (Table 1, 2, 3... Figure 1, 2, 3...)

**Maintainability:** Add/remove tables/figures anywhere → numbering updates automatically

**Cross-references:** Can cite "see Table 5" with confidence the number is correct

**Multi-agent safety:** Different agents can write different sections without numbering conflicts

**Professional standard:** Matches academic, industry, and journal submission requirements

---

## 1. Document Hierarchy & Paragraph Styling

### 1.0 Executive Summary Synchronization (Multi-Agent Workflows)

**CRITICAL for LLMs: This section added 2026-01-17 after detecting cross-section inconsistencies.**

#### THE PROBLEM: Executive Summary Becomes Stale

When different agents generate different sections, the executive summary drifts from reality:
- ❌ Exec summary says "~10% yield" but Section 5 explains "10% for test wafers, 60-65% for internal products"
- ❌ Exec summary says "mid-2027" but Section 3 says "H2 2027"
- ❌ Exec summary says "$13B loss" but financials say "$13.0B"
- ❌ Exec summary says "15M units" but analysis specifies "15M MacBook Air/iPad Air units"

**Root Cause:** Executive summary written first, then content evolves during multi-agent generation.

#### THE SOLUTION: Update Executive Summary LAST

**MANDATORY PROCESS for all multi-section documents:**

1. **Complete Main Body First** — Let all agents finish their sections
2. **Read ALL Sections** — Extract actual data points from completed content
3. **Grep for Conflicts** — Find inconsistencies across sections:
   ```bash
   # Find all mentions of key metrics
   grep -n "yield" file.tex | grep -E "(10%|60%|70%)"
   grep -E "(mid-|H[12]|Q[1-4])-?\s*202[5-9]" file.tex
   ```
4. **Identify Most Accurate Version** — When sections conflict, use the most detailed/sourced claim
5. **Rewrite Executive Summary** — Update to match finalized main content:
   - Add context from detailed sections ("test wafer yields of 10% vs management claims of 60-65%")
   - Use exact terminology from main body ("H2 2027" not "mid-2027")
   - Match precision level ("$13.0B" if that's what financials section uses)
   - Include scope clarifications ("15M MacBook Air/iPad units annually")
6. **Verify Consistency** — Re-grep to ensure exec summary now matches all sections

**Why This Matters:** Executive summary must accurately reflect the document it summarizes, not the initial draft outline.

### 0.1 Critical Rule: When to Use `\section{}` vs `\subsection{}` vs `\textbf{}`

**This section added 2026-01-17 after identifying hierarchy inconsistencies in multiple documents.**

#### THE PROBLEM: Inconsistent Heading Hierarchy

Documents often mix `\textbf{Title}` with proper `\subsection{}` commands, creating:
- ❌ Visual inconsistency (some headings large, others normal-sized)
- ❌ TOC chaos (missing or inconsistent entries)
- ❌ No automatic numbering for major topics
- ❌ Broken document outline structure

#### THE SOLUTION: Clear Decision Tree

```
Is this a MAJOR TOPIC spanning multiple pages?
├─ YES → Use \section{Title}
│         Examples: "Executive Summary", "Financial Analysis", "Investment Risks"
│
└─ NO → Is this a SUBTOPIC with multiple paragraphs/bullets under it?
    ├─ YES → Use \subsection{Title}
    │         Examples: "The Yield Gap", "Capacity Constraints", "TSMC's Roadmap"
    │
    └─ NO → Is this just EMPHASIS within a paragraph?
            └─ YES → Use \textbf{word} inline
                     Examples: "The \textbf{yield rate} is critical..."
```

#### ABSOLUTE RULES

| Pattern | Verdict | Reason |
|---------|---------|--------|
| `\textbf{The Strategic Rationale}` as standalone heading | ❌ **FORBIDDEN** | Should be `\subsection{The Strategic Rationale}` |
| `\textbf{1. Topic}` or `\textbf{2. Topic}` as numbered headings | ❌ **FORBIDDEN** | Remove numbers, use `\subsection{Topic}` (auto-numbered) |
| `Some text. \textbf{Key Point:} Explanation...` | ✅ **CORRECT** | Bold emphasis within paragraph flow |
| `\subsection{Title}\n\n\textbf{Subtitle:}` | ⚠️ **AVOID** | Use itemize or just paragraph text |

#### CORRECT HEADING PATTERN

```latex
\section{Investment Analysis}

\subsection{Valuation Framework}
We employ a three-pronged approach...

\subsection{Discounted Cash Flow Model}
The DCF model assumes...
\begin{itemize}
    \item \textbf{WACC:} 9.5\% reflecting...
    \item \textbf{Terminal Growth:} 2.5\% in perpetuity...
\end{itemize}

\subsection{Risk Assessment}
Key vulnerabilities include...
```

#### FORBIDDEN PATTERNS

```latex
% ❌ BAD: Using \textbf{} as pseudo-section headings
\textbf{Investment Analysis}

\textbf{1. Valuation Framework}
We employ a three-pronged approach...

\textbf{2. Discounted Cash Flow Model}
The DCF model assumes...

% ❌ BAD: Mixing styles
\subsection{Investment Analysis}
\textbf{Valuation Framework}  ← Should be \subsection{}
We employ a three-pronged approach...
```

### 0.2 Paragraph Spacing Standards

**This section added 2026-01-17 to establish consistent vertical rhythm.**

#### THE RULE: One Blank Line Between Paragraphs

Morgan Stanley documents use LaTeX's natural paragraph spacing. Follow these rules:

```latex
% ✅ CORRECT: Blank line between paragraphs
\subsection{Title}
First paragraph explaining the context and setup for the analysis.

Second paragraph diving deeper into the implications. This creates proper 
paragraph indentation and spacing.

Third paragraph with concluding thoughts.
```

```latex
% ❌ WRONG: No blank line = run-on paragraph
\subsection{Title}
First paragraph text.
Second paragraph text.  ← This continues the first paragraph!
Third paragraph text.
```

#### When to Use `\vspace{}`

| Situation | Rule |
|-----------|------|
| Between normal paragraphs | ❌ **NEVER** - Use blank line only |
| After `\section{}` | ✅ Optional: `\vspace{0.5cm}` for emphasis |
| Before/after tables/figures | ✅ `\vspace{0.3cm}` to `\vspace{0.5cm}` |
| Before major visual dividers | ✅ `\vspace{0.5cm}` |
| After `\subsection{}` | ❌ **NEVER** - Natural spacing is correct |

#### CORRECT SPACING EXAMPLES

```latex
% ✅ CORRECT: Natural flow
\subsection{Market Analysis}
The semiconductor market is experiencing unprecedented demand.

Supply constraints have created pricing power for incumbent foundries. 
TSMC currently holds 90\% market share in advanced nodes.

This monopoly creates strategic vulnerabilities for fabless customers.

\subsection{Competitive Dynamics}
Intel's entry as a merchant foundry...
```

```latex
% ❌ WRONG: Random \vspace{} commands
\subsection{Market Analysis}
The semiconductor market is experiencing unprecedented demand.
\vspace{0.3cm}  ← REMOVE: Unnecessary between paragraphs

Supply constraints have created pricing power...
\vspace{0.2cm}  ← REMOVE: Inconsistent spacing

This monopoly creates strategic vulnerabilities...
\vspace{0.5cm}  ← REMOVE: Use blank line instead
```

### 0.3 Maximum Document Depth

To maintain clarity, limit heading depth:

```
\section{Level 1}           ← Use sparingly (3-5 per document)
  \subsection{Level 2}      ← Primary organizational unit
    Paragraph text          ← No deeper nesting
    \begin{itemize}
      \item \textbf{Label:} ← Bold for list items only
    \end{itemize}
```

**NEVER create deeper nesting** like `\subsubsection{}` - use itemized lists instead.

### 0.4 Preventing Duplicate Sections

**This section added 2026-01-17 after finding 8+ duplicate subsections in a single document.**

#### THE PROBLEM: Copy-Paste During Reorganization

When reorganizing content, it's easy to:
1. Copy a section to a new location
2. Revise it
3. Forget to delete the old version

This creates:
- Duplicate TOC entries (e.g., "2.11 TSMC's Roadmap" and "2.16 TSMC's Roadmap")
- Redundant content (wastes 3-5 pages)
- Reader confusion
- Label conflicts if `\label{}` is used

#### THE SOLUTION: Section Markers

When reorganizing, add temporary comments:

```latex
\subsection{TSMC's Roadmap}  % MOVED FROM Section 2 → Section 3
Content here...

% Several pages later...
% OLD VERSION BELOW - DELETE BEFORE FINAL
% \subsection{TSMC's Roadmap}  
% Content here...
```

#### VERIFICATION CHECKLIST

Before compiling final PDF:

1. **Search for duplicate subsection titles:**
   ```bash
   grep "\\subsection{" yourfile.tex | sort | uniq -d
   ```

2. **Check TOC for duplicate numbering:**
   - Open the `.toc` file
   - Look for repeated section numbers (e.g., two "2.11" entries)

3. **Review page count:**
   - If document is >40 pages, check for redundancy
   - Morgan Stanley research notes: 15-25 pages typical

### 0.5 Executive Summary Placement

**Added 2026-01-17 (consolidated from changelog).**

**RULE:** Executive summary must appear BEFORE the table of contents, never after.

```latex
% ✅ CORRECT ORDER:
\begin{document}
\reporttitle{...}{...}{}

% 1. Executive Summary (first content after title)
\begin{multicols}{2}
  Summary content...
\end{multicols}

% 2. Table of Contents (dedicated page)
\newpage
\begin{tcolorbox}[...]
{\color{msblue}\Large\bfseries Table of Contents}
\end{tcolorbox}
\vspace{0.3cm}
\tableofcontents

% 3. Main document sections
\newpage
\section{Introduction}
```

**NEVER** wrap `\tableofcontents` in a `tcolorbox` that prevents page breaks - use a header box only.

---

## 1. Tables

### The Problem with `tabularx` & `colortbl`
While `tabularx` is useful for auto-width tables, it has known severe conflicts with the `colortbl` package (often used for row colors) and the `array` package. This often leads to compilation errors like `! Undefined control sequence \insert@pcolumn`.

### The Solution: Standard `tabular` + Calculated Columns
To ensure stability and consistent formatting, use standard `tabular` environments with explicit paragraph column widths (`p{percentage\linewidth}`).

*   **Font Size:** Always use the global `\tablefont` macro (`\footnotesize`).
*   **Column Widths:** Manually assign widths using `p{...}` that sum to roughly 0.9-1.0 of the linewidth for full-width tables.
*   **Color Compatibility:** This approach works natively with `\rowcolors`.

### Required Preamble Fix
If using `colortbl` with `array` or modern LaTeX kernels, include this fix in the preamble to avoid `\insert@pcolumn` errors:
```latex
\makeatletter
\let\insert@pcolumn\insert@column
\makeatother
```

### Implementation Rule
1.  Define the global font size:
    ```latex
    \newcommand{\tablefont}{\footnotesize}
    ```
2.  Construct tables using `tabular` with `p{...}` columns:
    ```latex
    \tablefont
    % Example: 4 columns
    \begin{tabular}{p{0.22\linewidth}p{0.22\linewidth}p{0.22\linewidth}p{0.22\linewidth}}
        \toprule
        Header 1 & Header 2 & Header 3 & Header 4 \\
        \midrule
        \rowcolor{white}
        Content & Content & Content & Content \\
        \bottomrule
    \end{tabular}
    ```

### 1.1 ⚠️ CRITICAL: The `adjustbox` Font Scaling Bug

**This section added 2026-01-15 after fixing 15+ tables with inconsistent font sizes.**

#### THE PROBLEM: Tables Have Wildly Different Font Sizes

When using `adjustbox` to make tables fit the page width, you may notice:
- Some tables have **huge fonts** (narrow tables scaled UP)
- Some tables have **tiny fonts** (wide tables scaled DOWN)
- Font sizes are unpredictable and inconsistent

#### THE ROOT CAUSE: `width=` vs `max width=`

```latex
% ❌ BAD - Forces scaling to EXACT width (fonts change!)
\begin{adjustbox}{width=\textwidth}
\begin{tabular}{lcc}  % Narrow 3-column table
...
\end{tabular}
\end{adjustbox}
```

**What happens:** A narrow table that's naturally 8cm wide gets SCALED UP to fill 15cm, making all fonts ~2x larger than intended.

```latex
% ❌ ALSO BAD - Wide table gets scaled DOWN
\begin{adjustbox}{width=\textwidth}
\begin{tabular}{p{4cm} p{5cm} p{5cm} p{4cm}}  % Wide table
...
\end{tabular}
\end{adjustbox}
```

**What happens:** A wide table that's naturally 18cm gets SCALED DOWN to fit 15cm, making all fonts ~0.8x smaller.

#### THE FIX: Use `max width=` Instead

```latex
% ✅ CORRECT - Only scales DOWN if needed, never UP
\begin{adjustbox}{max width=\textwidth}
\begin{tabular}{lcc}
...
\end{tabular}
\end{adjustbox}
```

**What happens:** 
- Narrow tables stay at their natural size (fonts unchanged)
- Wide tables get scaled down to fit (acceptable font shrinkage)
- **Fonts are consistent across all tables**

#### MANDATORY TABLE TEMPLATE

**Every table MUST follow this pattern:**

```latex
\begin{table}[H]
\centering
\caption{Your Table Title Here}
\label{tab:unique_label}
\rowcolors{2}{msgrey}{white}
\tablefont                              % ← REQUIRED: Sets base font to \footnotesize
\begin{adjustbox}{max width=\textwidth} % ← REQUIRED: max width, NOT width
\begin{tabular}{...}
\toprule
\textbf{Header 1} & \textbf{Header 2} & \textbf{Header 3} \\
\midrule
Content & Content & Content \\
\bottomrule
\end{tabular}
\end{adjustbox}
\par\vspace{0.1cm}                      % ← REQUIRED: \par forces source below table
{\tiny Source: Morgan Stanley Research}
\end{table}
```

### 1.2 ⚠️ Table Source Text Positioning

**This section added 2026-01-15 after fixing source citations appearing beside tables.**

#### THE PROBLEM: Source Text Appears Beside Table, Not Below

When using `max width=\textwidth`, narrow tables don't fill the full page width. If you use:

```latex
% ❌ BAD - Source may appear to the RIGHT of narrow tables
\end{adjustbox}
\vspace{0.1cm}
{\tiny Source: Morgan Stanley Research}
```

LaTeX treats this as inline content—the `\vspace` only adds vertical space *after* a line break. Since the narrow table doesn't fill the line, the source text flows horizontally beside it.

#### THE FIX: Add `\par` Before `\vspace`

```latex
% ✅ CORRECT - Source always appears BELOW the table
\end{adjustbox}
\par\vspace{0.1cm}                      % \par forces a paragraph break (new line)
{\tiny Source: Morgan Stanley Research}
```

**What `\par` does:** Forces LaTeX to end the current paragraph and start a new line, regardless of how wide the preceding content was.

#### VISUAL COMPARISON

**Without `\par`** (narrow table):
```
┌──────────────────┐
│   Narrow Table   │  Source: Morgan Stanley
└──────────────────┘
```

**With `\par`** (correct):
```
┌──────────────────┐
│   Narrow Table   │
└──────────────────┘
Source: Morgan Stanley
```

#### RULE: Always Use `\par\vspace` After Tables

| Pattern | Result |
|---------|--------|
| `\vspace{0.1cm}` alone | ❌ Source may appear beside narrow tables |
| `\par\vspace{0.1cm}` | ✅ Source always appears below table |
| `\\[0.1cm]` | ⚠️ Works but can cause spacing issues in floats |

#### PREAMBLE SETUP: Reusable Table Environments

Add these to your preamble for consistent table formatting:

```latex
% Standard table environment with consistent fonts
\newenvironment{mstable}[1][\textwidth]{%
    \tablefont%
    \renewcommand{\arraystretch}{1.2}%
    \rowcolors{2}{msgrey}{white}%
    \begin{adjustbox}{max width=#1, center}%
}{%
    \end{adjustbox}%
}

% For tables that MUST scale but should not shrink below \scriptsize
\newenvironment{mstablescaled}[1][\textwidth]{%
    \scriptsize%  % Minimum readable font size
    \renewcommand{\arraystretch}{1.3}%
    \rowcolors{2}{msgrey}{white}%
    \begin{adjustbox}{max width=#1, center}%
}{%
    \end{adjustbox}%
}
```

**Usage:**
```latex
\begin{table}[H]
\centering
\caption{My Table}
\begin{mstable}
\begin{tabular}{lcc}
...
\end{tabular}
\end{mstable}
\end{table}
```

#### TABLE FONT CHECKLIST (Run Before Compiling)

```
Table Setup Phase:
[ ] \tablefont appears BEFORE \begin{adjustbox}
[ ] adjustbox uses max width=, NOT width=
[ ] Each table has a unique \label{tab:...}
[ ] \rowcolors{2}{msgrey}{white} for alternating colors

Content Phase:
[ ] Headers use \textbf{...}
[ ] Currency values escaped: \$13B not $13B
[ ] Percentages escaped: 10\% not 10%
[ ] Ampersands in text escaped: Apple \& Intel

Verification Phase:
[ ] Compile and check ALL tables have similar font sizes
[ ] If one table looks much larger/smaller, check its adjustbox setting
```

#### COMMON MISTAKES

| Mistake | Result | Fix |
|---------|--------|-----|
| `{adjustbox}{width=\textwidth}` | Fonts scale unpredictably | Use `max width=` |
| Missing `\tablefont` | Table uses default `\normalsize` | Add `\tablefont` before adjustbox |
| Duplicate `\label{tab:...}` | Compilation warning, broken refs | Use unique labels |
| `\rowcolors` inside adjustbox | May not work correctly | Put before adjustbox |

---

## 2. Special Characters & Text Safety

### Headers & Body Text
LaTeX special characters must be escaped, *especially* in section headers, custom commands, and bold text where errors can be cryptic and stop compilation entirely.

### ⚠️ **CRITICAL: The Ampersand (`&`) Error**

The `&` character is the most common source of compilation failure because LaTeX reserves it for table/matrix alignment.

*   **Rule:** **NEVER** write a literal `&` in any text, header, or command argument.
*   **Escape:** Always use `\&`.
*   **Example (Titles):**
    *   *Bad:* `\blueheader{The Rumor Mill & Strategic Rationale}` $\rightarrow$ **Fails with `Misplaced alignment tab character &`**
    *   *Good:* `\blueheader{The Rumor Mill \& Strategic Rationale}`
*   **Example (Body):**
    *   *Bad:* `Apple & Intel partnership`
    *   *Good:* `Apple \& Intel partnership`

### Other Special Characters

*   **Dollar Signs:** Always use `\$` for currency. `$` triggers math mode.
    *   *Bad:* `$13 billion`
    *   *Good:* `\$13 billion`
*   **Percentages:** Always use `\%`.
    *   *Bad:* `10% Yield`
    *   *Good:* `10\% Yield`
*   **Underscores:** Always use `\_`.
    *   *Bad:* `file_name.tex`
    *   *Good:* `file\_name.tex`

---

## 3. Charts (PGFPlots)

### 3.0 Legend Placement (CRITICAL FOR LLMS)

**Problem:** Relying on pgfplots defaults (`legend pos=north east`) often overlaps data (e.g., legends sitting on top of the rightmost bar). One chart broke because it only set `legend style={font=...}` without a position.

**Global Fix (already in preamble):**
```latex
% Standard legend positioning for all axes
mslegend/.style={
    legend style={at={(0.5,-0.15)}, anchor=north, legend columns=-1, draw=none, font=\footnotesize}
}
% Apply to all charts unless explicitly overridden
every axis/.append style={
    legend style={at={(0.5,-0.15)}, anchor=north, legend columns=-1, draw=none, font=\footnotesize}
}
```
**Rules for LLMs:**
- Do NOT rely on defaults. Always set legend position explicitly or inherit `mslegend`.
- Preferred layout: below the chart, centered, horizontal flow (`legend columns=-1`).
- If placing the legend inside the plot, set clear coordinates (e.g., `at={(0.02,0.98)}, anchor=north west}`) and ensure it does not cover data.
- Keep legend fonts at `\footnotesize`; avoid `\tiny`.
- For tight spaces, you may shorten `yshift` or use a fixed column count, but never omit `at`/`anchor`.

**LLM Checklist (legends):**
- [ ] Legend position set (global default or explicit)
- [ ] Font set to `\footnotesize`
- [ ] Anchor and columns defined
- [ ] For bar charts, legend does not cover data unless intentionally overlaid

### ⚠️ CRITICAL: Chart Spacing & Font Consistency Issues

**This section added 2026-01-15 after fixing 10+ charts with consistent formatting problems.**

#### THE PROBLEM: Wide Column Spacing, Misaligned Notes, Inconsistent Fonts

When charts have **few data points** (2-3 columns) but use **percentage-based widths** like `width=0.95\textwidth`, three major issues occur:

1. **Excessive spacing** between bars/columns (looks unprofessional)
2. **Notes and sources** positioned outside `tikzpicture` appear disconnected and poorly aligned
3. **Font sizes** vary wildly across chart elements (tiny numbers, small labels, different tick sizes)

#### THE ROOT CAUSES:

**Problem 1: Width Calculation with Few Data Points**
```latex
% ❌ BAD - Only 2 x-axis values but using 95% of text width
\begin{axis}[
    width=0.95\textwidth,  % ~15cm on standard page
    symbolic x coords={2024, 2030E},  % Only 2 columns!
    bar width=35pt
]
```
Result: Each bar is surrounded by ~6cm of white space on each side.

**Problem 2: External Note Positioning**
```latex
% ❌ BAD - Note positioned outside tikzpicture
\end{tikzpicture}
\vspace{0.1cm}
{\tiny Source: Morgan Stanley Research}
```
Result: Note appears disconnected, alignment is fragile, spacing inconsistent.

**Problem 3: Font Size Chaos**
```latex
% ❌ BAD - Different font sizes everywhere
nodes near coords style={font=\tiny, color=white},  % Numbers are tiny
ylabel={Capacity Share (\%)},  % Label uses default font
legend style={font=\tiny},  % Legend is tiny
xtick=data,  % Tick labels use default
```
Result: Numbers barely visible, axis labels too large, no visual hierarchy.

#### THE SOLUTION: Fixed-Width Charts with Unified Fonts & Internal Notes

**Pattern for Charts with 2-3 Data Points:**

```latex
\begin{center}
\captionof{figure}{Chart Title Goes Here}
\begin{tikzpicture}
\begin{axis}[
    ybar stacked,
    height=6cm,
    width=8cm,  % ✅ FIXED WIDTH, not percentage
    bar width=25pt,  % ✅ Reduced from 35pt
    enlarge x limits={abs=1cm},  % ✅ Control spacing explicitly
    legend style={at={(0.5,-0.15)}, anchor=north, legend columns=-1, draw=none, font=\footnotesize},  % ✅ Consistent font
    ylabel={Capacity Share (\%)},
    ylabel style={font=\footnotesize},  % ✅ Explicit font
    symbolic x coords={2024, 2030E},
    xtick=data,
    xticklabel style={font=\footnotesize},  % ✅ Explicit font
    ymin=0, ymax=100,
    axis y line*=left,
    axis x line*=bottom,
    ymajorgrids=true,
    grid style={dotted, gray},
    nodes near coords,
    nodes near coords style={font=\footnotesize, color=white, font=\bfseries},  % ✅ Readable size
    yticklabel style={font=\footnotesize},  % ✅ Explicit font
    every node near coord/.append style={anchor=center}
]
\addplot[fill=msblue] coordinates {(2024,90) (2030E,75)};
\addplot[fill=msbrightblue] coordinates {(2024,0) (2030E,15)};
\addplot[fill=gray] coordinates {(2024,10) (2030E,10)};
\legend{TSMC (Taiwan), Intel (USA/Ireland), Samsung/Others}
\end{axis}
% ✅ CRITICAL: Note positioned INSIDE tikzpicture
\pgfplotsset{
    after end axis/.append code={
        \node[anchor=north, font=\tiny, text width=8cm, align=center] at (current axis.south) [yshift=-1.5cm] {
            Note: 2030E assumes successful Intel 18A/14A ramp and Apple adoption.\\
            Source: Morgan Stanley Research Estimates
        };
    }
}
\end{tikzpicture}
\end{center}
```

#### MANDATORY RULES FOR ALL NEW CHARTS:

**Rule 1: Width Selection**
- **2-3 data points:** Use `width=8cm` to `width=10cm` (fixed)
- **4-5 data points:** Use `width=10cm` to `width=12cm` (fixed)
- **6+ data points:** Can use `width=0.95\textwidth` or fixed `width=14cm`
- **Heatmaps/3D:** Use `width=12cm` for proper colorbar spacing
- **Never** use percentage widths for sparse data (<4 points)

**Rule 2: Bar Width Scaling**
- **2-3 bars:** `bar width=25pt` maximum
- **4-6 bars:** `bar width=20pt`
- **7+ bars:** `bar width=15pt`
- Add `enlarge x limits={abs=1cm}` or `enlarge x limits=0.15` to control spacing

**Rule 3: Font Consistency (CRITICAL)**
All chart elements MUST use `\footnotesize` for readability:
```latex
% Required font specifications:
ylabel style={font=\footnotesize},
xlabel style={font=\footnotesize},
xticklabel style={font=\footnotesize},
yticklabel style={font=\footnotesize},
nodes near coords style={font=\footnotesize, font=\bfseries},  % Bold for visibility
legend style={font=\footnotesize},
title style={font=\footnotesize},
colorbar style={ticklabel style={font=\footnotesize}}  % For heatmaps
```
**Never use `\tiny` for data labels** - they become illegible when printed.

**Rule 4: Note Positioning (CRITICAL)**
Always position notes/sources INSIDE the tikzpicture:
```latex
\end{axis}
\pgfplotsset{
    after end axis/.append code={
        \node[anchor=north, font=\tiny, text width=<match chart width>, align=center] 
        at (current axis.south) [yshift=-1.5cm] {
            Note/Source text here
        };
    }
}
\end{tikzpicture}
```
**Benefits:**
- Consistent alignment with chart
- Proper spacing control
- Text width matches chart width
- No orphaned notes when page breaks

**Rule 5: Long X-Axis Labels**
For labels longer than 15 characters:
```latex
xticklabel style={font=\footnotesize, text width=3cm, align=center},
```
This wraps text and centers it under bars.

### Bar Charts (Standard Reference)
*   **Standard Charts:** For datasets with many (>3) bars, use the standard `msstyle` which sets `width=0.95\textwidth`.
*   **Compact Charts:** For datasets with few (2-3) bars, use the `compactchart` style (width=0.5\textwidth) to prevent bars from appearing comically wide.

### 3D / Heatmap Plots
When using `matrix plot*` or 3D coordinates:
*   **Width:** Always use `width=12cm` for proper colorbar display
*   **Font Consistency:** Apply `\footnotesize` to all labels and colorbar
*   **Coordinates:** Ensure coordinates match the axis dimensions. For 3D surface/heatmaps, use `(x,y,z)`.
    ```latex
    coordinates {
        (50,10,-60) (60,10,-55) ...
    };
    ```
*   **Point Meta:** If the compiler throws errors about `pgfkeys` or coordinates, verify `point meta`. For standard Z-axis coloring, explicit `point meta` is often unnecessary or should be set to `z`.
    *   *Avoid:* `point meta=explicit` unless you are providing a 4th meta value.
*   **Labels:** `nodes near coords` in 3D plots can be unstable. If compilation fails, comment them out first.

### Complete Example: Professional Chart Template

```latex
\begin{center}
\captionof{figure}{Intel Foundry Services Operating Loss (2022-2027E)}
\begin{tikzpicture}
\begin{axis}[
    ybar,
    width=10cm,
    height=6cm,
    bar width=20pt,
    symbolic x coords={2022, 2023, 2024, 2025E, 2026E, 2027E},
    xtick=data,
    xticklabel style={font=\footnotesize},
    nodes near coords,
    nodes near coords style={font=\footnotesize, color=black, anchor=south},
    ylabel={Operating Loss (\$B)},
    ylabel style={font=\footnotesize},
    yticklabel style={font=\footnotesize},
    ymin=-15, ymax=2,
    axis y line*=left,
    axis x line*=bottom,
    ymajorgrids=true,
    grid style={dotted, gray}
]
\addplot[fill=msblue] coordinates {
    (2022,-5.2) (2023,-7.0) (2024,-13.2) 
    (2025E,-9.5) (2026E,-4.0) (2027E,0.5)
};
\end{axis}
\pgfplotsset{
    after end axis/.append code={
        \node[anchor=north, font=\tiny, text width=10cm, align=center] 
        at (current axis.south) [yshift=-1.2cm] {
            Source: Company Filings, Morgan Stanley Research Estimates (2025-2027E)
        };
    }
}
\end{tikzpicture}
\end{center}
```

## 4. **CRITICAL: Color-Coded Bar Charts - The Multi-AddPlot Error**

### ⚠️ THE PROBLEM: Multiple `\addplot` Commands Creating Separate Series

**This is the #1 most common chart rendering error in pgfplots.**

**What Happens:**
When you try to create a bar chart with different colored bars using multiple `\addplot` commands like this:

```latex
% ❌ WRONG - DO NOT USE THIS PATTERN
\begin{axis}[ybar, symbolic x coords={A, B, C, D}]
    \addplot[fill=red!60] coordinates {(A, -50)};
    \addplot[fill=orange!60] coordinates {(B, -20)};
    \addplot[fill=yellow!60] coordinates {(C, 0)};
    \addplot[fill=green!60] coordinates {(D, 20)};
\end{axis}
```

**Root Cause:**
- Each `\addplot` tells pgfplots to create a **separate data series**
- Pgfplots treats this as **4 overlapping plots**, not 4 bars in one series
- This causes:
  - Legend entries for EACH bar (visual clutter)
  - Incorrect bar positioning/spacing
  - Labels appearing in boxes ABOVE bars instead of on them
  - Potential compilation errors with `nodes near coords`

### ✅ THE SOLUTION: Use Scatter with Color Mapping OR Single Series with Meta

**Option 1: Forget Plot (Quick Fix)**
For simple cases where you just want different colors without caring about the legend:

```latex
% ✅ CORRECT - Each plot uses forget plot to avoid legend pollution
\begin{axis}[
    ybar,
    symbolic x coords={Yield Failure, Struggling, Break-Even, Target},
    xtick=data,
    bar width=30pt,
    nodes near coords,
    nodes near coords align={vertical}
]
\addplot[ybar, fill=red!60, draw=none] coordinates {(Yield Failure, -50)};
\addplot[ybar, fill=orange!60, draw=none, forget plot] coordinates {(Struggling, -20)};
\addplot[ybar, fill=yellow!60, draw=none, forget plot] coordinates {(Break-Even, 0)};
\addplot[ybar, fill=green!60, draw=none, forget plot] coordinates {(Target, 20)};
\end{axis}
```

**Key Elements:**
- **`forget plot`**: Prevents legend entry for that specific `\addplot`
- **`ybar`** on EACH `\addplot`: Forces bar mode (overrides axis-level for that series)
- **`draw=none`**: Removes bar outlines for cleaner look

**Option 2: Scatter with Point Meta (Advanced)**
For more complex color mapping or continuous color scales:

```latex
\begin{axis}[
    ybar,
    scatter,
    scatter/use mapped color={fill=mapped color},
    point meta=explicit symbolic,
    colormap/hot,
    symbolic x coords={A, B, C, D},
    xtick=data
]
\addplot[scatter] coordinates {
    (A, -50) [red]
    (B, -20) [orange]
    (C, 0) [yellow]
    (D, 20) [green]
};
\end{axis}
```

**Option 3: Colormap for True Heatmaps (Continuous)**
For sensitivity analysis or heatmap-style visualizations:

```latex
\begin{axis}[
    ybar,
    colormap/viridis,
    point meta=y,
    colorbar,
    symbolic x coords={Low, Med, High, Very High},
    xtick=data
]
\addplot+[fill] coordinates {(Low, 10) (Med, 30) (High, 60) (Very High, 90)};
\end{axis}
```

### 📋 Global Rule for All Color-Coded Charts

**NEVER use multiple `\addplot` commands for individual bars of different colors UNLESS:**
1. You explicitly use `forget plot` on all but the first, OR
2. You WANT each bar to be a separate series in the legend

**ALWAYS prefer:**
- Single `\addplot` with color mapping via `point meta`
- OR use `forget plot` directive to suppress unwanted legend entries

### 🚦 Semantic Chart Styles (LLM Checklist to Avoid Color Drift)
**Context:** We had 3 charts with off-brand colors because fills were hardcoded ad-hoc. Use the predefined semantic styles in the preamble instead of picking colors manually.

**Styles (already defined in the template preamble):**
- `msstyle` — Default single-series blue bars (use for most charts with many bars)
- `compactchart` — Same as `msstyle` but narrower width for 2-3 bars
- `comparestyle` — For company comparisons; supply bars with consistent fills: `msblue!80` (TSMC/dominant), `orange!70` (Intel/emerging), `gray!60` (Samsung/minor), `gray!30` (negligible)
- `divergingstyle` — For good→bad spectra (e.g., sensitivity): bars should be `red!60`, `orange!60`, `yellow!60`, `green!60`

**Rules:**
1) **Do not set `fill=` at the axis level.** Pick the semantic style and then add bars with the prescribed palette.  
2) **Do not invent new colors per chart.** Reuse the palette above so all documents stay visually consistent.  
3) **Name matches intent.** If you need a new visual treatment, add a new named style in the preamble—never inline ad-hoc colors.  
4) **LLM guardrail:** If you see raw color literals inside a chart body, refactor to one of the semantic styles before adding new data.

**Senior Engineer Guidance (treat as mandatory):**
- Choose the semantic style first, then add data. Never reach for `fill=...` inline.
- Company comparisons → `comparestyle` with the house palette; sensitivity/bad→good → `divergingstyle`; default bar charts → `msstyle`/`compactchart` depending on bar count.
- If a chart needs a new visual language, add a new named style in the preamble with comments; do not sprinkle bespoke colors in the plot body.
- LLM red flag: any axis or addplot that hardcodes a color outside these palettes must be refactored before merge.

### Stacked Bar Charts - Special Case

For stacked bar charts with `ybar stacked`, you MUST use multiple `\addplot` (one per stack layer), but ensure:

```latex
\begin{axis}[
    ybar stacked,
    symbolic x coords={2024, 2030E},
    xtick=data,
    nodes near coords,
    nodes near coords style={font=\tiny, color=white},
    legend style={at={(0.5,-0.25)}, anchor=north, legend columns=-1}
]
% Each addplot is a layer of the stack
\addplot[fill=msblue] coordinates {(2024,90) (2030E,75)};
\addplot[fill=msbrightblue] coordinates {(2024,0) (2030E,15)};
\addplot[fill=gray] coordinates {(2024,10) (2030E,10)};
\legend{Layer 1, Layer 2, Layer 3}
\end{axis}
```

**Key for Stacked:**
- `nodes near coords` shows the VALUE of each segment
- For cumulative labels, you need custom `\pgfplotspointmetatransformed`
- White text color works well on dark bars

### Style Definitions (Updated)
```latex
\pgfplotsset{
    compat=1.18,
    msstyle/.style={
        ybar,
        width=0.95\textwidth,
        bar width=15pt,
        nodes near coords,
        ymajorgrids=true,
    },
    compactchart/.style={
        msstyle,
        width=0.5\textwidth,
        enlarge x limits=0.5,
    },
    % New: Color-coded bar style
    colorbar/.style={
        ybar,
        bar width=30pt,
        draw=none,
        nodes near coords,
        nodes near coords align={vertical},
        nodes near coords style={font=\bfseries\footnotesize, color=black},
        axis x line*=bottom,
        axis y line*=left,
        ymajorgrids=true,
        grid style={dotted, gray},
    }
}
```

---

## 5. **CRITICAL: Common Compilation Errors & Prevention**

This section documents the most frequent LaTeX compilation errors encountered during document generation, their root causes, and how to prevent them. **AI agents generating LaTeX MUST follow these rules.**

### 5.1 The "Runaway Argument" Error in PGFPlots

####  THE PROBLEM: Blank Lines Inside Option Blocks

**Error Message:**
```
Runaway argument?
! Paragraph ended before \pgfplots@start@plot@with@behavioroptions was complete
```

**Root Cause:**
LaTeX interprets blank lines as paragraph breaks. Inside `\addplot[...]` or `\begin{axis}[...]` option blocks, a blank line terminates the command prematurely.

```latex
%  WRONG - Blank line breaks the command
\addplot3[
    matrix plot*,
    mesh/cols=6,

] coordinates {  % <-- LaTeX sees this as a NEW paragraph, not continuation
```

** THE FIX:**
```latex
%  CORRECT - No blank lines inside option brackets
\addplot3[
    matrix plot*,
    mesh/cols=6
] coordinates {
```

**Global Rule:** **NEVER insert blank lines inside `[...]` option blocks** for ANY LaTeX command.

---

### 5.2 Undefined Colormap Errors

**Error:** `! Package pgfplots Error: The colormap 'RdYlGn' is undefined!`

**Fix:** Define custom colormaps in preamble or use built-in ones (`viridis`, `hot`, `cool`, `bluered`).

---

### 5.3 Missing Newlines Before Environments

**Error:** `! Package titlesec Error: Entered in horizontal mode`

**Root Cause:** `\begin{...}` immediately after text without blank line.

**Fix:** Always add blank line before `\begin{multicols}`, `\begin{itemize}`, `\section{}`, etc.

---

### 5.4 Percent Signs in Symbolic Coordinates

**Error:** `Runaway argument? symbolic x coords={Yield Failure (<20xtick=data...`

**Root Cause:** `%` starts a comment, ignoring rest of line.

**Fix:** Escape as `\%` in ALL coordinates: `symbolic x coords={Low (<20\%), High (>80\%)}`

---

### 5.5 Dollar Signs Starting Math Mode

**Error:** `! LaTeX Error: Command \item invalid in math mode`

**Root Cause:** Currency `` opens math mode without closing.

**Fix:** Always escape currency: `\` not ``

---

### 5.6 Escape Character Quick Reference

| Char | Escape | Example |
|------|--------|---------|
| $ | \$ | \ million |
| % | \% | 10\% yield |
| & | \& | Apple \& Intel |
| _ | \_ | file\_name |

---

### 5.7 Pre-Compilation Checklist for AI Agents

- [ ] No blank lines inside `[...]` option blocks
- [ ] All `%` escaped as `\%` in text and coordinates
- [ ] All `$` escaped as `\$` for currency
- [ ] All `&` escaped as `\&` outside tables
- [ ] Blank line before every `\begin{...}` environment
- [ ] Colormaps are built-in or defined in preamble

---

## 6. **CRITICAL: ybar Legend Double-Pad Rendering**

### ⚠️ THE PROBLEM: Two Color Markers Per Legend Entry

**What Happens:**
In `ybar` charts with legends, each legend entry displays **two** visual markers—a filled rectangle plus a line segment—instead of a single color pad.

**Root Cause:**
pgfplots' default `ybar` legend style inherits from line plot rendering, which draws both a line and a fill marker. The `draw=none` option on bars does not affect legend rendering.

### ✅ THE SOLUTION: Override ybar Legend Style Globally

Add this to your `\pgfplotsset` in the preamble:

```latex
\pgfplotsset{
    compat=1.18,
    % ... other settings ...
    
    % Fix ybar legend to show single filled rectangle
    /pgfplots/ybar legend/.style={
        area legend,
    },
}
```

**Key Elements:**
- **`/pgfplots/ybar legend/.style`**: The hook point for ybar-specific legend rendering
- **`area legend`**: pgfplots' built-in style for filled-area plots (font-relative, properly aligned)

**Why This Works:**
- Single global definition affects ALL `ybar` charts
- Uses library-maintained style, not hardcoded coordinates
- Automatically scales with legend font size
- No per-chart modifications needed

### 📋 Global Rule for All ybar Charts

**ALWAYS** include `/pgfplots/ybar legend/.style={area legend}` in preamble when using `ybar` charts with legends.

---

## 7. **CRITICAL: Caption Formatting & Centering**

**Added 2026-01-17 after discovering inconsistent caption alignment throughout document.**

### 7.1 The Problem: Left-Aligned Captions by Default

LaTeX's default caption justification is **left-aligned**. This creates an unprofessional asymmetric appearance, especially for centered figures and tables. Many documents attempt to fix this by wrapping individual figures/tables in `\begin{center}...\end{center}` blocks, which:
- Creates inconsistent results (only works for some caption commands)
- Adds unwanted extra vertical spacing
- Requires manual intervention for every figure/table
- Is not maintainable across large documents

### 7.2 The Solution: Global Caption Configuration

**MANDATORY PREAMBLE SETUP:**

```latex
\usepackage{caption}
\captionsetup{justification=centering, font=normalsize, labelfont=bf}
```

This single line ensures:
- ✅ All captions (figures AND tables) are centered
- ✅ Caption text uses normal font size (readable but distinct from body text)
- ✅ Labels ("Figure 1:", "Table 1:") are bold for emphasis
- ✅ Works with both `\caption{}` and `\captionof{}` commands
- ✅ No extra vertical spacing issues

**⚠️ CRITICAL EXCEPTION:** When using `\captionof` inside `\begin{center}` environments, you MUST add a local `\captionsetup{justification=centering}` command immediately before the `\captionof` to override the environment's interference.

```latex
% ✅ CORRECT: captionof inside center environment
\begin{center}
\captionsetup{justification=centering}  % ← REQUIRED for center blocks!
\captionof{figure}{My Figure Title}
\begin{tikzpicture}
...
\end{tikzpicture}
\end{center}
```

**Why?** The `\begin{center}` environment's centering mechanism interferes with the caption package's global justification setting, causing captions to revert to left-alignment. The local `\captionsetup` command right before `\captionof` fixes this.

### 7.3 Correct Usage Patterns

#### ✅ CORRECT: Using \captionof in center environment (requires local setup)

```latex
\begin{center}
\captionsetup{justification=centering}  % ← REQUIRED when inside \begin{center}
\captionof{table}{Risk Assessment: Apple Adopting Intel 18A}
\rowcolors{2}{msgrey}{white}
\tablefont
\begin{tabular}{...}
...
\end{tabular}
\par\vspace{0.1cm}
{\tiny Source: Morgan Stanley Research}
\end{center}
```

**Why the center environment?** To center the *table itself*, not the caption. The caption centering is handled by the local `\captionsetup` which overrides the environment's interference.

#### ✅ CORRECT: Using \caption in table/figure environment

```latex
\begin{table}[H]
\centering
\caption{Intel Foundry Services Financial Trajectory}
\label{tab:ifs_financials}
\rowcolors{2}{msgrey}{white}
\tablefont
\begin{tabular}{...}
...
\end{tabular}
\par\vspace{0.1cm}
{\tiny Source: Company Filings, Morgan Stanley Research}
\end{table}
```

**Note:** Use `\centering` (not `\begin{center}`) inside float environments to center the table without extra spacing.

#### ❌ WRONG: Relying on environment centering alone

```latex
% BAD: Caption won't be centered without global \captionsetup
\begin{table}[H]
\caption{My Table Title}  % This will be LEFT-ALIGNED by default
\begin{tabular}{...}
...
\end{tabular}
\end{table}
```

#### ❌ WRONG: Wrapping in center just for caption alignment

```latex
% BAD: Adds extra spacing, inconsistent behavior
\begin{center}
\begin{table}[H]
\caption{My Table Title}  % Trying to center via outer environment
\begin{tabular}{...}
...
\end{tabular}
\end{table}
\end{center}
```

### 7.4 Caption Customization Options

The `\captionsetup{}` command accepts many options for fine-tuning:

```latex
% Full control example
\captionsetup{
    justification=centering,     % Center the caption text
    font=normalsize,             % Caption body font size
    labelfont=bf,                % Bold for "Figure 1:", "Table 1:"
    labelsep=colon,              % Separator after label (default)
    format=plain,                % No hanging indent
    skip=10pt,                   % Space between caption and figure/table
}
```

**For our Morgan Stanley style, the minimal configuration is sufficient:**

```latex
\captionsetup{justification=centering, font=normalsize, labelfont=bf}
```

### 7.5 When NOT to Override

Once global centering is configured, **DO NOT** add manual centering commands like:

```latex
% ❌ REDUNDANT: Caption is already centered globally
\captionsetup{justification=centering}  % Already set globally
\caption{My Title}
```

Only override if you have a specific exception (e.g., a sidebar table that needs left-aligned captions).

### 7.6 Debugging Caption Alignment Issues

If captions still appear misaligned after adding global `\captionsetup`:

1. **Check caption package is loaded:** Verify `\usepackage{caption}` appears before `\captionsetup{}`
2. **Check for conflicting packages:** Some packages (like `subfig`) can interfere with caption settings
3. **Check for local overrides:** Search for other `\captionsetup{}` commands that might override the global setting
4. **Verify PDF rendering:** Sometimes PDF viewers cache; recompile completely and refresh

### 📋 Global Rules for Captions

1. **ALWAYS** configure caption formatting globally in the preamble using `\captionsetup{}`
2. **NEVER** rely on LaTeX's default left-aligned captions
3. **CRITICAL:** When using `\captionof` inside `\begin{center}` environments, add `\captionsetup{justification=centering}` immediately before `\captionof`
4. **NEVER** wrap tables/figures in `\begin{center}` solely to center captions (use for content centering only)
5. Use `\centering` (not `\begin{center}`) inside float environments (`\begin{table}`, `\begin{figure}`)
6. The standard configuration: `\captionsetup{justification=centering, font=normalsize, labelfont=bf}`
7. Regular `\caption{}` commands inside float environments work automatically with global settings

---

## 8. Compilation Workflow

**Recommended Command:** `pdflatex -interaction=nonstopmode document.tex`

**Reading Error Logs:**
1. Look for `!` lines - actual errors
2. Note line numbers (`l.649` = line 649)
3. "Runaway argument" = unclosed bracket or blank line
4. "Missing $ inserted" = unescaped special character

---

## 9. Quick Reference: Chart Specifications by Data Point Count

| Data Points | Width | Bar Width | Font Size | Spacing Control |
|-------------|-------|-----------|-----------|-----------------|
| 2-3 | 8-10cm | 25pt max | `\footnotesize` | `enlarge x limits={abs=1cm}` |
| 4-5 | 10-12cm | 20pt | `\footnotesize` | `enlarge x limits=0.15` |
| 6-8 | 12-14cm | 15pt | `\footnotesize` | Auto or `enlarge x limits=0.1` |
| 9+ | `0.95\textwidth` | 12-15pt | `\footnotesize` | Auto |
| Heatmap/3D | 12cm | N/A | `\footnotesize` | N/A |

### Font Size Standards (Memorize This)

| Element | Font Size | Example |
|---------|-----------|---------|
| Data labels (bars) | `\footnotesize` + `\bfseries` | `nodes near coords style={font=\footnotesize\bfseries}` |
| Axis labels | `\footnotesize` | `ylabel style={font=\footnotesize}` |
| Tick labels | `\footnotesize` | `xticklabel style={font=\footnotesize}` |
| Legend | `\footnotesize` | `legend style={font=\footnotesize}` |
| Title | `\footnotesize` | `title style={font=\footnotesize}` |
| Notes/Sources | `\tiny` | Inside `\node` with `font=\tiny` |

**Golden Rule:** If you're using `\tiny` for anything users need to read (numbers, labels), you're doing it wrong. Only use `\tiny` for source citations and fine print.

### Chart Formatting Checklist (Run This Before Compiling)

```
Chart Design Phase:
[ ] Count x-axis data points
[ ] Select width from table above
[ ] Calculate bar width based on point count
[ ] Add enlarge x limits if needed

Font Specification Phase:
[ ] ylabel style={font=\footnotesize}
[ ] xlabel style={font=\footnotesize} (if used)
[ ] xticklabel style={font=\footnotesize}
[ ] yticklabel style={font=\footnotesize}
[ ] nodes near coords style={font=\footnotesize\bfseries}
[ ] legend style={font=\footnotesize}
[ ] title style={font=\footnotesize} (if used)
[ ] colorbar style={ticklabel style={font=\footnotesize}} (for heatmaps)

Note Positioning Phase:
[ ] \pgfplotsset{after end axis/.append code={...}}
[ ] \node positioned at (current axis.south)
[ ] text width matches chart width
[ ] font=\tiny for source/note text
[ ] yshift=-1.2cm to -1.5cm for spacing

Pre-Compilation Safety Check:
[ ] No blank lines in [...] option blocks
[ ] All % escaped as \% in coordinates
[ ] All $ escaped as \$ for currency
[ ] All & escaped as \& outside tables
[ ] Note is inside tikzpicture, not after \end{tikzpicture}
```

---

## 10. Senior Engineer's Final Notes

**To All Junior Staff and AI Agents:**

I've debugged these same chart issues across dozens of documents. The patterns are always identical:

1. **You assume percentage widths scale gracefully** - they don't. With 2 data points and `width=0.95\textwidth`, you create a comically wide chart. Use fixed widths.

2. **You forget that humans need to read the numbers** - `\tiny` might save space, but it makes data illegible. Use `\footnotesize` with `\bfseries` for emphasis.

3. **You put notes outside the tikzpicture because it seems easier** - but then alignment breaks, spacing is inconsistent, and it looks amateur. Put notes inside using `after end axis`.

4. **You copy-paste old chart code without understanding the context** - A 10-bar chart needs different settings than a 2-bar chart. Read the specifications table and think before you code.

5. **You forget to test at different zoom levels** - Your chart might look fine at 150% zoom in your editor. Print it at 100% scale and see if you can read the axis labels. If not, your fonts are too small.

**The Goal:** Every chart should be readable when printed on standard 8.5"×11" paper at 100% scale. If someone squints to read your data labels, you've failed.

**When in doubt:** Use the complete example template in Section 3. It's been battle-tested across 33-page documents with 10+ charts. Copy it, modify the data, and it will work.

— *Your Future Self (who won't have to debug this again)*

---

## 11. Document Structure: Executive Summary, Multicolumn Layouts & TOC

### 10.1 Executive Summary Placement & Layout

**Goal:** Readers should see the full executive summary immediately after the title page, before the table of contents.

**Standard Ordering (top of document):**
- Title block + disclosure banner / stock rating box
- Executive summary (1–3 pages)
- Table of contents (own page)
- Main body sections

**Canonical Executive Summary Pattern:**

```latex
% After title + disclosure box

% --- EXECUTIVE SUMMARY ---

\begin{multicols}{2}
    % Rating boxes, "What's Changed" box, bullets, narrative text
    % Use itemize/enumerate for key points; keep paragraphs short.
\end{multicols}
```

Rules:
- Use `\begin{multicols}{2}` / `\end{multicols}` for **narrative text, bullets, and short lists** in the summary.
- Keep executive summary fonts aligned with the rest of the document (no custom font sizes beyond the section/paragraph styles already defined in the preamble).
- Do **not** place very wide 3–4 column tables or complex charts inside `multicols` if they visually crowd one column.

### 10.2 Wide Tables & Charts Inside Executive Summaries

**Problem Observed:** A 4-column risk table inside `multicols` used `p{...\linewidth}` and overflowed into the margin.

**Global Rules:**
- Any table or chart that is intended to span the page width **must live outside** `multicols`.
- Inside `multicols`, if you really need a table, its columns must be sized in terms of `\columnwidth`, not `\textwidth` or `\linewidth`.
- Prefer to break out to full width for risk matrices, valuation tables, or dense numeric content.

**Full-Width Risk Table Pattern (Recommended):**

```latex
% 1) Finish the two-column narrative
\end{multicols}

% 2) Insert a full-width table
\vspace{0.5cm}
\begin{center}
\captionof{table}{Risk Assessment: Example Title}
\rowcolors{2}{msgrey}{white}
	ablefont
\begin{tabular}{p{0.15\textwidth}p{0.35\textwidth}p{0.35\textwidth}p{0.12\textwidth}}
    	oprule
    	extbf{Risk Factor} & \textbf{Bull Case (Strategic Win)} &
    	extbf{Bear Case (Execution Failure)} & \textbf{Impact} \\
    \midrule
    % rows ...
    \bottomrule
\end{tabular}
\par\vspace{0.1cm}
{\tiny Source: ...}
\end{center}

% 3) Optionally resume two-column text
\begin{multicols}{2}
    % Additional narrative sections
\end{multicols}
```

Key points:
- Column widths are expressed as fractions of `\textwidth` that sum to **≤ 1.0**, preventing margin overflow.
- Use the same `\rowcolors`, `\tablefont`, and `\par\vspace{0.1cm}` conventions documented in Section 1.
- Only close and reopen `multicols` where necessary; do **not** nest `multicols` inside floats.

### 10.3 Table of Contents (TOC) Formation & Placement

**Problems Observed:**
- TOC placed **before** the executive summary.
- TOC content wrapped completely inside a `tcolorbox`, preventing page breaks and clipping the bottom of the list.
- Legacy use of low-level `\@starttoc{toc}` instead of `\tableofcontents`.

**Global Rules for TOC:**
- The TOC **must follow** the executive summary, on its own page.
- Always use `\tableofcontents` (never `\@starttoc{toc}`) so LaTeX can manage page breaks and referencing correctly.
- Do **not** wrap `\tableofcontents` in `tcolorbox` or any other non-breaking box. Only the TOC **header line** may be boxed for styling.
- Set TOC depth to at most sections + subsections: `\setcounter{tocdepth}{2}` unless there is a strong reason otherwise.

**Canonical TOC Block (Used in `intelapple.tex`):**

```latex
% --- TABLE OF CONTENTS ---
\newpage
\begin{tcolorbox}[
    colback=msgrey,
    colframe=msgrey,
    boxrule=0pt,
    sharp corners,
    left=10pt, right=10pt, top=10pt, bottom=10pt
]
    {\color{msblue}\Large\bfseries Table of Contents}
\end{tcolorbox}
\vspace{0.3cm}

\renewcommand{\contentsname}{}  % suppress default "Contents" label
\setcounter{tocdepth}{2}        % sections + subsections only
	ableofcontents                % bare TOC so it can break across pages
\vspace{0.5cm}

\newpage                         % main body starts on a fresh page
```

Checklist for AI agents:
- [ ] Executive summary pages come **before** this block.
- [ ] No additional boxes or `minipage` wrappers around `\tableofcontents`.
- [ ] TOC fits cleanly within page margins; if it runs long, LaTeX adds extra pages automatically.

### 10.4 Margin Safety in Multicolumn Sections

To avoid surprises when working with `multicols`:

- Inside `multicols`, think in terms of `\columnwidth`, not `\textwidth`.
- Never use `width=\textwidth` or columns based on `\textwidth` inside a two-column environment; they will almost always overflow.
- For any element that truly needs full width (large figure, multi-column table, complex chart), close `multicols`, insert the full-width content, and only then reopen `multicols`.
- After editing, **visually scan** the compiled PDF around multicolumn boundaries for margin overflows and clipped content.

Following these patterns keeps the early pages (title, executive summary, TOC) visually consistent and prevents layout regressions when future agents modify the document.

---

## 12. Regression Prevention: Recent Fixes & Must-Not-Miss Items (2026-01-17)

This section documents the specific regressions fixed in `siRNA.tex` and the required checks to prevent them from reappearing.

### 12.1 Layout & Structure Fixes Applied

1. **Main content width**
    - **Fix:** Added a `maincontent` environment that narrows the body text (consistent with `intelapple.tex`).
    - **Rule:** Wrap all main-body sections in `\begin{maincontent} ... \end{maincontent}`. Executive summary remains full-width (two columns).

2. **Executive summary columning**
    - **Fix:** Executive summary is the only two-column section; all other sections are single column.
    - **Rule:** `multicols` only in Executive Summary. Avoid reopening `multicols` in the main body.

3. **TOC placement + formatting**
    - **Fix:** TOC inserted after executive summary on its own page; header can be boxed but TOC body must be unboxed.
    - **Rule:** Use the canonical TOC block (Section 10.3). Never wrap `\tableofcontents` in `tcolorbox`.

4. **New major sections start on a new page**
    - **Fix:** `\section` redefined inside `maincontent` to start on a fresh page.
    - **Rule:** Ensure each top-level section begins on a new page in main content (use `\clearpage` or the `maincontent` hook).

5. **Hierarchy cleanup**
    - **Fix:** Removed duplicate section titles and duplicated blocks; repaired missing line breaks between headings.
    - **Rule:** No duplicate `\section` / `\subsection` titles. Never let a `\subsection` immediately follow text without a blank line.

### 12.2 Chart & Table Safety Fixes

1. **Two-column table sizing**
    - **Fix:** Summary tables inside `multicols` now use `\columnwidth`, not `\textwidth`.
    - **Rule:** Inside `multicols`, size columns with `\columnwidth` only.

2. **PGFPlots symbolic coords**
    - **Fix:** Wrapped symbolic coordinate labels in braces to prevent parsing errors.
    - **Rule:** Use `{Label}` for all `symbolic x/y coords` labels and coordinate entries.

### 12.3 Text & LaTeX Hygiene

1. **No Markdown syntax in .tex**
    - **Fix:** Replaced Markdown bold `**...**` with `\textbf{...}`.
    - **Rule:** Search for `\*\*` before compile and replace with proper LaTeX.

2. **Escape special characters**
    - **Rule:** Escape `&`, `%`, `$`, `#` in normal text. Use math mode only when appropriate.

### 12.4 Compilation Discipline

- **Run twice** after TOC or label changes to resolve references.
- **Check logs** for overfull/underfull hbox warnings in charts/tables; fix if they affect layout.

### 12.5 Quick Regression Checklist

- [ ] Executive summary is the only two-column section.
- [ ] Main body wrapped in `maincontent` with narrowed margins.
- [ ] Each `\section` in the main body starts on a new page.
- [ ] TOC follows executive summary and is unboxed.
- [ ] No duplicated `\section` / `\subsection` titles.
- [ ] No Markdown `**` remains in `.tex` files.
- [ ] Any symbolic coords in pgfplots are brace-wrapped.
