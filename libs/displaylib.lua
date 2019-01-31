-- display lib

local newShapeList = {
	"newCircle",
	"newContainer",
	"newEmbossedText",
	"newEmitter",
	"newGroup",
	"newImage",
	"newImageRect",
	"newLine",
	"newMesh",
	"newPolygon",
	"newRect",
	"newRoundedRect",
	"newSnapshot",
	"newSprite",
	"newText",
}

local function addLocalToContentOverride( displayObj )
	local oldFunc = displayObj.contentToLocal
	
	displayObj.contentToLocal = function( x, y, rotation )
		local _x, _y = oldFunc( displayObj, x, y )
		-- perform rotation to local here
		return _x, _y
	end
end

local function addShapeOverrides()
	for i=1, #newShapeList do
		local funcName = newShapeList[i]
		local funcOld = display[ funcName ]
		
		local function funcNew( ... )
			local displayObj = oldFunc( unpack( arg ) )
			
			addLocalToContentOverride( displayObj )
			
			return object
		end
		
		display[ funcName ] = funcNew
	end
end
addShapeOverrides()

function display.newRadialFillCircle( parent, x, y, r, c )
	local group = display.newGroup()
	group.x, group.y = x, y
	parent = parent or display.currentStage
	parent:insert( group )
	
	local ringinc = 100/(r/4)
	local a = 0
	for i=r, 2, -4 do
		local circle = display.newCircle( group, 0, 0, i-2 )
		circle.fill = {0,0,0,0}
		circle.strokeWidth = 4
		a = a + ringinc
		c[4] = a/100
		circle.stroke = c
	end
	
	return group
end
