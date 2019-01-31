local composer = require( "composer" )

local scene = composer.newScene()
local sceneGroup
local sceneParams = {}

local function gotoDisclaimer()
	timer.cancel( sceneGroup.gotoDisclaimerTimer )
	sceneGroup.gotoDisclaimerTimer = nil
	
	sceneGroup.touchrect:removeEventListener( "tap", gotoDisclaimer )

	composer.gotoScene( "scenes.disclaimer", { effect="fade", time=800 } )
	
	return true
end

function scene:create( event )
	sceneGroup = self.view

	local touchrect = display.newRect( sceneGroup, display.actualCenterX, display.actualCenterY, display.actualContentWidth, display.actualContentHeight )
	sceneGroup.touchrect = touchrect
	touchrect.alpha = 0
	touchrect.isHitTestable = true

	local title = display.newText{ parent=sceneGroup, fontSize=70, text="virtual\nsensei" }
	sceneGroup.title = title
	title.x, title.y = display.safeCenterX, display.safeCenterY
	title.fill = {0,0,0}
end

function scene:show( event )
	if (event.phase == "will") then
	elseif (event.phase == "did") then
		sceneGroup.gotoDisclaimerTimer = timer.performWithDelay( 3000, gotoDisclaimer, 1 )
		sceneGroup.touchrect:addEventListener( "tap", gotoDisclaimer )
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
