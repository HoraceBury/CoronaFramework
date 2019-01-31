local composer = require("composer")
local rgb = require("libs.rgb")

local lib = {}

function lib.new( parent, gotoSceneName, callback )
    local group = display.newGroups( parent, 1 )

    local text = display.newText{ parent=group, fontSize=42, text="Back" }
    text.fill = rgb.rgb.iosblue

    group:addEventListener( "touch", function()
        return true
    end )

    group:addEventListener( "tap", function(e)
        if (callback) then
            callback()
        end

        composer.gotoScene( gotoSceneName, { effect="slideRight", time=800 } )
        
        return true
    end )

    group.x, group.y = display.safeScreenOriginX+group.width*.6, display.safeScreenOriginY+group.height*.6

    return group
end

return lib
