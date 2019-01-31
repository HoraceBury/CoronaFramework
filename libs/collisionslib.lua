-- collision library

local collisionslib = {}

local categoryNames = {}
local categoryCounter = 1
local totalCount = 0

local function newCategory( name )
	categoryNames[ name ] = categoryCounter
	categoryCounter = categoryCounter * 2
	totalCount = totalCount + 1
	if (totalCount >= 16) then
		print("WARNING: Max collision filters reached: 16")
	end
	return categoryNames[ name ]
end

function collisionslib.Size()
	return categoryCounter, totalCount
end

function collisionslib.getCategory( name )
	local category = categoryNames[ name ]
	if (category == nil) then
		category = newCategory( name )
	end
	return category
end

function collisionslib.getMask( ... )
	local mask = 0
	for i=1, #arg do
		local name = arg[i]
		mask = mask + collisionslib.getCategory( name )
	end
	return mask
end

function collisionslib.getFilter( categoryName, maskNames )
	return { categoryBits=collisionslib.getCategory( categoryName ), maskBits=collisionslib.getMask( unpack( maskNames ) ) }
end

function collisionslib.dump()
	for k,v in pairs(categoryNames) do
		print(k,v)
	end
end

--collisionslib.batCollisionFilter = getFilter( "bat", { "ball" } )
--collisionslib.ballCollisionFilter = getFilter( "ball", { "bat", "object", "target", "barrier", "powerup" } )
--collisionslib.objectCollisionFilter = getFilter( "object", { "ball" } )
--collisionslib.powerUpCollisionFilter = getFilter( "powerup", { "ball" } )
--collisionslib.targetCollisionFilter = getFilter( "target", { "ball" } )
--collisionslib.barrierCollisionFilter = getFilter( "barrier", { "ball" } )

return collisionslib
