# Patrick Prell — CV

LaTeX source for my curriculum vitae. Builds to a 2-page `cv.pdf` with LuaLaTeX.

- **Patrick Prell** — Robotics & Embedded Systems Engineer, Sydney NSW
- prelly95@gmail.com · [linkedin.com/in/patprell](https://linkedin.com/in/patprell) · [github.com/Prelly95](https://github.com/Prelly95)

---

## TL;DR — who I am

Robotics and embedded systems engineer with eight years building hardware and software
that ships to real customers. Started on ArduPilot and PX4 survey UAVs, then spent three
years at DroneShield on deployed counter-UAS products. I lead projects end to end and do
my best work getting a system out of the lab and into the dirt.

**Experience**

| Period | Role | Where |
| --- | --- | --- |
| Nov 2023 – present | Embedded Software Engineer | DroneShield |
| Sep 2019 – May 2025 | Co-founder & CTO | Borne Clothing |
| May 2022 – Sep 2023 | Embedded Systems Engineer | ResusRight (medical devices) |
| Apr 2018 – May 2022 | Mechatronic Engineer | CORDEL (formerly Airsight) |

Selected work: delivered angle-of-arrival estimation and the conducted calibration for a
four-antenna direction-finding system at DroneShield; cut an AFE calibration process from
12+ hours to 40 minutes (20x), removing the single largest production bottleneck. At
ResusRight, led firmware for a manufacturing test jig, architected a Qt-on-embedded-Linux
application, and developed firmware for the "Nemo" clinical resuscitation monitor. At
CORDEL, implemented an Extended Kalman Filter fusing IMU / RTK GNSS / LiDAR for pose
estimation, and worked hands-on with ArduPilot and PX4 flight stacks across the survey
UAV fleet.

**Programming languages** — C, C++, Python, Rust, MATLAB, JavaScript, Flutter.

**Domains and tooling**

- *Aerial Robotics* — ArduPilot, PX4, UAV bring-up, tuning, mission planning, GNSS/RTK, field flight operations
- *Control & Estimation* — Extended Kalman Filter, Bayesian sensor fusion, observer design, discrete-time control loops
- *Embedded* — Embedded Linux, bare-metal C/C++, bootloaders, STM32, NXP, Silicon Labs, ESP32, Bluetooth LE, gRPC, Qt
- *Perception / Vision* — OpenCV (C++), optical flow, 3D reconstruction, calibration
- *Hardware* — PCB design (KiCad, Eagle), 3D CAD (PTC Creo, Fusion 360), SMD soldering, 3D printing, CNC
- *Standards* — IEC 62304, IEC 60601, ISO 13485 (medical device development)

**Projects**

- *Farm inspection drone* — Autonomous ROS 2 inspection stack for a VTOL platform (PX4 SITL)
- *UVie* — Battery-free wearable UV tracker (nRF54L15, Embedded Rust, BLE/NFC, SolidJS companion app)
- *Balancing robot* — Full-state feedback with Kalman observer, embedded C on ATMega32

**Education** — B.Eng. Mechatronics (Honours), University of Newcastle, 2015–2019.
Short course: Vision-Based Navigation (Dr Chris Renton, 2022).

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
| `justfile` | Build tasks |

### Editing

Personal details and contact links live at the top of `cv.tex`. Content lives in the
`section_*.tex` files.

Sections are toggled by commenting the `\input{...}` lines in `cv.tex`. Currently included:
headline, skills, experience, projects, education (with references). Also present in the
repo but commented out: `section_publications_etc`, `section_honors_awards`,
`section_outreach_volunteering`, `section_teaching_mentoring`.

Useful class commands, all defined in `documentMETADATA.cls`:

- `\sectionTitle{<title>}{<Font Awesome icon>}` — a section heading
- `\experience{<end>}{<role>}{<employer>}{<start>}{<body>}{<comma-separated tags>}` — inside an `experiences` environment
- `\school{<end>}{<qualification>}{<institution>}{<start>}` — inside an `education` environment
- `\project{<title>}{<year>}{<link>}{<description>}{<tags>}` — inside a `projects` environment
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
