# LaTeX Compilation & Diagnostic Methodology

This document outlines the specific tools, engines, and workflows used by the AI assistant to compile and debug LaTeX documents in this environment, specifically referring to the fixes applied to `intelapple.tex`.

## 1. The Compilation Engines

### Initial Attempt: Tectonic
The workspace name suggested the use of **Tectonic**, a modern LaTeX engine that automates package management. Usually, this is the preferred method for this repository.
*   **Command:** `tectonic intelapple.tex`
*   **Result:** Command not found in the current system path.

### Secondary Attempt: PDFLaTeX (Success)
As a fallback, I utilized **pdfTeX**, the standard engine for producing PDF files from LaTeX source. This is provided by your **MiKTeX** installation.
*   **Command:** `pdflatex -interaction=nonstopmode intelapple.tex`
*   **Location:** Installed in your user profile: 
    `C:\Users\i_am_\AppData\Local\Programs\MiKTeX\bin\x64\pdflatex.exe` (mapped via system environment variables).

## 2. Why Command Line (CLI) over Extensions?

While VS Code extensions like *LaTeX Workshop* are installed, I performed the compilation via terminal commands for three strategic reasons:

1.  **Direct Log Access:** Extensions often hide the raw `.log` output. By running manually, I could immediately read `intelapple.log` to find the "Deep Root Reason" for chart failures (e.g., `Missing \endgroup` or `unmatched environment` errors).
2.  **Interaction Control:** Using the `-interaction=nonstopmode` flag ensures the compiler doesn't pause for user input on every error. Instead, it generates a full log of all issues at once, allowing for a holistic fix.
3.  **Engine Verification:** Manually running commands allows me to verify which specific binaries (Tectonic vs. MiKTeX) are available and responsive in your current environment.

## 3. The Diagnostic Workflow

To identify what was "going wrong with the charts," the following steps were taken:

1.  **Dry Run:** Ran `pdflatex` to generate a fresh `.log` file.
2.  **Log Analysis:** Search for fatal errors using regex patterns to find mismatched nested environments inside the `tikzpicture` blocks.
3.  **Environment Check:** Balanced `\begin` and `\end` statements using terminal-based counting to find unclosed tags.
4.  **Syntax Comparison:** Compared the `pgfplots` code in `intelapple.tex` against established styles in `LATEX_STYLE_GUIDE.md` to spot discrepancies in how series (addplots) were declared.

## 4. Key Configurations Used

The compilation leveraged the following preamble settings already present in your file:
*   **PGFPlots Version:** `\pgfplotsset{compat=1.18}`
*   **Style inheritance:** Use of the `msstyle` and `compactchart` styles defined in the document preamble.
*   **Fixed Layout:** Usage of `adjustbox` and `tabular` (instead of `tabularx`) to prevent column-width math errors during PDF generation.
## 5. Common Syntax Errors: LaTeX vs. Markdown

### CRITICAL: Bold Formatting Syntax Error

**Symptom:** Bold text appears in the PDF with visible `**text**` asterisks instead of rendered bold formatting.

**Root Cause:** Mixing Markdown syntax with LaTeX. This is an extremely common error when content is drafted in Markdown-aware editors or by LLMs trained on Markdown documentation.

**The Error:**
```latex
This is **wrong bold syntax** in LaTeX.
```

**The Fix:**
```latex
This is \textbf{correct bold syntax} in LaTeX.
```

**Why This Happens:**
*   Markdown uses `**text**` for bold formatting
*   LaTeX uses `\textbf{text}` or `{\bfseries text}` for bold
*   LaTeX will literally print `**` characters as they appear—it does not interpret them as formatting commands

**Detection Strategy:**
1.  **Visual Inspection:** If the compiled PDF shows `**text**` literally in the document, you have Markdown syntax in your source.
2.  **Regex Search:** Search the `.tex` file for the pattern `\*\*.+?\*\*` to find all instances.
3.  **Batch Fix:** Use find-and-replace with the following:
    *   **Find:** `\*\*(.+?)\*\*`
    *   **Replace:** `\\textbf{$1}`
    *   **Note:** Ensure regex mode is enabled in your editor.

**Prevention Guidelines for LLMs and Junior Staff:**
*   **Never use Markdown syntax in `.tex` files.** LaTeX is not Markdown.
*   **Always use LaTeX commands:**
    *   Bold: `\textbf{text}`
    *   Italic: `\textit{text}` or `\emph{text}`
    *   Underline: `\underline{text}`
    *   Monospace: `\texttt{text}` or use verbatim environments
*   **When converting content from Markdown to LaTeX:** Systematically search and replace all Markdown formatting before compilation.
*   **Post-compilation check:** If any formatting looks "wrong" (showing literal symbols), immediately check for Markdown syntax leakage.

**Impact:**
*   **Severity:** Medium (does not break compilation, but destroys document formatting)
*   **Frequency:** Very high in AI-generated or Markdown-sourced content
*   **Fix Difficulty:** Easy (simple find-and-replace)

This error was identified in `intelapple.tex` where 14+ instances of `**text**` were incorrectly used for emphasis in financial analysis sections, causing bold terms like "geopolitical resilience," "RibbonFET," "PowerVia," and section headers to render with visible asterisks in the PDF output.