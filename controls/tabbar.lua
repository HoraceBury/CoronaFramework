local widget = require( "widget" )
 
local lib = {}

local segments = { "Kata", "Kihon", "Kumite" }

function lib.new( parent, x, y, callback )
    local function onSegmentPress( event )
        local target = event.target
        print( target.segmentLabel.." - "..target.segmentNumber )
        callback(target.segmentLabel)
    end
    
    local segmentedControl = widget.newSegmentedControl {
        left = x,
        top = y,
        segmentWidth = display.safeActualContentWidth*.25,
        segments = segments,
        defaultSegment = 1,
        labelSize = 22,
        onPress = onSegmentPress
    }
    parent:insert( segmentedControl )

    function segmentedControl:setActiveLabel( label )
        local index = table.indexOf(segments, label)
        segmentedControl:setActiveSegment(index)
    end

    function segmentedControl:getX()
        return segmentedControl.x
    end

    function segmentedControl:getY()
        return segmentedControl.y
    end

    function segmentedControl:getWidth()
        return segmentedControl.width
    end

    function segmentedControl:getHeight()
        return segmentedControl.height
    end

    return segmentedControl
end

return lib
