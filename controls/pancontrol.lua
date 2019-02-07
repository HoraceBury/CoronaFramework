local fxlib = require("libs.fxlib")

local lib = {}

function lib.new( scrollView, itemgroup, canMoveX, canMoveY )
    local group = display.newGroup()
    group:insert( itemgroup )
    scrollView:insert( group )

    group.x, group.y = itemgroup.x, itemgroup.y
    itemgroup.x, itemgroup.y = 0, 0

    group.prev = nil
    
    function group:enterFrame()
        local x, y = group.parent:contentToLocal( group.prev.x, group.prev.y )

        if (canMoveX == nil or canMoveX) then
            group.x = x
        end
        if (canMoveY == nil or canMoveY) then
            group.y = y
        end
    end

    group:addEventListener( "touch", function(e)
        if (e.phase == "began") then
            e.target.hasFocus = true
            display.currentStage:setFocus(e.target)
            group.prev = e
            Runtime:addEventListener( "enterFrame", group )
            return true
        elseif (e.target.hasFocus) then
            group.prev = e

            local x, y = scrollView:contentToLocal( e.x, e.y )

            local xSpeed, ySpeed = 0, 0

            if (x+scrollView.width/2 > scrollView.width - 100) then
                xSpeed = -50
            elseif (x+scrollView.width/2 < 100) then
                xSpeed = 50
            end

            if (y+scrollView.height/2 > scrollView.height - 100) then
                ySpeed = -50
            elseif (y+scrollView.height/2 < 100) then
                ySpeed = 50
            end

            scrollView:setScrollSpeed( xSpeed, ySpeed )

            if (e.phase == "moved") then
            else
                e.target.hasFocus = nil
                display.currentStage:setFocus(nil)
                Runtime:removeEventListener( "enterFrame", group )
            end
            return true
        end
        return false
    end )

    group:addEventListener( "tap", function(e)
        return true
    end )

    return group
end

return lib
