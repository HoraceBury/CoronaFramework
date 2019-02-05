local rgb = require("libs.rgb")

local lib = {}

function lib.new()
    local group = display.newGroup()

    local label, text, fontSize, colour, callback, hitzone = nil, "", 42, rgb.rgb.iosblue, nil, nil

    function group:withParent( parent )
        parent:insert( group )
        return group
    end

    function group:at( x, y )
        group.x, group.y = x, y
        return group
    end

    function group:withText( _text )
        if (label) then label:removeSelf() end

        text = _text or ""

        label = display.newText{ parent=group, fontSize=fontSize, text=text }
        label.fill = colour

        return group
    end

    function group:withColour( _colour )
        colour = _colour or rgb.rgb.iosblue
        print(unpack(colour))
        if (label) then label.fill=colour end

        return group
    end

    function group:withFontSize( _fontSize )
        if (_fontSize and _fontSize >= 5 and _fontSize <=500) then
            fontSize = _fontSize
            group:withText( text )
        end
        return group
    end

    function group:callTo( _callback )
        callback = _callback
        return group
    end

    function group:withHitZone( width, height )
        if (hitzone) then hitzone:removeSelf() end

        hitzone = display.newRect( group, 0, 0, width, height )
        hitzone.isVisible = false
        hitzone.isHitTestable = true
        
        return group
    end

    group:addEventListener( "touch", function()
        return true
    end )

    group:addEventListener( "tap", function(e)
        if (callback) then
            callback()
        end
        
        return true
    end )

    return group
end

return lib
