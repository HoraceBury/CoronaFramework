-- timer lib

local tags = {}

local cancel, pause, performWithDelay, resume = timer.cancel, timer.pause, timer.performWithDelay, timer.resume

--[[
	Adds the optional tag parameter to the standard performWithDelay function.
	
	Parameters:
		tag: optional, allows naming the timer created
		delay: delay in milliseconds
		listener: callback function
		iterations: (optional) number of times to repeat, default is 1, 0 is infinite
	
	Returns:
		The timer handle created.
]]--
timer.performWithDelay = function( ... )
	if (type(arg[1]) == "string") then
		local tag = table.remove( arg, 1 )
		local id = performWithDelay( unpack( arg ) )
		if (id) then
			local handles = tags[tag] or {}
			handles[#handles+1] = id
			tags[tag] = handles
			return id
		end
		return
	else
		return performWithDelay( unpack( arg ) )
	end
end

timer.cancel = function( idOrTag )
	if (type(idOrTag) == "string") then
		local handles = tags[idOrTag] or {}
		for i=1, #handles do
			cancel( handles[i] )
		end
		tags[idOrTag] = nil
	else
		cancel( idOrTag )
	end
end

timer.pause = function( idOrTag )
	if (type(idOrTag) == "string") then
		local handles = tags[idOrTag] or {}
		local total = 0
		for i=1, #handles do
			total = tatal + pause( handles[i] )
		end
		return total
	else
		return pause( idOrTag )
	end
end

timer.resume = function( idOrTag )
	if (type(idOrTag) == "string") then
		local handles = tags[idOrTag] or {}
		local total = 0
		for i=1, #handles do
			total = tatal + resume( handles[i] )
		end
		return total
	else
		return resume( idOrTag )
	end
end

function timer.oneSecond( func, tag )
	tag = tag or tostring(system.getTimer())
	timer.performWithDelay( tag, 1000, func, 1 )
end

function timer.tenMillis( func, tag )
	tag = tag or tostring(system.getTimer())
	timer.performWithDelay( tag, 10, func, 1 )
end

function timer.immediate( func, tag )
	tag = tag or tostring(system.getTimer())
	timer.performWithDelay( tag, 1, func, 1 )
end
