# centrex-branding

Visual identity assets for CentrexOS: logo, colour palette, Plymouth boot splash, and GRUB theme.

---

## Structure

```
branding/
├── logo/
│   ├── centrexos.svg         Primary colour logo (512×512, SVG)
│   └── centrexos-white.svg   White/monochrome variant for dark backgrounds
├── colors.json               Canonical brand colour palette (JSON)
├── plymouth/
│   └── centrex-splash/
│       ├── centrex-splash.plymouth   Theme descriptor
│       └── centrex-splash.script     Plymouth animation script
├── grub/
│   └── centrex-theme/
│       └── theme.txt                 GRUB2 theme definition
└── install.sh                        One-shot branding installer
```

---

## Colour Palette

Defined in `colors.json`. Key values:

| Role | Hex | Usage |
|---|---|---|
| Primary blue | `#7aa2f7` | Logo, accent, GRUB title, progress bar |
| Primary purple | `#bb9af7` | Secondary accent, gradient |
| Background base | `#1a1b26` | Screen background, GRUB desktop colour |
| Background surface | `#24283b` | Cards, inputs, terminal background |
| Foreground text | `#c0caf5` | Primary text |
| Foreground muted | `#a9b1d6` | Secondary text, subtitles |
| Error | `#f7768e` | Error states |
| Success | `#9ece6a` | Success states |
| Warning | `#e0af68` | Warnings |

The palette is based on the Tokyo Night colour scheme with CentrexOS-specific customisations.

---

## Logo

The logo (`logo/centrexos.svg`) uses a circular ring with a gradient from `#7aa2f7` (blue) to `#2ac3de` (cyan), a stylised **C** letterform in the centre, and a wordmark at the bottom. It scales cleanly from 16×16 favicons to full-size splash screens.

Use `centrexos-white.svg` on coloured or photo backgrounds where the gradient version would not be legible.

---

## Plymouth Boot Splash

The Plymouth theme (`centrex-splash`) shows:
- Background fill: `#1a1b26`
- Centred logo (`logo.png` — a rasterised copy of the SVG)
- Tagline: "Engineered for Flexibility and Performance"
- Animated progress bar (grows across the bottom of the logo area)
- Password prompt support for encrypted disks

### Installing the Plymouth theme

```sh
sudo ./install.sh
# or manually:
sudo cp -r plymouth/centrex-splash /usr/share/plymouth/themes/
sudo plymouth-set-default-theme centrex-splash
sudo update-initramfs -u
```

---

## GRUB Theme

`grub/centrex-theme/theme.txt` defines:
- Dark background (`#1a1b26`)
- Large **CentrexOS** title in `#7aa2f7`
- Boot menu centred at 25–75% width
- Timeout progress bar in `#7aa2f7`

### Installing the GRUB theme

```sh
sudo ./install.sh
# or manually:
sudo cp -r grub/centrex-theme /usr/share/grub/themes/centrex
echo 'GRUB_THEME="/usr/share/grub/themes/centrex/theme.txt"' | sudo tee -a /etc/default/grub
sudo update-grub
```

---

## One-Shot Install

```sh
sudo ./install.sh
```

Installs the Plymouth theme, GRUB theme, and logo assets to their correct system paths, then runs `update-grub` and marks the Plymouth theme as default.
