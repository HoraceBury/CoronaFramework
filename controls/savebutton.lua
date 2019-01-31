local composer = require("composer")
local rgb = require("libs.rgb")

local lib = {}

function lib.new( parent, callback )
    local group = display.newGroups( parent, 1 )

    local text = display.newText{ parent=group, fontSize=42, text="Save" }
    text.fill = rgb.rgb.iosblue

    group:addEventListener( "touch", function()
        return true
    end )

    group:addEventListener( "tap", function(e)
        if (callback) then
            callback()
        end
        
        return true
    end )

    group.x, group.y = parent.width-group.width*1.1, group.height*.6

    return group
end

return lib
