local rgb = require("libs.rgb")

local lib = {}

function lib.new( parent, x, y, r, w, radii, colours, visibleRadii )
    local group = display.newGroups( parent, 1 )
    group.x, group.y = x, y

    colours = colours or { rgb.rgb.red, rgb.rgb.orange, rgb.rgb.yellow, rgb.rgb.green }--, rgb.rgb.blue, rgb.rgb.purple }

    radii = radii or 360
    local div = radii/(#colours-1)

    local segmentcount = 0
    local colourindex = 1
    local colA, colB = colours[1], colours[2]

    for i=0, radii, 2 do
        local pt = math.rotateTo({x=0,y=-r},i,{x=0,y=0})
        local d = display.newCircle( group, pt.x, pt.y, w or 25 )

        local r = colA[1] + ((colB[1]-colA[1])/div) * segmentcount
        local g = colA[2] + ((colB[2]-colA[2])/div) * segmentcount
        local b = colA[3] + ((colB[3]-colA[3])/div) * segmentcount

        d.fill = {r,g,b}
        display.stroke( d, {r,g,b}, 5 )

        segmentcount = segmentcount + 2

        if (segmentcount > div) then
            segmentcount = 0
            colourindex = colourindex + 1
            colA, colB = colours[colourindex], colours[colourindex+1]
        end
    end

    function group:setVisibleRadii( visibleRadii )
        visibleRadii = visibleRadii or radii
        
        for i=1, group.numChildren do
            group[i].isVisible = (i*2 <= visibleRadii)
        end
    end
    group:setVisibleRadii( visibleRadii )

    return group
end

return lib
