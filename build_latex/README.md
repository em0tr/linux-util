# Build LaTeX

## Overview
Build a $\LaTeX$ PDF using .tex file(s) in the current directory.

## Setup
1. **Be in the correct directory**:
    ```bash
    cd ~/
    ```
2. **Clone the repository**:
    ```bash
    git clone https://github.com/em0tr/linux-util.git
    mv linux-util util
    cd util/
    ```
3. **Create the command**:
    ```bash
    ./install.sh
    ```
4. **To build change to any directory with $\LaTeX$ file(s)**:
    ```bash
    cd <directory_with_tex_files>
    build-latex compile
    ```
5. **To view the built PDF**:
    ```bash
    build-latex view
    ```
6. **To clean up the many files that $\LaTeX$ creates**:
    ```bash
    build-latex clean
    ```

## Notes
For this command to work the main $\LaTeX$ file *must* be named 'main.tex'. The bibliography file must be named main.bib.
