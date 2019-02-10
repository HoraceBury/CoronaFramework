local lib = {}

--[[
	Displays a segmented control.

	Description:
		The labels on the buttons of the control are provided by the items parameter. The .text
		value of these items is passed into the setActiveLabel function and returned from the
		callback function. The .fontSize and .font can be set for the item labels individually,
		but the colour, parent group and position cannot.
	
	Params:
		parent: the parent display group
		x, y: top left position
		width, height: size of control
		items: parameters for the display.newText function to create each label
		showborder: true or false to show/hide the border and separators
		callback: function to call when a label is tapped
		rounding: display.newRoundedRect rounding value for the overall control, default: 5
		colour: the selected item colour, default: iOS blue
		offcolour: the unselected item colour, default: white
]]
function lib.new( params )
	local parent, x, y, width, height, items, showborder, callback, rounding, colour, offcolour =
		params.parent or display.currentStage, params.x, params.y, params.width, params.height, params.items, params.showborder,
		params.callback, params.rounding or 5, params.colour or {0,0.47843137254902,1}, params.offcolour or {1,1,1}
	
	local group = display.newGroups( parent, 1 )
	group.x, group.y = x, y

	local function newButton( item, isLeft, isRight, width )
		local button = display.newGroups( group, 1 )
		button.x = (group.numChildren-1) * width

		local centre = display.newRect( button, width/2, height/2, width, height )
		centre.fill = colour
		centre.alpha = 1
		button.centre = centre

		if (isLeft) then
			local left = display.newRoundedRect( button, centre.x-centre.width/2+rounding, height/2, rounding*2, height, rounding )
			left.fill = colour
			button.left = left

			centre.width = centre.width - rounding
			centre.x = centre.x + rounding/2
		end
		
		if (isRight) then
			local right = display.newRoundedRect( button, centre.x+centre.width/2-rounding, height/2, rounding*2, height, rounding )
			right.fill = colour
			button.right = right

			centre.width = centre.width - rounding
			centre.x = centre.x - rounding/2
		end

		if (not isLeft and showborder ~= false) then
			local separator = display.newLine( button, 0, 0, 0, height )
			separator.strokeWidth = 2
			separator.stroke = colour
		end

		item.parent = button
		item.x, item.y = width/2, height/2
		local text = display.newText( item )
		text.fill = offcolour

		button.text = text.text

		function button:setActive( isActive )
			local fill = colour
			if (not isActive) then fill=offcolour end

			if (isLeft) then
				button.left.fill = fill
			end
			
			if (isRight) then
				button.right.fill = fill
			end

			centre.fill = fill

			text.fill = colour
			if (isActive) then text.fill=offcolour end
		end

		button:addEventListener( "tap", group )
	end

	local function createButtons()
		local buttonWidth = width/#items

		for i=1, #items do
			newButton( items[i], (i==1), (i==#items), buttonWidth )
		end
	end
	createButtons()

	local function createBorder()
		if (showborder ~= false) then
			local border = display.newRoundedRect( group, width/2, height/2, width, height, rounding )
			border.fill = {0,0,0,0}
			border.stroke = colour
			border.strokeWidth = 2
		end
	end
	createBorder()

	function group:setActiveLabel( label )
		for i=1, group.numChildren do
			local button = group[i]
			if (button.setActive) then
				button:setActive( button.text:lower() == label:lower() )
				if (group.selected ~= button.text and button.text == label) then
					group.selected = button.text
				end
			end
		end
	end
	group:setActiveLabel( items[1].text )

	function group:tap(e)
		if (group.selected ~= e.target.text) then
			group:setActiveLabel( e.target.text )
			if (callback) then
				callback( e.target.text )
			end
		end
	end

	group:addEventListener( "touch", function(e) return true end )

    return group
end

return lib
