---------------------------------------------------------------------------
-- @author Julien Danjou &lt;julien@danjou.info&gt;
-- @copyright 2009 Julien Danjou
-- @release v3.4.3
---------------------------------------------------------------------------

local setmetatable = setmetatable

local capi = { widget = widget }
local completion = require("awful.completion")
local util = require("awful.util")
local prompt = require("awful.prompt")
local layout = require("awful.widget.layout")

module("awful.widget.prompt")

--- Run method for promptbox.
-- @param promptbox The promptbox to run.
local function run(promptbox)
    return prompt.run({ prompt = promptbox.prompt },
                      promptbox.widget,
                      function (...) promptbox.widget.text = util.spawn(...) end,
                      completion.shell,
                      util.getdir("cache") .. "/history")
end

--- Create a prompt widget which will launch a command.
-- @param args Standard widget table arguments, with prompt to change the
-- default prompt.
-- @return A launcher widget.
function new(args)
    local args = args or {}
    local promptbox = {}
    args.type = "textbox"
    promptbox.widget = capi.widget(args)
    promptbox.widget.ellipsize = "start"
    promptbox.run = run
    promptbox.prompt = args.prompt or "Run: "
    promptbox.layout = args.layout or layout.horizontal.leftright
    return promptbox
end

setmetatable(_M, { __call = function (_, ...) return new(...) end })

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
