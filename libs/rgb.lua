
-- Colors referenced from http://www.tayloredmktg.com/rgb/
-- rgb

local rgb = {
	neoncyan = {16, 174, 239}, -- Neon Cyan
	neonyellow = {231, 228, 37}, -- Neon Yellow
	neonpink = {231, 83, 177}, -- Neon Pink
	neongreen = {4, 228, 37}, -- Neon Green
	
	iosblue = {0, 122, 255}, -- iOS Blue
	iosgrey = {146, 146, 146}, -- iOS Grey
	iosgreen = {50, 155, 43}, -- iOS Green
	iosdarkgreen = {35, 105, 28}, -- iOS Dark Green
	
	white = {255, 255, 255}, --White
	orange = {255, 132, 66}, --Orange
	pink = {255, 0, 255}, --Pink
	red = {255, 0, 0}, --Red
	green = {0, 255, 0}, --Green
	blue = {0, 0, 255}, --Blue
	purple = {160, 32, 240}, --Purple
	black = {0, 0, 0}, --Black
	yellow = {255, 255, 0}, --Yellow
	grey = {150, 150, 150}, --Grey
	cyan = {0, 255, 255}, -- Cyan
	
	whitesmoke = {245, 245, 245}, --White Smoke
	
	skyblue = {135, 206, 250}, --Sky Blue
	deepskyblue = {0, 191, 255}, --Deep sky blue
	dodgerblue = {30, 144, 255}, --Dodger Blue
	navy = {0, 0, 128}, --Navy
	lightskyblue = {135, 206, 250}, --Light Sky Blue
	lightcyan = {224, 255, 255}, --Light Cyan
	powderblue = {176, 224, 230}, --Powder Blue
	
	darkgreen = {0, 100, 0}, --Dark Green
	darkolivegreen = {85, 107, 47}, -- Dark Olive Green
	yellowgreen = {154, 205, 50}, --Yellow Green
	khaki = {240, 230, 140}, --Khaki
	kellygreen = {76, 187, 23}, --Kelly Green
	northtexasgreen = {5, 144, 51}, --North Texas Green
	mediumspringgreen = {0, 250, 154}, -- Medium Spring Green
	honeydew = {240, 255, 240}, --Honeydew
	lightseagreen = {32, 178, 170}, --Light Sea Green
	palegreen = {152, 251, 152}, --Pale Green
	limegreen = {50, 205, 50}, --Lime Green
	forestgreen = {34, 139, 34}, --Forest Green
	
	gold = {255, 215, 0}, --Gold
	mustard = {255, 192, 3}, --Mustard
	lemonchiffon = {255, 250, 205}, --Lemon Chiffon
	lightgoldenrodyellow = {250, 250, 210}, --Light Goldenrod Yellow
	
	darkred = {160, 0, 0}, --Dark Red
	peach = {255, 185, 143}, --Peach
	hotpink = {255, 105, 180}, --Hot Pink
	brightpink = {255, 192, 203}, --Pink
	deeppink = {255, 20, 147}, --Deep Pink
	turquoise = {64, 224, 208}, --Turquoise
	kcred = {207, 0, 0}, --KC Red
	petal = {173, 90, 255}, --Petal
	indianred = {205, 92, 92}, --Indian Red
	violetred = {208, 32, 144}, --Violet Red
	darksalmon = {233, 150, 122}, --Dark Salmon
	lavenderblush = {255, 240, 245}, --Lavender Blush
	wheat = {245, 222, 179}, --Wheat
	thistle = {216, 191, 216}, --Thistle
	maroon = {176, 48, 96}, --Maroon
	
	bamboo = {216, 199, 169}, --Bamboo
	greyflannel = {195, 196, 192}, -- Grey Flannel
	oldlace = {249, 240, 226}, --Old Lace
	brownbag = {192, 137, 103}, -- Brown Bag
	mediumgrey = {175, 175, 175}, -- Med Grey
	darkwood = {133, 94, 66}, -- Dark Wood
	woolgrey = {143, 148, 152}, -- Wool Grey
	tan = {139, 90, 43}, --Tan
	darkgrey = {100, 100, 100}, -- Dark Grey
	darkbrown = {95, 59, 24}, --Dark Brown
}

-- added since CoronaSDK v.1225
local function convertForGfx2()
	for k,v in pairs(rgb) do
		for i=1, #v do
			v[i] = v[i] / 255
		end
	end
end
convertForGfx2()

-- useful collections of colour names
local collections = {
	rgb = {
	},
	cmyk = {
	},
	ios = {
		"iosblue",
		"iosgrey",
		"iosgreen",
		"iosdarkgreen"
	},
	primary = {
		"white",
		"orange",
		"pink",
		"red",
		"green",
		"blue",
		"purple",
		"black",
		"yellow",
		"grey",
		"cyan",
	},
	neutral = {
		"red",
		"blue",
		"kellygreen",
	},
	moderate = {
		"red",
		"blue",
		"kellygreen",
		
		"deeppink",
		"deepskyblue",
		"gold",
	},
	advanced = {
		"red",
		"blue",
		"kellygreen",
		
		"deeppink",
		"deepskyblue",
		"gold",
		
		"darkbrown",
		"lightseagreen",
		"mediumspringgreen",
	},
}

return { rgb=rgb, collections=collections }
