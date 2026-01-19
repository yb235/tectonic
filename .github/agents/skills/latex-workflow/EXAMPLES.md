# Example Use Cases for LaTeX Workflow Automation Skill

This document provides concrete examples of how to use the LaTeX Workflow Automation skill in various scenarios.

## Use Case 1: Creating a New Financial Case Study Document

**Scenario:** You need to create a new case study analyzing Tesla's battery technology strategy.

**User Request:**
```
Create a new financial case study document analyzing Tesla's 4680 battery cell technology and its competitive implications.
```

**What the Skill Does:**

1. **Phase 0-1: Setup**
   - Creates document with proper preamble
   - Defines brand colors (brandblue, brandaccent, etc.)
   - Sets up legal disclaimers and watermark
   - Configures headers and footers

2. **Phase 2: Structure**
   - Creates title page: "Tesla 4680 Battery Technology"
   - Adds legal disclaimer box
   - Sets up executive summary section (multicols)
   - Creates table of contents placeholder
   - Structures main sections:
     - Introduction
     - Technology Overview
     - Competitive Analysis
     - Financial Implications

3. **Validation**
   - Confirms all packages loaded correctly
   - Verifies brand colors defined
   - Checks legal disclaimers present

**Output:** A compliant LaTeX template ready for content addition.

---

## Use Case 2: Converting Raw LaTeX to Compliant Format

**Scenario:** You have a raw LaTeX file from an external source that needs to be converted to repository standards.

**User Request:**
```
Convert this raw LaTeX file to follow our repository standards and compile it.
```

**What the Skill Does:**

1. **Phase 0: Pre-Flight**
   - Validates source file is readable
   - Scans for existing structure
   - Identifies non-compliant elements

2. **Phase 1: Preamble**
   - Replaces preamble with compliant version
   - Removes forbidden packages (colortbl)
   - Adds compatibility fixes
   - Defines brand colors
   - Sets up watermark and disclaimers

3. **Phase 2: Structure**
   - Converts `\textbf{Title}` → `\subsection{Title}`
   - Removes manual numbering from sections
   - Eliminates `\subsubsection` (too deep)
   - Removes duplicate sections
   - Reorders: title → exec summary → TOC → content

4. **Phase 3: Tables**
   - Finds all instances of `\captionof{table}`
   - Converts to:
     ```latex
     \begin{table}[H]
     \centering
     \caption{...}
     \label{tab:...}
     ```
   - Changes `width=` to `max width=`
   - Adds `\tablefont` if missing
   - Fixes source citations with `\par\vspace{0.1cm}`
   - Generates unique labels

5. **Phase 4: Figures**
   - Converts `\captionof{figure}` to `\begin{figure}[H]`
   - Replaces hardcoded colors with semantic styles
   - Adjusts chart widths based on data points
   - Moves source notes inside tikzpicture
   - Ensures all fonts are `\footnotesize`

6. **Phase 5: Legal**
   - Adds front cover disclaimer box
   - Verifies watermark present
   - Checks footer disclaimer
   - Removes institutional references

7. **Phase 6-7: Validate & Compile**
   - Runs validation script
   - Compiles PDF (two passes)
   - Generates conversion report
   - Calculates quality score

**Output:** Compliant document with quality report and compiled PDF.

---

## Use Case 3: Adding a Comparative Table

**Scenario:** You need to add a table comparing financial metrics across three companies.

**User Request:**
```
Add a table to section 3 comparing revenue, profit margin, and market cap for Apple, Microsoft, and Google.
```

**What the Skill Does:**

1. **Context Gathering**
   - Reads existing document
   - Checks for existing labels: `grep "\\label{tab:" file.tex`
   - Identifies section 3 location

2. **Label Generation**
   - Generates unique label: `tab:company_comparison`
   - Verifies no duplicates exist

3. **Table Creation**
   - Uses mandatory table template:
     ```latex
     \begin{table}[H]
     \centering
     \caption{Company Financial Comparison}
     \label{tab:company_comparison}
     \rowcolors{2}{msgrey}{white}
     \tablefont
     \begin{adjustbox}{max width=\textwidth}
     \begin{tabular}{p{0.25\linewidth}p{0.25\linewidth}p{0.25\linewidth}p{0.25\linewidth}}
     \toprule
     \textbf{Company} & \textbf{Revenue (B)} & \textbf{Profit Margin} & \textbf{Market Cap (B)} \\
     \midrule
     Apple & \$394.3 & 25.3\% & \$2,800 \\
     Microsoft & \$211.9 & 36.7\% & \$2,500 \\
     Google & \$307.4 & 26.9\% & \$1,700 \\
     \bottomrule
     \end{tabular}
     \end{adjustbox}
     \par\vspace{0.1cm}
     {\tiny Source: Company filings, Q4 2023}
     \end{table}
     ```

4. **Validation**
   - Confirms `max width` used (not `width`)
   - Verifies `\par\vspace{0.1cm}` before source
   - Checks label uniqueness
   - Ensures proper float environment

**Output:** Compliant table inserted at correct location.

---

## Use Case 4: Adding a Chart/Figure

**Scenario:** You need to add a bar chart showing market share trends.

**User Request:**
```
Create a bar chart in section 4 showing smartphone market share for 2021-2024 for top 5 vendors.
```

**What the Skill Does:**

1. **Chart Sizing Decision**
   - Data points: 5 vendors × 4 years = 20 bars
   - Decision: Use `width=0.95\textwidth` (9+ data points)
   - Bar width: `12-15pt`

2. **Figure Creation**
   - Uses complete chart template:
     ```latex
     \begin{figure}[H]
     \centering
     \caption{Smartphone Market Share Trends (2021-2024)}
     \label{fig:market_share_trends}
     \begin{tikzpicture}
     \begin{axis}[
         ybar,
         height=6cm,
         width=0.95\textwidth,
         bar width=12pt,
         symbolic x coords={2021,2022,2023,2024},
         xtick=data,
         xticklabel style={font=\footnotesize},
         yticklabel style={font=\footnotesize},
         ylabel={Market Share (\%)},
         ylabel style={font=\footnotesize},
         nodes near coords,
         nodes near coords style={font=\footnotesize, font=\bfseries, color=white},
         legend style={at={(0.5,-0.15)}, anchor=north, legend columns=-1, draw=none, font=\footnotesize},
         ymajorgrids=true,
         grid style={dotted, gray}
     ]
     \addplot[fill=brandblue] coordinates {(2021,18) (2022,20) (2023,22) (2024,23)};
     \addplot[fill=brandaccent] coordinates {(2021,16) (2022,17) (2023,18) (2024,19)};
     % Additional series...
     \legend{Apple, Samsung, Xiaomi, OPPO, Vivo}
     \end{axis}
     \pgfplotsset{
         after end axis/.append code={
             \node[anchor=north, font=\tiny, text width=0.95\textwidth, align=center] 
             at (current axis.south) [yshift=-1.5cm] {
                 Source: IDC Quarterly Mobile Phone Tracker, 2024
             };
         }
     }
     \end{tikzpicture}
     \end{figure}
     ```

3. **Style Selection**
   - Uses `msstyle` (or defines custom for multi-series)
   - All fonts set to `\footnotesize`
   - Source note positioned inside tikzpicture

4. **Validation**
   - Confirms no hardcoded colors (using brandblue/brandaccent)
   - Verifies all font sizes are `\footnotesize`
   - Checks source note positioning

**Output:** Professional chart with compliant styling.

---

## Use Case 5: Validating an Existing Document

**Scenario:** You want to check if a document follows all repository standards.

**User Request:**
```
Validate this LaTeX document and tell me what needs to be fixed.
```

**What the Skill Does:**

1. **Runs Validation Script**
   ```bash
   ./validate.sh document.tex
   ```

2. **Checks Each Phase:**
   - **Preamble:** No colortbl, neutral color names
   - **Structure:** No pseudo-headings, no excessive nesting
   - **Tables:** All use float environments, no `\captionof`
   - **Figures:** All use float environments, no hardcoded colors
   - **Legal:** Disclaimers present, watermark configured
   - **Special Chars:** All properly escaped

3. **Reports Issues**
   ```
   ❌ CRITICAL: 3 illegal \captionof{table} found
   Line 145: \captionof{table}{Revenue Data}
   Line 289: \captionof{table}{Market Share}
   Line 456: \captionof{table}{Financial Metrics}
   
   ❌ CRITICAL: 2 tables using 'width=' instead of 'max width='
   Line 150: \begin{adjustbox}{width=\textwidth}
   Line 294: \begin{adjustbox}{width=\textwidth}
   
   ⚠️  WARNING: 1 pseudo-headings found
   Line 78: \textbf{Market Analysis}
   ```

4. **Provides Fixes**
   - Specific line numbers
   - Clear instructions for each issue
   - Priority order (critical before warnings)

**Output:** Detailed validation report with actionable fixes.

---

## Use Case 6: Compiling and Troubleshooting

**Scenario:** Document won't compile and you need to diagnose the issue.

**User Request:**
```
This document won't compile. Help me figure out what's wrong.
```

**What the Skill Does:**

1. **Attempts Compilation**
   ```bash
   pdflatex -interaction=nonstopmode document.tex 2>&1 | tee compile.log
   ```

2. **Analyzes Error Log**
   - Finds first error: `! Misplaced alignment tab character &`
   - Identifies line number: 234
   - Examines context around line 234

3. **Diagnoses Issue**
   ```
   Line 234: "Apple & Microsoft announced..."
   
   Problem: Unescaped & in text (outside table)
   Fix: Change to "Apple \& Microsoft announced..."
   ```

4. **Applies Fix and Recompiles**
   - Makes the change
   - Runs compilation again
   - Checks for additional errors

5. **Reports Result**
   ```
   ✅ Compilation successful
   ⚠️  3 overfull hbox warnings (acceptable)
   📄 PDF generated: document.pdf (24 pages)
   ```

**Output:** Compiled PDF with error resolution summary.

---

## Use Case 7: Ensuring Legal Compliance

**Scenario:** You need to verify all legal disclaimers are present and correct.

**User Request:**
```
Check if this document has all required legal disclaimers.
```

**What the Skill Does:**

1. **Front Cover Check**
   - Searches for disclaimer box
   - Verifies all 4 enumerated points present:
     1. NOT FINANCIAL ADVICE
     2. FICTIONAL DATA
     3. ATTRIBUTION & DESIGN
     4. NO LIABILITY

2. **Watermark Check**
   - Confirms `\AddToShipoutPictureBG` exists
   - Verifies watermark text defined
   - Checks opacity and positioning

3. **Footer Check**
   - Confirms `\cfoot` contains "EDUCATIONAL CASE STUDY"
   - Verifies text appears on all pages

4. **Branding Check**
   - Scans for institutional references
   - Confirms headers use "James Bian Research"
   - Verifies no institutional color names

5. **Reports Status**
   ```
   ✅ Front cover disclaimer box: PRESENT
   ✅ Diagonal watermark: CONFIGURED
   ✅ Footer disclaimer: PRESENT
   ✅ Branding compliance: VERIFIED
   
   Legal Compliance: PASSED
   ```

**Output:** Comprehensive legal compliance report.

---

## Use Case 8: Multi-Agent Coordination

**Scenario:** Multiple agents have worked on the document and you need to synchronize everything.

**User Request:**
```
Clean up this document that multiple people have edited. Fix any duplicates or inconsistencies.
```

**What the Skill Does:**

1. **Duplicate Detection**
   ```bash
   # Find duplicate sections
   grep "\\subsection{" file.tex | sort | uniq -d
   
   # Find duplicate labels
   grep "\\label{" file.tex | cut -d'{' -f2 | cut -d'}' -f1 | sort | uniq -d
   ```

2. **Executive Summary Sync**
   - Extracts claims from executive summary
   - Searches main body for detailed versions
   - Identifies discrepancies:
     ```
     Exec: "~10% yield"
     Main: "10% test wafers, 60-65% production"
     → Update exec to add context
     ```

3. **Color Palette Check**
   - Extracts all color usage from charts
   - Verifies all use approved brand colors
   - Replaces any inconsistent colors

4. **Numbering Verification**
   - Checks table/figure numbering is sequential
   - Identifies any gaps or duplicates
   - Regenerates numbering if needed

5. **Content Deduplication**
   - Finds repeated paragraphs
   - Identifies section relocations
   - Removes or consolidates duplicates

**Output:** Clean, consistent document with sync report.

---

## Best Practices from Examples

### Always:
- ✅ Run validation before compilation
- ✅ Generate unique labels for all tables/figures
- ✅ Use brand colors consistently
- ✅ Include source citations
- ✅ Verify legal disclaimers present

### Never:
- ❌ Use `\captionof` for tables/figures
- ❌ Hardcode colors in charts
- ❌ Use institutional color names
- ❌ Forget to escape special characters
- ❌ Use `width=` instead of `max width=`

### When in Doubt:
- 📖 Consult LATEX_STYLE_GUIDE.md
- 📋 Run validation script
- 🔍 Compare with template.tex
- ✔️ Check against LATEX_CHECKLIST.md
