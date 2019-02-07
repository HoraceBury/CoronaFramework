local composer = require( "composer" )
local segmentcontrol = require("controls.segmentcontrol")

local scene = composer.newScene()
local sceneGroup
local sceneParams = {}

function scene:create( event )
	sceneGroup = self.view

	local segment = segmentcontrol.new{
		parent=sceneGroup,
		x=display.contentCenterX-300, y=display.contentCenterY,
		width=600, height=100,
		items={
			{ text="First", fontSize=48 },
			{ text="Second", fontSize=48 },
			{ text="Third", fontSize=48 },
		},
		showborder=nil,
		callback=function(e) print(e) end
	}
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
