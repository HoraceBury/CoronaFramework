-- composer support library

local composer = require("composer")

-- fires the lazyhide event prior to the normal hide event
-- allows a scene to be told to hide and control when it actually hides
-- requires that the current scene is listening for the event and calls the callback function passed in the event table
-- options parameter requires options.callback function or will behave as normal
--[[
	Requires scene to implement:
	
		function scene:lazyhide( event )
			event.callback()
		end
		scene:addEventListener( "lazyhide", scene )
]]--
function composer.gotoLazyScene( sceneName, options )
	options = options or {}
	
	local function callback()
		options.callback = nil
		composer.gotoScene( sceneName, options )
	end
	
	local currentSceneName = composer.getSceneName( "current" )
	local currentScene = composer.getScene( currentSceneName )
	
	if (currentScene.lazyhide) then
		currentScene:dispatchEvent{ name="lazyhide", options=options, callback=callback }
	else
		callback()
	end
end

-- allows customer composer events to be dispatched (allows display groups used in scenes to avoid knowing about the scene they are added to)
function composer.dispatchEvent( options )
	local currentSceneName = composer.getSceneName( "current" )
	local currentScene = composer.getScene( currentSceneName )
	
	currentScene:dispatchEvent( options )
end

-- very simply calls the hide function on the current scene, waits for options.time and then
-- calls the show function on the same scene
-- this is because calling gotoScene with normal composer behaviour does not implement a typical hide/show event sequence
local _gotoScene = composer.gotoScene
composer.gotoScene = function( ... )
	local currentSceneName = composer.getSceneName( "current" )
	
	if (currentSceneName == arg[1]) then
		local options = arg[2] or {}
		local time = options.time or 1
		
		local currentScene = composer.getScene( currentSceneName )
		
		currentScene:dispatchEvent{ name="hide", phase="will", options=options }
		transition.to( currentScene.view, { time=time, alpha=0, onComplete=function()
			currentScene:dispatchEvent{ name="hide", phase="did", options=options }
			currentScene:dispatchEvent{ name="show", phase="will", options=options }
			transition.to( currentScene.view, { time=time, alpha=1, onComplete=function()
				currentScene:dispatchEvent{ name="show", phase="did", options=options }
			end } )
		end } )
	else
		_gotoScene( unpack( arg ) )
	end
end

-- calls a series of functions (without parameters), each one being called after the callback function is returned
function composer.fire( ... )
	local call
	
	call = function()
		local func = table.remove( arg, 1 )
		if (func) then
			func( call )
		end
	end
	
	call()
end
