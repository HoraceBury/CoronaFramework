local composer = require( "composer" )
local container = require( "controls.menubuttoncontainer" )
local menubutton = require( "controls.menubutton" )

local scene = composer.newScene()
local sceneGroup
local sceneParams = {}

local function gotoScrollViewDemo()
	composer.gotoScene( "scenes.scrollviewdemo" )
end

local function gotoReorderListDemo()
	composer.gotoScene( "scenes.reorderlistdemo" )
end

local function gotoSegmentedDemo()
	composer.gotoScene( "scenes.segmenteddemo" )
end

local function gotoHelp()
	composer.gotoScene( "scenes.help", { effect="fade", time=300 } )
end

function scene:create( event )
	sceneGroup = self.view
	
	local heading = display.newText{ parent=sceneGroup, text="Corona Framework Demos", fontSize=60, width=display.safeActualContentWidth, align="center" }
	heading.x, heading.y = display.actualCenterX, display.safeScreenOriginY+heading.height*.6
	heading.fill = {0,0,0}
	sceneGroup.heading = heading
	
	sceneGroup.container = container.new( sceneGroup,
		display.safeScreenOriginX+display.safeActualContentWidth*.025, heading.y+heading.height,
		display.safeActualContentWidth*.97, display.safeActualContentHeight-(heading.y+heading.height)
	)

	sceneGroup.quick = menubutton.new( sceneGroup.container, "ScrollViewDemo", gotoScrollViewDemo, .15 )
	sceneGroup.lesson = menubutton.new( sceneGroup.container, "ReorderListDemo", gotoReorderListDemo, .15 )
	sceneGroup.lesson = menubutton.new( sceneGroup.container, "SegmentedDemo", gotoSegmentedDemo, .15 )
	sceneGroup.lesson = menubutton.new( sceneGroup.container, "Help", gotoHelp, .15 )
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
