# HUDToggle

One command to hide every addon window in Final Fantasy XI ([Windower 4](https://www.windower.net/)),
e.g. to read the map or take a clean screenshot, and bring them all back again.

Windower can't tell which game menu is open, so this is a command rather than something automatic.
Put it on a macro (`/console hud`) or a keyboard/G13 key and press it whenever you want a clear screen.

## Install

1. On this page, click **Code > Download ZIP** (or grab the zip from the latest
   [release](https://github.com/Grimdarts/HUDToggle/releases)) and unzip it.
2. The unzipped folder is called `HUDToggle-main` (or `HUDToggle-1.1.0`). Rename it to exactly
   **`HUDToggle`** and put it in `Windower4\addons\`, so the file ends up at
   `Windower4\addons\HUDToggle\HUDToggle.lua`.
3. **Edit the list for your own addons** before using it (see below). The list that ships is the
   author's setup.
4. Load it in game: `//lua load HUDToggle`. To load it at every launch, add this line to
   `Windower4\scripts\init.txt`:

   ```
   lua load HUDToggle
   ```

## Use

| Command | What it does |
|---|---|
| `//hud` | Hide everything, or show it again |
| `//hud hide` | Hide |
| `//hud show` | Show |
| `//hud list` | List what it hides and how |

As a macro line, use `/console hud`. If you log out or unload HUDToggle while things are hidden,
it shows them again first, so you never end up with addons left unloaded.

## Make the list match your addons

Open `HUDToggle.lua` in Notepad. Near the top is a list called `entries`. Each line is one thing to
hide. There are three kinds of line:

```lua
-- 1. The addon has its own hide and show commands (type them as you would after //)
{name = 'EnemyHUD',  hide = 'ehud hide',  show = 'ehud show'},

-- 2. The addon only has a toggle: use the same command for both
{name = 'Parse (melee)', hide = 'parse show melee', show = 'parse show melee'},

-- 3. The addon has no hide command: it is unloaded on hide and loaded again on show
--    (its settings are kept)
{name = 'xivbar', reload = 'xivbar'},
```

Add `job = 'SMN'` to a line to use it only when that is your main job.

What to change:

- **Delete lines for addons you don't use.** This matters most for `reload` lines and the FFXIDB
  line: on `//hud show` those addons are *loaded*, even if you weren't running them before.
- **Delete the `Nova HUD` and `SMN HUD` lines** unless your own GearSwap files have those commands.
  They belong to the author's GearSwap job files.
- **Add lines for your own windows**, using the addon's own hide/show commands if it has them
  (check its readme), or `reload` if it doesn't.

Save the file and reload: `//lua r HUDToggle`. Check the result with `//hud list`.

### Lines in the shipped list

| Name | How it is hidden | Notes |
|---|---|---|
| EnemyHUD | `//ehud hide` / `//ehud show` | [Grimdarts/EnemyHUD](https://github.com/Grimdarts/EnemyHUD) |
| XIVPetBar | `//petbar hide` / `//petbar show` | [Grimdarts/XIVPetBar](https://github.com/Grimdarts/XIVPetBar) |
| Parse (melee) | toggles `//parse show melee` | |
| Nova HUD | toggles `//gs c nova hud` | Author's GearSwap; delete it |
| SMN HUD | toggles `//gs c toggle_hud`, SMN main job only | Author's GearSwap; delete it |
| FFXIDB minimap | unloads / loads the FFXIDB plugin | |
| GearInfo, xivbar, equipviewer, DistancePlus | unloaded / loaded | |

### Toggles can get out of step

Parse and the GearSwap HUDs only have a toggle, so HUDToggle flips them. If one of those windows
was already hidden when you pressed `//hud`, it comes up the wrong way round. Press that window's
own toggle once and they line up again.

## Credits

Written by Someonesmall with Claude (Anthropic).

## License

BSD 3-Clause, see [LICENSE](LICENSE).
