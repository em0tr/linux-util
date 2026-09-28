#!/bin/bash

file="build-latex"
dir="bin"

echo "Checking dependencies..."
required_commands=(
    make 
    latexmk
    pdflatex
    xelatex
    lualatex
    evince
)

for cmd in "${required_commands[@]}"; do 
    if command -v "$cmd" >/dev/null 2>&1; then
        echo "$cmd found"
    else
        echo "$cmd not found"
        missing+=("$cmd")
    fi 
done

if (( ${#missing[@]} > 0 )); then
    echo ""
    echo "Error: The following dependencies are missing:"
    printf ' - %s\n' "${missing[@]}"
    echo ""
    echo "Please install them before continuing."
    exit 1
fi

echo ""
echo "All dependencies found."

echo "Create a $dir directory if it doesn't exist."
mkdir -p "$HOME/$dir"

echo "Copy the $file script to the $HOME/$dir directory."
cp "$file" "$HOME/$dir/"

echo "Make script executable."
chmod +x "$HOME/$dir/$file"

echo "Install finished."
