local rgb = require("libs.rgb")
local togglebutton = require("controls.togglebutton")

local lib = {}

local offset = 10
local gap = 10
local rounding = 30
local fill = {.98}
local shadow = {.82,.82,.82}

function lib.new( parent, texts, value, fillcolours, backcolour, callback, heightfraction )
    local x, y = parent:getX(), parent:getY()+gap

    local group = display.newGroups( parent, 1 )
    group.x, group.y = x, y

    function group:getX()
        return group.x
    end

    function group:getY()
        return group.y
    end

    function group:getWidth()
        return group.width
    end

    function group:getHeight()
        return group.height
    end

    local function buttoncallback( text )
        callback{ label=text, value=value }
    end
    
    local button = togglebutton.new( group, 0, 0, texts, buttoncallback )

    local backrect = display.newRoundedRect( group, 0, 0, parent:getWidth()-offset, display.safeActualContentHeight*heightfraction-offset-button.height, rounding )
    local frontrect = display.newRoundedRect( group, 0, 0, parent:getWidth()-offset, display.safeActualContentHeight*heightfraction-offset-button.height, rounding )

    frontrect.x, frontrect.y = frontrect.width/2, frontrect.height/2+button.height*.6
    backrect.x, backrect.y = frontrect.x+offset/2+1, frontrect.y+offset/2

    backrect.fill = shadow
    frontrect.fill = fill

    local function fill()
        for i=1, #fillcolours do
            fillcolours[i][4] = 1
        end
        backcolour[4] = nil

        frontrect.fill.effect = "generator.linearGradient"
        frontrect.fill.effect.color1 = fillcolour
        frontrect.fill.effect.position1  = { value-.1, 0 }
        frontrect.fill.effect.color2 = backcolour
        frontrect.fill.effect.position2  = { value+.2, 0 }
    end
    fill()

    local r = (fillcolours[2][1]-fillcolours[1][1])
    local g = (fillcolours[2][2]-fillcolours[1][2])
    local b = (fillcolours[2][3]-fillcolours[1][3])

    local function position( _value )
        local colour = {
            fillcolours[1][1]+_value*r,
            fillcolours[1][2]+_value*g,
            fillcolours[1][3]+_value*b,
            1
        }

        frontrect.fill.effect.color1 = colour
        frontrect.fill.effect.position1  = { _value, 0 }
        frontrect.fill.effect.position2  = { _value+.1, 0 }

        value = _value
    end
    position( value )

    function group:getValue()
        return value
    end

    frontrect:addEventListener( "touch", function(e)
        if (e.phase == "began") then
            e.target.hasFocus = true
            display.currentStage:setFocus(e.target)
            return true
        elseif (e.target.hasFocus) then
            local x, y = e.target:contentToLocal( e.x, e.y )
            local value = (x*1.1+frontrect.width/2)/frontrect.width
            
            position( value )
            
            if (e.phase == "moved") then
            else
                e.target.hasFocus = nil
                display.currentStage:setFocus(nil)

                if (value < 0) then value=0 elseif (value > 1) then value=1 end
                callback{ label=button.getText(), value=value }
            end
            return true
        end
        return false
    end )

    return group
end

return lib
