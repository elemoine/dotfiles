---------------------------------------------------------------------------
-- @author Julien Danjou &lt;julien@danjou.info&gt;
-- @copyright 2008 Julien Danjou
-- @release v3.4.3
---------------------------------------------------------------------------

-- Grab environment we need
local util = require("awful.util")
local pairs = pairs
local ipairs = ipairs
local table = table
local setmetatable = setmetatable
local capi =
{
    tag = tag,
    screen = screen,
    mouse = mouse,
    client = client
}

--- Useful functions for tag manipulation.
module("awful.tag")

-- Private data
local data = {}
data.history = {}
data.tags = setmetatable({}, { __mode = 'k' })

-- History functions
history = {}
history.limit = 20

--- Create a set of tags and attach it to a screen.
-- @param names The tag name, in a table
-- @param screen The tag screen, or 1 if not set.
-- @param layout The layout or layout table to set for this tags by default.
-- @return A table with all created tags.
function new(names, screen, layout)
    local screen = screen or 1
    local tags = {}
    for id, name in ipairs(names) do
        tags[#tags + 1] = capi.tag { name = name }
        tags[#tags].screen = screen
        -- Select the first tag.
        if id == 1 then
            tags[#tags].selected = true
        end
        setproperty(tags[#tags], "layout", layout and (layout[#tags] or layout[1]) or layout)
    end
    return tags
end

--- Update the tag history.
-- @param obj Screen object.
function history.update(obj)
    local s = obj.index
    local curtags = capi.screen[s]:tags()
    -- create history table
    if not data.history[s] then
        data.history[s] = {}
    -- limit history
    elseif #data.history[s] >= history.limit then
        for i = history.limit, #data.history[s] do
            data.history[s][i] = nil
        end
    end
    -- store previously selected tags in the history table
    table.insert(data.history[s], 1, data.history[s].current)
    data.history[s].previous = data.history[s][1]
    -- store currently selected tags
    data.history[s].current = setmetatable(selectedlist(s), { __mode = 'v' })
end

--- Revert tag history.
-- @param screen The screen number.
-- @param idx Index in history. Defaults to "previous" which is a special index
-- toggling between last two selected sets of tags. Number (eg 1) will go back
-- to the given index in history.
function history.restore(screen, idx)
    local s = screen or capi.mouse.screen
    local i = idx or "previous"
    local sel = selectedlist(s)
    -- do nothing if history empty
    if not data.history[s] or not data.history[s][i] then return end
    -- if all tags been deleted, try next entry
    if #data.history[s][i] == 0 then
        if i == "previous" then i = 0 end
        history.restore(s, i + 1)
        return
    end
    -- deselect all tags
    viewnone(s)
    -- select tags from the history entry
    for _, t in ipairs(data.history[s][i]) do
        t.selected = true
    end
    -- update currently selected tags table
    data.history[s].current = data.history[s][i]
    -- store previously selected tags
    data.history[s].previous = setmetatable(sel, { __mode = 'v' })
    -- remove the reverted history entry
    if i ~= "previous" then table.remove(data.history[s], i) end
end

--- Return a table with all visible tags
-- @param s Screen number.
-- @return A table with all selected tags.
function selectedlist(s)
    local screen = s or capi.mouse.screen
    local tags = capi.screen[screen]:tags()
    local vtags = {}
    for i, t in pairs(tags) do
        if t.selected then
            vtags[#vtags + 1] = t
        end
    end
    return vtags
end

--- Return only the first visible tag.
-- @param s Screen number.
function selected(s)
    return selectedlist(s)[1]
end

--- Set master width factor.
-- @param mwfact Master width factor.
function setmwfact(mwfact, t)
    local t = t or selected()
    if mwfact >= 0 and mwfact <= 1 then
        setproperty(t, "mwfact", mwfact)
    end
end

--- Increase master width factor.
-- @param add Value to add to master width factor.
function incmwfact(add, t)
    setmwfact(getmwfact(t) + add)
end

--- Get master width factor.
-- @param t Optional tag.
function getmwfact(t)
    local t = t or selected()
    return getproperty(t, "mwfact") or 0.5
end

--- Set the number of master windows.
-- @param nmaster The number of master windows.
-- @param t Optional tag.
function setnmaster(nmaster, t)
    local t = t or selected()
    if nmaster >= 0 then
        setproperty(t, "nmaster", nmaster)
    end
end

--- Get the number of master windows.
-- @param t Optional tag.
function getnmaster(t)
    local t = t or selected()
    return getproperty(t, "nmaster") or 1
end

--- Increase the number of master windows.
-- @param add Value to add to number of master windows.
function incnmaster(add, t)
    setnmaster(getnmaster(t) + add)
end


--- Set the tag icon
-- @param icon the icon to set, either path or image object
-- @param tag the tag
function seticon(icon, tag)
    local tag = tag or selected()
    setproperty(tag, "icon", icon)
end

--- Get the tag icon
-- @param t the tag
function geticon(tag)
    local tag = tag or selected()
    return getproperty(tag, "icon")
end

--- Set number of column windows.
-- @param ncol The number of column.
function setncol(ncol, t)
    local t = t or selected()
    if ncol >= 1 then
        setproperty(t, "ncol", ncol)
    end
end

--- Get number of column windows.
-- @param t Optional tag.
function getncol(t)
    local t = t or selected()
    return getproperty(t, "ncol") or 1
end

--- Increase number of column windows.
-- @param add Value to add to number of column windows.
function incncol(add, t)
    setncol(getncol(t) + add)
end

--- View no tag.
-- @param Optional screen number.
function viewnone(screen)
    local tags = capi.screen[screen or capi.mouse.screen]:tags()
    for i, t in pairs(tags) do
        t.selected = false
    end
end

--- View a tag by its taglist index.
-- @param i The relative index to see.
-- @param screen Optional screen number.
function viewidx(i, screen)
    local screen = screen and screen.index or capi.mouse.screen
    local tags = capi.screen[screen]:tags()
    local showntags = {}
    for k, t in ipairs(tags) do
        if not getproperty(t, "hide") then
            table.insert(showntags, t)
        end
    end
    local sel = selected(screen)
    viewnone(screen)
    for k, t in ipairs(showntags) do
        if t == sel then
            showntags[util.cycle(#showntags, k + i)].selected = true
        end
    end
    capi.screen[screen]:emit_signal("tag::history::update")
end

--- View next tag. This is the same as tag.viewidx(1).
-- @param screen The screen number.
function viewnext(screen)
    return viewidx(1, screen)
end

--- View previous tag. This is the same a tag.viewidx(-1).
-- @param screen The screen number.
function viewprev(screen)
    return viewidx(-1, screen)
end

--- View only a tag.
-- @param t The tag object.
function viewonly(t)
    local tags = capi.screen[t.screen]:tags()
    -- First, untag everyone except the viewed tag.
    for _, tag in pairs(tags) do
        if tag ~= t then
            tag.selected = false
        end
    end
    -- Then, set this one to selected.
    -- We need to do that in 2 operations so we avoid flickering and several tag
    -- selected at the same time.
    t.selected = true
    capi.screen[t.screen]:emit_signal("tag::history::update")
end

--- View only a set of tags.
-- @param tags A table with tags to view only.
-- @param screen Optional screen number of the tags.
function viewmore(tags, screen)
    local screen_tags = capi.screen[screen or capi.mouse.screen]:tags()
    for _, tag in ipairs(screen_tags) do
        if not util.table.hasitem(tags, tag) then
            tag.selected = false
        end
    end
    for _, tag in ipairs(tags) do
        tag.selected = true
    end
    capi.screen[screen]:emit_signal("tag::history::update")
end

--- Toggle selection of a tag
-- @param tag Tag to be toggled
function viewtoggle(t)
    t.selected = not t.selected
    capi.screen[t.screen]:emit_signal("tag::history::update")
end

--- Get tag data table.
-- @param tag The Tag.
-- @return The data table.
function getdata(tag)
    return data.tags[tag]
end

--- Get a tag property.
-- @param tag The tag.
-- @param prop The property name.
-- @return The property.
function getproperty(tag, prop)
    if data.tags[tag] then
        return data.tags[tag][prop]
    end
end

--- Set a tag property.
-- This properties are internal to awful. Some are used to draw taglist, or to
-- handle layout, etc.
-- @param tag The tag.
-- @param prop The property name.
-- @param value The value.
function setproperty(tag, prop, value)
    if not data.tags[tag] then
        data.tags[tag] = {}
    end
    data.tags[tag][prop] = value
    tag:emit_signal("property::" .. prop)
end

--- Tag a client with the set of current tags.
-- @param c The client to tag.
-- @param startup Optional: don't do anything if true.
function withcurrent(c, startup)
    if startup ~= true and c.sticky == false then
        if #c:tags() == 0 then
            c:tags(selectedlist(c.screen))
        end
    end
end

local function attached_add_signal_screen(screen, sig, func)
    capi.screen[screen]:add_signal("tag::attach", function (s, tag)
        tag:add_signal(sig, func)
    end)
    capi.screen[screen]:add_signal("tag::detach", function (s, tag)
        tag:remove_signal(sig, func)
    end)
    for _, tag in ipairs(capi.screen[screen]:tags()) do
        tag:add_signal(sig, func)
    end
end

--- Add a signal to all attached tag and all tag that will be attached in the
-- future. When a tag is detach from the screen, its signal is removed.
-- @param screen The screen concerned, or all if nil.
function attached_add_signal(screen, ...)
    if screen then
        attached_add_signal_screen(screen, ...)
    else
        for screen = 1, capi.screen.count() do
            attached_add_signal_screen(screen, ...)
        end
    end
end

-- Register standards signals
capi.client.add_signal("manage", function(c, startup)
    -- If we are not managing this application at startup,
    -- move it to the screen where the mouse is.
    -- We only do it for "normal" windows (i.e. no dock, etc).
    if not startup
        and c.type ~= "desktop"
        and c.type ~= "dock"
        and c.type ~= "splash" then
        if c.transient_for then
            c.screen = c.transient_for.screen
            if not c.sticky then
                c:tags(c.transient_for:tags())
            end
        else
            c.screen = capi.mouse.screen
        end
    end
    withcurrent(c, startup)
    c:add_signal("property::screen", withcurrent)
end)

for s = 1, capi.screen.count() do
    capi.screen[s]:add_signal("tag::history::update", history.update)
end

setmetatable(_M, { __call = function (_, ...) return new(...) end })

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
