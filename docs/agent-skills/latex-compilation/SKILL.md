---
name: latex-compilation
description: Compile LaTeX documents in a containerized environment with error diagnosis and validation. Use when compiling .tex files, generating PDFs, or troubleshooting compilation errors.
usage: |
  - "Compile intelapple.tex"
  - "Build the PDF from this LaTeX file"
  - "Generate the document"
  - "Fix compilation errors"
  - "Why isn't my .tex file compiling?"
version: 1.0.0
priority: critical
---

# LaTeX Compilation Skill

## Overview

This skill enables safe, reproducible LaTeX document compilation using the Tectonic project's containerized environment. It enforces container-first development, diagnoses compilation errors, and validates output quality.

**Core Principle:** All LaTeX compilation MUST occur inside the dev container for security isolation and environmental consistency.

## When to Use

Trigger this skill when the user:
- Explicitly requests compilation ("compile", "build", "generate PDF")
- Reports compilation errors or failures
- Asks why a document won't compile
- Needs to verify LaTeX code works correctly

## Prerequisites

- Docker or compatible container engine installed
- Dev container configuration present in `.devcontainer/`
- LaTeX source file (`.tex`) exists in the repository

## Execution Steps

### Step 1: PRIORITY 0 - Container Status Check

**CRITICAL: This step is non-negotiable and must be executed first.**

```bash
# Verify you're in the dev container
cat /etc/os-release 2>/dev/null | grep -i debian
```

**Decision Point:**
- ✅ Output shows "Debian" → Proceed to Step 2
- ❌ No output or error → Execute Step 1.1 (Start Container)

#### Step 1.1: Start Dev Container

**Option A: VS Code (Recommended for interactive work)**
1. Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
2. Type: "Dev Containers: Reopen in Container"
3. Press Enter and wait for container to build/start
4. Verify with: `cat /etc/os-release`

**Option B: Docker CLI (For command execution)**
```bash
docker run -it --rm -v "${PWD}:/workspaces/tectonic" \
  -w /workspaces/tectonic tectonic-latex bash
```

**After container starts, return to Step 1 to verify.**

### Step 2: Navigate to Correct Directory

```bash
cd /workspaces/tectonic
# Verify location
pwd
# Should output: /workspaces/tectonic
```

### Step 3: Locate Target File

```bash
# If user specified a file path, use it directly
# Otherwise, find .tex files
find . -name "*.tex" -type f | grep -v ".aux" | head -10
```

**Validation:**
- [ ] Target `.tex` file exists
- [ ] File is not a temporary/auxiliary file (`.aux`, `.log`, `.fls`)

### Step 4: Run LaTeX Compilation

```bash
# Standard two-pass compilation with error handling
latexmk -pdf -interaction=nonstopmode filename.tex
```

**Compilation Flags Explained:**
- `-pdf`: Generate PDF output (uses pdflatex)
- `-interaction=nonstopmode`: Don't pause on errors (capture all issues)

**Expected Output:**
- `Latexmk: All targets (filename.pdf) are up to date` → Success
- `Latexmk: Errors, so I did not complete making targets` → Errors present (proceed to Step 5)

### Step 5: Error Diagnosis (If Compilation Failed)

```bash
# Extract error lines from log file
grep -A5 "^!" filename.log

# Check for common error patterns
grep -E "(Misplaced|Runaway|Undefined|Missing)" filename.log
```

**Common Error Patterns and Fixes:**

| Error Keyword | Root Cause | Fix |
|---------------|-----------|-----|
| `Misplaced alignment tab character &` | Unescaped `&` outside table | Change to `\&` |
| `Runaway argument` | Blank line in option block `[...]` | Remove blank line |
| `Missing $ inserted` | Unescaped `$` or `%` | Change to `\$` or `\%` |
| `Undefined control sequence` | Typo or missing package | Check command spelling, verify package loaded |
| `Undefined colormap` | Custom colormap not defined | Use built-in: `viridis`, `hot`, `bluered` |

**Action:**
1. Identify error pattern from table above
2. Apply documented fix
3. Return to Step 4 (re-compile)
4. If errors persist after 3 attempts, escalate to user with specific error details

### Step 6: Verify PDF Output

```bash
# Check PDF was created and is valid
ls -lh filename.pdf

# Optional: View PDF metadata
pdfinfo filename.pdf 2>/dev/null || echo "pdfinfo not available, PDF exists"
```

**Success Criteria:**
- [ ] PDF file exists
- [ ] File size > 0 bytes
- [ ] No critical errors in log (grep "^!" returns empty)

### Step 7: Check Compilation Warnings (Optional Quality Check)

```bash
# Extract warnings
grep -E "(Overfull|Underfull|Warning)" filename.log | head -20
```

**Acceptable Warnings:**
- `Overfull \hbox` (minor spacing issues)
- `Underfull \hbox` (minor spacing issues)
- `LaTeX Warning: Label ... multiply defined` (only if intentional cross-referencing)

**Unacceptable Warnings:**
- `Package hyperref Warning: Token not allowed` → Fix link syntax
- `LaTeX Warning: Reference ... undefined` → Add missing `\label{}`

### Step 8: Report Results

**On Success:**
```
✅ Compilation successful
📄 PDF generated: filename.pdf (XXX KB)
⚠️  Warnings: N (XX overfull, YY underfull)
🔗 Open PDF to verify visual output
```

**On Failure:**
```
❌ Compilation failed
🐛 Error: [specific error message]
📋 Suggested fix: [from error pattern table]
📝 See filename.log for full details
```

## Decision Trees

### Container Check Decision Tree

```
Is this a LaTeX compilation task?
├─ YES → Check if in container
│   ├─ In container (Debian detected) → Proceed with compilation
│   └─ Not in container → Start container → Verify → Proceed
│
└─ NO → This skill is not applicable
```

### Error Handling Decision Tree

```
Compilation failed?
├─ YES → Check log file
│   ├─ Known error pattern (in table) → Apply fix → Retry
│   ├─ Unknown error → Extract error context → Report to user
│   └─ Persistent error after 3 attempts → Escalate with full context
│
└─ NO → Verify PDF output → Report success
```

## Examples

### Example 1: Successful Compilation

**User Request:** "Compile intelapple.tex"

**Agent Actions:**
```bash
# Step 1: Check container
cat /etc/os-release | grep Debian
# Output: Debian GNU/Linux 13 (trixie)

# Step 2-3: Navigate and locate
cd /workspaces/tectonic
ls intelapple.tex
# Output: intelapple.tex

# Step 4: Compile
latexmk -pdf -interaction=nonstopmode intelapple.tex
# Output: Latexmk: All targets (intelapple.pdf) are up to date

# Step 6: Verify
ls -lh intelapple.pdf
# Output: -rw-r--r-- 1 user user 2.3M Jan 19 10:30 intelapple.pdf
```

**Agent Response:**
```
✅ Compilation successful
📄 PDF generated: intelapple.pdf (2.3 MB)
⚠️  Warnings: 3 (2 overfull hbox, 1 underfull hbox)
```

### Example 2: Compilation with Errors

**User Request:** "Build document.tex"

**Agent Actions:**
```bash
# Steps 1-3: Container check and navigation (successful)

# Step 4: Compile
latexmk -pdf -interaction=nonstopmode document.tex
# Output: Latexmk: Errors, so I did not complete making targets

# Step 5: Diagnose
grep -A5 "^!" document.log
# Output: ! Misplaced alignment tab character &.
#         l.123 This is text with an unescaped & symbol
```

**Agent Response:**
```
❌ Compilation failed
🐛 Error: Misplaced alignment tab character &
📍 Location: Line 123
📋 Suggested fix: Change unescaped & to \& in text content
💡 Special characters (& $ % _) must be escaped outside tables
```

**After Fix:**
```bash
# User or agent fixes line 123: "This is text with an unescaped \& symbol"
latexmk -pdf -interaction=nonstopmode document.tex
# Output: Latexmk: All targets (document.pdf) are up to date
```

### Example 3: Starting Container First

**User Request:** "Compile report.tex"

**Agent Actions:**
```bash
# Step 1: Check container
cat /etc/os-release 2>/dev/null | grep Debian
# Output: (empty - not in container)

# Step 1.1: Start container (Docker CLI method)
docker run -it --rm -v "${PWD}:/workspaces/tectonic" \
  -w /workspaces/tectonic tectonic-latex bash

# Step 1 (retry): Verify
cat /etc/os-release | grep Debian
# Output: Debian GNU/Linux 13 (trixie)

# Now proceed with Steps 2-8...
```

## Troubleshooting

### Problem: "latexmk: command not found"

**Cause:** Not running inside dev container

**Solution:** Return to Step 1, start container properly

### Problem: Compilation hangs indefinitely

**Cause:** Interactive prompt waiting for input (missing `-interaction=nonstopmode`)

**Solution:**
```bash
# Kill the process
pkill -9 latexmk

# Retry with correct flags
latexmk -pdf -interaction=nonstopmode filename.tex
```

### Problem: PDF generated but looks wrong

**Cause:** Visual issues not caught by compilation

**Solution:**
1. Run post-compilation visual checks (see resources/visual-checklist.md)
2. Consider using latex-validation skill first
3. Check for missing fonts or incorrect packages

### Problem: "File not found" errors

**Cause:** Relative paths broken or working directory incorrect

**Solution:**
```bash
# Verify working directory
pwd
# Should be: /workspaces/tectonic

# Use absolute paths
latexmk -pdf -interaction=nonstopmode /workspaces/tectonic/path/to/file.tex
```

## Resources

- **Error Pattern Library:** See `resources/error-patterns.md` for comprehensive error catalog
- **Visual Checklist:** See `resources/visual-checklist.md` for post-compilation quality checks
- **Container Setup Guide:** See `/docs/process/DEV_CONTAINER_SETUP.md` for container troubleshooting

## Related Skills

- **latex-validation:** Run this BEFORE compilation to catch errors early
- **latex-conversion:** Use this if source file needs compliance fixes
- **latex-document-creation:** Use this to start with compliant template

## Security Considerations

**Why Container-First is Mandatory:**

1. **Security Isolation:** LaTeX packages can execute arbitrary code during compilation
2. **Sandboxing:** Container provides security boundary from host system
3. **Controlled Environment:** Known, audited package versions prevent supply chain attacks
4. **No Host Pollution:** LaTeX dependencies don't install system-wide

**Never bypass container requirement for LaTeX compilation.**

## Success Metrics

- [ ] Container status verified before any LaTeX commands
- [ ] PDF successfully generated
- [ ] File size > 0 and file is valid
- [ ] Error count = 0 (or known acceptable warnings only)
- [ ] Execution completed in < 2 minutes for typical documents

---

*Skill Version: 1.0.0*  
*Last Updated: 2026-01-19*  
*Compatibility: Tectonic LaTeX Project v2.0+*  
*Container: mcr.microsoft.com/devcontainers/base:debian with TeX Live*
