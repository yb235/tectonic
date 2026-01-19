# Tectonic LaTeX Project - Antigravity Agent Instructions

**Project Name:** Tectonic  
**Project Type:** LaTeX Document Generation & Compilation  
**Primary Purpose:** Professional financial case study document creation with strict compliance requirements  
**Last Updated:** 2026-01-19

---

## 🚀 NEW: MODULAR AGENT SKILLS AVAILABLE

**For structured, executable workflows, see the new Agent Skills system:**

📦 **[Agent Skills Directory](../docs/agent-skills/README.md)** - Modular, composable workflow bundles

**Available Skills:**
- 🔨 [latex-compilation](../docs/agent-skills/latex-compilation/SKILL.md) - Compile LaTeX in containers
- 📝 [latex-document-creation](../docs/agent-skills/latex-document-creation/SKILL.md) - Create new compliant documents  
- 🔄 [latex-conversion](../docs/agent-skills/latex-conversion/SKILL.md) - Fix non-compliant LaTeX
- ✅ [latex-validation](../docs/agent-skills/latex-validation/SKILL.md) - Validate compliance & quality

**Benefits:**
- ✅ Progressive loading (save context tokens)
- ✅ Step-by-step executable instructions
- ✅ Validation gates at each phase
- ✅ Composable for complex workflows

**Quick Start:** Read [SKILL_INDEX.md](../docs/agent-skills/SKILL_INDEX.md) for overview, then load the skill you need.

---

## 🎯 PROJECT OVERVIEW

This repository is dedicated to creating high-quality, professionally formatted LaTeX documents for financial case studies. The project emphasizes:

1. **Legal Compliance**: All documents must include educational disclaimers and avoid real institutional branding
2. **Visual Consistency**: Strict adherence to brand colors, typography, and formatting standards
3. **Technical Excellence**: Automated validation, compilation, and quality assurance
4. **Containerized Development**: All LaTeX work should be performed in the dev container environment
5. **Modular Workflows**: Agent skills package complex processes into reusable components

---

## ⚠️ PRIORITY 0: CONTAINER-FIRST MANDATE (READ THIS FIRST)

### 🔒 SECURITY & CONSISTENCY REQUIREMENT

**BEFORE DOING ANY LATEX WORK, YOU MUST:**

1. ✅ **Verify you are running inside the dev container**
2. ✅ **If not in container, start it immediately**
3. ✅ **Never compile LaTeX on the host system**

### Why This is Priority 0 (Non-Negotiable)

#### Security Reasons:
- **Isolation**: LaTeX packages can execute arbitrary code during compilation
- **Sandboxing**: Container provides a security boundary from the host system
- **Controlled Environment**: Known, audited package versions prevent supply chain attacks
- **No Host Pollution**: LaTeX dependencies don't install system-wide on user's machine

#### Consistency Reasons:
- **Reproducibility**: Same environment = same compilation results every time
- **Version Control**: Exact LaTeX distribution version locked in Dockerfile
- **Dependency Management**: All required packages pre-installed and tested
- **Cross-Platform**: Works identically on Windows, Mac, Linux

#### Technical Reasons:
- **Complete TeX Live**: Full LaTeX distribution with all packages
- **Correct Tool Versions**: latexmk 4.86, specific biber version, etc.
- **No "Works on My Machine"**: Eliminates environment-specific bugs
- **Validated Configuration**: Container tested and known to work

### How to Verify Container Status

**Step 1: Check if you're in the container**
```bash
# Run this command - if it shows Debian, you're in the container
cat /etc/os-release 2>/dev/null | grep -i debian

# Alternative check - this path only exists in container
ls /workspaces/tectonic 2>/dev/null && echo "✅ In container" || echo "❌ On host"
```

**Step 2: If NOT in container, start it NOW**

**Option A: VS Code (Recommended for interactive work)**
```
1. Press Ctrl+Shift+P (Cmd+Shift+P on Mac)
2. Type: "Dev Containers: Reopen in Container"
3. Press Enter and wait for container to start
```

**Option B: Docker CLI (For command execution)**
```bash
docker run -it --rm -v "${PWD}:/workspaces/tectonic" -w /workspaces/tectonic tectonic-latex bash
```

### Container-First Workflow Pattern

**CORRECT Pattern:**
```
User asks for LaTeX work
    ↓
Check: Am I in container? (cat /etc/os-release)
    ↓
NO → Start container first
    ↓
YES → Proceed with LaTeX work
```

**INCORRECT Pattern (DO NOT DO THIS):**
```
User asks for LaTeX work
    ↓
Run latexmk on host ❌ WRONG!
    ↓
Get "command not found" or version mismatch errors
```

### Exception: When Container is NOT Required

You may work on the host system ONLY for:
- ✅ Reading documentation files (`.md`, `.txt`)
- ✅ Viewing compiled PDFs
- ✅ Editing non-LaTeX files (markdown, JSON, etc.)
- ✅ Git operations (commit, push, pull)
- ✅ File organization (moving, renaming files)

You MUST use the container for:
- ❌ Compiling `.tex` files (`latexmk`, `pdflatex`)
- ❌ Running LaTeX validation commands
- ❌ Testing LaTeX code
- ❌ Installing LaTeX packages
- ❌ Any command that processes `.tex` files

### Quick Reference Card

```
┌─────────────────────────────────────────────────────────┐
│  BEFORE ANY LATEX WORK:                                 │
│  1. Run: cat /etc/os-release | grep Debian             │
│  2. If no output → Start container                      │
│  3. If shows Debian → Proceed with work                 │
│                                                          │
│  Container Start Command:                               │
│  docker run -it --rm -v "${PWD}:/workspaces/tectonic" \ │
│    -w /workspaces/tectonic tectonic-latex bash          │
└─────────────────────────────────────────────────────────┘
```

---

## 🚨 CRITICAL RULES (NEVER VIOLATE)

### Legal & Compliance
- ❌ **NEVER** use color names that imply real institutions (e.g., `msblue`, `gsgreen`)
- ✅ **ALWAYS** use neutral names: `brandblue`, `brandaccent`, `lightgrey`, `textgrey`, `tableheader`
- ✅ **ALWAYS** include legal disclaimers on the front page
- ✅ **ALWAYS** include diagonal watermark: "SAMPLE: FICTIONAL DATA / DESIGN CASE STUDY"
- ✅ **ALWAYS** include footer disclaimer: "EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES"

### LaTeX Compilation Killers
- ❌ **NEVER** use `\captionof{table}` or `\captionof{figure}` (breaks auto-numbering)
- ✅ **ALWAYS** use `\begin{table}[H]` with `\caption{}` and `\label{}`
- ✅ **ALWAYS** use `\begin{figure}[H]` with `\caption{}` and `\label{}`
- ❌ **NEVER** use `\usepackage{colortbl}` (causes conflicts with xcolor)
- ✅ **ALWAYS** escape special characters outside tables: `\&`, `\$`, `\%`, `\_`

### Brand Colors (Exact Values)
```latex
\definecolor{brandblue}{HTML}{003366}
\definecolor{brandaccent}{HTML}{008EC7}
\definecolor{lightgrey}{HTML}{F3F3F3}
\definecolor{textgrey}{HTML}{6A6A6A}
\definecolor{tableheader}{HTML}{E6E6E6}
```

---

## 🐳 DEVELOPMENT ENVIRONMENT

### Container-First Approach

**CRITICAL**: All LaTeX compilation and development work MUST be performed inside the dev container.

#### Starting the Dev Container

**Option 1: VS Code (Recommended)**
1. Open Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`)
2. Run: **"Dev Containers: Reopen in Container"**
3. Wait for container to build and reload

**Option 2: Docker CLI**
```bash
# Build the image (first time only)
docker build -t tectonic-latex .devcontainer

# Run the container
docker run -it --rm -v "${PWD}:/workspaces/tectonic" -w /workspaces/tectonic tectonic-latex bash
```

#### Verifying Container Environment
```bash
# Check OS (should show Debian)
cat /etc/os-release

# Verify LaTeX tools
latexmk -version

# List files
ls -la
```

#### Container Specifications
- **Base Image**: `mcr.microsoft.com/devcontainers/base:debian`
- **OS**: Debian GNU/Linux 13 (trixie)
- **LaTeX Distribution**: TeX Live (full installation)
- **Key Tools**: latexmk, biber, make, git
- **Working Directory**: `/workspaces/tectonic`
- **VS Code Extension**: LaTeX Workshop (james-yu.latex-workshop)

### Why Use the Container?

1. **Consistency**: Same environment across all machines
2. **Dependencies**: All LaTeX packages pre-installed
3. **Isolation**: No conflicts with host system
4. **Reproducibility**: Guaranteed compilation results

---

## 📁 PROJECT STRUCTURE

```
tectonic/
├── .agent/                      # Agent instructions (this file)
├── .devcontainer/               # Dev container configuration
│   ├── Dockerfile              # Container image definition
│   └── devcontainer.json       # VS Code dev container config
├── docs/                        # Documentation
│   ├── agent-skills/           # 🆕 Modular agent workflow skills
│   │   ├── SKILL_INDEX.md              # Master index of all skills
│   │   ├── IMPLEMENTATION_GUIDE.md     # Integration guide for AI systems
│   │   ├── README.md                   # Quick start and overview
│   │   ├── latex-compilation/          # Compilation skill
│   │   ├── latex-document-creation/    # Document creation skill
│   │   ├── latex-conversion/           # Conversion skill
│   │   └── latex-validation/           # Validation skill
│   ├── latex/                  # LaTeX-specific guides
│   │   ├── LATEX_STYLE_GUIDE.md           # Comprehensive style reference
│   │   ├── LATEX_CHECKLIST.md             # Pre-compilation checklist
│   │   ├── LATEX_COMPILATION_DETAILS.md   # Error debugging guide
│   │   └── siRNA_CHECKLIST.md             # Project-specific checklist
│   ├── legal/                  # Legal compliance docs
│   │   ├── COPYRIGHT_AND_LICENSE_AUDIT.md
│   │   └── FONT_AND_LICENSE_ANALYSIS.md
│   └── process/                # Workflow documentation
│       ├── DEV_CONTAINER_SETUP.md         # Container setup guide
│       └── LLM_WORKFLOW.md                # Phase-based workflow
├── incoming/                    # Raw input files (to be processed)
├── output/                      # Compiled PDFs and artifacts
├── scripts/                     # Automation scripts
├── templates/                   # LaTeX templates and examples
│   ├── template.tex            # Master template
│   ├── intelapple.tex          # Reference example
│   └── examples/               # Additional examples
├── work/                        # Active work directory
│   └── PROJECT_NAME/           # Per-project workspace
│       ├── source/             # Source .tex files
│       ├── output/             # Project-specific outputs
│       ├── logs/               # Compilation logs
│       ├── progress_checklist.md
│       └── CONVERSION_REPORT.md
└── workflow/                    # Workflow instructions
    └── LLM_INSTRUCTIONS.md     # Quick reference for agents
```

---

## 🔄 STANDARD WORKFLOWS

### Workflow 1: Compiling Existing LaTeX Documents

When the user asks to compile a `.tex` file:

1. **Ensure you're in the container**:
   ```bash
   # If not in container, start it first
   docker run -it --rm -v "${PWD}:/workspaces/tectonic" -w /workspaces/tectonic tectonic-latex bash
   ```

2. **Navigate to the file location**:
   ```bash
   cd /workspaces/tectonic
   ```

3. **Run latexmk (two-pass compilation)**:
   ```bash
   latexmk -pdf -interaction=nonstopmode filename.tex
   ```

4. **Check for errors**:
   ```bash
   # View compilation log
   cat filename.log | grep -A5 "^!"
   
   # Check for warnings
   grep -E "(Overfull|Underfull|Warning)" filename.log
   ```

5. **Verify PDF output**:
   ```bash
   ls -lh filename.pdf
   ```

### Workflow 2: Creating New LaTeX Documents

When the user asks to create a new document:

1. **Read the master template**:
   ```bash
   cat templates/template.tex
   ```

2. **Copy template to new file**:
   ```bash
   cp templates/template.tex work/new_project/source/document.tex
   ```

3. **Customize the document**:
   - Update `\reporttitle{TICKER}{Title}{Subtitle}`
   - Add content sections
   - Follow the style guide strictly

4. **Validate before compiling**:
   ```bash
   # Check for forbidden patterns
   grep -n "\captionof" document.tex
   grep -n "usepackage{colortbl}" document.tex
   grep -nE "definecolor\{(ms|gs|citi)" document.tex
   ```

5. **Compile in container**:
   ```bash
   latexmk -pdf -interaction=nonstopmode document.tex
   ```

### Workflow 3: Converting Raw LaTeX to Compliant Format

When the user provides a raw `.tex` file that needs compliance fixes:

**Follow the 7-phase workflow documented in `docs/process/LLM_WORKFLOW.md`:**

1. **Phase 0**: Pre-flight preparation (read style guide, create work directory)
2. **Phase 1**: Preamble & package setup (fix packages, define colors)
3. **Phase 2**: Document structure (fix headings, remove duplicates)
4. **Phase 3**: Tables & captions (convert to float environments)
5. **Phase 4**: Figures & charts (standardize formatting)
6. **Phase 5**: Legal compliance (add disclaimers, remove institutional references)
7. **Phase 6**: Validation & compilation (run checks, compile PDF)
8. **Phase 7**: Final handoff (package outputs, generate report)

**Key validation commands to run between phases**:
```bash
# Check for illegal captionof usage
grep "\captionof" file.tex

# Find duplicate labels
grep "\label{" file.tex | sort | uniq -d

# Check for unescaped special characters
grep -P '(?<!\\)[\$%&]' file.tex | grep -v "\\begin{tabular}"

# Verify table font consistency
grep "adjustbox.*width=" file.tex
```

---

## 📚 ESSENTIAL DOCUMENTATION

### Must-Read Before Any LaTeX Work

1. **`workflow/LLM_INSTRUCTIONS.md`** (540 lines)
   - Quick reference for LaTeX generation
   - Prioritized rules and patterns
   - Common error fixes
   - **READ THIS FIRST** for any LaTeX task

2. **`docs/latex/LATEX_STYLE_GUIDE.md`** (comprehensive reference)
   - Complete technical specification
   - Historical context for rules
   - Advanced customization patterns

3. **`docs/process/LLM_WORKFLOW.md`** (1373 lines)
   - Phase-based conversion workflow
   - Validation gates and success criteria
   - Error handling procedures
   - Automated validation scripts

### Quick Reference Hierarchy

```
For quick tasks → workflow/LLM_INSTRUCTIONS.md
For conversions → docs/process/LLM_WORKFLOW.md
For deep dives → docs/latex/LATEX_STYLE_GUIDE.md
For debugging  → docs/latex/LATEX_COMPILATION_DETAILS.md
```

---

## 🎨 LATEX FORMATTING STANDARDS

### Table Template (Mandatory Pattern)

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
\par\vspace{0.1cm}  % NOTE: \par is REQUIRED
{\tiny Source: Your Source Here}
\end{table}
```

### Chart Template (Mandatory Pattern)

```latex
\begin{figure}[H]
\centering
\caption{Chart Title}
\label{fig:descriptive_name}
\begin{tikzpicture}
\begin{axis}[
    msstyle,  % Use semantic style
    width=10cm,
    height=6cm,
    bar width=20pt,
    symbolic x coords={A, B, C, D, E},
    xtick=data,
    xticklabel style={font=\footnotesize},
    yticklabel style={font=\footnotesize},
    ylabel={Metric Name},
    ylabel style={font=\footnotesize},
    nodes near coords,
    nodes near coords style={font=\footnotesize, font=\bfseries, color=white},
    ymajorgrids=true,
    grid style={dotted, gray}
]
\addplot[fill=brandblue] coordinates {(A,10) (B,20) (C,30) (D,25) (E,15)};
\legend{Series Name}
\end{axis}
\pgfplotsset{
    after end axis/.append code={
        \node[anchor=north, font=\tiny, text width=10cm, align=center] 
        at (current axis.south) [yshift=-1.5cm] {
            Source: Your Source Here
        };
    }
}
\end{tikzpicture}
\end{figure}
```

### Font Size Rules

- **Table content**: `\tablefont` (defined as `\footnotesize`)
- **Chart labels**: `\footnotesize` (NEVER `\tiny`)
- **Chart legends**: `\footnotesize`
- **Source citations**: `\tiny`
- **Body text**: Default (10pt)

---

## 🔍 VALIDATION & QUALITY ASSURANCE

### Pre-Compilation Checklist

Run these commands **BEFORE** compiling any document:

```bash
# 1. Check for illegal captionof usage
grep "\captionof" file.tex
# Expected: Empty or only inside multicols with \captionsetup

# 2. Find duplicate labels (CRITICAL)
grep "\label{" file.tex | sort | uniq -d
# Expected: Empty output (no duplicates)

# 3. Find duplicate subsections
grep "\subsection{" file.tex | sort | uniq -d
# Expected: Empty output

# 4. Check for unescaped special characters
grep -P '(?<!\\)[\$%&]' file.tex | grep -v "\\begin{tabular}"
# Expected: Minimal output (only in tables/math mode)

# 5. Verify table font consistency
grep "adjustbox.*width=" file.tex
# Expected: All should say "max width=" NOT "width="

# 6. Check for institutional color names
grep -nE "definecolor\{(ms|gs|citi|morgan|stanley)" file.tex
# Expected: Empty output
```

### Post-Compilation Visual Checks

After PDF generation, verify:

- [ ] All tables have similar font sizes
- [ ] All chart data labels are readable at 100% zoom
- [ ] All captions are centered
- [ ] Source citations appear **below** tables/charts, not beside them
- [ ] No chart legends overlap data
- [ ] No text overflows page margins
- [ ] Watermark is visible but not distracting
- [ ] Legal disclaimer box is prominent on first page
- [ ] Footer disclaimer appears on every page

---

## 🐛 COMMON ERRORS & FIXES

### Compilation Errors

| Error Message | Root Cause | Fix |
|---------------|------------|-----|
| `Misplaced alignment tab character &` | Unescaped `&` in text | Change to `\&` |
| `Runaway argument` | Blank line inside `[...]` block | Remove blank line |
| `Missing $ inserted` | Unescaped `$` or `%` | Change to `\$` or `\%` |
| `Undefined colormap` | Colormap not defined | Use built-in: `viridis`, `hot`, `bluered` |
| `Package pgfplots Error` | Syntax error in coordinates | Check for unescaped `%` in labels |

### Diagnostic Commands

```bash
# Find compilation errors
grep -A5 "^!" filename.log

# Extract warnings
grep -E "(Overfull|Underfull|Warning)" filename.log > warnings.txt

# Check PDF was created
ls -lh filename.pdf

# View PDF info
pdfinfo filename.pdf
```

---

## 💡 AGENT BEHAVIOR GUIDELINES

### When User Asks to Compile LaTeX

**⚠️ PRIORITY 0 CHECK - DO THIS FIRST:**

1. **Verify container status IMMEDIATELY**:
   ```bash
   cat /etc/os-release 2>/dev/null | grep -i debian
   ```
   - If output shows "Debian" → ✅ Proceed to step 2
   - If no output or error → ❌ STOP and start container first

2. **If not in container, start it NOW** (do not proceed without container):
   ```bash
   docker run -it --rm -v "${PWD}:/workspaces/tectonic" -w /workspaces/tectonic tectonic-latex bash
   ```

3. **Navigate to correct directory**: Ensure working in `/workspaces/tectonic`

4. **Run latexmk**: Use `-pdf -interaction=nonstopmode` flags

5. **Report results**: Show success/failure, file size, any warnings

6. **Offer next steps**: View PDF, fix errors, or continue work

**CRITICAL**: Steps 3-6 can ONLY happen after steps 1-2 are complete. Never skip the container check.

### When User Asks to Create/Edit LaTeX

1. **Read relevant documentation**: Start with `workflow/LLM_INSTRUCTIONS.md`
2. **Use templates**: Copy from `templates/template.tex`
3. **Follow mandatory patterns**: Use exact table/chart templates
4. **Validate before compiling**: Run pre-compilation checks
5. **Compile in container**: Always use dev container
6. **Document changes**: Update progress checklist if doing conversion

### When User Asks About Container

1. **Explain the purpose**: Consistent LaTeX environment
2. **Show how to start**: Both VS Code and CLI methods
3. **Verify container state**: Run diagnostic commands
4. **Troubleshoot if needed**: Check Docker Desktop, rebuild if necessary

### When Errors Occur

1. **Read the log file**: Extract actual error messages
2. **Consult error patterns**: Use tables in this document
3. **Apply systematic fixes**: Don't guess, follow documented solutions
4. **Re-validate**: Run checks again after fixes
5. **Document the issue**: Add to progress log if doing conversion

---

## 🚀 QUICK START EXAMPLES

### Example 1: Compile Existing Document

**User Request**: "Compile intelapple.tex"

**Agent Actions**:
```bash
# 1. Check if in container
cat /etc/os-release 2>/dev/null || echo "Not in container"

# 2. If not in container, start it
docker run -it --rm -v "${PWD}:/workspaces/tectonic" -w /workspaces/tectonic tectonic-latex bash

# 3. Compile the document
latexmk -pdf -interaction=nonstopmode intelapple.tex

# 4. Check results
ls -lh intelapple.pdf
grep -c "^!" intelapple.log || echo "Compilation successful"
```

### Example 2: Fix Compliance Issues

**User Request**: "Fix the LaTeX file to be compliant"

**Agent Actions**:
1. Read `docs/process/LLM_WORKFLOW.md`
2. Create work directory structure
3. Run Phase 0-7 workflow
4. Generate validation report
5. Compile final PDF
6. Create CONVERSION_REPORT.md

### Example 3: Start Dev Container

**User Request**: "How do I run in the container?"

**Agent Response**:
```markdown
You can start the dev container in two ways:

**Option 1: VS Code (Recommended)**
1. Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
2. Type "Dev Containers: Reopen in Container"
3. Wait for the container to build and reload

**Option 2: Docker CLI**
```bash
docker run -it --rm -v "${PWD}:/workspaces/tectonic" -w /workspaces/tectonic tectonic-latex bash
```

Once inside, verify with:
```bash
cat /etc/os-release  # Should show Debian
latexmk -version     # Should show version 4.86
```
```

---

## 📋 DECISION TREES

### Should I Use the Container?

```
Is the task related to LaTeX compilation or editing?
├─ YES → MUST use container
│   ├─ Compiling .tex files → Use container
│   ├─ Running latexmk → Use container
│   ├─ Validating LaTeX → Use container
│   └─ Testing changes → Use container
│
└─ NO → Can use host
    ├─ Reading documentation → Host is fine
    ├─ Viewing PDFs → Host is fine
    └─ Editing markdown → Host is fine
```

### Which Documentation Should I Read?

```
What is the user asking for?
├─ Quick LaTeX generation → workflow/LLM_INSTRUCTIONS.md
├─ Converting raw LaTeX → docs/process/LLM_WORKFLOW.md
├─ Understanding a rule → docs/latex/LATEX_STYLE_GUIDE.md
├─ Debugging errors → docs/latex/LATEX_COMPILATION_DETAILS.md
├─ Container setup → docs/process/DEV_CONTAINER_SETUP.md
└─ Legal compliance → docs/legal/COPYRIGHT_AND_LICENSE_AUDIT.md
```

### How Should I Handle Errors?

```
Compilation failed?
├─ Check error message in .log file
├─ Match against error patterns in this document
├─ Apply documented fix
├─ Re-validate with pre-compilation checks
├─ Recompile
└─ If still failing after 3 attempts → Flag for manual review
```

---

## 🎓 LEARNING PRINCIPLES

### Pattern Recognition Over Memorization

Instead of memorizing thousands of lines, internalize these core patterns:

1. **Table Pattern**: `\begin{table}[H]` → `\centering` → `\caption{}` → `\label{}` → `\tablefont` → `\begin{adjustbox}{max width=...}` → content → `\par\vspace{0.1cm}` → source

2. **Chart Pattern**: Count data points → Choose width → Set all fonts to `\footnotesize` → Position note inside tikzpicture

3. **Error Pattern**: Compilation fails → Check special characters first → Then check blank lines → Then check typos

4. **Container Pattern**: LaTeX task → Check if in container → Start if needed → Execute → Verify results

### When Uncertain

- **Tables**: Use the mandatory template from this document
- **Charts**: Use the complete template from this document
- **Colors**: Use approved palette only (brandblue, brandaccent, etc.)
- **Structure**: Section → Subsection → Paragraph (never deeper)
- **Container**: When in doubt, use it (better safe than sorry)

---

## 📞 SUPPORT & REFERENCES

### Key Files to Reference

1. **This file** (`.agent/AGENT.md`): Overall project guidance
2. **`workflow/LLM_INSTRUCTIONS.md`**: Day-to-day LaTeX work
3. **`docs/process/LLM_WORKFLOW.md`**: Conversion workflows
4. **`docs/latex/LATEX_STYLE_GUIDE.md`**: Comprehensive technical reference

### Container Configuration Files

- **`.devcontainer/Dockerfile`**: Container image definition
- **`.devcontainer/devcontainer.json`**: VS Code integration

### Templates

- **`templates/template.tex`**: Master template for new documents
- **`templates/intelapple.tex`**: Reference example with real content

---

## ✅ FINAL CHECKLIST: Am I Ready to Work?

Before starting any LaTeX task, verify **IN THIS ORDER**:

### Priority 0: Container Status
- [ ] **I have verified I am running inside the dev container** (ran `cat /etc/os-release | grep Debian`)
- [ ] **If not in container, I have started it** (will not proceed without container)

### Priority 1: Project Understanding
- [ ] I understand this is a LaTeX document generation project
- [ ] I know the container must be used for compilation
- [ ] I have the approved color palette memorized

### Priority 2: Technical Knowledge
- [ ] I know the mandatory table template
- [ ] I know the complete chart template
- [ ] I know the validation commands to run

### Priority 3: Compliance Rules
- [ ] I will escape all special characters (`& $ % _`)
- [ ] I will use `max width=`, never `width=`
- [ ] I will use `\footnotesize` for all chart elements
- [ ] I will add legal disclaimers to all documents

**If all checked**: Proceed with confidence.

**If any unchecked**: Read the relevant documentation section above.

---

*This document is the authoritative guide for Antigravity agents working on the Tectonic LaTeX project.*  
*Last updated: 2026-01-18*  
*Maintained by: Project Owner*  
*Based on: 150+ hours of LaTeX debugging and workflow optimization*
