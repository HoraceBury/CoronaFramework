local container = require( "controls.menubuttoncontainer" )
local gradientslider = require( "controls.gradientslider" )
local radialgradientslider = require( "controls.radialgradientslider" )
local savebutton = require("controls.savebutton")
local tabbar = require("controls.tabbar")
local segmentcontrol = require("controls.segmentcontrol")
local rgb = require("libs.rgb")

local lib = {}

function lib.new( parent )
    local x, y, width, height = parent:getX(), parent:getY(), parent:getWidth(), parent:getHeight()

    local group = display.newGroups( parent, 1 )
    group.x, group.y = x, y
    
    local background = display.newRoundedRect( group, width/2, height/2, width, height, 25 )
    background.fill = rgb.rgb.white

    local function save()
    end

	local save = savebutton.new( group, nil )

	local activitylabel = display.newText{ parent=group, text="Activity", fontSize=42 }
	activitylabel.x, activitylabel.y = activitylabel.width*.6, save.y+activitylabel.height
	activitylabel.fill = rgb.rgb.iosgrey

    local segment = segmentcontrol.new{ parent=group, x=parent:getWidth()*.05, y=activitylabel.y+activitylabel.height, width=parent:getWidth()*.9, height=50, items={
        { text="Kata", fontSize=26 },
        { text="Kihon", fontSize=26 },
        { text="Kumite", fontSize=26 }
    }, showborder=nil, callback=function(e) print(e) end }

    -- local lesson = gradientslider.new( group, { "Kyu", "Dan" }, 0, { rgb.rgb.green, rgb.rgb.orange }, rgb.rgb.white, callback, .15 )

    return group
end

return lib
