local wezterm = require('wezterm')
local fonts = require('config.fonts')
local palette = require('config.palette')
local platform = require('utils.platform')

local tab_bar_font = platform.is_win and wezterm.font({
   family = 'Segoe UI',
   weight = 'Regular',
}) or fonts.font

local tab_bar_font_size = platform.is_win and 10.5 or fonts.font_size

return {
   -- tab bar
   enable_tab_bar = true,
   hide_tab_bar_if_only_one_tab = false,
   use_fancy_tab_bar = platform.is_win,
   tab_max_width = 25,
   show_tab_index_in_tab_bar = false,
   switch_to_last_active_tab_when_closing_tab = true,

   -- window
   window_padding = {
      left = 0,
      right = 0,
      top = 10,
      bottom = 7.5,
   },
   adjust_window_size_when_changing_font_size = false,
   window_close_confirmation = 'NeverPrompt',
   window_decorations = platform.is_win and 'INTEGRATED_BUTTONS|RESIZE' or 'TITLE|RESIZE',
   integrated_title_button_alignment = 'Right',
   integrated_title_button_color = palette.topbar.button_text,
   integrated_title_button_style = 'Windows',
   integrated_title_buttons = { 'Hide', 'Maximize', 'Close' },
   window_frame = {
      active_titlebar_bg = palette.topbar.bg,
      inactive_titlebar_bg = palette.topbar.bg_inactive,
      active_titlebar_fg = palette.topbar.text,
      inactive_titlebar_fg = palette.topbar.text_dim,
      active_titlebar_border_bottom = palette.topbar.border,
      inactive_titlebar_border_bottom = palette.topbar.border_inactive,
      button_bg = palette.topbar.bg,
      button_fg = palette.topbar.text,
      button_hover_bg = palette.topbar.button_hover,
      button_hover_fg = '#FFFFFF',
      font = tab_bar_font,
      font_size = tab_bar_font_size,
   },
}
