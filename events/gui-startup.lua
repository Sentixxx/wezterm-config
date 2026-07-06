---@type Wezterm
local wezterm = require('wezterm')
local mux = wezterm.mux

local M = {}
local WINDOW_STATE_FILE = wezterm.config_dir .. '/.window-size.lua'

---@return { width: integer, height: integer }|nil
local function load_window_size()
   local chunk = loadfile(WINDOW_STATE_FILE)
   if not chunk then
      return nil
   end

   local ok, state = pcall(chunk)
   if not ok or type(state) ~= 'table' then
      return nil
   end

   if type(state.width) ~= 'number' or type(state.height) ~= 'number' then
      return nil
   end

   return {
      width = math.floor(state.width),
      height = math.floor(state.height),
   }
end

---@param window Window
local function save_window_size(window)
   local dims = window:get_dimensions()
   if dims.is_full_screen then
      return
   end

   local file, err = io.open(WINDOW_STATE_FILE, 'w')
   if not file then
      wezterm.log_error('failed to save window size: ' .. tostring(err))
      return
   end

   file:write(
      string.format(
         'return { width = %d, height = %d }\n',
         dims.pixel_width,
         dims.pixel_height
      )
   )
   file:close()
end

M.setup = function()
   wezterm.on('gui-startup', function(cmd)
      local _, _, window = mux.spawn_window(cmd or {})
      local gui_window = window:gui_window()
      local saved_size = load_window_size()
      if saved_size then
         gui_window:set_inner_size(saved_size.width, saved_size.height)
      end
   end)

   wezterm.on('window-resized', function(window, _pane)
      save_window_size(window)
   end)
end

return M
