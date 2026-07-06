local wezterm = require('wezterm')
local fonts = require('config.fonts')
local palette = require('config.palette')
local platform = require('utils.platform')

local tab_bar_font = nil
local tab_bar_font_size = nil
local window_decorations = 'TITLE|RESIZE'
local integrated_title_button_alignment = 'Right'
local integrated_title_button_style = 'Windows'
local integrated_title_buttons = { 'Hide', 'Maximize', 'Close' }
local use_fancy_tab_bar = false
local tab_max_width = 25
local window_padding = {
   left = 0,
   right = 0,
   top = 10,
   bottom = 7.5,
}

if platform.is_win then
   tab_bar_font = wezterm.font({
      family = 'Segoe UI',
      weight = 'Regular',
   })
   tab_bar_font_size = 10.5
   window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
   use_fancy_tab_bar = true
elseif platform.is_mac then
   tab_bar_font = wezterm.font({
      family = 'Monaco',
      weight = 'Regular',
   })
   tab_bar_font_size = 11.5
   window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
   integrated_title_button_alignment = 'Left'
   integrated_title_button_style = 'MacOsNative'
   integrated_title_buttons = { 'Close', 'Hide', 'Maximize' }
   use_fancy_tab_bar = true
   tab_max_width = 18
   window_padding = {
      left = 2,
      right = 2,
      top = 8,
      bottom = 4,
   }
else
   tab_bar_font = fonts.font
   tab_bar_font_size = fonts.font_size
end

local window_frame = {
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
}

if tab_bar_font then
   window_frame.font = tab_bar_font
end

if tab_bar_font_size then
   window_frame.font_size = tab_bar_font_size
end

return {
   -- tab bar
   enable_tab_bar = true,
   hide_tab_bar_if_only_one_tab = false,
   use_fancy_tab_bar = use_fancy_tab_bar,
   tab_max_width = tab_max_width,
   show_tab_index_in_tab_bar = false,
   switch_to_last_active_tab_when_closing_tab = true,

   -- window
   window_padding = window_padding,
   adjust_window_size_when_changing_font_size = false,
   window_close_confirmation = 'NeverPrompt',
   window_decorations = window_decorations,
   integrated_title_button_alignment = integrated_title_button_alignment,
   integrated_title_button_color = palette.topbar.button_text,
   integrated_title_button_style = integrated_title_button_style,
   integrated_title_buttons = integrated_title_buttons,
   window_frame = window_frame,
}
