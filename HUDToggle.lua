--[[
HUDToggle: one command to hide every addon window (e.g. to read the map) and bring them back.

  //hud          hide everything, or show it again
  //hud hide     hide
  //hud show     show
  //hud list     what it hides and how

Windower can't tell which game menu is open, so this is a command rather than automatic; put it on
a G13 key or an in-game macro (/console hud). Addons with no hide command of their own are unloaded
and loaded again (their settings are kept). Parse and the GearSwap HUDs only have a toggle, so they
are flipped; if one of them was already hidden it comes up the wrong way round: press its own key once.
--]]

_addon.name = 'HUDToggle'
_addon.author = 'Someonesmall (with Claude)'
_addon.version = '1.1.0'
_addon.commands = {'hud'}

-- hide/show: commands sent as typed after //. reload: addon to unload on hide and load on show.
-- job: only when that is the main job (the SMN HUD exists only in the SMN GearSwap file).
local entries = {
    {name = 'EnemyHUD',       hide = 'ehud hide',        show = 'ehud show'},
    {name = 'XIVPetBar',      hide = 'petbar hide',      show = 'petbar show'},
    {name = 'Parse (melee)',  hide = 'parse show melee', show = 'parse show melee'},   -- toggle
    {name = 'Nova HUD',       hide = 'gs c nova hud',    show = 'gs c nova hud'},      -- toggle (Alt+F12)
    {name = 'SMN HUD',        hide = 'gs c toggle_hud',  show = 'gs c toggle_hud', job = 'SMN'},   -- toggle (Win+X)
    {name = 'FFXIDB minimap', hide = 'unload FFXIDB',    show = 'load FFXIDB'},        -- plugin
    {name = 'GearInfo',       reload = 'GearInfo'},
    {name = 'xivbar',         reload = 'xivbar'},
    {name = 'equipviewer',    reload = 'equipviewer'},
    {name = 'DistancePlus',   reload = 'DistancePlus'},
}

local hidden = false
local applied = {}   -- entries hidden last time, so show undoes exactly those (even after a job change)

local function msg(text)
    windower.add_to_chat(207, 'HUDToggle: ' .. text)
end

local function set_hidden(hide)
    if hide == hidden then return end
    if hide then
        local player = windower.ffxi.get_player()
        applied = {}
        for _, e in ipairs(entries) do
            if not e.job or (player and player.main_job == e.job) then applied[#applied + 1] = e end
        end
    end
    for _, e in ipairs(applied) do
        if e.reload then
            windower.send_command('lua ' .. (hide and 'unload ' or 'load ') .. e.reload)
        else
            windower.send_command(hide and e.hide or e.show)
        end
    end
    hidden = hide
    msg(hide and 'addon windows hidden (//hud to show)' or 'addon windows shown')
end

windower.register_event('addon command', function(cmd)
    cmd = cmd and cmd:lower() or ''
    if cmd == '' then
        set_hidden(not hidden)
    elseif cmd == 'hide' or cmd == 'show' then
        set_hidden(cmd == 'hide')
    elseif cmd == 'list' then
        for _, e in ipairs(entries) do
            msg(e.name .. ': ' .. (e.reload and 'unload / load' or e.hide == e.show and 'toggle //' .. e.hide or '//' .. e.hide)
                .. (e.job and ' (' .. e.job .. ' only)' or ''))
        end
    else
        msg('//hud | hide | show | list')
    end
end)

-- Don't leave addons unloaded if this addon is reloaded or the character logs out while hidden
windower.register_event('unload', 'logout', function()
    set_hidden(false)
end)
