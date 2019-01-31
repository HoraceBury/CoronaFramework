-- catmull-rom-spline library

-- Resources:
-- https://gist.github.com/1383576
-- http://codeplea.com/simple-interpolation
-- http://codeplea.com/introduction-to-splines

require("tablelib")
require("mathlib")

local lib = {}

lib.steprate = 15

function lib.catmull( points, closed )
	if (#points < 6) then
		return points
	end
	
	local steps = steps or 10
	local firstX, firstY, secondX, secondY = unpack( table.range( points, 1, 4 ) )
	local penultX, penultY, lastX, lastY = unpack( table.range( points, #points-3, 4 ) )
	
	if (closed) then
		points = table.copy( { penultX, penultY, lastX, lastY } , points, { firstX, firstY, secondX, secondY } )
	end
	
	local spline = {}
	local start, count = 1, #points-2
	local p0x, p0y, p1x, p1y, p2x, p2y, p3x, p3y
	local x, y
	
	if (closed) then
		start = 3
		count = #points-5
	end
	
	for i=start, count, 2 do
		if (not closed and i==1) then
			p0x, p0y, p1x, p1y, p2x, p2y, p3x, p3y = points[i], points[i+1], points[i], points[i+1], points[i+2], points[i+3], points[i+4], points[i+5]
			steps = math.lengthOf( p1x,p1y , p3x,p3y )
		elseif (not closed and i==count-1) then
			p0x, p0y, p1x, p1y, p2x, p2y = unpack( table.range( points, #points-5, 6 ) )
			p3x, p3y = points[#points-1], points[#points]
			steps = math.lengthOf( p1x,p1y , p3x,p3y )
		else
			p0x, p0y, p1x, p1y, p2x, p2y, p3x, p3y = unpack( table.range( points, i-2, 8 ) )
			steps = math.lengthOf( p0x,p0y , p1x,p1y )
		end
		
		for t=0, 1, 1 / (steps/lib.steprate) do
			x = 0.5 * ( ( 2 * p1x ) + ( p2x - p0x ) * t + ( 2 * p0x - 5 * p1x + 4 * p2x - p3x ) * t * t + ( 3 * p1x - p0x - 3 * p2x + p3x ) * t * t * t )
			y = 0.5 * ( ( 2 * p1y ) + ( p2y - p0y ) * t + ( 2 * p0y - 5 * p1y + 4 * p2y - p3y ) * t * t + ( 3 * p1y - p0y - 3 * p2y + p3y ) * t * t * t )
			
			-- prevent duplicate entries
			if (not(#spline > 0 and spline[#spline-1] == x and spline[#spline] == y)) then
				spline[#spline+1] = x
				spline[#spline+1] = y
			end
		end
	end
	
	if (closed) then
		table.remove(points,1)
		table.remove(points,1)
		table.remove(points,#points)
		table.remove(points,#points)
	end
	
	return spline
end

function lib.test()
	local ctrls = { 100, 100, 100, 300, 300, 300, 300, 500 }
	for i=1, #ctrls-1, 2 do
		display.newCircle( ctrls[i], ctrls[i+1], 15 ).fill = {1,0,0}
	end
	local spline = lib.catmull( ctrls, true )
	display.newLine( unpack( spline ) ).strokeWidth = 2
end

return lib
