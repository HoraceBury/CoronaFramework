local lib = {}

--[[
    Provide a nested layout container.

    If position and size are provided this returns a container constraining it's contents to those dimensions.

    If orientation is provided this returns a dynamically sized container which will stack it's contents in that orientation.
    
    Required params:
        parent: Parent display group or container
]]
function lib.new( parent, ... )

    local group = display.newGroups( parent, 1 )

    group.x, group.y = x, y
    
    function group:getX()
        return 0
    end

    function group:getY()
        if (group.numChildren == 0) then
            return 0
        else
            return group[ group.numChildren ].y+group[ group.numChildren ].height
        end
    end

    function group:getWidth()
        return width
    end

    function group:getHeight()
        return height
    end

    return group
end

return lib
