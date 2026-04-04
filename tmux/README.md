# Tmux Shortcuts

Prefix key = `Ctrl + b`

## Windows (tabs)

| Shortcut | Action |
|----------|--------|
| `prefix + c` | create new window (prompts for name) |
| `prefix + ,` | rename current window |
| `prefix + n` | next window |
| `prefix + p` | previous window |
| `prefix + 1-9` | jump to window by number |
| `prefix + &` | close current window |

## Panes (splits)

| Shortcut | Action |
|----------|--------|
| `prefix + %` | split vertical (side by side) |
| `prefix + "` | split horizontal (top/bottom) |
| `prefix + o` | cycle through panes |
| `prefix + Tab` | switch to next pane + auto-zoom (custom) |
| `prefix + z` | toggle zoom on current pane |
| `prefix + x` | close current pane |
| `prefix + arrow` | resize pane |

## Copy mode (vi keys)

| Shortcut | Action |
|----------|--------|
| `prefix + [` | enter copy mode |
| `v` | start selection |
| `y` | yank selection |
| `q` | exit copy mode |

## Sessions

| Shortcut | Action |
|----------|--------|
| `prefix + d` | detach from session |
| `prefix + s` | list sessions |
| `prefix + $` | rename session |

## Plugins (tpm)

| Shortcut | Action |
|----------|--------|
| `prefix + I` | install plugins |
| `prefix + Ctrl-s` | save session (resurrect) |
| `prefix + Ctrl-r` | restore session (resurrect) |

## Other

| Shortcut | Action |
|----------|--------|
| `prefix + :` | command prompt (e.g. `source-file ~/.tmux.conf`) |
| `prefix + ?` | list all key bindings |
