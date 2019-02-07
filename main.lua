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

-- composer.gotoScene( "scenes.title" )


local function randomColour()
	return math.random(100,250)/255
end

-- reorder list control demo...
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

--[[ -- speed controlled scrollview control demo...
local widget = require("widget")

local scrollView = widget.newScrollView{
	left = display.safeScreenOriginX+display.safeActualContentWidth*.1,
	top = display.safeScreenOriginY,
	width = display.safeActualContentWidth*.8,
	height = display.safeActualContentHeight,
	scrollWidth = display.safeActualContentWidth,
	scrollHeight = display.safeActualContentHeight,
	backgroundColor = {.9,.6,.6},
	horizontalScrollDisabled = false
}

local content = display.newGroup()
scrollView:insert( content )

display.newCircle( content, 0, 0, 75 ).fill = {1,0,0}
display.newCircle( content, display.safeActualContentWidth*.8, 0, 75 ).fill = {0,1,0}
display.newCircle( content, display.safeActualContentWidth*.8*2, 0, 75 ).fill = {0,1,.5}

display.newCircle( content, 0, display.safeActualContentHeight, 75 ).fill = {1,0,1}
display.newCircle( content, display.safeActualContentWidth*.8, display.safeActualContentHeight, 75 ).fill = {0,1,1}
display.newCircle( content, display.safeActualContentWidth*.8*2, display.safeActualContentHeight, 75 ).fill = {.5,1,1}

display.newCircle( content, 0, display.safeActualContentHeight*2, 75 ).fill = {0,0,1}
display.newCircle( content, display.safeActualContentWidth*.8, display.safeActualContentHeight*2, 75 ).fill = {1,1,0}
display.newCircle( content, display.safeActualContentWidth*.8*2, display.safeActualContentHeight*2, 75 ).fill = {1,1,.5}

scrollView:setScrollWidth( display.safeActualContentWidth*.8*2 )
scrollView:setScrollHeight( display.safeActualContentHeight*2 )

scrollView:setScrollSpeed( -10, -100 )

timer.performWithDelay( 5000, function()
	scrollView:setScrollSpeed( 10, 100 )
end )
]]