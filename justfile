# Patrick Prell - CV build tasks
#
# The document must be built with LuaLaTeX: cv.tex declares
# `% !TEX TS-program = luatex` and documentMETADATA.cls loads
# fontspec + luainputenc, neither of which work under pdflatex.

main := "cv"

# List available recipes
default:
    @just --list

# Build cv.pdf
build:
    latexmk -lualatex -interaction=nonstopmode -halt-on-error {{main}}.tex

# Clean everything, then build from scratch
rebuild: clean build

# Rebuild automatically whenever a source file is saved
watch:
    latexmk -lualatex -pvc -interaction=nonstopmode {{main}}.tex

# Build and open the PDF in the default viewer
view: build
    xdg-open {{main}}.pdf

# Remove LaTeX aux files but keep the PDF
clean-aux:
    latexmk -c

# Remove LaTeX aux files and the PDF
clean:
    latexmk -C

# Verify the toolchain is installed
check:
    @command -v lualatex >/dev/null || { echo "lualatex not found - see 'just setup'"; exit 1; }
    @command -v latexmk  >/dev/null || { echo "latexmk not found - see 'just setup'"; exit 1; }
    @lualatex --version | head -1

# Install the TeX Live packages needed to build (Arch Linux, prompts for sudo)
setup:
    sudo pacman -S --needed \
        texlive-basic texlive-luatex texlive-latex texlive-latexrecommended \
        texlive-latexextra texlive-fontsrecommended texlive-fontsextra \
        texlive-pictures texlive-plaingeneric texlive-binextra
