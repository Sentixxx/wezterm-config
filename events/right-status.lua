---@type Wezterm
local wezterm = require('wezterm')
local umath = require('utils.math')
local Cells = require('utils.cells')
local OptsValidator = require('utils.opts-validator')
local platform = require('utils.platform')

local nf = wezterm.nerdfonts
local attr = Cells.attr
local status_attrs = platform.is_mac and nil or attr(attr.intensity('Bold'))

---@alias Event.RightStatusOptionsInput { date_format?: string }

---@alias Event.RightStatusOptions { date_format: string }

---Setup options for the right status bar
---@type OptsValidator
local EVENT_OPTS = OptsValidator:new({
   {
      name = 'date_format',
      type = 'string',
      default = '%a %H:%M:%S',
   },
})

local M = {}

local ICON_SEPARATOR = nf.oct_dash
local ICON_DATE = nf.fa_calendar
local ICON_KEY_TABLE = nf.md_table_key
local ICON_KEY = nf.md_key

---@type string[]
local discharging_icons = {
   nf.md_battery_10,
   nf.md_battery_20,
   nf.md_battery_30,
   nf.md_battery_40,
   nf.md_battery_50,
   nf.md_battery_60,
   nf.md_battery_70,
   nf.md_battery_80,
   nf.md_battery_90,
   nf.md_battery,
}
---@type string[]
local charging_icons = {
   nf.md_battery_charging_10,
   nf.md_battery_charging_20,
   nf.md_battery_charging_30,
   nf.md_battery_charging_40,
   nf.md_battery_charging_50,
   nf.md_battery_charging_60,
   nf.md_battery_charging_70,
   nf.md_battery_charging_80,
   nf.md_battery_charging_90,
   nf.md_battery_charging,
}

---@type table<string, Cells.SegmentColors>
-- stylua: ignore
local colors = {
   date      = { fg = '#fab387', bg = 'rgba(0, 0, 0, 0.4)' },
   battery   = { fg = '#f9e2af', bg = 'rgba(0, 0, 0, 0.4)' },
   separator = { fg = '#74c7ec', bg = 'rgba(0, 0, 0, 0.4)' }
}

local cells = Cells:new()

cells
   :add_segment('date_icon', ICON_DATE .. '  ', colors.date, status_attrs)
   :add_segment('date_text', '', colors.date, status_attrs)
   :add_segment('separator', ' ' .. ICON_SEPARATOR .. '  ', colors.separator)
   :add_segment('battery_icon', '', colors.battery)
   :add_segment('battery_text', '', colors.battery, status_attrs)
   :add_segment('mode_icon', '', { fg = '#89b4fa' }, status_attrs)
   :add_segment('mode_text', '', { fg = '#cdd6f4' }, status_attrs)

---@return string, string
local function battery_info()
   -- ref: https://wezfurlong.org/wezterm/config/lua/wezterm/battery_info.html

   local charge = ''
   local icon = ''

   for _, b in ipairs(wezterm.battery_info()) do
      local idx = umath.clamp(umath.round(b.state_of_charge * 10), 1, 10)
      charge = string.format('%.0f%%', b.state_of_charge * 100)

      if b.state == 'Charging' then
         icon = charging_icons[idx]
      else
         icon = discharging_icons[idx]
      end
   end

   return charge, icon .. ' '
end

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

---@param opts? Event.RightStatusOptionsInput Default: {date_format = '%a %H:%M:%S'}
M.setup = function(opts)
   local valid_opts, err = EVENT_OPTS:validate(opts or {})

   if err then
      wezterm.log_error(err)
   end

   ---@cast valid_opts Event.RightStatusOptions

   wezterm.on('update-status', function(window, _pane)
      if platform.is_mac then
         local name = window:active_key_table()
         local icon = ''
         local text = ''

         if name then
            icon = ICON_KEY_TABLE .. ' '
            text = format_key_table_name(name)
         end

         if window:leader_is_active() then
            icon = ICON_KEY .. ' '
            text = 'Leader'
         end

         cells
            :update_segment_text('mode_icon', icon)
            :update_segment_text('mode_text', text)

         local segments = {}
         if text ~= '' then
            segments = { 'mode_icon', 'mode_text' }
         end

         window:set_right_status(wezterm.format(cells:render(segments)))
         return
      end

      local battery_text, battery_icon = battery_info()

      cells
         :update_segment_text('date_text', wezterm.strftime(valid_opts.date_format))
         :update_segment_text('battery_icon', battery_icon)
         :update_segment_text('battery_text', battery_text)

      local segments = { 'date_icon', 'date_text' }

      if battery_text ~= '' then
         if not platform.is_win then
            table.insert(segments, 'separator')
         end
         table.insert(segments, 'battery_icon')
         table.insert(segments, 'battery_text')
      end

      window:set_right_status(wezterm.format(cells:render(segments)))
   end)
end

return M
