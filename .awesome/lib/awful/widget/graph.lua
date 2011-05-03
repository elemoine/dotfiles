---------------------------------------------------------------------------
-- @author Julien Danjou &lt;julien@danjou.info&gt;
-- @copyright 2009 Julien Danjou
-- @release v3.4.3
---------------------------------------------------------------------------

local setmetatable = setmetatable
local ipairs = ipairs
local math = math
local table = table
local capi = { image = image,
               widget = widget }
local layout = require("awful.widget.layout")

--- A graph widget.
module("awful.widget.graph")

local data = setmetatable({}, { __mode = "k" })

--- Set the graph border color.
-- If the value is nil, no border will be drawn.
-- @name set_border_color
-- @class function
-- @param graph The graph.
-- @param color The border color to set.

--- Set the graph foreground color as a gradient.
-- @name set_gradient_colors
-- @class function
-- @param graph The graph.
-- @param gradient_colors A table with gradients colors. The distance between each color
-- can also be specified. Example: { "red", "blue" } or { "red", "green",
-- "blue", blue = 10 } to specify blue distance from other colors.

--- Set the graph foreground colors gradient angle. Default is 270 degrees
-- (horizontal).
-- @name set_gradient_angle
-- @class function
-- @param graph The graph.
-- @param gradient_angle Angle of gradient in degrees.

--- Set the graph foreground color.
-- @name set_color
-- @class function
-- @param graph The graph.
-- @param color The graph color.

--- Set the graph background color.
-- @name set_background_color
-- @class function
-- @param graph The graph.
-- @param color The graph background color.

--- Set the maximum value the graph should handle.
-- If "scale" is also set, the graph never scales up below this value, but it
-- automatically scales down to make all data fit.
-- @name set_max_value
-- @class function
-- @param graph The graph.
-- @param value The value.

--- Set the graph to automatically scale its values. Default is false.
-- @name set_scale
-- @class function
-- @param graph The graph.
-- @param scale A boolean value

local properties = { "width", "height", "border_color",
                     "gradient_colors", "gradient_angle", "color",
                     "background_color", "max_value", "scale" }

local function update(graph)
    -- Create new empty image
    local img = capi.image.argb32(data[graph].width, data[graph].height, nil)

    local border_width = 0
    if data[graph].border_color then
        border_width = 1
    end

    local values = data[graph].values
    local max_value = data[graph].max_value

    if data[graph].scale then
        for _, v in ipairs(values) do
            if v > max_value then
                max_value = v
            end
        end
    end

    -- Draw background
    -- Draw full gradient
    if data[graph].gradient_colors then
        img:draw_rectangle_gradient(border_width, border_width,
                                    data[graph].width - (2 * border_width),
                                    data[graph].height - (2 * border_width),
                                    data[graph].gradient_colors,
                                    data[graph].gradient_angle or 270)
    else
        img:draw_rectangle(border_width, border_width,
                           data[graph].width - (2 * border_width),
                           data[graph].height - (2 * border_width),
                           true, data[graph].color or "red")
    end

    -- No value? Draw nothing.
    if #values ~= 0 then
        -- Draw reverse
        for i = 0, #values - 1 do
            local value = values[#values - i]
            if value >= 0 then
                value = value / max_value
                img:draw_line(data[graph].width - border_width - i - 1,
                              border_width - 1 +
                                  math.floor(((data[graph].height - 2 * border_width) * (1 - value)) + 0.5),
                              data[graph].width - border_width - i - 1,
                              border_width - 1,
                              data[graph].background_color or "#000000aa")
            end
        end
    end

    -- If we did not draw values everywhere, draw a square over the last left
    -- part to set everything to 0 :-)
    if #values < data[graph].width - (2 * border_width) then
        img:draw_rectangle(border_width, border_width,
                           data[graph].width - (2 * border_width) - #values,
                           data[graph].height - (2 * border_width),
                           true, data[graph].background_color or "#000000aa")
    end

    -- Draw the border last so that it overlaps other stuff
    if data[graph].border_color then
        -- Draw border
        img:draw_rectangle(0, 0, data[graph].width, data[graph].height,
                           false, data[graph].border_color or "white")
    end

    -- Update the image
    graph.widget.image = img
end

--- Add a value to the graph
-- @param graph The graph.
-- @param value The value between 0 and 1.
local function add_value(graph, value)
    if not graph then return end

    local value = value or 0
    local max_value = data[graph].max_value
    value = math.max(0, value)
    if not data[graph].scale then
        value = math.min(max_value, value)
    end

    table.insert(data[graph].values, value)

    local border_width = 0
    if data[graph].border then border_width = 2 end

    -- Ensure we never have more data than we can draw
    while #data[graph].values > data[graph].width - border_width do
        table.remove(data[graph].values, 1)
    end

    update(graph)
    return graph
end


--- Set the graph height.
-- @param graph The graph.
-- @param height The height to set.
function set_height(graph, height)
    if height >= 5 then
        data[graph].height = height
        update(graph)
    end
    return graph
end

--- Set the graph width.
-- @param graph The graph.
-- @param width The width to set.
function set_width(graph, width)
    if width >= 5 then
        data[graph].width = width
        update(graph)
    end
    return graph
end

-- Build properties function
for _, prop in ipairs(properties) do
    if not _M["set_" .. prop] then
        _M["set_" .. prop] = function(graph, value)
            data[graph][prop] = value
            update(graph)
            return graph
        end
    end
end

--- Create a graph widget.
-- @param args Standard widget() arguments. You should add width and height
-- key to set graph geometry.
-- @return A graph widget.
function new(args)
    local args = args or {}
    args.type = "imagebox"

    local width = args.width or 100
    local height = args.height or 20

    if width < 5 or height < 5 then return end

    local graph = {}
    graph.widget = capi.widget(args)
    graph.widget.resize = false

    data[graph] = { width = width, height = height, values = {}, max_value = 1 }

    -- Set methods
    graph.add_value = add_value

    for _, prop in ipairs(properties) do
        graph["set_" .. prop] = _M["set_" .. prop]
    end

    graph.layout = args.layout or layout.horizontal.leftright

    return graph
end

setmetatable(_M, { __call = function(_, ...) return new(...) end })

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
