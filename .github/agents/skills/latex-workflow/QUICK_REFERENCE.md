# Quick Reference Card: LaTeX Workflow

## Critical Rules (Never Violate)

### ❌ Forbidden
```latex
\captionof{table}{Title}        # Use \begin{table}[H] instead
\captionof{figure}{Title}        # Use \begin{figure}[H] instead
\definecolor{msblue}{...}        # Use brandblue instead
width=\textwidth                 # Use max width=\textwidth
&  $  %  _                       # Must escape as \&  \$  \%  \_
\usepackage{colortbl}           # Causes conflicts
```

### ✅ Required
```latex
\begin{table}[H]                 # All tables must use this
\begin{figure}[H]                # All figures must use this
\caption{Title}                  # Required for auto-numbering
\label{tab:name}                 # Required for cross-reference
Legal disclaimer box             # On front cover
Diagonal watermark               # On all pages
Footer disclaimer                # On all pages
```

## Brand Colors

```latex
\definecolor{brandblue}{HTML}{003366}
\definecolor{brandaccent}{HTML}{008EC7}
\definecolor{lightgrey}{HTML}{F3F3F3}
\definecolor{textgrey}{HTML}{6A6A6A}
\definecolor{tableheader}{HTML}{E6E6E6}
```

## Table Template

```latex
\begin{table}[H]
\centering
\caption{Descriptive Title}
\label{tab:unique_name}
\rowcolors{2}{msgrey}{white}
\tablefont
\begin{adjustbox}{max width=\textwidth}
\begin{tabular}{lrr}
\toprule
\textbf{Header 1} & \textbf{Header 2} & \textbf{Header 3} \\
\midrule
Data 1 & Data 2 & Data 3 \\
\bottomrule
\end{tabular}
\end{adjustbox}
\par\vspace{0.1cm}
{\tiny Source: Provider}
\end{table}
```

## Figure Template

```latex
\begin{figure}[H]
\centering
\caption{Chart Title}
\label{fig:unique_name}
\begin{tikzpicture}
\begin{axis}[msstyle, width=10cm]
\addplot[fill=brandblue] coordinates {(A,10) (B,20)};
\legend{Series Name}
\end{axis}
\end{tikzpicture}
\end{figure}
```

## Validation Commands

```bash
# Pre-Compilation Checks
grep -n "\\captionof{" file.tex              # Should return empty
grep "\\label{" file.tex | sort | uniq -d   # Should return empty
grep -nE "[^\\](&|\$|%)" file.tex            # Check unescaped chars

# Legal Compliance
grep "EDUCATIONAL CASE STUDY" file.tex       # Should find 2+ instances
grep "watermarktext" file.tex                # Should find 1 instance

# Package Validation
grep "\\usepackage{colortbl}" file.tex       # Should return empty
grep -E "definecolor\{(ms|gs)" file.tex      # Should return empty
```

## Compilation

```bash
# Standard two-pass compilation
pdflatex -interaction=nonstopmode document.tex
pdflatex -interaction=nonstopmode document.tex

# With error logging
pdflatex -interaction=nonstopmode document.tex 2>&1 | tee compile.log
```

## Common Errors

| Error | Cause | Fix |
|-------|-------|-----|
| `Misplaced alignment tab &` | Unescaped & | Change to `\&` |
| `Missing $ inserted` | Unescaped $ or % | Escape as `\$` or `\%` |
| `Undefined control sequence` | Typo or missing package | Check spelling |
| `Runaway argument` | Blank line in [...] | Remove blank line |

## Font Sizes

```latex
% Tables
\tablefont                       # Use for all tables (footnotesize)

% Charts
xticklabel style={font=\footnotesize}
nodes near coords style={font=\footnotesize}
legend style={font=\footnotesize}

% Sources
{\tiny Source: ...}              # Only for source citations
```

## Document Structure

```latex
\documentclass[10pt, a4paper]{article}

% Preamble with packages and colors

\begin{document}

% Title page with legal disclaimer
\reporttitle{TICKER}{Title}{Subtitle}

\begin{tcolorbox}[...]
EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES
\end{tcolorbox}

% Executive summary
\begin{multicols}{2}
\subsection*{Executive Summary}
...
\end{multicols}

% Table of contents
\newpage
\tableofcontents

% Main content
\newpage
\begin{maincontent}
\section{Introduction}
...
\end{maincontent}

\end{document}
```

## Decision Tree

```
Need to add content?
├─ Multi-page topic? → Use \section{Title}
├─ Multi-paragraph topic? → Use \subsection{Title}
└─ Inline emphasis? → Use \textbf{word}

Need to add data?
├─ Tabular data? → Use table template
├─ Visual chart? → Use figure template
└─ Simple list? → Use itemize/enumerate

Need to reference?
├─ Tables? → \ref{tab:name}
├─ Figures? → \ref{fig:name}
└─ Sections? → \ref{sec:name}
```

## Quality Checklist

Before final compilation:
- [ ] All tables use `\begin{table}[H]`
- [ ] All figures use `\begin{figure}[H]`
- [ ] No `\captionof` anywhere
- [ ] All labels are unique
- [ ] All special chars escaped
- [ ] Legal disclaimer on cover
- [ ] Watermark configured
- [ ] Footer disclaimer present
- [ ] Brand colors only
- [ ] No institutional names

## 7-Phase Workflow

1. **Phase 0:** Pre-flight - Load context
2. **Phase 1:** Preamble - Setup packages/colors
3. **Phase 2:** Structure - Fix headings
4. **Phase 3:** Tables - Convert to floats
5. **Phase 4:** Figures - Standardize charts
6. **Phase 5:** Legal - Add disclaimers
7. **Phase 6:** Validate - Check and compile

## Resources

- `/workflow/LLM_INSTRUCTIONS.md` - Quick guide
- `/docs/process/LLM_WORKFLOW.md` - Detailed workflow
- `/docs/latex/LATEX_STYLE_GUIDE.md` - Complete style guide
- `/templates/template.tex` - Base template
- `/templates/intelapple.tex` - Example document
