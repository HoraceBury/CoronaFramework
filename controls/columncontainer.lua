local container = require( "controls.menubuttoncontainer" )

local lib = {}

function lib.new( parent, columnsPercentages )
    local x, y, width = parent:getX(), parent:getY(), parent:getWidth()
    
    local cps = columnsPercentages

    local group = display.newGroups( parent, 1 )
    group.x, group.y = x, y

    function group:getY()
        return 0
    end

    function group:getHeight()
        return 0
    end

    local function validatePercentsTotal100()
        local total = 0
        for i=1, #cps do
            total = total + cps[i]
        end
        assert(total == 100, "Column percentages ~= 100. Found "..total)
    end
    validatePercentsTotal100()

    local function constructColumns()
        local division = width/100
        local accumulator = cps[1]
        for i=1, #cps do
            if (i == 1) then
                container.new( group, 0, 0, division*cps[i], height )
            else
                container.new( group, division*accumulator, 0, division*cps[i], height )
                accumulator = accumulator + cps[i]
            end
        end
    end
    constructColumns()

    local _insert = group.insert
    function group:insert( ... )
        assert(#arg == 2, "Columns:insert requires params: column index, child display object")
        local index, child = unpack( arg )

        group[index]:insert( child )
    end
    
    return group
end

return lib
