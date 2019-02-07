local rgb = require("libs.rgb")
local radialgradient = require("utils.radialgradient")

local lib = {}

function lib.new( parent, r, w, radii, colours, visibleRadii, callback )
    local x, y = parent:getX(), parent:getY()

    local group = display.newGroups( parent, 1 )
    group.x, group.y = x, y
    group.class = "radialgradientslider"

    local cx = r+w*2
    local cy = cx

    function group:getX()
        return group.x
    end

    function group:getY()
        return group.y
    end

    function group:getWidth()
        return cx*2
    end

    function group:getHeight()
        return cy*2
    end

    local function background()
        local centre = display.newCircle( group, cx, cy, r )
        centre.fill = {0,0,0,0}
        display.stroke( centre, {1}, w*2+10 )

        local wide = display.newCircle( group, cx, cy, r+w )
        wide.fill = {0,0,0,0}
        display.stroke( wide, {.85}, 5 )

        local near = display.newCircle( group, cx, cy, r-w )
        near.fill = {0,0,0,0}
        display.stroke( near, {.85}, 5 )
    end
    background()

    local gradient = radialgradient.new( group, cx, cy, r, w-5, radii, colours, visibleRadii )

    local function dot()
        local dot = display.newGroups( group, 1 )
        dot.x, dot.y = cx, cy
        dot.rotation = visibleRadii

        local shadow = display.newCircle( dot, 0, -r, w*3 )
        shadow.alpha = .25

        shadow.fill.effect = "generator.radialGradient"
 
        shadow.fill.effect.color1 = { .5,.5,.5, 1 }
        shadow.fill.effect.color2 = { 0,0,0, 0 }
        shadow.fill.effect.center_and_radiuses  =  { 0.5, 0.5, 0.1, .5 }
        shadow.fill.effect.aspectRatio  = 1

        local circle = display.newCircle( dot, 0, -r, w*2 )
        display.stroke( circle, {1}, 3 )
        dot.circle = circle

        return dot
    end

    dot():addEventListener( "touch", function(e)
        if (e.phase == "began") then
            e.target.hasFocus = true
            display.currentStage:setFocus(e.target)
            if (e.target.touch) then e.target:touch(e) end
            return true
        elseif (e.target.hasFocus) then
            local _x, _y = e.target:contentToLocal( e.x, e.y )
            local t = {x=_x,y=_y}
            local len = math.lengthOf( e.target.circle, t )
            if (len <= r*.75) then
                local angle = math.angleOf( e.target, e.target.circle, t )
                local new = e.target.rotation - angle
                if (new < 0) then new=0 elseif (new > radii) then new=radii end
                new = math.round(new)
                e.target.rotation = new
                gradient:setVisibleRadii( new )
                if (callback) then callback( new ) end
            end

            if (e.phase == "moved") then
            else
                e.target.hasFocus = nil
                display.currentStage:setFocus(nil)
            end
            if (e.target.touch) then e.target:touch(e) end
            return true
        end
        return false
    end )
    
    return group
end

return lib
