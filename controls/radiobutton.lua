local rgb = require("libs.rgb")
local settings = require("libs.settings")

local lib = {}

local offset = 10
local gap = 10
local rounding = 30
local fill = {.98}
local shadow = {.82,.82,.82}
local indent = 20

local function tick( parent, x, y )
    local group = display.newGroups( parent, 1 )
    local len = 10
    local strokewidth = 8

    local line = display.newLine( group, -len, 0, 0, len, len*1.5, -len*1.5 )
    line:setStrokeColor( unpack( rgb.rgb.iosblue ) )
    line.strokeWidth = strokewidth

    return group
end

local function touch()
    return true
end

function lib.new( parent, setting, value, callback, heightfraction )
    local group = display.newGroups( parent, 1 )
    group.x, group.y = 0, (parent.numChildren-1)*(display.safeActualContentHeight*heightfraction+gap)

    local backrect = display.newRoundedRect( group, 0, 0, parent:getWidth()-offset, display.safeActualContentHeight*heightfraction-offset, rounding )
    local frontrect = display.newRoundedRect( group, 0, 0, parent:getWidth()-offset, display.safeActualContentHeight*heightfraction-offset, rounding )
    local tick = tick( group, 0, 0 )

    frontrect.x, frontrect.y = frontrect.width/2, frontrect.height/2
    backrect.x, backrect.y = frontrect.x+offset/2+1, frontrect.y+offset/2+1
    tick.x, tick.y = frontrect.width-tick.width, frontrect.y

    backrect.fill = shadow
    backrect.isVisible = false
    frontrect.fill = fill

    local label = display.newText{ parent=group, text=value, fontSize=72 }
    label.x, label.y = label.width*.5+indent, frontrect.y
    label.fill = rgb.rgb.iosgrey

    group:addEventListener( "touch", touch )

    group:addEventListener( "tap", function(e)
        callback()
        settings[ setting ] = value
        settings.refresh()
        return true
    end )

    local function refresh(e)
        tick.isVisible = (settings[ setting ] == value)
    end

    Runtime:addEventListener( "refresh", refresh )

    group:addEventListener( "finalize", function()
        Runtime:removeEventListener( "group:"..setting, settingEvent )
    end )

    return group
end

return lib
