#!/bin/bash

file="simple-backup"
dir="bin"

echo "Create a $dir directory if it doesn't exist."
mkdir -p "$HOME/$dir"

echo "Copy the $file script to the $HOME/$dir directory."
cp "$file" "$HOME/$dir/"

echo "Make script executable."
chmod +x "$HOME/$dir/$file"

echo "Install finished."

