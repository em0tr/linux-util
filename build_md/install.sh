#!/bin/bash

file="build-md"
dir="bin"

echo "Create a $dir directory if it doesn't exist."
mkdir -p ~/$dir 

echo "Copy the build-md file to the ~/bin/ directory."
cp $file ~/$dir/

echo "File copied, making it executable."
chmod +x ~/$dir/$file

echo "File is executable. Install completed."
echo ""

