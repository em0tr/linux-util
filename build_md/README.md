# Build Markdown

## Overview
Build a large Markdown file using multiple smaller ones in the current directory.

## Prerequisites
- Make
- Python3 (Needed to create Table of Contents of the Markdown files)

## Setup
1. **Clone the repository**:
    ```bash
    git clone https://github.com/em0tr/linux-util.git
    cd util
    ```
2. **Run the install.sh script to create the command for building**
    ```bash
    ./install.sh
    ```
3. **Change directory to any directory with Markdown files and run the command to get a file named main.md**
    ```bash
    cd <directory_with_md_files>
    build-md
    ```
4. **Open the new main.md file in your preferred editor, such as Neovim**
    ```bash
    nvim main.md 
    ```

## Create a files.list file
For build-md to know how to organize the order of the files in the directory, create a file named files.list and add the order of the files separated by newlines. For example for a directory named dir with Markdown files on networks can look something like:
```bash
dir/
  nat.md 
  private_network_addresses.md 
  subnets.md 
```
With no files.list file, build-md will *not* work since it does not know how to organize the files for the main.md file. By creating a files.list you can easily organize the order of the files manually.
```bash
dir/
  files.list
  nat.md 
  private_network_addresses.md 
  subnets.md
```
where the files.list can look like:
```bash
private_network_addresses.md 
subnets.md 
nat.md 
```
build-md should work with the specified order. 



