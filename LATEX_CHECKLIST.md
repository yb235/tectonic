# LaTeX Pre-Compilation Checklist

Use this checklist before finalizing any Morgan Stanley research document to ensure consistency and professionalism.

## 📋 Document Structure

### ☐ Heading Hierarchy
- [ ] All major topics use `\section{}` (not `\textbf{}`)
- [ ] All subtopics use `\subsection{}` (not `\textbf{}`)
- [ ] No standalone `\textbf{Title}` acting as headings
- [ ] No numbered headings like `\textbf{1. Topic}` - use auto-numbered `\subsection{}`
- [ ] Maximum depth is `\subsection{}` (no `\subsubsection{}`)

**Quick test:** Search for `\textbf{` followed by line break - these should be `\subsection{}`

```bash
# Find potential pseudo-headings
grep -n "^\\\\textbf{" yourfile.tex
```

### ☐ Duplicate Content
- [ ] No duplicate `\section{}` titles
- [ ] No duplicate `\subsection{}` titles
- [ ] Check TOC (.toc file) for duplicate section numbers

**Quick test:** Find duplicate subsections

```bash
# Check for duplicate subsection titles
grep "\\subsection{" yourfile.tex | sort | uniq -d
```

### ☐ Executive Summary Placement
- [ ] Executive summary appears BEFORE table of contents
- [ ] TOC is NOT wrapped in a `tcolorbox` that prevents page breaks
- [ ] TOC uses `\tableofcontents` directly (not `\@starttoc`)

---

## 📝 Paragraph Styling

### ☐ Spacing Between Paragraphs
- [ ] ONE blank line between normal paragraphs
- [ ] NO blank lines within the same paragraph
- [ ] NO `\vspace{}` between regular paragraphs

### ☐ Spacing Around Sections
- [ ] Natural spacing after `\section{}` and `\subsection{}` (no manual `\vspace{}`)
- [ ] `\vspace{0.5cm}` ONLY used before/after major visual elements (tables, charts)
- [ ] Consistent pattern throughout document

**Pattern check:**
```latex
% ✅ CORRECT
\subsection{Title}
First paragraph.

Second paragraph.

% ❌ WRONG
\subsection{Title}
\vspace{0.3cm}  ← Remove this
First paragraph.
\vspace{0.2cm}  ← Remove this
Second paragraph.
```

---

## 📊 Tables

### ☐ Font Sizing
- [ ] All tables have `\tablefont` before `\begin{adjustbox}`
- [ ] Using `max width=\textwidth` (NOT `width=\textwidth`)
- [ ] Column widths use fractions summing to ≤1.0 of `\textwidth` or `\linewidth`

### ☐ Source Citations
- [ ] All table sources use `\par\vspace{0.1cm}` before source text
- [ ] Source text uses `{\tiny Source: ...}` format
- [ ] Source appears BELOW table, not beside it

**Template check:**
```latex
\begin{table}[H]
\centering
\caption{Table Title}
\tablefont                              % ← REQUIRED
\begin{adjustbox}{max width=\textwidth} % ← max width, not width
\begin{tabular}{...}
...
\end{tabular}
\end{adjustbox}
\par\vspace{0.1cm}                      % ← REQUIRED: \par forces line break
{\tiny Source: Morgan Stanley Research}
\end{table}
```

---

## 📈 Charts

### ☐ Chart Formatting
- [ ] Using semantic styles: `msstyle`, `comparestyle`, `divergingstyle`
- [ ] NO hardcoded colors in chart body (e.g., `fill=blue!50`)
- [ ] Sparse data charts use fixed widths (8-12cm), not percentages
- [ ] All labels use `\footnotesize` (never `\tiny` for data labels)

### ☐ Legend Placement
- [ ] Legend positioned below chart: `at={(0.5,-0.15)}, anchor=north`
- [ ] Horizontal layout: `legend columns=-1`
- [ ] No overlapping with chart data

### ☐ Source Notes
- [ ] Notes positioned inside `tikzpicture` using `pgfplotsset` with `after end axis`
- [ ] Font size: `\tiny`
- [ ] Consistent `yshift` for spacing

**Pattern:**
```latex
\pgfplotsset{
    after end axis/.append code={
        \node[anchor=north, font=\tiny, text width=10cm, align=center] 
             at (current axis.south) [yshift=-1.5cm] {
            Source: Morgan Stanley Research.
        };
    }
}
```

---

## 🔤 Special Characters

### ☐ Character Escaping
- [ ] All standalone `&` escaped as `\&` (except in `tabular`, `align`)
- [ ] All `%` escaped as `\%` (except comments)
- [ ] All `$` escaped as `\$` (except math mode)
- [ ] All `#` escaped as `\#` (except macro parameters)

**Quick test:**
```bash
# Find unescaped ampersands (crude check)
grep -n "[^\\]&" yourfile.tex | grep -v "tabular\|midrule\|toprule"
```

---

## 🎨 Visual Consistency

### ☐ Color Usage
- [ ] All blue elements use `msblue` or `msbrightblue`
- [ ] Table headers use `mstableheader`
- [ ] Grey backgrounds use `msgrey`
- [ ] No arbitrary RGB colors

### ☐ Font Consistency
- [ ] Section headings use preamble-defined sizes (no manual `\Large`)
- [ ] Body text uses default font (no random `\small` or `\large`)
- [ ] Table text uses `\tablefont` (footnotesize)
- [ ] Chart labels use `\footnotesize`

---

## 🔍 Final Validation

### ☐ Compilation Test
- [ ] Document compiles without errors
- [ ] No "Overfull hbox" warnings for tables/charts
- [ ] No missing references or labels
- [ ] PDF page count reasonable (15-25 pages typical for research notes)

### ☐ TOC Review
- [ ] TOC shows clear hierarchy (numbered sections)
- [ ] No duplicate entries
- [ ] No more than 2 levels deep (section + subsection)
- [ ] All entries match actual document headings

### ☐ Visual Scan
- [ ] Consistent heading sizes throughout
- [ ] No "orphan" single-line paragraphs at page tops
- [ ] Tables fit within margins
- [ ] Charts have readable labels
- [ ] Spacing feels uniform (no random gaps)

---

## 🚀 Quick Fix Commands

### Find Pseudo-Headings
```bash
# Find \textbf{} that might be headings
grep -n "^\\\\textbf{" intelapple.tex
```

### Find Duplicate Sections
```bash
# Check for duplicate subsection titles
grep "\\subsection{" intelapple.tex | sort | uniq -c | grep -v "^ *1 "
```

### Check Table Font Usage
```bash
# Find tables without \tablefont
grep -B 5 "begin{adjustbox}" intelapple.tex | grep -L "tablefont"
```

### Find Manual \vspace in Text
```bash
# Find \vspace that might be unnecessary
grep -n "\\vspace{" intelapple.tex | grep -v "% Keep\|% Required"
```

### Verify Source Positioning
```bash
# Find tables missing \par before source
grep -A 2 "end{adjustbox}" intelapple.tex | grep "vspace" | grep -v "par"
```

---

## 📚 Reference

- **Style Guide:** [LATEX_STYLE_GUIDE.md](LATEX_STYLE_GUIDE.md)
- **Hierarchy Rules:** See Style Guide Section 0.1
- **Table Standards:** See Style Guide Section 1
- **Chart Standards:** See Style Guide Section 3

---

## ✅ Sign-Off

Before submitting document:

- [ ] All checklist items reviewed
- [ ] Style guide referenced for unclear cases
- [ ] PDF reviewed for professional appearance
- [ ] File saved and committed

**Checked by:** ________________  
**Date:** ________________  
**Document:** ________________
