# VSpaceCode Shortcuts Reference

Leader key = `Space`

## Conventions

VSpaceCode follows Spacemacs-style grouping:

| Prefix | Category |
|--------|----------|
| `SPC f` | file |
| `SPC b` | buffer |
| `SPC g` | git |
| `SPC w` | window / split |
| `SPC s` | search |
| `SPC p` | project |
| `SPC e` | errors / diagnostics |
| `SPC t` | toggles |
| `SPC m` / `,` | major mode (language-specific) |

## Built-in defaults (commonly used)

| Shortcut | Action |
|----------|--------|
| `SPC SPC` | run command (command palette) |
| `SPC f f` | find / open file |
| `SPC f s` | save file |
| `SPC f r` | recent files |
| `SPC b b` | switch buffer |
| `SPC b d` | close buffer |
| `SPC g g` | open source control |
| `SPC g s` | git status |
| `SPC p f` | find file in project |
| `SPC p p` | switch project |
| `SPC w v` | split vertical |
| `SPC w s` | split horizontal |
| `SPC w h/j/k/l` | focus left/down/up/right |
| `SPC e n / p` | next / previous error |
| `SPC t t` | toggle terminal |

## Custom overrides (vspacecode.bindingOverrides)

| Shortcut | Action | VSCode Command |
|----------|--------|----------------|
| `SPC s f` | find in file (native) | `actions.find` |
