# WezTerm Config

Personal WezTerm setup for Windows, WSL, Catppuccin Mocha, and Starship.

## Where To Edit

| Need | File |
| --- | --- |
| Main entry and load order | `wezterm.lua` |
| Font family and font size | `config/fonts.lua` |
| Theme colors | `themes/catppuccin-mocha.lua` |
| Tab bar, titlebar, window padding | `config/ui.lua` |
| Rendering, cursor, background, command palette | `config/appearance.lua` |
| Keybindings and mouse bindings | `config/bindings.lua` |
| Default shell and launch menu | `config/launch.lua` |
| WSL and SSH domains | `config/domains.lua` |
| General terminal behavior | `config/general.lua` |
| Left status area | `events/left-status.lua` |
| Right status area | `events/right-status.lua` |
| Custom tab title rendering | `events/tab-title.lua` |
| New tab button behavior | `events/new-tab-button.lua` |
| Startup window behavior | `events/gui-startup.lua` |
| Background image utility | `utils/backdrops.lua` |
| Background images | `assets/backdrops/` |
| Starship prompt theme | `C:\Users\sentuix\.config\starship.toml` |

## Structure

```text
wezterm.lua
config/
  appearance.lua
  bindings.lua
  domains.lua
  fonts.lua
  general.lua
  launch.lua
  ui.lua
events/
  gui-startup.lua
  left-status.lua
  new-tab-button.lua
  right-status.lua
  tab-title.lua
themes/
  catppuccin-mocha.lua
integrations/
  starship.toml
utils/
  backdrops.lua
  cells.lua
  gpu-adapter.lua
  math.lua
  opts-validator.lua
  platform.lua
  str.lua
assets/
  backdrops/
```

## Starship

WezTerm starts PowerShell with `STARSHIP_CONFIG` pointing to:

```text
C:\Users\sentuix\.config\starship.toml
```

Install Starship separately before the prompt theme appears:

```powershell
choco install starship -y
```

Run that command from an elevated PowerShell if Chocolatey is installed system-wide.

## Validation

After editing Lua config:

```powershell
wezterm.exe show-keys --lua
```
