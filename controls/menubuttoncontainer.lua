local lib = {}

function lib.new( parent, x, y, width, height )
    local group = display.newGroups( parent, 1 )

    group.x, group.y = x, y
    
    function group:getX()
        return 0
    end

    function group:getY()
        if (group.numChildren == 0) then
            return 0
        else
            print(group[ group.numChildren ].class)
            return group[ group.numChildren ]:getY() + group[ group.numChildren ]:getHeight()
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
