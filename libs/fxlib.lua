local lib = {}

--[[
	Shadow constructor. Takes a display group and optional colour match to the background.
	Renders a shadow
	Params:
		group: Requires that the object the shadow is generated for is a display group.
		backgroundColour: The colour that the shadow should be rendered to.
		spread: Amount the blur is rendered by to increase its spread.
		alpha: The alpha value of the blur. Default is 1.
		notgrey: True if the shadow should be coloured like the group. Default is false.
	Returns:
		The shadow which is inserted into the group is returned, but will have index 1 anyway.
]]
function lib.new( group, backgroundColour, spread, alpha, notgrey )
	local backed = lib.back(group, backgroundColour, spread)

	local blurred = lib.blur(backed, true, spread or 0)
	if (notgrey == nil or notgrey) then blurred = lib.greyed(blurred, true) end
	blurred.alpha = alpha or 1

	local x, y = lib.shadowLocation( group )
	group:insert( 1, blurred )
	blurred.x, blurred.y = x, y

	return blurred
end

--[[ SUPPORTING FUNCTIONS ]]

function lib.cap( group )
	local capture = display.capture( group, { saveToPhotoLibrary=false, captureOffscreenArea=true } )
	capture.x, capture.y = group.x, group.y
	return capture
end

function lib.shadowLocation( group )
	local x, y = (group.contentBounds.xMin+group.contentBounds.xMax)/2, (group.contentBounds.yMin+group.contentBounds.yMax)/2
	return group:contentToLocal( x, y )
end

function lib.back( group, colour, spread )
	local x, y = lib.shadowLocation( group )
	local rect = display.newRect( group, x, y, group.width+(150*(spread or 1)), group.height+(150*(spread or 1)) )
	rect:toBack()
	rect.fill = colour or {1,1,1}

	local c = lib.cap( group )

	rect:removeSelf()

	return c
end

function lib.blur( group, removeOriginal, count )
	local capture = lib.cap( group )
	capture.fill.effect = "filter.blurGaussian"
	capture.fill.effect.horizontal.blurSize = 512
	capture.fill.effect.horizontal.sigma = 512
	capture.fill.effect.vertical.blurSize = 512
	capture.fill.effect.vertical.sigma = 512
	if (count > 0) then
		capture = lib.blur( capture, true, count-1 )
	end
	if (removeOriginal) then group:removeSelf() end
	return capture
end

function lib.greyed( group, removeOriginal )
	local capture = lib.cap( group )
	capture.fill.effect = "filter.grayscale"
	if (removeOriginal) then group:removeSelf() end
	return capture
end

--[[ DEMO ]]

--[[
local a = display.newGroup()
a.x, a.y = display.actualCenterX, display.actualContentHeight*.25
display.newRoundedRect( a, 0, 0, 300, 300, 50 ).fill = {1,0,0}

local b = display.newGroup()
b.x, b.y = display.actualCenterX-150, display.actualContentHeight*.5-150
display.newRoundedRect( b, 150, 150, 300, 300, 50 ).fill = {0,0,1}

local d = display.newGroup()
d.x, d.y = display.actualCenterX+150, display.actualContentHeight*.75
display.newRoundedRect( d, -150, 0, 300, 300, 50 ).fill = {0,1,0}

local c = {.96}

lib.new( a, c, 2 )
lib.new( b, c, nil, nil, false )
lib.new( d, c, nil, 1 )
]]

return lib
