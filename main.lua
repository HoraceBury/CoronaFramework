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

-- composer.gotoScene( "scenes.scrollviewdemo" )
-- composer.gotoScene( "scenes.menu" )

local widget = require("widget")
local scrollView = widget.newScrollView{
	top=display.safeScreenOriginY, left=display.safeScreenOriginX,
	width=display.safeActualContentWidth, height=display.safeActualContentHeight,
	backgroundColor={1,0,0,.1}
}

local content, drag = display.newGroup(), display.newGroup()
scrollView:insert( content )
drag.x, drag.y = display.safeScreenOriginX, display.safeScreenOriginY

local isPopped = false

local function nextContentInsertPosY()
	local y = 0

	if (content.numChildren == 0) then return 0 end

	for i=1, content.numChildren do
		if (content[i].contentBounds.yMax > y) then y=content[i].contentBounds.yMax end
	end

	local _x, _y = content:contentToLocal( 0, y )
	return _y
end

local function addTab( parent )
	local group = display.newGroups( parent, 1 )
	group.x, group.y = parent.width*.9, parent.height*.5
	local rect = display.newRoundedRect( group, 0, 0, parent.height*.5, parent.height*.5, 5 )
	rect.fill = {.8}
	return group
end

local function pop( group )
	group.rect.fill = {.86}
	drag:insert( group )
	isPopped = true
end

local function newItem( text )
	local x, y = 0, nextContentInsertPosY()

	local group = display.newGroups( content, 1 )
	group.x, group.y = x, y

	local rect = display.newRect( group, 0, 0, display.safeActualContentWidth, display.safeActualContentHeight*.1 )
	rect.x, rect.y = rect.width/2, rect.height/2
	display.stroke( rect, {.7}, 2 )
	group.rect = rect

	local label = display.newText{ parent=group, text=text, fontSize=60, x=rect.x, y=rect.y }
	label.fill = {0,0,0}

	group.tab = addTab( group )

	return group
end

for i=1, 10 do
	newItem( i )
end

scrollView:setScrollHeight(nextContentInsertPosY())

local item = content[6]
pop( item )

local function getMidY( item )
	local cb = item.contentBounds
	local yContent = (cb.yMin + cb.yMax) / 2
	local x, y = content:contentToLocal( 0, yContent )
	return y
end

local function sorter(a,b)
	if (not a or not b) then return true end
	if (a.midY < b.midY) then
		return a.midY < b.midY-b.height/2
	else
		return a.midY > b.midY+b.height/2
	end
end

local function sort()
	local tbl = { item }
	item.midY = getMidY( item )

	for i=1, content.numChildren do
		tbl[ #tbl+1 ] = content[i]
		content[i].midY = getMidY( content[i] )
	end

	-- this function needs to determine based on closest 50%
	table.sort( tbl, sorter ) -- throws error because calling sorter(a,b) MUST return a different result than calling sorter(b,a)
	return tbl
end

local function position( tbl )
	local y = 0
	for i=1, #tbl do
		-- tbl[i].y = tbl[i].midY - tbl[i].height/2
		if (tbl[i].parent == content) then
			if (tbl[i].y ~= y) then
				transition.to( tbl[i], { time=100, y=y } )
				-- tbl[i].y = y
			end
		end
		y = y + tbl[i].height
	end
end

-- transition.to( item, { time=4000, y=item.y+350, onComplete=function()
	transition.to( item, { time=6000, y=item.y-700 } )
-- end } )

timer.performWithDelay( 100, function()
	if (isPopped) then
		position( sort() )
	end
end, 0 )
