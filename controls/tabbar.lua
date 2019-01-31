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

    return segmentedControl
end

local function newSegmentBar( parent, top, segments, listener, width )
	width = width or display.actualContentWidth*.92
	
	-- Image sheet options and declaration
	local options = {
		frames = 
		{
			{ x=0, y=0, width=40, height=58 },
			{ x=40, y=0, width=40, height=58 },
			{ x=80, y=0, width=40, height=58 },
			{ x=120, y=0, width=40, height=58 },
			{ x=160, y=0, width=40, height=58 },
			{ x=200, y=0, width=40, height=58 },
			{ x=240, y=0, width=2, height=58 }
		},
		sheetContentWidth = 242,
		sheetContentHeight = 58
	}
	local segmentSheet = graphics.newImageSheet( "segment.png", options )
	
	-- Create a custom segmented control
	local segmentedControl = widget.newSegmentedControl
	{
		left = display.actualContentWidth*.05,
		top = top,
		
		sheet = segmentSheet,
		leftSegmentFrame = 1,
		middleSegmentFrame = 2,
		rightSegmentFrame = 3,
		leftSegmentSelectedFrame = 4,
		middleSegmentSelectedFrame = 5,
		rightSegmentSelectedFrame = 6,
		segmentFrameWidth = 40,
		segmentFrameHeight = 58,
		
		dividerFrame = 7,
		dividerFrameWidth = 2,
		dividerFrameHeight = 58,
		
		labelSize = 28,
		
		segmentWidth = width/#segments,
		segments = segments,
		defaultSegment = 1,
		labelColor = 
		{
			default = { 0, .5, .98 },
			over = { .97, .97, .97 },
		},
		onPress = listener,
	}
	parent:insert( segmentedControl )
	segmentedControl.x = display.actualCenterX
	
	return segmentedControl
end

return lib
