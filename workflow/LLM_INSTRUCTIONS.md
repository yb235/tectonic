# LLM LaTeX Workflow Instructions

**PURPOSE:** This document provides optimized instructions for LLM agents generating or editing LaTeX documents in this repository. It distills the comprehensive [LATEX_STYLE_GUIDE.md](../docs/latex/LATEX_STYLE_GUIDE.md) into a prioritized, action-oriented workflow.

**AUDIENCE:** AI agents, automated tools, and human operators working with LaTeX generation

---

## 🚨 PRIORITY 0: CRITICAL RULES (NEVER VIOLATE)

These rules are **non-negotiable** and will cause compilation failure or legal issues if violated:

### Legal & Compliance
- [ ] **NEVER** use color names that imply real institutions (e.g., `msblue` → use `brandblue`)
- [ ] **ALWAYS** include legal disclaimers (see Section 0B in main guide)
- [ ] **ALWAYS** update `COPYRIGHT_AND_LICENSE_AUDIT.md` when changing colors/fonts

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

---

## 🎯 PRIORITY 1: PRE-WORK CHECKLIST

Before generating **ANY** LaTeX content, complete this checklist:

### 1. Context Gathering
- [ ] Read existing `.tex` file to understand structure
- [ ] Check for existing labels: `grep "\\label{" file.tex`
- [ ] Check for duplicate sections: `grep "\\subsection{" file.tex | sort | uniq -d`
- [ ] Identify which sections already exist

### 2. Multi-Agent Coordination
If other agents have worked on this document:
- [ ] Search for duplicate content (copy-paste remnants)
- [ ] Check executive summary is synchronized with main body
- [ ] Verify color palette consistency across all charts
- [ ] Ensure table/figure numbering is sequential

### 3. Template Verification
- [ ] Confirm preamble includes: `\captionsetup{justification=centering, font=normalsize, labelfont=bf}`
- [ ] Confirm preamble includes: `/pgfplots/ybar legend/.style={area legend}`
- [ ] Confirm color definitions use neutral names (`brandblue`, not `msblue`)

---

## 📊 PRIORITY 2: CONTENT GENERATION PATTERNS

### Decision Tree: When to Use What

```
Is this a MAJOR TOPIC spanning multiple pages?
├─ YES → Use \section{Title}
│
└─ NO → Is this a SUBTOPIC with multiple paragraphs?
    ├─ YES → Use \subsection{Title}
    │
    └─ NO → Use \textbf{word} for inline emphasis
```

### Table Generation Workflow

**MANDATORY TEMPLATE (memorize this):**
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
\par\vspace{0.1cm}  % NOTE: \par is REQUIRED to force source below table
{\tiny Source: Your Source Here}
\end{table}
```

**Key Points:**
1. `max width=\textwidth` → Scales DOWN if needed, never UP (prevents font chaos)
2. `\tablefont` → Sets consistent `\footnotesize` for all tables
3. `\par\vspace{0.1cm}` → Forces source text below (not beside) narrow tables
4. Column widths as fractions of `\linewidth` → Sum to ≈0.9-1.0

### Chart Generation Workflow

**Step 1: Choose Chart Width Based on Data Point Count**
| Data Points | Width | Bar Width | Spacing |
|-------------|-------|-----------|---------|
| 2-3 | `8-10cm` | `25pt` | `enlarge x limits={abs=1cm}` |
| 4-5 | `10-12cm` | `20pt` | `enlarge x limits=0.15` |
| 6-8 | `12-14cm` | `15pt` | Auto |
| 9+ | `0.95\textwidth` | `12-15pt` | Auto |

**Step 2: Use Complete Chart Template**
```latex
\begin{center}
\captionsetup{justification=centering}  % REQUIRED when inside \begin{center}
\captionof{figure}{Chart Title}
\begin{tikzpicture}
\begin{axis}[
    ybar,
    height=6cm,
    width=10cm,  % From table above
    bar width=20pt,  % From table above
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
    grid style={dotted, gray},
    axis y line*=left,
    axis x line*=bottom
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
\end{center}
```

**Font Size Rule (memorize):** **EVERYTHING** in charts uses `\footnotesize` except sources (use `\tiny`). **NEVER** use `\tiny` for data labels or axis labels.

---

## 🔍 PRIORITY 3: VALIDATION & ERROR PREVENTION

### Pre-Compilation Checklist

Run these commands **BEFORE** compiling:

```bash
# 1. Check for illegal captionof usage
grep "\\captionof" file.tex
# Expected: Only inside multicols or with preceding \captionsetup{justification=centering}

# 2. Find duplicate labels (CRITICAL)
grep "\\label{" file.tex | sort | uniq -d
# Expected: Empty output (no duplicates)

# 3. Find duplicate subsections
grep "\\subsection{" file.tex | sort | uniq -d
# Expected: Empty output

# 4. Check for unescaped special characters in text
grep -P '(?<!\\)[\$%&]' file.tex | grep -v "\\begin{tabular}" | grep -v "\\end{tabular}"
# Expected: Minimal output (only in tables/math mode)

# 5. Check for blank lines in chart option blocks
grep -A 20 "\\begin{axis}\[" file.tex | grep -B 5 "^\s*$" | grep -A 5 "^\s*$"
# Expected: No blank lines between \begin{axis}[ and the closing ]

# 6. Verify table font consistency
grep "adjustbox.*width=" file.tex
# Expected: All should say "max width=" NOT "width="
```

### Common Compilation Errors & Fixes

| Error Message | Root Cause | Fix |
|---------------|------------|-----|
| `Misplaced alignment tab character &` | Unescaped `&` in text | Change to `\&` |
| `Runaway argument` | Blank line inside `[...]` block | Remove blank line |
| `Missing $ inserted` | Unescaped `$` or `%` | Change to `\$` or `\%` |
| `Undefined colormap` | Colormap not defined | Use built-in: `viridis`, `hot`, `bluered` |
| `Package pgfplots Error` | Syntax error in coordinates | Check for unescaped `%` in labels |

### Post-Compilation Visual Checks

After PDF generation:
- [ ] All tables have similar font sizes (if one is much larger/smaller, check `adjustbox`)
- [ ] All chart data labels are readable at 100% zoom
- [ ] All captions are centered
- [ ] Source citations appear **below** tables/charts, not beside them
- [ ] No chart legends overlap data
- [ ] No text overflows page margins

---

## 🔄 PRIORITY 4: MULTI-AGENT WORKFLOWS

### Executive Summary Synchronization

**CRITICAL RULE:** Executive summary is written **LAST**, after all main sections are complete.

**Process:**
1. Complete all main body sections first
2. Extract actual data points from completed content
3. Use grep to find inconsistencies:
   ```bash
   grep -E "(yield|timeline|cost|\$[0-9]+)" file.tex
   ```
4. Identify most accurate/detailed version of each claim
5. Rewrite executive summary to match main body
6. Verify consistency with another grep pass

**Common Drift Patterns:**
- Exec summary: "~10% yield" → Main body: "10% test wafers, 60-65% production"
- Exec summary: "mid-2027" → Main body: "H2 2027" or "Q4 2027"
- Exec summary: "$13B loss" → Main body: "$13.0B operating loss"

**Fix:** Add context and precision from detailed sections.

### Label Coordination

**BEFORE creating new labels:**
```bash
# Check existing table labels
grep "\\label{tab:" file.tex

# Check existing figure labels
grep "\\label{fig:" file.tex
```

**Naming Convention:**
- ✅ `tab:apple_intel_roadmap` (descriptive, hierarchical)
- ✅ `fig:ifs_breakeven_analysis` (clear content indicator)
- ❌ `tab:table1` (meaningless, breaks when reordered)
- ❌ `fig:chart` (too vague)

### Preventing Duplicate Content

**When reorganizing sections:**
1. Add temporary comment markers:
   ```latex
   \subsection{Topic}  % MOVED FROM Section 2 → Section 3
   Content here...
   
   % OLD VERSION BELOW - DELETE BEFORE FINAL
   % \subsection{Topic}
   ```

2. Run duplicate detection:
   ```bash
   grep "\\subsection{" file.tex | sort | uniq -d
   ```

3. Check TOC for duplicate numbering (open `.toc` file)

---

## 🎨 PRIORITY 5: STYLE CONSISTENCY

### Color Palette (Approved)

```latex
\definecolor{brandblue}{HTML}{003366}
\definecolor{brandaccent}{HTML}{008EC7}
\definecolor{lightgrey}{HTML}{F3F3F3}
\definecolor{textgrey}{HTML}{6A6A6A}
\definecolor{tableheader}{HTML}{E6E6E6}
```

**Rule:** **ONLY** use these colors. **NEVER** introduce institutional colors.

### Chart Semantic Styles

Use predefined styles based on chart purpose:

| Chart Type | Style | When to Use |
|------------|-------|-------------|
| Single-series bars | `msstyle` | Most common (many bars) |
| Few-bar charts | `compactchart` | 2-3 bars only |
| Company comparisons | `comparestyle` | Competitor analysis |
| Good→Bad spectrum | `divergingstyle` | Sensitivity, risk assessment |

**Rule:** **NEVER** hardcode `fill=color` in chart bodies. Use semantic styles.

### Paragraph Spacing

```latex
✅ CORRECT:
\subsection{Title}
First paragraph here.

Second paragraph here.

✅ CORRECT (spacing around tables/charts):
\vspace{0.3cm}
[table/chart]
\vspace{0.3cm}

❌ WRONG:
\subsection{Title}
First paragraph.
\vspace{0.3cm}  ← REMOVE: Never between normal paragraphs
Second paragraph.
```

**Rule:** One blank line between paragraphs. `\vspace{}` only around tables/charts/sections.

---

## 📝 PRIORITY 6: DOCUMENT STRUCTURE

### Correct Ordering

```latex
1. Title page + legal disclaimers
2. Executive Summary (multicols)
3. Table of Contents (own page, unboxed)
4. Main body sections (each \section starts new page)
```

### Executive Summary Pattern

```latex
\begin{multicols}{2}
    % Rating boxes
    % Key points (itemize)
    % Brief narrative
\end{multicols}

% If wide tables needed:
\end{multicols}
\vspace{0.5cm}
[Full-width table using \textwidth fractions]
\vspace{0.5cm}
\begin{multicols}{2}
    % Resume narrative
\end{multicols}
```

**Rule:** Inside `multicols`, size tables using `\columnwidth`. For wide tables, close `multicols`, insert table, reopen `multicols`.

### Table of Contents Pattern

```latex
\newpage
\begin{tcolorbox}[
    colback=msgrey,
    colframe=msgrey,
    boxrule=0pt,
    sharp corners,
    left=10pt, right=10pt, top=10pt, bottom=10pt
]
    {\color{brandblue}\Large\bfseries Table of Contents}
\end{tcolorbox}
\vspace{0.3cm}

\renewcommand{\contentsname}{}
\setcounter{tocdepth}{2}
\tableofcontents  % MUST be unboxed for page breaks

\newpage
```

**Rule:** **NEVER** wrap `\tableofcontents` in a box. Only the header can be boxed.

---

## 🧪 PRIORITY 7: TESTING & ITERATION

### Compilation Discipline

1. **First compile:** Check for errors
2. **Fix errors:** Use error patterns from Priority 3
3. **Second compile:** Resolve references (TOC, labels)
4. **Visual check:** Use post-compilation checklist from Priority 3
5. **If changes made:** Repeat from step 1

### Regression Prevention Checklist

Before finalizing any document:

- [ ] Executive summary matches main body (no drift)
- [ ] All tables have similar font sizes
- [ ] All charts use `\footnotesize` for labels
- [ ] All captions are centered
- [ ] No duplicate subsection titles in TOC
- [ ] All labels are unique (`grep | uniq -d` returns nothing)
- [ ] No unescaped special characters outside tables
- [ ] Source citations appear below tables/charts
- [ ] Wide tables in exec summary use `\textwidth` fractions
- [ ] TOC is unboxed and can break across pages
- [ ] Legal disclaimers are present and unmodified

---

## 📚 REFERENCE: QUICK DECISION MATRICES

### "My table looks wrong" Diagnostic

| Symptom | Cause | Fix |
|---------|-------|-----|
| Font too large | `width=\textwidth` on narrow table | Change to `max width=\textwidth` |
| Font too small | `width=\textwidth` on wide table | Already using `max width=`? Add `\scriptsize` before adjustbox |
| Source beside table | Missing `\par` before `\vspace` | Change to `\par\vspace{0.1cm}` |
| Missing `\tablefont` | Table uses default font | Add `\tablefont` before adjustbox |
| Caption not centered | Missing global config | Add `\captionsetup{justification=centering}` in preamble |

### "My chart looks wrong" Diagnostic

| Symptom | Cause | Fix |
|---------|-------|-----|
| Bars too wide | Using percentage width with few bars | Use fixed width from table (Priority 2) |
| Labels unreadable | Using `\tiny` for data labels | Change all to `\footnotesize` |
| Legend overlaps data | No legend position set | Add `legend style={at={(0.5,-0.15)}, anchor=north, ...}` |
| Source disconnected | Note outside tikzpicture | Move inside using `after end axis/.append code` |
| Multiple legend entries | Multiple `\addplot` for colored bars | Add `forget plot` to all but first |
| Chart compilation fails | Blank line in `[...]` block | Remove all blank lines in axis options |

### "Compilation failed" Diagnostic

| Error Keyword | Most Likely Cause | First Check |
|---------------|-------------------|-------------|
| `alignment tab` | Unescaped `&` | Search for `&` outside tables, change to `\&` |
| `Runaway argument` | Blank line in options | Remove blank lines in `\addplot[...]` or `\begin{axis}[...]` |
| `Missing $` | Unescaped `$` or `%` | Search for `$` or `%` in text, escape them |
| `Undefined control` | Typo or missing package | Check command spelling, verify package loaded |
| `colormap` | Custom colormap not defined | Use built-in: `viridis`, `hot`, `bluered` |

---

## 🎓 LEARNING PRINCIPLES FOR LLMs

### Pattern Recognition Over Memorization

Instead of memorizing 2000 lines of rules, internalize these patterns:

1. **Table pattern:** `\begin{table}[H]` + `\centering` + `\caption{}` + `\label{}` + `\tablefont` + `\begin{adjustbox}{max width=...}` + content + `\par\vspace{0.1cm}` + source

2. **Chart pattern:** Count data points → Choose width → Set all fonts to `\footnotesize` → Position note inside tikzpicture

3. **Error pattern:** Compilation fails → Check special characters first → Then check blank lines → Then check typos

4. **Multi-agent pattern:** Read existing content → Check for duplicates → Coordinate labels → Synchronize exec summary last

### Decision Heuristics

When uncertain:
- **Tables:** Use the mandatory template (Priority 2)
- **Charts:** Use the complete template (Priority 2)
- **Spacing:** One blank line between paragraphs, `\vspace{}` only around floats
- **Colors:** Use approved palette only (Priority 5)
- **Structure:** Section → Subsection → Paragraph (never deeper)

### Verification Strategy

After generating content:
1. Run all validation commands (Priority 3)
2. Compile and check for errors
3. Visual check against post-compilation list
4. If anything looks wrong, consult diagnostic matrices (Priority 7 reference)

---

## 📖 FULL REFERENCE

This document is a **workflow-optimized** distillation of:
- [LATEX_STYLE_GUIDE.md](../docs/latex/LATEX_STYLE_GUIDE.md) - Complete technical reference
- [LATEX_CHECKLIST.md](../docs/latex/LATEX_CHECKLIST.md) - Pre-compilation validation
- [LATEX_COMPILATION_DETAILS.md](../docs/latex/LATEX_COMPILATION_DETAILS.md) - Error debugging

**When to consult the full style guide:**
- Uncommon patterns (3D charts, heatmaps, custom colormaps)
- Historical context (why a rule exists)
- Advanced customization (beyond standard templates)
- Legal/licensing details

**Use this workflow guide for:**
- Daily LaTeX generation tasks
- Quick reference during editing
- Multi-agent coordination
- Error troubleshooting

---

## ✅ FINAL CHECKLIST: Am I Ready to Generate LaTeX?

Before starting any LaTeX generation task, answer these:

- [ ] I have read existing `.tex` file to understand context
- [ ] I have checked for existing labels to avoid duplicates
- [ ] I know which sections already exist
- [ ] I have the approved color palette loaded
- [ ] I have the mandatory table template ready
- [ ] I have the complete chart template ready
- [ ] I know the validation commands to run
- [ ] I will write exec summary LAST (after main body)
- [ ] I will escape all special characters (`& $ % _`)
- [ ] I will use `max width=`, never `width=`
- [ ] I will use `\footnotesize` for all chart elements
- [ ] I will position chart notes inside tikzpicture

**If all checked:** Proceed with confidence.

**If any unchecked:** Review the relevant Priority section above.

---

*Last updated: 2026-01-18*
*Optimized for: LLM agents (GPT-4, Claude, etc.)*
*Based on: 150+ hours of debugging real LaTeX documents*
