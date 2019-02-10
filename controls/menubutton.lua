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

    function group:getX()
        return group.x
    end

    function group:getY()
        return group.y
    end

    function group:getWidth()
        return group.width
    end

    function group:getHeight()
        return group.height
    end

    local backrect = display.newRoundedRect( group, 0, 0, parent:getWidth()-offset, display.safeActualContentHeight*heightfraction-offset, rounding )
    local frontrect = display.newRoundedRect( group, 0, 0, parent:getWidth()-offset, display.safeActualContentHeight*heightfraction-offset, rounding )
    local line = arrow( group, 0, 0 )

    frontrect.x, frontrect.y = frontrect.width/2, frontrect.height/2
    backrect.x, backrect.y = frontrect.x+offset/2+1, frontrect.y+offset/2+1
    line.x, line.y = frontrect.width-line.width, frontrect.y

    backrect.fill = shadow
    frontrect.fill = fill
    backrect.isVisible = false
    
    local label, isCentred, fontSize = nil, false, 72

    local function createText()
        if (label) then label:removeSelf() end

        label = display.newText{ parent=group, text=text, fontSize=fontSize }
        if (isCentred) then label.x=frontrect.x else label.x=label.width*.5+indent end
        label.y = frontrect.y
        label.fill = rgb.rgb.iosgrey
    end
    createText()
    
    function group:withFontSize( _fontSize )
        fontSize = _fontSize or 72
        createText()
        return group
    end

    function group:isCentred( _isCentred )
        isCentred = _isCentred or isCentred
        createText()
        return group
    end

    function group:withButtonColour( _colour )
        frontrect.fill = _colour or fill
        return group
    end

    function group:withShadowColour( _shadow )
        backrect.fill = _shadow or shadow
        return group
    end

    group:addEventListener( "touch", touch )

    group:addEventListener( "tap", function(e)
    	callback()
        return true
    end )

    return group
end

return lib
