local rgb = require("libs.rgb")
local radialgradient = require("utils.radialgradient")

local lib = {}

function lib.new( parent, x, y, r, w, radii, colours, visibleRadii )
    local group = display.newGroups( parent, 1 )
    group.x, group.y = x, y

    local function background()
        local centre = display.newCircle( group, 0, 0, r )
        centre.fill = {0,0,0,0}
        display.stroke( centre, {1}, w*2+10 )

        local wide = display.newCircle( group, 0, 0, r+w )
        wide.fill = {0,0,0,0}
        display.stroke( wide, {.85}, 5 )

        local near = display.newCircle( group, 0, 0, r-w )
        near.fill = {0,0,0,0}
        display.stroke( near, {.85}, 5 )
    end
    background()

    local gradient = radialgradient.new( group, 0, 0, r, w-5, radii, colours, visibleRadii )

    local function dot()
        local dot = display.newGroups( group, 1 )

        local shadow = display.newCircle( dot, 0, -r, w*3 )
        shadow.alpha = .25

        shadow.fill.effect = "generator.radialGradient"
 
        shadow.fill.effect.color1 = { .5,.5,.5, 1 }
        shadow.fill.effect.color2 = { 0,0,0, 0 }
        shadow.fill.effect.center_and_radiuses  =  { 0.5, 0.5, 0.1, .5 }
        shadow.fill.effect.aspectRatio  = 1

        local circle = display.newCircle( dot, 0, -r, w*2 )
        display.stroke( circle, {1}, 3 )

        return dot
    end
    dot()

    return group
end

return lib
