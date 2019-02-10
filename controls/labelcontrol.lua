local rgb = require("libs.rgb")

local lib = {}

local gap = 10

function lib.new( parent, label, title )
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

    local labelitem = display.newText{ parent=group, text=label or "", fontSize=42 }
	labelitem.x, labelitem.y = labelitem.width*.5, 0
    labelitem.fill = rgb.rgb.iosgrey
    
	local titleitem = display.newText{ parent=group, text=title, fontSize=60 }
	titleitem.x, titleitem.y = parent:getWidth()*.5, 0
    titleitem.fill = rgb.rgb.iosblue

    local filler

    local function setAllY()
        labelitem.x = labelitem.width/2
        labelitem.y = labelitem.height/2
        if (label == nil) then labelitem.height=0 end
        titleitem.y = labelitem.height+titleitem.height/2
        if (title == nil) then titleitem.height=0 end

        display.remove(filler)
        fillter = nil
        filler = display.newRoundedRect( group, parent:getWidth()*.5, group.height*1.2*.5, parent:getWidth(), group.height*1.2, 25 )
        filler.fill = {.7}
        filler.isVisible = false
        filler:toBack()
    end

    function group:setLabel( _label )
        label = _label
        labelitem.text = label or ""
        setAllY()
    end

    function group:setTitle( _title )
        title = _title
        titleitem.text = title or ""
        setAllY()
    end

    setAllY()

    return group
end

return lib
