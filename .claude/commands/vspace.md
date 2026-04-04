You are helping manage VSpaceCode keyboard shortcuts.

Current shortcuts reference:
!`cat ~/.dotfiles/vscode/shortcuts.md`

Current binding overrides in VSCode settings:
!`python3 -c "
import json, sys, os, platform
s = platform.system()
if s == 'Darwin':
    p = os.path.expanduser('~/Library/Application Support/Code/User/settings.json')
elif s == 'Windows':
    p = os.path.join(os.environ['APPDATA'], 'Code', 'User', 'settings.json')
else:
    p = os.path.expanduser('~/.config/Code/User/settings.json')
d = json.load(open(p))
print(json.dumps(d.get('vspacecode.bindingOverrides', []), indent=2))
"`

User request: $ARGUMENTS

---

Follow these steps:

1. **Look up** — check if a shortcut already exists in the defaults or overrides above. If yes, report it and stop.

2. **Suggest** — if no shortcut exists, propose a keybinding that fits vspacecode conventions (Space as leader, grouped by category). Show the JSON snippet that will be added to `vspacecode.bindingOverrides`.

3. **Apply** — once the user confirms:
   a. Add the new shortcut to `~/.dotfiles/vscode/shortcuts.md` under the "Custom overrides" table.
   b. Update `vspacecode.bindingOverrides` in the VSCode settings.json (path resolved by platform as above). Read the file first, modify only the `vspacecode.bindingOverrides` key, and write back. Do NOT commit settings.json — it contains secrets.

Keep suggestions consistent with the category conventions listed in shortcuts.md.
