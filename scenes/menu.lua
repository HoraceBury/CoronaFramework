local composer = require( "composer" )
local container = require( "controls.menubuttoncontainer" )
local menubutton = require( "controls.menubutton" )

local scene = composer.newScene()
local sceneGroup
local sceneParams = {}

local function gotoQuick()
	composer.gotoScene( "scenes.quick", { effect="slideLeft", time=800 } )
end

local function gotoMe()
	composer.gotoScene( "scenes.me", { effect="slideLeft", time=800 } )
end

local function gotoSensei()
	composer.gotoScene( "scenes.sensei", { effect="slideLeft", time=800 } )
end

local function gotoHelp()
	composer.gotoScene( "scenes.help", { effect="slideLeft", time=800 } )
end

function scene:create( event )
	sceneGroup = self.view
	
	local heading = display.newText{ parent=sceneGroup, text="Virtual Sensei", fontSize=72 }
	heading.x, heading.y = display.actualCenterX, display.safeScreenOriginY+heading.height*.6
	heading.fill = {0,0,0}
	sceneGroup.heading = heading
	
	sceneGroup.container = container.new( sceneGroup,
		display.safeScreenOriginX+display.safeActualContentWidth*.025, heading.y+heading.height,
		display.safeActualContentWidth*.97, display.safeActualContentHeight-(heading.y+heading.height)
	)

	sceneGroup.quick = menubutton.new( sceneGroup.container, "Quick", gotoQuick, .15 )
	sceneGroup.lesson = menubutton.new( sceneGroup.container, "Lesson", callback, .15 )
	sceneGroup.gallery = menubutton.new( sceneGroup.container, "Gallery", callback, .15 )
	sceneGroup.me = menubutton.new( sceneGroup.container, "Me", gotoMe, .15 )
	sceneGroup.sensei = menubutton.new( sceneGroup.container, "Sensei", gotoSensei, .15 )
	sceneGroup.help = menubutton.new( sceneGroup.container, "Help", gotoHelp, .15 )
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
