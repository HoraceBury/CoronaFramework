local composer = require( "composer" )
local widget = require("widget")
local pancontrol = require("controls.pancontrol")

local scene = composer.newScene()
local sceneGroup
local sceneParams = {}

function scene:create( event )
	sceneGroup = self.view

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
	sceneGroup:insert( scrollView )
	
	local content = display.newGroup()
	scrollView:insert( content )

	display.newRect( content, display.safeActualContentWidth*.8, display.safeActualContentHeight, display.safeActualContentWidth*.8*2, display.safeActualContentHeight*2 )
	
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
	
	-- timer.performWithDelay( 1000, function()
		-- scrollView:setScrollSpeed( -10, -100 )
	-- end )
	
	-- timer.performWithDelay( 5000, function()
	-- 	scrollView:setScrollSpeed( 10, 100 )
	-- end )

	local itemgroup = display.newGroup()
	itemgroup.x, itemgroup.y = 300, 500
	display.newRoundedRect( itemgroup, 0, 0, 200, 200, 50 ).fill = {1,0,1}

	local pan = pancontrol.new( scrollView, itemgroup, false, true )
end

function scene:show( event )
	if (event.phase == "will") then
	elseif (event.phase == "did") then
	end
end

function scene:hide( event )
	if (event.phase == "will") then
	elseif (event.phase == "did") then
	end
end

function scene:destroy( event )
	sceneGroup = nil
	sceneParams = nil
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
