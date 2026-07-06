---@type Wezterm
local wezterm = require('wezterm')
local Cells = require('utils.cells')
local platform = require('utils.platform')

local nf = wezterm.nerdfonts
local attr = Cells.attr
local status_attrs = platform.is_mac and nil or attr(attr.intensity('Bold'))

local M = {}

local GLYPH_SEMI_CIRCLE_LEFT = nf.ple_left_half_circle_thick --[[ '' ]]
local GLYPH_SEMI_CIRCLE_RIGHT = nf.ple_right_half_circle_thick --[[ '' ]]
local GLYPH_KEY_TABLE = nf.md_table_key --[[ '󱏅' ]]
local GLYPH_KEY = nf.md_key --[[ '󰌆' ]]

---@type table<string, Cells.SegmentColors>
local colors = {
   default = { bg = '#fab387', fg = '#1c1b19' },
   scircle = { bg = 'rgba(0, 0, 0, 0.4)', fg = '#fab387' },
}

---@param name string
---@return string
local function format_key_table_name(name)
   local label = name
      :gsub('[_-]+', ' ')
      :gsub('%s+', ' ')
      :gsub('^%s+', '')
      :gsub('%s+$', '')
      :lower()

   label = label:gsub('%s+mode$', '')

   return (label:gsub('(%a)([%w]*)', function(first, rest)
      return first:upper() .. rest
   end))
end

local cells = Cells:new()

if not platform.is_mac then
   cells
      :add_segment(1, GLYPH_SEMI_CIRCLE_LEFT, colors.scircle, status_attrs)
      :add_segment(2, ' ', colors.default, status_attrs)
      :add_segment(3, ' ', colors.default, status_attrs)
      :add_segment(4, GLYPH_SEMI_CIRCLE_RIGHT, colors.scircle, status_attrs)
end

M.setup = function()
   wezterm.on('update-status', function(window, _pane)
      if platform.is_mac then
         window:set_left_status('')
         return
      end

      local name = window:active_key_table()
      local res = {}

      if name then
         cells
            :update_segment_text(2, GLYPH_KEY_TABLE)
            :update_segment_text(3, ' ' .. format_key_table_name(name):upper())
         res = cells:render_all()
      end

      if window:leader_is_active() then
         cells
            :update_segment_text(2, GLYPH_KEY)
            :update_segment_text(3, ' ')
         res = cells:render_all()
      end
      window:set_left_status(wezterm.format(res))
   end)
end

return M
