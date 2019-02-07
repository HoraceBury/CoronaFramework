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
require("controls.scrollview")

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

-- composer.gotoScene( "scenes.scrollviewdemo" )
composer.gotoScene( "scenes.scrollviewdemo" )
