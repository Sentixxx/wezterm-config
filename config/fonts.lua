local wezterm = require('wezterm')
local platform = require('utils.platform')

local font_family = platform.is_mac and 'Menlo' or 'JetBrains Mono'
local font_size = platform.is_mac and 12 or 11
local font_fallback = nil

if platform.is_mac then
   font_fallback = {
      font_family,
      'Hiragino Sans GB',
      'Symbols Nerd Font Mono',
   }
else
   font_fallback = {
      font_family,
      'Symbols Nerd Font Mono',
   }
end

return {
   font = wezterm.font_with_fallback(font_fallback),
   font_size = font_size,
   line_height = platform.is_mac and 1.0 or nil,

   --ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
   freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
   freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}
