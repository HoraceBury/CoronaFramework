local widget = require("widget")

local _oldNewScrollView = widget.newScrollView

function widget.newScrollView( ... )
    local scrollView = _oldNewScrollView( arg[1] )

    local tagprefix = tostring(scrollView)

    local scrollWidth = arg[1].scrollWidth or arg[1].width
    local scrollHeight = arg[1].scrollHeight or arg[1].height

    scrollView._setScrollWidth = scrollView.setScrollWidth
    function scrollView:setScrollWidth( width )
        scrollWidth = width
        scrollView:_setScrollWidth( width )
    end

    scrollView._setScrollHeight = scrollView.setScrollHeight
    function scrollView:setScrollHeight( height )
        scrollHeight = height
        scrollView:_setScrollHeight( height )
    end

    local _xSpeed, _ySpeed

    function scrollView:setScrollSpeed( xSpeed, ySpeed )
        if (_xSpeed == xSpeed and _ySpeed == ySpeed) then return end
        _xSpeed, _ySpeed = xSpeed, ySpeed

        transition.cancel( tagprefix..":setScrollSpeed" )

        local xDist, yDist = scrollView:getContentPosition()
        local xTarget, yTarget = 0, 0

        if (xSpeed < 0) then
            xDist = scrollWidth - xDist
            xTarget = -(scrollWidth - scrollView:getView()._width)
        end

        if (ySpeed < 0) then
            yDist = scrollHeight - yDist
            yTarget = -(scrollHeight - scrollView:getView()._height)
        end

        local xTime = (math.abs(xDist)/math.abs(xSpeed))*60
        local yTime = (math.abs(yDist)/math.abs(ySpeed))*60
        
        if (tostring(xTime) ~= "nan" and xTime) then
            transition.to( scrollView:getView(), { x=xTarget, time=xTime, tag=tagprefix..":setScrollSpeed", onComplete=function()
                transition.cancel( tagprefix..":setScrollSpeed" )
            end } )
        end

        if (tostring(yTime) ~= "nan" and yTime) then
            transition.to( scrollView:getView(), { y=yTarget, time=yTime, tag=tagprefix..":setScrollSpeed", onComplete=function()
                transition.cancel( tagprefix..":setScrollSpeed" )
            end } )
        end
    end

    return scrollView
end
