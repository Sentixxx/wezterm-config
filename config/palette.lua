-- Keep the top bar palette constrained to Catppuccin Mocha tokens.
-- Do not introduce ad-hoc colors here; this file only composes the preset.
local mocha = {
   rosewater = '#f5e0dc',
   flamingo = '#f2cdcd',
   pink = '#f5c2e7',
   mauve = '#cba6f7',
   red = '#f38ba8',
   maroon = '#eba0ac',
   peach = '#fab387',
   yellow = '#f9e2af',
   green = '#a6e3a1',
   teal = '#94e2d5',
   sky = '#89dceb',
   sapphire = '#74c7ec',
   blue = '#89b4fa',
   lavender = '#b4befe',
   text = '#cdd6f4',
   subtext1 = '#bac2de',
   subtext0 = '#a6adc8',
   overlay2 = '#9399b2',
   overlay1 = '#7f849c',
   overlay0 = '#6c7086',
   surface2 = '#585b70',
   surface1 = '#45475a',
   surface0 = '#313244',
   base = '#1e1e2e',
   mantle = '#181825',
   crust = '#11111b',
}

local M = {}

M.topbar = {
   bg = mocha.crust,
   bg_inactive = mocha.crust,
   border = mocha.surface0,
   border_inactive = mocha.mantle,
   active = mocha.mauve,
   inactive = mocha.mantle,
   hover = mocha.surface0,
   text = mocha.text,
   text_active = mocha.crust,
   text_dim = mocha.overlay1,
   button_text = mocha.overlay2,
   accent = mocha.blue,
   button_hover = mocha.surface0,
}

M.topbar.tabs = {
   {
      inactive = mocha.mantle,
      hover = mocha.surface0,
      active = mocha.teal,
      active_fg = mocha.crust,
      fg = mocha.teal,
   },
   {
      inactive = mocha.mantle,
      hover = mocha.surface0,
      active = mocha.mauve,
      active_fg = mocha.crust,
      fg = mocha.mauve,
   },
   {
      inactive = mocha.mantle,
      hover = mocha.surface0,
      active = mocha.peach,
      active_fg = mocha.crust,
      fg = mocha.peach,
   },
   {
      inactive = mocha.mantle,
      hover = mocha.surface0,
      active = mocha.blue,
      active_fg = mocha.crust,
      fg = mocha.blue,
   },
   {
      inactive = mocha.mantle,
      hover = mocha.surface0,
      active = mocha.green,
      active_fg = mocha.crust,
      fg = mocha.green,
   },
   {
      inactive = mocha.mantle,
      hover = mocha.surface0,
      active = mocha.red,
      active_fg = mocha.crust,
      fg = mocha.red,
   },
}

M.tab_bar = {
   background = M.topbar.bg,
   inactive_tab_edge = M.topbar.border_inactive,
   active_tab = {
      bg_color = M.topbar.active,
      fg_color = M.topbar.text_active,
      intensity = 'Bold',
   },
   inactive_tab = {
      bg_color = M.topbar.inactive,
      fg_color = M.topbar.text_dim,
   },
   inactive_tab_hover = {
      bg_color = M.topbar.hover,
      fg_color = M.topbar.text,
   },
   new_tab = {
      bg_color = mocha.crust,
      fg_color = mocha.overlay1,
   },
   new_tab_hover = {
      bg_color = mocha.surface0,
      fg_color = mocha.lavender,
   },
}

return M
