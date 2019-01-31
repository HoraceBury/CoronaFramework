local composer = require( "composer" )
local iolib = require("libs.iolib")
local backbutton = require("controls.backbutton")

local scene = composer.newScene()
local sceneGroup
local sceneParams = {}

local helpText

local function loadText()
	helpText = helpText or iolib.rResource( "static/help.txt" )
	return helpText
end

function scene:create( event )
	sceneGroup = self.view

	local back = backbutton.new( sceneGroup, "scenes.menu", callback )

	local heading = display.newText{ parent=sceneGroup, text="Sensei", fontSize=72 }
	heading.x, heading.y = display.actualCenterX, display.safeScreenOriginY+heading.height*.6
	heading.fill = {0,0,0}
	sceneGroup.heading = heading
	
	back.y = heading.y

	sceneGroup.disclaimer = display.newText{ parent=sceneGroup, fontSize=32, text=loadText(), width=display.safeActualContentWidth*.75 }
	sceneGroup.disclaimer.x, sceneGroup.disclaimer.y = display.safeCenterX, display.safeCenterY
	sceneGroup.disclaimer.fill = {0,0,0}
end

function callback()
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
