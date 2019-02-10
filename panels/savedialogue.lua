local modalbackground = require("controls.modalbackground")
local linkbutton = require("controls.linkbutton")
local rgb = require("libs.rgb")

local lib = {}

function lib.new( callback )
    local blocker = modalbackground.new()

    local group = display.newGroup()
    group.x, group.y = display.safeCenterX, display.safeActualContentHeight*.45

    local calltoaction = display.newText{ parent=group, x=0, y=0, fontSize=52, text="Name this activity:" }
    calltoaction.fill = {0,0,0}

    local input = native.newTextField( 0, 0, calltoaction.width, calltoaction.height )
    
    local background = display.newRoundedRect( group, 0, 0, calltoaction.width*1.4, calltoaction.height*7, 25 )
    background.fill = {.9}
    display.stroke( background, {.75}, 2 )
    background:toBack()

    calltoaction.y = background.y-background.height/2+background.height*.25
    local callX, callY = calltoaction:localToContent( 0, 0 )
    input.x, input.y = callX, callY+calltoaction.height*2

    local horizontal = display.newLine( group, -background.width/2+1, background.height*.25, background.width/2-1, background.height*.25 )
    horizontal.strokeWidth = 2
    horizontal:setStrokeColor( .75 )

    local vertical = display.newLine( group, 0, background.height*.25, 0, background.height*.5 )
    vertical.strokeWidth = 2
    vertical:setStrokeColor( .75 )

    local cancel = linkbutton.new()
        :withParent( group )
        :withText( "Cancel" )
        :at( (-background.width/2+1)/2, (background.height/2)-(background.height*.25/2) )
        :withHitZone( background.width/2, (background.height/2)-(background.height*.3) )
        :withFontSize( 50 )
        :callTo( function(e)
            group:removeSelf()
        end )
    
    local save = linkbutton.new()
        :withParent( group )
        :withText( "Save" )
        :at( (background.width/2+1)/2, (background.height/2)-(background.height*.25/2) )
        :withHitZone( background.width/2, (background.height/2)-(background.height*.3) )
        :withFontSize( 50 )
        :callTo( function(e)
            callback( input.text )
            group:removeSelf()
        end )
    
    input:addEventListener( "userInput", function(e)
        if (input.text == "") then
            save:withColour( {.8} )
        else
            save:withColour( rgb.rgb.iosblue )
        end
    end )
    input:dispatchEvent{ name="userInput" }

    group:addEventListener( "finalize", function()
        native.setKeyboardFocus( nil )
        blocker:removeSelf()
        input:removeSelf()
        blocker = nil
        input = nil
    end )

    return group
end

return lib
