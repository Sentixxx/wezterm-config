local wezterm = require('wezterm')
local platform = require('utils.platform')

local options = {
   default_prog = {},
   launch_menu = {},
}

if platform.is_win then
   local pwsh = 'C:/Program Files/PowerShell/7/pwsh.exe'
   local starship_config = wezterm.home_dir .. '\\.config\\starship.toml'
   local starship_init = "$env:STARSHIP_CONFIG = '" .. starship_config .. "'; "
      .. "Invoke-Expression (& 'C:\\Program Files\\starship\\bin\\starship.exe' init powershell)"
   local pwsh_with_starship = { pwsh, '-NoLogo', '-NoExit', '-Command', starship_init }

   options.default_prog = pwsh_with_starship
   options.launch_menu = {
      { label = 'PowerShell Core', args = pwsh_with_starship },
      { label = 'PowerShell Desktop', args = { 'powershell' } },
      { label = 'Command Prompt', args = { 'cmd' } },
      {
         label = 'Git Bash',
         args = { '' },
      },
   }
elseif platform.is_mac then
   options.default_prog = { '/opt/homebrew/bin/fish', '-l' }
   options.launch_menu = {
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Fish', args = { '/opt/homebrew/bin/fish', '-l' } },
      { label = 'Nushell', args = { '/opt/homebrew/bin/nu', '-l' } },
      { label = 'Zsh', args = { 'zsh', '-l' } },
   }
elseif platform.is_linux then
   options.default_prog = { 'fish', '-l' }
   options.launch_menu = {
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Fish', args = { 'fish', '-l' } },
      { label = 'Zsh', args = { 'zsh', '-l' } },
   }
end

return options
