print( os.date( "%c" ) )

display.actualCenterX, display.actualCenterY = display.actualContentWidth/2, display.actualContentHeight/2
-- docs: display.safeScreenOriginX, display.safeScreenOriginY
-- docs: display.safeActualContentWidth, display.safeActualContentHeight
display.safeCenterX, display.safeCenterY = display.safeScreenOriginX+display.safeActualContentWidth/2, display.safeScreenOriginY+display.safeActualContentHeight/2

require("libs.utils")
require("libs.tablelib")
require("libs.mathlib")
require("libs.graphicslib")
require("libs.timerlib")
require("libs.composerlib")

local json = require("json")
local iolib = require("libs.iolib")
iolib.isdebug = false

display.setStatusBar( display.DefaultStatusBar )
display.setDefault( "background", .88 )

local composer = require("composer")

local composer_isDebug = "normal"

--[[ local function touch(e)
	if (e.phase == "began") then
		e.target.hasFocus = true
		display.currentStage:setFocus(e.target)
		e.target.touchjoint = physics.newJoint( "touch", e.target, e.x, e.y )
		if (e.target.touch) then e.target:touch(e) end
		return true
	elseif (e.target.hasFocus) then
		e.target.touchjoint:setTarget( e.x, e.y )
		if (e.phase == "moved") then
		else
			e.target.hasFocus = nil
			display.currentStage:setFocus(nil)
			e.target.touchjoint:removeSelf()
			e.target.touchjoint = nil
		end
		if (e.target.touch) then e.target:touch(e) end
		return true
	end
	return false
end ]]

-- composer.gotoScene( "scenes.title" )


local function randomColour()
	return math.random(100,250)/255
end

local reorder = require("controls.reorderlist")
local list = reorder.new( display.currentStage, display.safeScreenOriginX+display.safeActualContentWidth*.1, display.safeScreenOriginY, display.safeActualContentWidth*.8, display.safeActualContentHeight )

local function newitem(t)
	local group = display.newGroup()

	local rect = display.newRect( group, 0, 0, display.safeActualContentWidth*.8, display.safeActualContentHeight*.15 )
	rect.fill = {randomColour(),randomColour(),randomColour()}

	local text = display.newText{ parent=group, text=t, fontSize=48 }
	text.fill = {1,1,1}

	return group
end

list:addItem( newitem(1), true )
list:addItem( newitem(2), true )
list:addItem( newitem(3), true )
list:addItem( newitem(4), true )
list:addItem( newitem(5), true )
list:addItem( newitem(6), true )
list:addItem( newitem(7), true )
list:addItem( newitem(8), true )
list:addItem( newitem(9), true )
list:addItem( newitem(10), true )
