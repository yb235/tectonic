# LLM Workflow (Raw TeX → Polished Template)

**Purpose:** Standardize how an LLM agent takes a raw LaTeX file and rewrites it to match this repository’s template and style rules.

---

## 1) Drop Zone
1. Place the new raw file in incoming/ using a dated name, e.g.:
   - incoming/raw_YYYYMMDD_project.tex

---

## 2) Read-Only Context the Agent Must Load
The agent must read these documents before editing any TeX:

- docs/latex/LATEX_STYLE_GUIDE.md
- docs/latex/LATEX_CHECKLIST.md
- docs/latex/LATEX_COMPILATION_DETAILS.md
- docs/legal/COPYRIGHT_AND_LICENSE_AUDIT.md
- templates/template.tex
- templates/intelapple.tex

If the job is a siRNA refresh, also read:
- docs/latex/siRNA_CHECKLIST.md
- docs/latex/siRNA_LATEX_COMPLIANCE_CHECKLIST.md
- templates/examples/siRNA.tex

---

## 3) Create a Work Folder
1. Create a working directory:
   - work/project_name/
2. Copy the raw file into work/project_name/source.tex
3. Create a checklist file in the same folder:
   - work/project_name/agent_checklist.md

---

## 4) Agent Checklist Template
The agent_checklist.md must include:

- Document hierarchy (sections/subsections only)
- Color palette compliance (brandblue, brandaccent, lightgrey, textgrey, tableheader)
- Legal disclaimer blocks present
- Table and figure numbering with labels
- Caption centering
- Table font and adjustbox rules
- Chart styles and legend placement
- Special character escapes
- Duplicate sections check
- Executive summary before TOC

---

## 5) Revamp Steps (Agent)
1. Apply template structure from templates/template.tex
2. Reference patterns from templates/intelapple.tex
3. Normalize headings and paragraph spacing
4. Convert captions to proper float environments with labels
5. Enforce palette and style-guide rules
6. Remove markdown syntax and illegal LaTeX

---

## 6) Validation (Agent)
Run all relevant checks from docs/latex/LATEX_CHECKLIST.md before compiling.

---

## 7) Build Output
1. Compile in work/project_name/
2. Save outputs to:
   - output/project_name/pdf/
   - output/project_name/logs/

---

## 8) Final Review
Confirm:
- No branding conflicts
- Disclaimers visible
- Consistent typography and spacing
- No compilation errors
- TOC is correct

---

## 9) Handoff Notes
Add a short summary in work/project_name/agent_checklist.md with:
- Files changed
- Major fixes applied
- Remaining risks or manual review items
