-- settings

local iolib = require("libs.iolib")
local json = require("json")

local lib = {}

-- imports and removes the old settings file
local function importOnce()
	-- check for old settings file
	-- load it
	-- store values into new settings
	-- delete it
end
importOnce()

-- deletes the settings file
function lib.clear( ... )
	if (#arg == 0) then
		iolib.removeDoc( "settings.json" )
	else
		local doBroadcast = false

		if (type(arg[#arg]) == "boolean") then
			doBroadcast = arg[#arg]
			arg[#arg] = nil
		end

		for i=1, #arg do
			lib.set( arg[i], nil, doBroadcast )
		end
	end
end

-- simply loads the saved table into the lib table
function lib.load()
	local data = iolib.wrDocs( "settings.json" )
	
	if (data) then
		data = json.decode(data)

		for k,v in pairs(data) do
			lib[k] = v
		end
	end
end

-- simply saves the lib table without the function objects
function lib.save()
	local data = {}

	for k,v in pairs(lib) do
		if (type(v) ~= "function") then
			data[k] = v
		end
	end
	
	-- print(json.prettify(json.encode(data)))
	iolib.wrDocs( "settings.json", data )
end

function lib.deferSave()
	if (lib.deferTimer) then
		lib.deferTimer = timer.cancel( lib.deferTimer )
	end

	lib.deferTimer = timer.performWithDelay( 500, function()
		lib.deferTimer = nil
		lib.save()
	end, 1 )
end

-- saves the table and dispatches a refresh event
function lib.refresh()
	lib.save()
	Runtime:dispatchEvent{ name="refresh" }
end

-- sets a value and optionally broadcasts if the value changed
function lib.set( key, value, doBroadcast, force )
	local original = lib.get( key, nil )
	lib[ key ] = value
	if (lib[ key ] ~= original or force) then
		if (force or (doBroadcast ~= nil and doBroadcast)) then
			Runtime:dispatchEvent{ name=key, value=value }
		end
		lib.deferSave()
	end
end

-- returns a guaranteed value
function lib.get( key, default )
	local value = lib[ key ]
	if (value == nil) then value=default end
	return value
end

-- convenience to flip binary settings
function lib.toggle( key, defaultValue, doBroadcast )
	lib.set( key, not lib.get( key, defaultValue ), doBroadcast )
end

lib.load()

return lib
