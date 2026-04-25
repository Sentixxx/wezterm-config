# AGENTS Notes

## WezTerm Source

- Local WezTerm source checkout: `C:\Users\sentuix\code\wezterm`
- When investigating WezTerm behavior from this config repo, inspect the upstream source there first.

## Notification Debugging Note

- Current issue: some notifications emitted from remote terminals do not produce Windows toast popups, while local Windows terminals do.
- Relevant upstream paths:
  - `wezterm-gui/src/frontend.rs`
  - `term/src/terminalstate/performer.rs`
  - `docs/config/lua/config/notification_handling.md`
  - `docs/changelog.md`
- Initial finding from upstream source/docs:
  - `notification_handling` defaults to `AlwaysShow`.
  - Toast notifications are generated from OSC 9 / OSC 777 escapes.
  - Upstream changelog notes that these notifications do not currently pass through multiplexer connections.
  - Current upstream source also shows `wezterm-client/src/pane/clientpane.rs` forwarding `NotifyAlert` into local `MuxNotification::Alert`, so some mux-backed remote paths may now work.
  - `ssh_domains` with `multiplexing = "None"` should behave more like a direct terminal stream, so OSC 9 / 777 can work there if no intermediate layer strips escapes.
  - `wsl_domains` are launched locally via `wsl.exe`, so they are not the same as a remote mux client path.
  - If the remote shell is inside `tmux`, escape passthrough is the likely failure point; WezTerm docs require `set -g allow-passthrough on` for passthrough-based features.
