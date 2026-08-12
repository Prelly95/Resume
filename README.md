# Patrick Prell — CV

LaTeX source for my curriculum vitae. Builds to a 3-page `cv.pdf` with LuaLaTeX.

- **Patrick Prell** — Embedded Systems Engineer, Sydney NSW
- prelly95@gmail.com · [linkedin.com/in/patprell](https://linkedin.com/in/patprell) · [github.com/prelly95](https://github.com/prelly95)

---

## TL;DR — who I am

Embedded systems and mechatronics engineer with experience spanning bare-metal firmware,
embedded Linux, computer vision and hardware design. I like difficult problems, robust
workflows and owning a feature end to end.

**Experience**

| Period | Role | Where |
| --- | --- | --- |
| Nov 2023 – present | Embedded Software Engineer | DroneShield |
| May 2022 – Sep 2023 | Embedded Systems Engineer | ResusRight (medical devices) |
| Apr 2018 – May 2022 | Mechatronic Engineer | CORDEL |
| Sep 2019 – present | Founding Member | Borne Clothing |
| Aug 2018 – Nov 2018 | Tutor, ELEC3850 / ENGG1003 | University of Newcastle |
| Feb 2018 – Apr 2018 | Creative Technologist | Core Electronics |

Selected work: cut an AFE calibration process from 12+ hours to 40 minutes (20x) at
DroneShield, removing a production bottleneck; built battery management and alerting for
handheld devices, including a bootloader-level fix for a hardware-caused power bug. At
ResusRight, led a Qt-on-embedded-Linux application on a SOM, developed firmware for the
"Nemo" clinical resuscitation monitor (NXP and Silicon Labs MCUs, BLE and serial stacks),
led the firmware for a manufacturing test jig, and built a Flutter companion app for the
"Juno Training Monitor". At CORDEL, implemented an Extended Kalman Filter fusing IMU / RTK
GPS / LiDAR for pose estimation, and pose/velocity estimation from optic flow with OpenCV.

**Programming languages** — C, Python; Rust, C++, MATLAB; JavaScript, Flutter;
SystemVerilog.

**Domains and tooling**

- *Embedded* — AtMega, STM32, ESP32/Espressif, NXP, Silicon Labs, embedded Linux, Bluetooth LE, Qt
- *Hardware* — PCB CAD (KiCad, ATOPile, Eagle), 3D CAD (PTC Creo, Fusion 360), SMD soldering, 3D printing (FDM/SLA), CNC router and laser cutting
- *Robotics / vision* — Bayesian filtering, sensor fusion, OpenCV, point cloud processing
- *Standards* — IEC 62304, IEC 60601, ISO 13485 (medical device development)

**Education** — B.Eng. Mechatronics (Honours), University of Newcastle, 2015–2019.
Short courses in QMS ISO 13485 (SeerPharma, 2023) and Vision-Based Navigation (2022).

The PDF is the source of truth, this section is just the summary.

---

## Building

### Requirements

The document **must** be compiled with **LuaLaTeX**. `cv.tex` declares
`% !TEX TS-program = luatex`, and `documentMETADATA.cls` requires `fontspec` and
`luainputenc`, so `pdflatex` will not work.

Fonts are vendored in `fonts/` (Adobe Source Sans Pro) and loaded via the class's
`localFont` option, so there is nothing to install system-wide for text.

You need a TeX Live installation providing LuaLaTeX, `latexmk`, and these packages:
`fontspec`, `fontawesome`, `tikz`/`pgf`, `tcolorbox`, `titlesec`, `enumitem`, `fullpage`,
`geometry`, `fancyhdr`, `hyphenat`, `hyperref`, `etoolbox`, `babel`.

### Setup — Arch Linux

```sh
just setup
```

which runs:

```sh
sudo pacman -S --needed \
    texlive-basic texlive-luatex texlive-latex texlive-latexrecommended \
    texlive-latexextra texlive-fontsrecommended texlive-fontsextra \
    texlive-pictures texlive-plaingeneric texlive-binextra
```

Roughly 940 MB of downloads / 2.4 GB installed. The bulk is `texlive-fontsextra`, which is
where the `fontawesome` package lives — the class uses it for the header icons, so it is
not optional. `texlive-meta` (~7 GB) also works if you would rather not track individual
packages.

### Setup — other systems

- **Debian / Ubuntu** — `sudo apt install texlive-luatex texlive-latex-extra texlive-fonts-extra texlive-pictures latexmk`
- **macOS** — `brew install --cask mactex` (or `basictex` plus the packages listed above via `tlmgr`)
- **Anywhere** — a full TeX Live install from [tug.org/texlive](https://tug.org/texlive/) covers everything

Confirm the toolchain is visible with `just check`.

### Build

```sh
just build      # produce cv.pdf
just view       # build, then open the PDF
just watch      # rebuild on every save
just rebuild    # clean, then build from scratch
just clean      # remove aux files and cv.pdf
just clean-aux  # remove aux files, keep cv.pdf
just            # list all recipes
```

Without `just`, the equivalent single command is:

```sh
latexmk -lualatex cv.tex
```

`cv.pdf` and all LaTeX aux files are gitignored — the PDF is a build artefact, not a
tracked file.

## Repository layout

| Path | Purpose |
| --- | --- |
| `cv.tex` | Main document: header details, and the list of sections to include |
| `documentMETADATA.cls` | The document class — all layout, commands and styling |
| `section_*.tex` | One file per CV section |
| `fonts/` | Source Sans Pro OTF files, loaded by the `localFont` class option |
| `patprell.png` | Header photo |
| `justfile` | Build tasks |

### Editing

Personal details, photo and contact links live at the top of `cv.tex`. Content lives in the
`section_*.tex` files.

Sections are toggled by commenting the `\input{...}` lines in `cv.tex`. Currently included:
headline, experience, skills, languages, education, references. Also present in the repo but
commented out: `section_projects`, `section_publications_etc`, `section_honors_awards`,
`section_outreach_volunteering`, `section_teaching_mentoring`. Note that `cv.tex` has a
commented reference to `section_interets`, for which no file exists — uncommenting it will
fail until the file is written.

Useful class commands, all defined in `documentMETADATA.cls`:

- `\sectionTitle{<title>}{<Font Awesome icon>}` — a section heading
- `\experience{<end>}{<role>}{<employer>}{<start>}{<body>}{<comma-separated tags>}` — inside an `experiences` environment
- `\school{<end>}{<qualification>}{<institution>}{<start>}` — inside an `education` environment
- `\skill{<name>}{<1–5>}` — inside a `skills` environment
- `\referee{<name>}{<title>}{<organisation>}{<contact>}` — inside a `referees` environment
- `\emptySeparator` — vertical space between entries

### Known build noise

Two warnings appear in `cv.log` on every build. Both are template quirks, both are harmless:

- `(\end occurred inside a group at level 1)` — from the class's `\socialinfo` header handling
- `Package xcolor Warning: Package option 'usenames' is obsolete` — from `documentMETADATA.cls:63`

## Credits and licence

`documentMETADATA.cls` is a USA STEM CV template by **Sabrina Benge**, adapted from the
[YAAC — Another Awesome CV](https://github.com/darwiin/yaac-another-awesome-cv) template by
**Christophe Roger (Darwiin)**, which itself derives from a template by
**Alessandro Plasmati**. Template licensed under
[CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).

Fonts: [Source Sans Pro](https://github.com/adobe-fonts/source-sans-pro) by Adobe (SIL Open
Font License). Icons: [Font Awesome](https://fontawesome.io/).

The CV content itself is © Patrick Prell.
