-- graphics extension library

local lib = {}

-- https://math.stackexchange.com/questions/2269589/calculate-angle-of-the-next-point-on-a-circle
--[[
	Generates a table of points containing the outline of a circle with each point 'step' pixels from the previous.
	
	Parameters:
		x, y: The centre of the circle
		radius: The radius of the circle to generate
		step: Distance between one point and the next around the edge of the circel
		length: Length around the circumference to travel. Allows the generation of segments.
		initialrotation: Angle of the first generated point.
		innerradius: If a positive number, the generated path is copied, reversed and attach to the end of the path to make a segment.
	
	Returns:
		Table of {x,y} tables
		Table of {x,y,x,y,...} point values (as accepted by physics.addBody outline parameter)
	
	Notes:
		The first and last point are not likely to be 'step' distance from each other because the circumference around a
		circle is not likely to be evenly divisible by 'step'.
]]--
function graphics.newCircleOutline( ... )
	local x, y, radius, step, length, initialrotation, innerradius
	
	if (#arg == 1) then
		x, y, radius, step, length, initialrotation, innerradius = arg[1].x, arg[1].y, arg[1].radius, arg[1].step, arg[1].length, arg[1].initialrotation, arg[1].innerradius
	else
		x, y, radius, step, length, initialrotation, innerradius = unpack(arg)
	end
	
	local tbl, pts = {}, {}
	
	if (length == nil or length < 0 or length > 360) then length=360 end
	
	local centre = {x=x,y=y}
	
	local r = step/(2*radius)
	local angle = math.deg(math.asin(r)) * 2
	
	local origin = {x=0,y=-radius}
	origin = math.rotateTo( origin, initialrotation or 0, {x=0,y=0} )
	
	local a = 0
	while (a < length) do
		local pt = math.rotateTo( origin, a, {x=0,y=0} )
		tbl[#tbl+1] = pt
		pts[#pts+1] = pt.x
		pts[#pts+1] = pt.y
		a = a + angle
	end
	
	if (innerradius ~= nil and innerradius > 0) then
		local innertbl = graphics.newCircleOutline( x, y, innerradius, step, length, initialrotation, nil )
		innertbl = table.reverse( innertbl )
		tbl = table.copy( tbl, innertbl )
		
		for i=1, #innertbl do
			pts[#pts+1] = innertbl[i].x
			pts[#pts+1] = innertbl[i].y
		end
	end
	
	return tbl, pts
end

--[[
	Generates a semi-circle set of points, starting at a given angle and continuing for half a turn.
	
	Parameters:
		x, y: The centre of the would-be circle
		radius: Radius of the circle
		ptcount: Number of graphics location points to generate
		startangle: The initial angle to have a point at. Last point will be 180 degrees rotated from this point around the x,y centre.
	
	Returns:
		tbl: Table of {x,y} locations
		pts: Collection of {x,y,x,y,x,y,...} points as accepted by display.newLine(unpack(pts))
]]--
function graphics.newSemiCircle( x, y, radius, ptcount, startangle )
	local tbl = {}
	local pts = {}
	
	local centre = {x=x,y=y}
	local origin = {x=x,y=y-radius}
	
	for i=0, ptcount-1 do
		local pt = math.rotateTo( origin, startangle+i*(180/(ptcount-1)), centre )
		tbl[#tbl+1] = pt
		pts[#pts+1] = pt.x
		pts[#pts+1] = pt.y
	end
	
	return tbl, pts
end

return lib
