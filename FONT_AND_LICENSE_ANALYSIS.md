# Font and License Analysis for intelapple.tex

## Date: January 17, 2026

## Overview
This document provides a comprehensive analysis of fonts, colors, and package dependencies used in the LaTeX document, along with their licensing information.

---

## 1. Color Definitions (msblue and others)

### Source: Custom Defined (Lines 39-43)
These colors are **NOT dependencies** - they are custom color definitions created specifically for this document:

```latex
\definecolor{msblue}{HTML}{002A5C}       % James Bian Dark Blue
\definecolor{msbrightblue}{HTML}{0096D6} % Light Blue for "INSIGHT" and Highlights
\definecolor{msgrey}{HTML}{F2F2F2}       % Light Grey for Backgrounds
\definecolor{mstextgrey}{HTML}{666666}   % Grey text for analysts
\definecolor{mstableheader}{HTML}{E5E5E5} % Grey for table headers
```

**License:** These are custom hex color values. Color values themselves are not copyrightable.
**Commercial Use:** ✅ **FREE** - No restrictions
**Proprietary:** ❌ **NO** - These are just color definitions

---

## 2. Primary Font: Helvetica (via helvet package)

### Package Used
- **Package:** `\usepackage[scaled]{helvet}` (Line 8)
- **Font Family:** URW Nimbus Sans L (Helvetica clone)

### Font Details
The `helvet` package provides access to Helvetica-like fonts through:
- **URW Nimbus Sans L** - A free, open-source Helvetica clone
- Located in: `/usr/share/texlive/texmf-dist/fonts/type1/urw/helvetic/`

### Licensing Information

#### helvetic (font files): **GPL (GNU General Public License)**
- **Source:** URW Type Foundry
- **License:** GPL (General Public License)
- **Commercial Use:** ✅ **FREE** for commercial use
- **Proprietary:** ❌ **NO** - Open source under GPL
- **Distribution:** Can be freely used, modified, and distributed
- **Note:** GPL allows commercial use, but derivative works must also be GPL

#### psnfss (helvet.sty package): **LPPL (LaTeX Project Public License)**
- **Package:** PostScript font support for LaTeX
- **License:** LPPL (LaTeX Project Public License)
- **Commercial Use:** ✅ **FREE** for commercial use
- **Proprietary:** ❌ **NO** - Open source

### Important Notes on Helvetica
- **Original Helvetica** (by Linotype) is proprietary and commercial
- **This document uses URW Nimbus Sans L**, which is a free, GPL-licensed Helvetica clone
- URW fonts were released as free software and are widely used in TeX distributions
- The fonts look virtually identical to Helvetica but are completely free

---

## 3. Other LaTeX Packages Used

### Core Packages and Their Licenses

| Package | Purpose | License | Commercial Use | Proprietary |
|---------|---------|---------|----------------|-------------|
| **geometry** | Page layout | LPPL 1.3c | ✅ FREE | ❌ NO |
| **fontenc** | Font encoding | LPPL | ✅ FREE | ❌ NO |
| **xcolor** | Color support | LPPL 1.3c | ✅ FREE | ❌ NO |
| **graphicx** | Graphics inclusion | LPPL | ✅ FREE | ❌ NO |
| **tcolorbox** | Colored boxes | LPPL 1.3 | ✅ FREE | ❌ NO |
| **booktabs** | Professional tables | LPPL 1.3c | ✅ FREE | ❌ NO |
| **array** | Array/table environments | LPPL | ✅ FREE | ❌ NO |
| **tabularx** | Extended tables | LPPL | ✅ FREE | ❌ NO |
| **fancyhdr** | Custom headers/footers | LPPL 1.3 | ✅ FREE | ❌ NO |
| **tikz** | Graphics/diagrams | LPPL/GPL | ✅ FREE | ❌ NO |
| **pgfplots** | Plotting | GPL 3+ | ✅ FREE | ❌ NO |
| **float** | Float positioning | LPPL | ✅ FREE | ❌ NO |
| **caption** | Caption customization | LPPL | ✅ FREE | ❌ NO |
| **multicol** | Multiple columns | LPPL | ✅ FREE | ❌ NO |
| **adjustbox** | Box adjustments | LPPL | ✅ FREE | ❌ NO |
| **titlesec** | Section title formatting | LPPL | ✅ FREE | ❌ NO |
| **enumitem** | List customization | LPPL | ✅ FREE | ❌ NO |
| **changepage** | Page layout changes | LPPL | ✅ FREE | ❌ NO |

---

## 4. License Details

### LPPL (LaTeX Project Public License)
- **Type:** Free software license
- **Commercial Use:** ✅ Fully allowed
- **Modifications:** Allowed (with renamed files)
- **Distribution:** Free
- **Compatibility:** Can be used in commercial documents
- **Full text:** `/usr/share/common-licenses/` or included with packages

### GPL (GNU General Public License)
- **Type:** Free software license (copyleft)
- **Commercial Use:** ✅ Fully allowed
- **Modifications:** Allowed
- **Distribution:** Free (derivatives must also be GPL)
- **Compatibility:** Can be used in commercial documents
- **Note:** The GPL applies to the software/fonts, not to documents created with them

---

## 5. Summary and Recommendations

### ✅ All Components Are Free and Open Source

**GOOD NEWS:** All fonts and packages used in this document are:
- ✅ **FREE** for commercial use
- ✅ **Open source** (not proprietary)
- ✅ **No licensing fees** required
- ✅ **Safe for business/commercial documents**

### Key Points

1. **msblue** is just a custom color definition - not a dependency
2. **Helvetica font** is provided via URW Nimbus Sans L (GPL) - completely free
3. **All LaTeX packages** are under LPPL or GPL - both allow commercial use
4. **No proprietary software** is being used
5. **No licensing costs** for any component

### License Compliance

To use this document commercially, you only need to:
- ✅ Keep using the free packages as-is
- ✅ Credit LaTeX/TeX if you want (courteous but not required)
- ❌ **No payment** needed
- ❌ **No special licenses** to purchase

### For Maximum Safety

If you want to be extra cautious about font licensing:
- The current setup uses **URW Nimbus Sans L** (free Helvetica clone)
- Alternatively, you could use **Latin Modern Sans** or **TeX Gyre Heros** (also free)
- All are high-quality, professional fonts with no licensing restrictions

---

## 6. Font Source Verification

### Where the Fonts Come From

```bash
Font files location:
/usr/share/texlive/texmf-dist/fonts/type1/urw/helvetic/

Package definition:
/usr/share/texlive/texmf-dist/tex/latex/psnfss/helvet.sty
```

### URW Type Foundry
- **Company:** URW Type Foundry (Germany)
- **Action:** Released their fonts under GPL in 1996
- **Fonts:** Include Helvetica clone (Nimbus Sans), Times clone, etc.
- **Status:** Industry-standard free fonts, widely trusted

---

## Conclusion

**🎉 You're completely safe!** 

All components in your LaTeX document are free, open-source, and suitable for commercial use. There are no proprietary fonts or commercial dependencies. The document can be used freely for business, publication, or any other purpose without licensing concerns.

**msblue** is simply a color you defined yourself - it's not a dependency from anywhere.

The **helvet** package provides free Helvetica-like fonts from URW, licensed under GPL, which explicitly allows commercial use.
