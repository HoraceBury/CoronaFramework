local widget = require("widget")

local lib = {}

function lib.new( parent, x, y, width, height )
    local group = display.newGroups( parent, 1 )
    group.x, group.y = x, y

    local scrollView = widget.newScrollView{
        top = 0,
        left = 0,
        width = width,
        height = height,
        scrollWidth = width,
        scrollHeight = height,
        backgroundColor = {.7,.7,.7}
    }
    group:insert( scrollView )

    local positions = display.newGroups( group, 1 )

    local content = display.newGroup()
    scrollView:insert( content )

    local function yMaxLowest()
        local yMax = 0

        for i=1, content.numChildren do
            if (content[i].y + content[i].height > yMax) then
                yMax = content[i].y + content[i].height
            end
        end

        return yMax
    end
    
    local function createPosition( subgroup )
        local position = display.newGroups( positions, 1 )
        position.alpha = .3
        
        local rnd = (30+15*positions.numChildren)/255 -- math.random( 50, 150 ) / 255 -- 
        
        display.newRect( position, 50, subgroup.height/2, 100, subgroup.height ).fill = {rnd,rnd,rnd}
        display.newText{ parent=position, text="P:"..positions.numChildren, fontSize=40, x=50, y=subgroup.height/2 }
        
        position.y = subgroup.y

        position.subgroup = subgroup
        subgroup.position = position
    end

    local function firePositionMove( subgroup, shift )
        if (shift < 0) then
            local index = display.indexOf( positions, subgroup.position )
            if (index+shift < 1) then return false end
            positions:insert( index+shift, subgroup.position )
        else
            local index = display.indexOf( positions, subgroup.position )
            if (index+shift > positions.numChildren) then return false end
            positions:insert( index, positions[index+1] )
        end

        for i=1, positions.numChildren do
            if (i == 1) then
                positions[i].y = 0
            else
                positions[i].y = positions[i-1].y + positions[i-1].height
            end
        end

        transition.cancel( "reorder_items_shift_animation" )

        for i=1, positions.numChildren do
            if (not positions[i].subgroup.tab.hasFocus) then
                transition.to( positions[i].subgroup, { time=100, y=positions[i].y, tag="reorder_items_shift_animation", onComplete=function() canFire = true end } )
            end
        end

        return true
    end

    local isScrollingDown, isScrollingUp = false, false
    local function dragItem(e)
    	if (e.phase == "began") then
            e.target.hasFocus = true
            display.currentStage:setFocus(e.target)
            e.target.parent:setRed()
            e.target.prev = e
            e.target.yOriginal = e.target.parent.y
            return true
        elseif (e.target.hasFocus) then
            local _x, _y = group:contentToLocal( e.x, e.y )
            
            if (_y > height+100) then
                if (not isScrollingUp) then
                    isScrollingUp = true
                    scrollView:scrollToPosition{ y=height-yMaxLowest(), time=2000 }
                end
            else
                isScrollingUp = false
                local _x, _y = scrollView:getContentPosition()
                scrollView:scrollToPosition{ y=_y, time=0 }
            end

            e.target.parent:toFront()
            e.target.parent.y = e.target.parent.y + (e.y-e.target.prev.y)
            e.target.prev = e

            if (e.target.parent.y < e.target.yOriginal-e.target.parent.height/2) then
                if (firePositionMove( e.target.parent, -1 )) then
                    e.target.yOriginal = e.target.yOriginal - e.target.parent.height
                end
            elseif (e.target.parent.y > e.target.yOriginal+e.target.parent.height/2) then
                if (firePositionMove( e.target.parent, 1 )) then
                    e.target.yOriginal = e.target.yOriginal + e.target.parent.height
                end
            end

            if (e.phase == "moved") then
            else
                transition.to( e.target.parent, { time=100, y=e.target.parent.position.y } )
                e.target.hasFocus = nil
                display.currentStage:setFocus(nil)
            end

            return true
        end
        return false
    end

    local function createDragTab( subgroup )
        local tab = display.newGroups( subgroup, 1 )
        tab.x, tab.y = width*.9, subgroup.contentBounds.yMax*.5

        local rect = display.newRoundedRect( tab, 0, 0, 100, 100, 15 )
        rect.fill = {.8}
        rect.stroke = {.5}
        rect.strokeWidth = 3

        function subgroup:setDraggable( isdraggable )
            tab.isVisible = isdraggable
            tab:removeEventListener( "touch", dragItem )

            if (isdraggable) then
                tab:addEventListener( "touch", dragItem )
            end
        end

        subgroup.tab = tab
        subgroup:setDraggable( true )
    end

    function group:addItem( itemgroup, isdraggable )
        local y = yMaxLowest()

        local subgroup = display.newGroup()
        subgroup:insert( itemgroup )
        itemgroup.x, itemgroup.y = -itemgroup.contentBounds.xMin, -itemgroup.contentBounds.yMin

        createDragTab( subgroup )
        subgroup:setDraggable( isdraggable )

        content:insert( subgroup )

        subgroup.x, subgroup.y = 0, y

        createPosition( subgroup )

        function subgroup:setRed()
            itemgroup[1].fill = {1,0,0}
        end
    end

    positions:toFront()

    return group
end

return lib
