local composer = require( "composer" )
local reorder = require("controls.reorderlist")

local scene = composer.newScene()
local sceneGroup
local sceneParams = {}

local function randomColour()
	return math.random(100,250)/255
end

function scene:create( event )
	sceneGroup = self.view

	local list = reorder.new( sceneGroup, display.safeScreenOriginX+display.safeActualContentWidth*.1, display.safeScreenOriginY, display.safeActualContentWidth*.8, display.safeActualContentHeight )

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
