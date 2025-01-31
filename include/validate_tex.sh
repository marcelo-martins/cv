#!/bin/sh

set - e # Exists on the first error

# ===============================
# Validates the .tex file
# Author: Marcelo Martins
# Usage: This script uses pdflatex library to validate the .tex file and convert it to pdf
# Environment Variables:
#   - FILE_NAME: The LaTeX file name (without extension)
#   - INPUT_FILE: The LaTeX file relative path
#   - OUTPUT_DIR: The latex/output path in which the .pdf will be generated
# ===============================

INPUT_FILE=/latex/input/$FILE_NAME.tex
OUTPUT_DIR=/latex/output

# Validate the .tex file
echo "Validating LaTeX file: $INPUT_FILE..."
pdflatex -halt-on-error -interaction=nonstopmode "$INPUT_FILE"

# If the .tex is validated, convert it to .pdf
if [ $? -eq 0 ]; then
    echo "Validation succeeded. Generating PDF..."
    pdflatex -output-directory="$OUTPUT_DIR" "$INPUT_FILE"
    # Clear auxiliary files
    rm -f "$OUTPUT_DIR"/*.aux "$OUTPUT_DIR"/*.log "$OUTPUT_DIR"/*.out
else
    echo "Validation failed. Skipping PDF generation."
fi