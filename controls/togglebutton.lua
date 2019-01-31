local composer = require("composer")
local rgb = require("libs.rgb")

local lib = {}

function lib.new( parent, x, y, texts, callback )
    local group = display.newGroups( parent, 1 )
    group.x, group.y = x, y

    local text = display.newText{ parent=group, fontSize=42, text="Yy" }
    text.x, text.y = text.width/2, text.height/2

    function group.getText()
        return text.text
    end

    local function refresh( index )
        if (type(texts) == "table") then
            text.text = texts[ index ]
            text.fill = rgb.rgb.iosblue
        else
            text.text = texts
            text.fill = rgb.rgb.iosgrey
        end
        text.x, text.y = text.width/2, 0
    end
    refresh( 1 )

    group:addEventListener( "touch", function()
        return true
    end )

    if (type(texts) == "table") then
        group:addEventListener( "tap", function(e)
            local index = table.indexOf( texts, text.text ) + 1
            if (index > #texts) then index=1 end

            refresh( index )

            if (callback) then
                callback( texts[index] )
            end
            
            return true
        end )
    end

    return group
end

return lib
