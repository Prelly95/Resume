# Patrick Prell - CV build tasks
#
# The document must be built with LuaLaTeX: cv.tex declares
# `% !TEX TS-program = luatex` and documentMETADATA.cls loads
# fontspec + luainputenc, neither of which work under pdflatex.

src     := "cv"
outname := "patrick_prell_cv"
cl_src  := "cover_letter"
cl_out  := "patrick_prell_cover_letter"
outdir  := "build"

# List available recipes
default:
    @just --list

# Build patrick_prell_cv.pdf into build/ and copy to repo root (tracked deliverable)
build:
    mkdir -p {{outdir}}
    latexmk -lualatex -interaction=nonstopmode -halt-on-error \
        -output-directory={{outdir}} -jobname={{outname}} {{src}}.tex
    cp {{outdir}}/{{outname}}.pdf {{outname}}.pdf

# Clean everything, then build from scratch
rebuild: clean build

# Rebuild automatically whenever a source file is saved
watch:
    mkdir -p {{outdir}}
    latexmk -lualatex -pvc -interaction=nonstopmode \
        -output-directory={{outdir}} -jobname={{outname}} {{src}}.tex

# Build and open the PDF in the default viewer
view: build
    xdg-open {{outdir}}/{{outname}}.pdf

# Remove LaTeX aux files but keep the PDF
clean-aux:
    latexmk -c -output-directory={{outdir}}

# Remove LaTeX aux files and the PDF
clean:
    latexmk -C -output-directory={{outdir}}

# Build the cover letter PDF into build/ and copy to repo root (tracked deliverable)
cover-letter:
    mkdir -p {{outdir}}
    latexmk -lualatex -interaction=nonstopmode -halt-on-error \
        -output-directory={{outdir}} -jobname={{cl_out}} {{cl_src}}.tex
    cp {{outdir}}/{{cl_out}}.pdf {{cl_out}}.pdf

# Build both the CV and cover letter
all: build cover-letter

# Rebuild the cover letter automatically whenever a source file is saved
watch-cover-letter:
    mkdir -p {{outdir}}
    latexmk -lualatex -pvc -interaction=nonstopmode \
        -output-directory={{outdir}} -jobname={{cl_out}} {{cl_src}}.tex

# Build and open the cover letter in the default viewer
view-cover-letter: cover-letter
    xdg-open {{outdir}}/{{cl_out}}.pdf

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
