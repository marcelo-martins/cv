#!/bin/sh

# Path to the input .tex file
INPUT_FILE=/latex/input/CV_Marcelo_Martins.tex
OUTPUT_DIR=/latex/output

# Step 1: Validate the .tex file
echo "Validating LaTeX file: $INPUT_FILE..."
pdflatex -halt-on-error -interaction=nonstopmode "$INPUT_FILE"

# Step 2: Check validation success
if [ $? -eq 0 ]; then
    echo "Validation succeeded. Generating PDF..."
    # Step 3: Compile the .tex file and clean up auxiliary files
    pdflatex -output-directory="$OUTPUT_DIR" "$INPUT_FILE"
    rm -f "$OUTPUT_DIR"/*.aux "$OUTPUT_DIR"/*.log "$OUTPUT_DIR"/*.out
else
    echo "Validation failed. Skipping PDF generation."
fi
