-- settings

local iolib = require("libs.iolib")
local json = require("json")

local lib = {}

function lib.load()
	local data = iolib.wrDocs( "settings.json" )
	
	if (data) then
		data = json.decode(data)

		for k,v in pairs(data) do
			lib[k] = v
		end
	end
end

function lib.save()
	local data = {}

	for k,v in pairs(lib) do
		if (type(v) ~= "function") then
			data[k] = v
		end
	end
	
	print(json.prettify(json.encode(data)))
	iolib.wrDocs( "settings.json", data )
end

function lib.refresh()
	lib.save()
	Runtime:dispatchEvent{ name="refresh" }
end

lib.load()

return lib
