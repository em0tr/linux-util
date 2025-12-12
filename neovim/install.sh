#!/bin/bash

nvim_file="init.lua"
nvim_dir="~/.config/nvim"

echo "Create the $nvim_dir if it doesn't exist"
mkdir -p $nvim_dir

echo "Copy the $nvim_file to the $nvim_dir"
cp $nvim_file $nvim_dir

echo "Copy the rest of the required files"
cp -r css/ $nvim_dir
cp -r lua/ $nvim_dir
