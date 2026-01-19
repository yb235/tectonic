#!/bin/bash
# LaTeX Document Validation Script
# Part of latex-workflow automation skill
# Validates LaTeX documents against repository standards

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Usage function
usage() {
    echo "Usage: $0 <latex_file.tex>"
    echo ""
    echo "Validates LaTeX document against repository standards"
    echo "Returns exit code 0 if all checks pass, 1 otherwise"
    exit 1
}

# Check if file argument provided
if [ $# -eq 0 ]; then
    usage
fi

FILE="$1"

# Check if file exists
if [ ! -f "$FILE" ]; then
    echo -e "${RED}Error: File '$FILE' not found${NC}"
    exit 1
fi

# Initialize counters
ERRORS=0
WARNINGS=0
CHECKS=0

echo -e "${BLUE}=========================================${NC}"
echo -e "${BLUE}LaTeX Document Validation Suite${NC}"
echo -e "${BLUE}File: $FILE${NC}"
echo -e "${BLUE}=========================================${NC}"

# PHASE 1: Preamble Compliance
echo -e "\n${YELLOW}[Phase 1] Preamble Compliance${NC}"
CHECKS=$((CHECKS+1))

# Check for forbidden colortbl package
if grep -q "\\usepackage{colortbl}" "$FILE"; then
    echo -e "${RED}❌ CRITICAL: colortbl package detected (causes conflicts)${NC}"
    ERRORS=$((ERRORS+1))
else
    echo -e "${GREEN}✅ No colortbl conflicts${NC}"
fi

# Check for institutional color names
if grep -qE "definecolor\{(ms|gs|citi|morgan|stanley)" "$FILE"; then
    echo -e "${RED}❌ CRITICAL: Institutional color names detected${NC}"
    grep -nE "definecolor\{(ms|gs|citi|morgan|stanley)" "$FILE"
    ERRORS=$((ERRORS+1))
else
    echo -e "${GREEN}✅ Neutral color names used${NC}"
fi

# PHASE 2: Document Structure
echo -e "\n${YELLOW}[Phase 2] Document Structure${NC}"
CHECKS=$((CHECKS+1))

# Check for pseudo-headings
PSEUDO_HEADINGS=$(grep -c "^\\\\textbf{.*}$" "$FILE" 2>/dev/null || echo "0")
PSEUDO_HEADINGS=$(echo "$PSEUDO_HEADINGS" | tr -d '\n' | tr -d ' ')
if [ "$PSEUDO_HEADINGS" -gt 0 ] 2>/dev/null; then
    echo -e "${YELLOW}⚠️  WARNING: $PSEUDO_HEADINGS pseudo-headings found (should use \\subsection)${NC}"
    WARNINGS=$((WARNINGS+1))
else
    echo -e "${GREEN}✅ No pseudo-headings${NC}"
fi

# Check for excessive nesting
DEEP_NESTING=$(grep -c "\\subsubsection" "$FILE" 2>/dev/null || echo "0")
DEEP_NESTING=$(echo "$DEEP_NESTING" | tr -d '\n' | tr -d ' ')
if [ "$DEEP_NESTING" -gt 0 ]; then
    echo -e "${YELLOW}⚠️  WARNING: Excessive nesting (subsubsection) detected${NC}"
    WARNINGS=$((WARNINGS+1))
else
    echo -e "${GREEN}✅ Heading depth compliant${NC}"
fi

# PHASE 3: Table Compliance
echo -e "\n${YELLOW}[Phase 3] Table Compliance${NC}"
CHECKS=$((CHECKS+1))

# Check for illegal table captions
ILLEGAL_TABLE_CAPTIONS=$(grep -c "\\captionof{table}" "$FILE" 2>/dev/null || echo "0")
ILLEGAL_TABLE_CAPTIONS=$(echo "$ILLEGAL_TABLE_CAPTIONS" | tr -d '\n' | tr -d ' ')
if [ "$ILLEGAL_TABLE_CAPTIONS" -gt 0 ] 2>/dev/null; then
    echo -e "${RED}❌ CRITICAL: $ILLEGAL_TABLE_CAPTIONS illegal \\captionof{table} found${NC}"
    grep -n "\\captionof{table}" "$FILE"
    ERRORS=$((ERRORS+1))
else
    echo -e "${GREEN}✅ All tables use proper float environments${NC}"
fi

# Check for incorrect width usage
BAD_WIDTH=$(grep -c "adjustbox}{width=" "$FILE" 2>/dev/null || echo "0")
BAD_WIDTH=$(echo "$BAD_WIDTH" | tr -d '\n' | tr -d ' ')
if [ "$BAD_WIDTH" -gt 0 ] 2>/dev/null; then
    echo -e "${RED}❌ CRITICAL: $BAD_WIDTH tables using 'width=' instead of 'max width='${NC}"
    grep -n "adjustbox}{width=" "$FILE"
    ERRORS=$((ERRORS+1))
else
    echo -e "${GREEN}✅ All tables use 'max width'${NC}"
fi

# Check for duplicate table labels
DUPLICATE_TAB_LABELS=$(grep "\\label{tab:" "$FILE" 2>/dev/null | cut -d'{' -f2 | cut -d'}' -f1 | sort | uniq -d | wc -l)
if [ "$DUPLICATE_TAB_LABELS" -gt 0 ]; then
    echo -e "${RED}❌ CRITICAL: $DUPLICATE_TAB_LABELS duplicate table labels found${NC}"
    grep "\\label{tab:" "$FILE" | cut -d'{' -f2 | cut -d'}' -f1 | sort | uniq -d
    ERRORS=$((ERRORS+1))
else
    echo -e "${GREEN}✅ All table labels are unique${NC}"
fi

# PHASE 4: Figure Compliance
echo -e "\n${YELLOW}[Phase 4] Figure Compliance${NC}"
CHECKS=$((CHECKS+1))

# Check for illegal figure captions
ILLEGAL_FIG_CAPTIONS=$(grep -c "\\captionof{figure}" "$FILE" 2>/dev/null || echo "0")
ILLEGAL_FIG_CAPTIONS=$(echo "$ILLEGAL_FIG_CAPTIONS" | tr -d '\n' | tr -d ' ')
if [ "$ILLEGAL_FIG_CAPTIONS" -gt 0 ] 2>/dev/null; then
    echo -e "${RED}❌ CRITICAL: $ILLEGAL_FIG_CAPTIONS illegal \\captionof{figure} found${NC}"
    grep -n "\\captionof{figure}" "$FILE"
    ERRORS=$((ERRORS+1))
else
    echo -e "${GREEN}✅ All figures use proper float environments${NC}"
fi

# Check for hardcoded colors in charts
HARDCODED_COLORS=$(grep -c "fill=.*!" "$FILE" 2>/dev/null || echo "0")
HARDCODED_COLORS=$(echo "$HARDCODED_COLORS" | tr -d '\n' | tr -d ' ')
if [ "$HARDCODED_COLORS" -gt 0 ] 2>/dev/null; then
    echo -e "${YELLOW}⚠️  WARNING: $HARDCODED_COLORS hardcoded colors found (prefer semantic styles)${NC}"
    WARNINGS=$((WARNINGS+1))
else
    echo -e "${GREEN}✅ Using semantic color styles${NC}"
fi

# Check for duplicate figure labels
DUPLICATE_FIG_LABELS=$(grep "\\label{fig:" "$FILE" 2>/dev/null | cut -d'{' -f2 | cut -d'}' -f1 | sort | uniq -d | wc -l)
if [ "$DUPLICATE_FIG_LABELS" -gt 0 ]; then
    echo -e "${RED}❌ CRITICAL: $DUPLICATE_FIG_LABELS duplicate figure labels found${NC}"
    grep "\\label{fig:" "$FILE" | cut -d'{' -f2 | cut -d'}' -f1 | sort | uniq -d
    ERRORS=$((ERRORS+1))
else
    echo -e "${GREEN}✅ All figure labels are unique${NC}"
fi

# PHASE 5: Legal Compliance
echo -e "\n${YELLOW}[Phase 5] Legal Compliance${NC}"
CHECKS=$((CHECKS+1))

# Check for legal disclaimer
if grep -q "EDUCATIONAL CASE STUDY -- NOT FOR INVESTMENT PURPOSES" "$FILE"; then
    echo -e "${GREEN}✅ Legal disclaimer present${NC}"
else
    echo -e "${RED}❌ CRITICAL: Legal disclaimer missing${NC}"
    ERRORS=$((ERRORS+1))
fi

# Check for watermark
if grep -q "AddToShipoutPictureBG" "$FILE"; then
    echo -e "${GREEN}✅ Watermark configured${NC}"
else
    echo -e "${RED}❌ CRITICAL: Watermark missing${NC}"
    ERRORS=$((ERRORS+1))
fi

# Check for institutional branding violations
INSTITUTIONAL_REFS=$(grep -ciE "(morgan stanley|goldman sachs|jp ?morgan|citigroup|bank of america)" "$FILE" 2>/dev/null || echo 0)
if [ "$INSTITUTIONAL_REFS" -gt 0 ]; then
    echo -e "${YELLOW}⚠️  WARNING: $INSTITUTIONAL_REFS potential institutional references found${NC}"
    echo -e "${YELLOW}    Review context to ensure these are content references, not branding${NC}"
    WARNINGS=$((WARNINGS+1))
else
    echo -e "${GREEN}✅ No institutional branding in headers/colors${NC}"
fi

# PHASE 6: Additional Checks
echo -e "\n${YELLOW}[Phase 6] Additional Validation${NC}"
CHECKS=$((CHECKS+1))

# Check for unescaped special characters (simplified check)
UNESCAPED_AMP=$(grep -c "[^\\]&" "$FILE" 2>/dev/null || echo 0)
if [ "$UNESCAPED_AMP" -gt 5 ]; then  # Allow some in tables
    echo -e "${YELLOW}⚠️  WARNING: Potentially unescaped & characters detected${NC}"
    echo -e "${YELLOW}    Verify all & outside tables are escaped as \\&${NC}"
    WARNINGS=$((WARNINGS+1))
else
    echo -e "${GREEN}✅ Special character escaping looks good${NC}"
fi

# Document Statistics
echo -e "\n${BLUE}[Document Statistics]${NC}"
SECTIONS=$(grep -c "\\\\section{" "$FILE" 2>/dev/null || echo 0)
SUBSECTIONS=$(grep -c "\\\\subsection{" "$FILE" 2>/dev/null || echo 0)
TABLES=$(grep -c "\\\\begin{table}" "$FILE" 2>/dev/null || echo 0)
FIGURES=$(grep -c "\\\\begin{figure}" "$FILE" 2>/dev/null || echo 0)

echo "Sections: $SECTIONS"
echo "Subsections: $SUBSECTIONS"
echo "Tables: $TABLES"
echo "Figures: $FIGURES"

# Summary
echo -e "\n${BLUE}=========================================${NC}"
echo -e "${BLUE}Validation Summary${NC}"
echo -e "${BLUE}=========================================${NC}"
echo "Checks performed: $CHECKS phases"
echo -e "Errors: ${RED}$ERRORS${NC}"
echo -e "Warnings: ${YELLOW}$WARNINGS${NC}"

if [ "$ERRORS" -eq 0 ]; then
    echo -e "\n${GREEN}✅ ALL CRITICAL CHECKS PASSED - Ready to compile${NC}"
    if [ "$WARNINGS" -gt 0 ]; then
        echo -e "${YELLOW}⚠️  Review warnings for potential improvements${NC}"
    fi
    exit 0
else
    echo -e "\n${RED}❌ VALIDATION FAILED - $ERRORS critical issues found${NC}"
    echo -e "${RED}Fix errors before proceeding to compilation${NC}"
    exit 1
fi
