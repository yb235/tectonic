# Tectonic - LaTeX Financial Case Study Repository

This repository contains LaTeX documents for financial case study reports, along with comprehensive automation tools for document generation and editing.

## 🚀 New: LaTeX Workflow Automation Skill

**Automate your entire LaTeX editing workflow with AI!**

We've built a Claude Agent Skill that automates the complete LaTeX document workflow, from raw files to polished, compliant PDFs. This skill implements a 7-phase systematic process that ensures every document meets our strict style guides, legal requirements, and technical standards.

👉 **[Read the full automation guide](LATEX_WORKFLOW_AUTOMATION.md)**

### Quick Start

Simply describe what you need in natural language:

```
"Create a new financial case study document for Apple's M4 chip"
"Convert this raw LaTeX file to follow our repository standards"
"Add a comparative table showing revenue data for three companies"
```

The skill automatically:
- ✅ Sets up compliant preamble with all required packages
- ✅ Adds legal disclaimers and watermarks
- ✅ Formats tables and figures correctly
- ✅ Validates compliance before compilation
- ✅ Generates professional PDF output

**Learn more:** [Skill Documentation](.github/agents/skills/latex-workflow/)

## 📁 Repository Structure

```
tectonic/
├── .github/agents/skills/latex-workflow/  # 🆕 Automation skill
│   ├── SKILL.md                           # Main skill definition
│   ├── README.md                          # Usage guide
│   ├── QUICK_REFERENCE.md                 # Fast reference
│   ├── EXAMPLES.md                        # Use case examples
│   └── validate.sh                        # Validation script
├── workflow/
│   └── LLM_INSTRUCTIONS.md                # Prioritized workflow guide
├── docs/
│   ├── process/
│   │   └── LLM_WORKFLOW.md                # 7-phase workflow details
│   ├── latex/
│   │   ├── LATEX_STYLE_GUIDE.md           # Comprehensive style guide
│   │   └── LATEX_CHECKLIST.md             # Validation checklist
│   └── legal/
│       └── COPYRIGHT_AND_LICENSE_AUDIT.md # Legal compliance
├── templates/
│   ├── template.tex                       # Base template
│   ├── intelapple.tex                     # Intel/Apple case study
│   └── examples/                          # Additional examples
├── output/                                # Compiled PDFs
├── intelapple.tex                         # Main Intel/Apple document
└── siRNA.tex                              # siRNA technology document
```

## 📚 Documents

### Current Case Studies

1. **Intel/Apple Analysis** (`intelapple.tex`)
   - Intel Foundry Services and potential Apple partnership
   - Advanced packaging technologies
   - Competitive landscape analysis
   - Financial projections and scenarios

2. **siRNA Technology** (`siRNA.tex`)
   - Small interfering RNA technology overview
   - Therapeutic applications
   - Market analysis

## 🎯 Key Features

### Automation Skill
- **7-Phase Workflow** - Systematic transformation from raw to compliant
- **Automated Validation** - Catches errors before compilation
- **Legal Compliance** - Ensures all disclaimers present
- **Quality Metrics** - Scores documents on multiple criteria
- **Error Prevention** - Detects common mistakes automatically

### Style Guide
- **Critical Rules** - Non-negotiable requirements
- **Templates** - Ready-to-use table and figure patterns
- **Brand Colors** - Approved color palette
- **Font Sizing** - Consistent typography
- **Legal Disclaimers** - Required boilerplate text

### Documentation
- **Quick Reference** - Fast lookup for common patterns
- **Examples** - 8 detailed use case scenarios
- **Checklists** - Pre-compilation validation
- **Troubleshooting** - Common errors and solutions

## 🛠️ Tools

### Validation Script
Run automated checks on any document:

```bash
./.github/agents/skills/latex-workflow/validate.sh document.tex
```

Checks:
- ✅ Preamble compliance
- ✅ Document structure
- ✅ Table/figure formatting
- ✅ Legal disclaimers
- ✅ Special character escaping
- ✅ Label uniqueness

### Compilation
Standard two-pass compilation:

```bash
pdflatex -interaction=nonstopmode document.tex
pdflatex -interaction=nonstopmode document.tex
```

## 📋 Critical Rules

### ❌ Never Use
- `\captionof{table}` or `\captionof{figure}` (use float environments)
- Institutional color names like `msblue` (use `brandblue`)
- `width=\textwidth` for tables (use `max width=\textwidth`)
- Unescaped special characters `& $ % _` outside tables
- Package `colortbl` (causes conflicts)

### ✅ Always Use
- Legal disclaimers (front cover box, watermark, footer)
- Formal float environments (`\begin{table}[H]`, `\begin{figure}[H]`)
- Unique labels (`tab:name`, `fig:name`)
- Brand colors with neutral names
- `\tablefont` for all tables

## 🎨 Brand Colors

```latex
\definecolor{brandblue}{HTML}{003366}
\definecolor{brandaccent}{HTML}{008EC7}
\definecolor{lightgrey}{HTML}{F3F3F3}
\definecolor{textgrey}{HTML}{6A6A6A}
\definecolor{tableheader}{HTML}{E6E6E6}
```

## 📖 Quick Start Guide

### Creating a New Document

1. **Use the skill** (recommended):
   ```
   "Create a new financial case study document for [topic]"
   ```

2. **Manual approach**:
   - Copy `templates/template.tex`
   - Update title and content
   - Run validation before compilation

### Converting Raw LaTeX

1. **Use the skill** (recommended):
   ```
   "Convert this raw LaTeX file to follow our repository standards"
   ```

2. **Manual approach**:
   - Follow the 7-phase workflow in `docs/process/LLM_WORKFLOW.md`
   - Run validation after each phase
   - Compile when all checks pass

### Adding Content

**Tables:**
```latex
\begin{table}[H]
\centering
\caption{Table Title}
\label{tab:unique_name}
\tablefont
\begin{adjustbox}{max width=\textwidth}
\begin{tabular}{lrr}
\toprule
\textbf{Header} & \textbf{Data} & \textbf{More} \\
\midrule
Row 1 & Value & Value \\
\bottomrule
\end{tabular}
\end{adjustbox}
\par\vspace{0.1cm}
{\tiny Source: Provider}
\end{table}
```

**Figures:**
```latex
\begin{figure}[H]
\centering
\caption{Chart Title}
\label{fig:unique_name}
\begin{tikzpicture}
\begin{axis}[msstyle, width=10cm]
\addplot[fill=brandblue] coordinates {(A,10) (B,20)};
\legend{Series}
\end{axis}
\end{tikzpicture}
\end{figure}
```

## 🔍 Documentation Index

### For Quick Reference
- [QUICK_REFERENCE.md](.github/agents/skills/latex-workflow/QUICK_REFERENCE.md) - Templates and commands
- [workflow/LLM_INSTRUCTIONS.md](workflow/LLM_INSTRUCTIONS.md) - Prioritized workflow

### For Detailed Guidance
- [docs/process/LLM_WORKFLOW.md](docs/process/LLM_WORKFLOW.md) - Complete 7-phase workflow
- [docs/latex/LATEX_STYLE_GUIDE.md](docs/latex/LATEX_STYLE_GUIDE.md) - Comprehensive style guide
- [docs/latex/LATEX_CHECKLIST.md](docs/latex/LATEX_CHECKLIST.md) - Validation checklist

### For Examples
- [EXAMPLES.md](.github/agents/skills/latex-workflow/EXAMPLES.md) - 8 use case scenarios
- [templates/intelapple.tex](templates/intelapple.tex) - Reference document

### For Automation
- [LATEX_WORKFLOW_AUTOMATION.md](LATEX_WORKFLOW_AUTOMATION.md) - Full automation guide
- [SKILL.md](.github/agents/skills/latex-workflow/SKILL.md) - Skill definition

## 🤖 About the Automation Skill

The LaTeX Workflow Automation Skill is a Claude Agent Skill that packages our entire workflow into a reusable, modular format. It follows the official Claude platform specification for Agent Skills.

**Features:**
- Progressive loading (metadata → instructions → resources)
- Auto-detection of LaTeX-related tasks
- Comprehensive error prevention
- Quality scoring and reporting
- Based on 150+ hours of debugging experience

**Usage:** Just describe what you need in natural language. The skill automatically activates for LaTeX-related tasks in this repository.

## 📊 Quality Standards

Documents processed with our workflow achieve:
- 🎯 Zero compilation errors
- 🎯 100% validation check pass rate
- 🎯 Professional visual quality
- 🎯 Legal compliance confirmation
- 🎯 Quality score ≥ 80/100

## 🤝 Contributing

To improve the workflow or documentation:

1. Edit relevant files in `.github/agents/skills/latex-workflow/`
2. Update version numbers and test with sample documents
3. Update documentation as needed
4. Submit changes with clear descriptions

## ⚖️ Legal Notice

All documents in this repository include prominent disclaimers:

> **EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES**
>
> These documents are fictional research reports created solely for educational and graphic design portfolio purposes. They are not financial advice and contain simulated or unverified data.

Required elements:
- Front cover disclaimer box
- Diagonal watermark on all pages
- Footer disclaimer on all pages
- No affiliation with real financial institutions

## 📝 License

This repository and its automation tools follow the license terms specified in the repository.

## 🙋 Support

For questions or issues:
1. Check the [automation guide](LATEX_WORKFLOW_AUTOMATION.md)
2. Review [quick reference](.github/agents/skills/latex-workflow/QUICK_REFERENCE.md)
3. Examine [examples](.github/agents/skills/latex-workflow/EXAMPLES.md)
4. Consult the [style guide](docs/latex/LATEX_STYLE_GUIDE.md)

---

**Version:** 1.0.0 (with LaTeX Workflow Automation Skill)  
**Last Updated:** 2026-01-19  
**Author:** James Bian
