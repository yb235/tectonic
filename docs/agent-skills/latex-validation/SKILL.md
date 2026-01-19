---
name: latex-validation
description: Validate LaTeX documents for compliance, common errors, legal requirements, and quality standards before compilation. Use for pre-compilation checks and quality assurance.
usage: |
  - "Check if this LaTeX is compliant"
  - "Validate my document before compiling"
  - "Are there any errors in this .tex file?"
  - "Run compliance checks"
version: 1.0.0
priority: medium
---

# LaTeX Validation Skill

## Overview

This skill provides comprehensive validation of LaTeX documents against the Tectonic project's compliance, quality, and legal standards. It identifies issues before compilation, saving time and preventing cascading errors.

**Core Principle:** Catch errors early, before they propagate.

## When to Use

Trigger this skill when the user:
- Wants to check document quality before compilation
- Asks if a document is "compliant" or "correct"
- Needs to verify legal disclaimer presence
- Reports mysterious compilation issues
- Before finalizing a document for delivery

## Prerequisites

- LaTeX source file (`.tex`) exists
- Bash shell access for running validation commands
- Read access to reference documentation

## Validation Levels

### Level 1: Critical Compliance (Must Pass)
Issues that will cause compilation failure or legal problems

### Level 2: Quality Standards (Should Pass)
Issues that affect document quality but won't break compilation

### Level 3: Best Practices (Nice to Have)
Suggestions for improvement that don't block acceptance

## Execution Steps

### Step 1: File Integrity Check

```bash
# Verify file exists and is readable
test -f document.tex && echo "✅ File exists" || echo "❌ File not found"

# Check file size (should be > 0)
ls -lh document.tex

# Check for binary corruption
file document.tex | grep -q "ASCII text" && echo "✅ Valid text file" || echo "⚠️ Not ASCII text"
```

**Validation:**
- [ ] File exists
- [ ] File size > 0 bytes
- [ ] File is text format (not binary)

---

### Step 2: Critical Compliance Checks (Level 1)

#### Check 2.1: No Forbidden captionof Usage

```bash
grep -n "\\captionof{table}\|\\captionof{figure}" document.tex
```

**Expected:** Empty output (or only inside `multicols` with preceding `\captionsetup{justification=centering}`)

**Why Critical:** Breaks automatic numbering, causes LaTeX errors

**Fix if Failed:**
```latex
% WRONG:
\captionof{table}{Title}

% RIGHT:
\begin{table}[H]
\centering
\caption{Title}
\label{tab:name}
```

#### Check 2.2: No Duplicate Labels

```bash
grep "\\label{" document.tex | sort | uniq -d
```

**Expected:** Empty output

**Why Critical:** Causes "multiply defined label" errors, breaks cross-references

**Fix if Failed:** Rename duplicate labels to unique values

#### Check 2.3: No Forbidden colortbl Package

```bash
grep "usepackage{colortbl}" document.tex
```

**Expected:** Empty output

**Why Critical:** Conflicts with xcolor[table], causes compilation failure

**Fix if Failed:**
```latex
% WRONG:
\usepackage{colortbl}

% RIGHT:
\usepackage[table]{xcolor}
```

#### Check 2.4: No Unescaped Special Characters (Outside Tables)

```bash
grep -P '(?<!\\)[\$%&]' document.tex | grep -v "\\begin{tabular}" | grep -v "\\end{tabular}"
```

**Expected:** Minimal output (only in tables/math mode)

**Why Critical:** Causes "Misplaced alignment tab" and "Missing $" errors

**Fix if Failed:**
```latex
% WRONG:
Cost is $100 & profit is 20%

% RIGHT:
Cost is \$100 \& profit is 20\%
```

#### Check 2.5: No Blank Lines in Axis Options

```bash
grep -A20 "\\begin{axis}\[" document.tex | grep -B3 -A3 "^\s*$"
```

**Expected:** No blank lines inside `\begin{axis}[...]` blocks

**Why Critical:** Causes "Runaway argument" errors

**Fix if Failed:** Remove blank lines from option blocks

**Level 1 Summary:**
- [ ] No captionof usage (or properly configured)
- [ ] No duplicate labels
- [ ] No colortbl package
- [ ] Special characters escaped
- [ ] No blank lines in axis options

---

### Step 3: Legal Compliance Checks (Level 1)

#### Check 3.1: Educational Disclaimer Present

```bash
grep -i "EDUCATIONAL DISCLAIMER\|FICTIONAL CASE STUDY" document.tex
```

**Expected:** Found (at least once)

**Why Critical:** Legal requirement for educational use

**Fix if Failed:** Add disclaimer box on front page

#### Check 3.2: Watermark Present

```bash
grep "SAMPLE: FICTIONAL DATA\|DESIGN CASE STUDY" document.tex
```

**Expected:** Found

**Why Critical:** Visual indication of non-real content

**Fix if Failed:** Add watermark using `eso-pic` package

#### Check 3.3: Footer Disclaimer Present

```bash
grep "EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES" document.tex
```

**Expected:** Found

**Why Critical:** Legal protection on every page

**Fix if Failed:** Configure footer with `fancyhdr`

#### Check 3.4: No Institutional Branding

```bash
grep -i "morgan stanley\|goldman sachs\|jpmorgan\|citigroup" document.tex
```

**Expected:** Empty (or only in citations with disclaimers)

**Why Critical:** Legal/trademark issues

**Fix if Failed:** Replace with neutral terms

#### Check 3.5: No Institutional Color Names

```bash
grep -E "definecolor\{(ms|gs|citi|jp)" document.tex
```

**Expected:** Empty

**Why Critical:** Implies affiliation with real institutions

**Fix if Failed:**
```latex
% WRONG:
\definecolor{msblue}{HTML}{003366}

% RIGHT:
\definecolor{brandblue}{HTML}{003366}
```

**Level 1 Legal Summary:**
- [ ] Educational disclaimer present
- [ ] Watermark configured
- [ ] Footer disclaimer present
- [ ] No institutional names
- [ ] No institutional color names

---

### Step 4: Quality Standard Checks (Level 2)

#### Check 4.1: Table Sizing Consistency

```bash
grep "adjustbox.*width=" document.tex | grep -v "max width"
```

**Expected:** Empty (all should use `max width=\textwidth`)

**Why Important:** Fixed `width=` causes font size inconsistencies

**Fix if Failed:**
```latex
% WRONG:
\begin{adjustbox}{width=\textwidth}

% RIGHT:
\begin{adjustbox}{max width=\textwidth}
```

#### Check 4.2: Chart Font Consistency

```bash
grep -A20 "\\begin{axis}" document.tex | grep "font=\\\\tiny" | grep -v "Source:"
```

**Expected:** Empty (no `\tiny` fonts except for sources)

**Why Important:** Tiny fonts are unreadable; all chart text should be `\footnotesize`

**Fix if Failed:**
```latex
% WRONG:
xticklabel style={font=\tiny}

% RIGHT:
xticklabel style={font=\footnotesize}
```

#### Check 4.3: All Tables Have Labels

```bash
# Count tables
TABLE_COUNT=$(grep "\\begin{table}" document.tex | wc -l)
# Count table labels
LABEL_COUNT=$(grep "\\label{tab:" document.tex | wc -l)

echo "Tables: $TABLE_COUNT, Labels: $LABEL_COUNT"
```

**Expected:** Counts should match

**Why Important:** Unlabeled tables can't be cross-referenced

**Fix if Failed:** Add unique `\label{tab:name}` to each table

#### Check 4.4: All Figures Have Labels

```bash
# Count figures
FIGURE_COUNT=$(grep "\\begin{figure}" document.tex | wc -l)
# Count figure labels
FIG_LABEL_COUNT=$(grep "\\label{fig:" document.tex | wc -l)

echo "Figures: $FIGURE_COUNT, Labels: $FIG_LABEL_COUNT"
```

**Expected:** Counts should match

**Why Important:** Unlabeled figures can't be cross-referenced

**Fix if Failed:** Add unique `\label{fig:name}` to each figure

#### Check 4.5: No Duplicate Subsections

```bash
grep "\\subsection{" document.tex | sort | uniq -d
```

**Expected:** Empty

**Why Important:** Duplicate headings confuse readers and TOC

**Fix if Failed:** Rename or merge duplicate subsections

#### Check 4.6: Table Source Citations Positioned Correctly

```bash
# Check for \par before source citations
grep -B1 "{\tiny Source:" document.tex | grep "\\par"
```

**Expected:** `\par\vspace{0.1cm}` appears before each source citation

**Why Important:** Without `\par`, sources appear beside table instead of below

**Fix if Failed:**
```latex
% WRONG:
\end{adjustbox}
{\tiny Source: Data}

% RIGHT:
\end{adjustbox}
\par\vspace{0.1cm}
{\tiny Source: Data}
```

**Level 2 Quality Summary:**
- [ ] All tables use `max width=`
- [ ] All chart fonts are `\footnotesize` (except sources)
- [ ] All tables have labels
- [ ] All figures have labels
- [ ] No duplicate subsections
- [ ] Table sources positioned with `\par`

---

### Step 5: Best Practice Checks (Level 3)

#### Check 5.1: Reasonable Heading Depth

```bash
grep "\\subsubsection" document.tex | wc -l
```

**Expected:** 0 or very few

**Recommendation:** Keep hierarchy to section → subsection

#### Check 5.2: Consistent Paragraph Spacing

```bash
# Check for excessive \vspace between paragraphs
grep -A1 "^[A-Z]" document.tex | grep "\\vspace"
```

**Expected:** Minimal results

**Recommendation:** Use blank lines between paragraphs, `\vspace` only around floats

#### Check 5.3: Brand Color Usage

```bash
# Check that approved colors are defined
grep "definecolor{brandblue}" document.tex
grep "definecolor{brandaccent}" document.tex
grep "definecolor{lightgrey}" document.tex
grep "definecolor{textgrey}" document.tex
```

**Expected:** All 5 approved colors defined

**Recommendation:** Use semantic color names

#### Check 5.4: TOC Configuration

```bash
# Check TOC depth
grep "tocdepth" document.tex
```

**Expected:** `\setcounter{tocdepth}{2}`

**Recommendation:** Show sections and subsections, hide deeper levels

#### Check 5.5: Caption Centering

```bash
grep "captionsetup" document.tex | grep "justification=centering"
```

**Expected:** Found in preamble

**Recommendation:** All captions should be centered

**Level 3 Best Practices Summary:**
- [ ] Minimal use of deep heading levels
- [ ] Consistent spacing (no excessive \vspace)
- [ ] All brand colors defined
- [ ] TOC depth set to 2
- [ ] Caption centering configured

---

### Step 6: Generate Validation Report

**Create comprehensive report:**

```bash
cat > validation_report.md << 'EOF'
# Validation Report: document.tex

## Date: YYYY-MM-DD HH:MM

## Level 1: Critical Compliance
- [ ] No forbidden captionof: ✅/❌
- [ ] No duplicate labels: ✅/❌
- [ ] No colortbl package: ✅/❌
- [ ] Special characters escaped: ✅/❌
- [ ] No blank lines in axis options: ✅/❌

**Critical Issues Found:** X

## Level 1: Legal Compliance
- [ ] Educational disclaimer: ✅/❌
- [ ] Watermark present: ✅/❌
- [ ] Footer disclaimer: ✅/❌
- [ ] No institutional names: ✅/❌
- [ ] No institutional colors: ✅/❌

**Legal Issues Found:** X

## Level 2: Quality Standards
- [ ] Table sizing (max width): ✅/❌
- [ ] Chart fonts (\footnotesize): ✅/❌
- [ ] All tables labeled: ✅/❌
- [ ] All figures labeled: ✅/❌
- [ ] No duplicate subsections: ✅/❌
- [ ] Source citations positioned: ✅/❌

**Quality Issues Found:** X

## Level 3: Best Practices
- [ ] Reasonable heading depth: ✅/❌
- [ ] Consistent spacing: ✅/❌
- [ ] Brand colors defined: ✅/❌
- [ ] TOC depth configured: ✅/❌
- [ ] Caption centering: ✅/❌

**Best Practice Issues Found:** X

## Overall Assessment

**Total Issues:** XX
- Critical: X
- Legal: X
- Quality: X
- Best Practice: X

**Compliance Status:** 
- ✅ PASS (0 critical, 0 legal issues)
- ⚠️  WARNING (0 critical, 0 legal, but quality issues)
- ❌ FAIL (critical or legal issues present)

**Recommendation:**
[Specific next steps based on findings]

## Detailed Findings

### Critical Issues
[List each critical issue with line numbers and suggested fixes]

### Legal Issues
[List each legal issue with suggested fixes]

### Quality Issues
[List each quality issue with suggested fixes]

### Best Practice Suggestions
[List suggestions for improvement]

EOF
```

---

## Decision Trees

### Validation Priority Decision

```
What's the goal?
├─ About to compile → Run Level 1 checks only (speed)
├─ Quality review → Run Level 1 + Level 2 (thorough)
├─ Final delivery → Run all 3 levels (comprehensive)
└─ Troubleshooting → Run relevant level for specific issue
```

### Fix Priority Decision

```
Issues found?
├─ Level 1 Critical → MUST fix before compiling
├─ Level 1 Legal → MUST fix before delivery
├─ Level 2 Quality → SHOULD fix for professional output
└─ Level 3 Best Practice → NICE to fix, not blocking
```

## Examples

### Example 1: Clean Document

**User Request:** "Check if my document is compliant"

**Agent Actions:**
```bash
# Run all Level 1 checks
# All return empty/pass

# Run Level 2 checks
# All return pass

# Run Level 3 checks
# Minor suggestions only
```

**Agent Response:**
```
✅ Validation PASSED

Critical Issues: 0
Legal Issues: 0
Quality Issues: 0
Best Practice Suggestions: 2

📋 Minor recommendations:
  - Consider reducing use of \subsubsection (found 3)
  - Add \vspace before table on line 245 for consistent spacing

Document is ready for compilation.
```

### Example 2: Multiple Issues

**User Request:** "Why won't this compile?"

**Agent Actions:**
```bash
# Level 1 checks
grep "\\captionof" document.tex
# Output: Lines 45, 67, 89 use \captionof{table}

grep "\\label{" document.tex | sort | uniq -d
# Output: \label{tab:data} appears twice

grep -P '(?<!\\)\$' document.tex
# Output: Lines 123, 145 have unescaped $
```

**Agent Response:**
```
❌ Validation FAILED

Critical Issues: 5
- Lines 45, 67, 89: Using \captionof{table} (breaks numbering)
- Lines 101, 245: Duplicate label \label{tab:data}
- Lines 123, 145: Unescaped $ symbol

Legal Issues: 0
Quality Issues: 3

🔧 Required fixes before compiling:
1. Convert \captionof to \begin{table}[H] + \caption
2. Rename duplicate label (e.g., tab:data_2)
3. Escape $ symbols: \$

See validation_report.md for detailed fixes.
```

### Example 3: Legal Compliance Check

**User Request:** "Is this document legally compliant?"

**Agent Actions:**
```bash
# Level 1 Legal checks
grep "EDUCATIONAL DISCLAIMER" document.tex
# Output: Not found

grep "morgan stanley" -i document.tex
# Output: Found on lines 34, 67, 89

grep "definecolor{msblue}" document.tex
# Output: Found on line 12
```

**Agent Response:**
```
❌ Legal Compliance FAILED

Legal Issues: 3
- Missing educational disclaimer box
- Lines 34, 67, 89: References to "Morgan Stanley"
- Line 12: Institutional color name "msblue"

⚠️ This document cannot be published without fixing legal issues.

Required actions:
1. Add disclaimer box on front page
2. Replace "Morgan Stanley" with neutral terms
3. Rename msblue → brandblue

See latex-conversion skill for systematic fixes.
```

## Automation Script

**Create reusable validation script:**

```bash
cat > scripts/validate_latex.sh << 'EOF'
#!/bin/bash
# LaTeX Validation Script

FILE="$1"
LEVEL="${2:-2}"  # Default to Level 2

if [ ! -f "$FILE" ]; then
    echo "❌ File not found: $FILE"
    exit 1
fi

echo "🔍 Validating: $FILE (Level $LEVEL)"
echo ""

CRITICAL=0
LEGAL=0
QUALITY=0

# Level 1: Critical
echo "=== Level 1: Critical Compliance ==="
if grep -q "\\captionof" "$FILE"; then
    echo "❌ Found captionof usage"
    ((CRITICAL++))
fi

if grep "\\label{" "$FILE" | sort | uniq -d | grep -q .; then
    echo "❌ Found duplicate labels"
    ((CRITICAL++))
fi

# ... (continue for all checks)

echo ""
echo "=== Summary ==="
echo "Critical Issues: $CRITICAL"
echo "Legal Issues: $LEGAL"
echo "Quality Issues: $QUALITY"

if [ $CRITICAL -eq 0 ] && [ $LEGAL -eq 0 ]; then
    echo "✅ Validation PASSED"
    exit 0
else
    echo "❌ Validation FAILED"
    exit 1
fi
EOF

chmod +x scripts/validate_latex.sh
```

**Usage:**
```bash
# Quick check (Level 1 only)
./scripts/validate_latex.sh document.tex 1

# Standard check (Level 1+2)
./scripts/validate_latex.sh document.tex 2

# Comprehensive (All levels)
./scripts/validate_latex.sh document.tex 3
```

## Troubleshooting

### Problem: Too many false positives

**Cause:** Validation rules too strict for specific use case

**Solution:** Review context of each finding; some patterns may be justified

### Problem: Validation passes but compilation fails

**Cause:** Edge cases not covered by validation rules

**Solution:**
1. Run compilation to get actual error
2. Add new validation rule for that pattern
3. Update validation skill

### Problem: Validation takes too long

**Cause:** Large file, complex regex patterns

**Solution:**
1. Run Level 1 only for quick checks
2. Use parallel grep with xargs if available
3. Cache validation results

## Resources

- **Compliance Checklist:** See `resources/compliance-checklist.md` for printable checklist
- **Error Patterns:** See `/docs/latex/LATEX_COMPILATION_DETAILS.md`
- **Style Guide:** See `/docs/latex/LATEX_STYLE_GUIDE.md`

## Related Skills

- **latex-compilation:** Run after validation passes
- **latex-conversion:** Use if validation finds many issues
- **latex-document-creation:** Alternative if starting fresh is easier

## Success Metrics

- [ ] All Level 1 checks run successfully
- [ ] Clear pass/fail status determined
- [ ] Specific line numbers provided for issues
- [ ] Actionable fix suggestions provided
- [ ] Validation report generated
- [ ] Total execution time < 30 seconds

---

*Skill Version: 1.0.0*  
*Last Updated: 2026-01-19*  
*Compatibility: Tectonic LaTeX Project v2.0+*  
*Validation Levels: 3 (Critical, Quality, Best Practice)*
