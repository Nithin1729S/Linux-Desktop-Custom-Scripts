#!/bin/bash
shopt -s nullglob
for f in *.pptx; do
    libreoffice --headless --convert-to pdf "$f"
    pdf="${f%.pptx}.pdf"
    if [ -f "$pdf" ]; then
        rm "$f"
    fi
done
