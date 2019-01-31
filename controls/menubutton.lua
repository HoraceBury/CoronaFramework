local rgb = require("libs.rgb")

local lib = {}

local offset = 10
local gap = 10
local rounding = 30
local fill = {.98}
local shadow = {.82,.82,.82}
local indent = 20

local function arrow( parent, x, y )
    local group = display.newGroups( parent, 1 )
    local len = 20
    local strokewidth = 8

    local line = display.newLine( group, -len/2, -len, len/2, 0, -len/2, len )
    
    line:setStrokeColor( unpack( rgb.rgb.grey ) )
    line.strokeWidth = strokewidth

    return group
end

local function touch()
    return true
end

function lib.new( parent, text, callback, heightfraction )
    local x, y = parent:getX(), parent:getY()+gap

    local group = display.newGroups( parent, 1 )
    group.x, group.y = x, y

    local backrect = display.newRoundedRect( group, 0, 0, parent:getWidth()-offset, display.safeActualContentHeight*heightfraction-offset, rounding )
    local frontrect = display.newRoundedRect( group, 0, 0, parent:getWidth()-offset, display.safeActualContentHeight*heightfraction-offset, rounding )
    local line = arrow( group, 0, 0 )

    frontrect.x, frontrect.y = frontrect.width/2, frontrect.height/2
    backrect.x, backrect.y = frontrect.x+offset/2+1, frontrect.y+offset/2+1
    line.x, line.y = frontrect.width-line.width, frontrect.y

    backrect.fill = shadow
    frontrect.fill = fill

    local label = display.newText{ parent=group, text=text, fontSize=72 }
    label.x, label.y = label.width*.5+indent, frontrect.y
    label.fill = rgb.rgb.iosgrey

    group:addEventListener( "touch", touch )

    group:addEventListener( "tap", function(e)
    	callback()
        return true
    end )

    return group
end

return lib
