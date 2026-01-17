# Copyright, License, and Legal Audit: intelapple.tex

**Date:** January 17, 2026  
**File Audited:** `intelapple.tex`  
**Auditor:** GitHub Copilot

**Merged Sources:** This document now consolidates the prior font and license analysis into a single audit.

---

## 1. Executive Summary

The document `intelapple.tex` is technically compliant with copyright laws regarding the software components (fonts, packages) used to generate it. The assets are Open Source (GPL/LPPL) and free for commercial use.

**Use Caution:** The primary legal risk is not copyright but **Trademark/Trade Dress**. The document historically used a Morgan Stanley-like palette and naming conventions. Those variable names have now been renamed and the palette slightly adjusted, which reduces—but does not eliminate—the trade dress risk if the overall design still resembles a specific institutional template.

---

## 2. Font Analysis (Merged)

The document uses the `helvet` package for its sans-serif typography.

| Package | Defined in File | Actual Font Used (TeX Live/Default) | License | Commercial Status |
| :--- | :--- | :--- | :--- | :--- |
| `helvet` | `\usepackage[scaled]{helvet}` | **URW Nimbus Sans L** (`uhvr8a.pfb`) | **GPL / AFPL** | ✅ **Free & Legal** |

*   **Details**: While the package is named `helvet` (implying Helvetica), standard TeX distributions (like the one in this environment) map this to **URW Nimbus Sans L**, a free, open-source clone created by URW++.
*   **Adobe Helvetica**: If the document is compiled on a system where `helvet` is manually mapped to the proprietary Adobe Helvetica font, a license for that font would be required. In this container and most standard setups, it is the free clone.
*   **GPL scope note**: The GPL applies to the font software itself, not to the documents you create with it. Commercial use of the document is permitted.

---

## 3. Color and Branding Analysis (Trade Dress Risk)

The document defines custom colors. These are not external dependencies and are not copyrightable by themselves.

**Current palette (renamed and adjusted):**

| Defined Name | Hex Code | Notes | Risk Factor |
| :--- | :--- | :--- | :--- |
| `brandblue` | `#003366` | Generic navy (adjusted) | ⚠️ **Lower** |
| `brandaccent` | `#008EC7` | Accent blue (adjusted) | ⚠️ **Lower** |
| `lightgrey` | `#F3F3F3` | Neutral background | 🟢 Low |
| `textgrey` | `#6A6A6A` | Neutral text | 🟢 Low |
| `tableheader` | `#E6E6E6` | Neutral header grey | 🟢 Low |

*   **Analysis**: Colors themselves are generally not copyrightable. However, a specific combination of colors, fonts, and layout styles can be protected as **Trade Dress** if it is distinctive to a brand.
*   **Naming cleanup**: The previous `ms*` variable names were removed to avoid implied branding.
*   **Recommendation**: If commercial distribution is planned, ensure the overall layout and branding does not imply affiliation with any specific financial institution.

---

## 4. LaTeX Package Licensing (Merged)

All packages used in the document are standard components of the TeX Live distribution and are covered by the **LPPL (LaTeX Project Public License)** or compatible free software licenses.

| Package | License | Status |
| :--- | :--- | :--- |
| `geometry`, `fontenc`, `xcolor`, `graphicx` | LPPL | ✅ Legal |
| `tcolorbox`, `tikz`, `pgfplots` | LPPL/GPL | ✅ Legal |
| `booktabs`, `array`, `tabularx` | LPPL | ✅ Legal |
| `fancyhdr`, `caption`, `float` | LPPL | ✅ Legal |
| `adjustbox`, `titlesec`, `enumitem` | LPPL | ✅ Legal |

---

## 5. Content and Trademark Usage

The document mentions several third-party entities.

*   **Entities Referenced**: Apple Inc., Intel Corp., TSMC, Samsung.
*   **Legal Doctrine**: **Nominative Fair Use**.
    *   It is legal to use a trademark (e.g., "Intel") to refer to the actual company or its products, provided you do not suggest sponsorship or endorsement by that company.
    *   **Context**: The document appears to be an investment research report *about* these companies. This is a standard, protected form of speech and commercial activity.
*   **Images**: No external images (`.png`, `.jpg`, `.pdf`) were found linked via `\includegraphics` in the source code. All graphics are generated procedurally using `TikZ`/`PGFPlots`, which is creating original content, not copying existing copyrighted diagrams.

---

## 6. Final Checklist for Commercial Distribution

1.  **[ ]** **Fonts**: Confirm you are compiling with the standard URW fonts (default in TeX Live) and not proprietary Adobe fonts.
2.  **[ ]** **Branding**: If selling this report, verify that the design does not imply affiliation with any specific institution. A disclaimer may be advisable depending on distribution context.
3.  **[ ]** **Content**: Ensure factual accuracy. Opinions are protected, but presenting false facts as truth can lead to libel issues (though this is rare in equity research).
