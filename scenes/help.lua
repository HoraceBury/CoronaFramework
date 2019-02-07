local composer = require( "composer" )
local iolib = require("libs.iolib")

local scene = composer.newScene()
local sceneGroup
local sceneParams = {}

local disclaimerText

local function loadText()
	disclaimerText = disclaimerText or iolib.rResource( "static/help.txt" )
	return disclaimerText
end

local function gotoMenu()
	timer.cancel( sceneGroup.gotoMenuTimer )
	sceneGroup.gotoMenuTimer = nil
	
	sceneGroup.touchrect:removeEventListener( "tap", gotoMenu )

	composer.gotoScene( "scenes.menu", { effect="fade", time=300 } )
	
	return true
end

function scene:create( event )
	sceneGroup = self.view
	
	local touchrect = display.newRect( sceneGroup, display.actualCenterX, display.actualCenterY, display.actualContentWidth, display.actualContentHeight )
	sceneGroup.touchrect = touchrect
	touchrect.alpha = 0
	touchrect.isHitTestable = true

	sceneGroup.disclaimer = display.newText{ parent=sceneGroup, fontSize=36, text=loadText(), width=display.safeActualContentWidth*.75 }
	sceneGroup.disclaimer.x, sceneGroup.disclaimer.y = display.safeCenterX, display.safeCenterY
	sceneGroup.disclaimer.fill = {0,0,0}
end

function scene:show( event )
	if (event.phase == "will") then
	elseif (event.phase == "did") then
		sceneGroup.gotoMenuTimer = timer.performWithDelay( 3000, gotoMenu, 1 )
		sceneGroup.touchrect:addEventListener( "tap", gotoMenu )
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
