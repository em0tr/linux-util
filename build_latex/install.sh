#!/bin/bash

file="build-latex"
dir="bin"

echo "Create a $dir directory if it doesn't exist"
mkdir -p ~/$dir 

echo "Copy the $file script to the ~/bin/ directory"
cp $file ~/$dir/

echo "Make script executable"
chmod +x ~/$dir/$file

echo "Install finished"
