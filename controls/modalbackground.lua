local lib = {}

function lib.new()
    local group = display.newGroup()

    local rect = display.newRect( group, display.actualCenterX, display.actualCenterY, display.actualContentWidth, display.actualContentHeight )
    rect.isVisible = false
    rect.isHitTestable = true

    function group:withColour( colour )
        rect.fill = colour
    end

    group:addEventListener( "touch", function()
        return true
    end )

    group:addEventListener( "tap", function(e)
        return true
    end )

    return group
end

return lib
