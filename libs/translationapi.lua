-- yandex translation api

local iolib = require("libs.iolib")
local json = require("json")

local url = "https://translate.yandex.net/api/v1.5/tr.json/translate?key=<KEY>&lang=<LANG>&text="
local key = "<GET A KEY FROM https://translate.yandex.com/developers/keys>"
key = "trnsl.1.1.20190222T054823Z.b20ee4ff0ece60f1.56cdabe571a12666ec111a3467af1b01063e15ae"

local lib = {
    cache = {}
}

function lib.currentUserLanguage()
    return system.getPreference( "ui", "language" ):lower():sub(1,2)
end

function lib.translate( text, sourcelang, targetlang, callback )
    local cacheKey = "["..sourcelang.."-"..targetlang.."]["..text.."]"

    if (lib.cache[ cacheKey ] == nil) then
        text = string.urlencode( text )

        local _url = string.gsub( url, "<KEY>", key )
        _url = string.gsub( _url, "<LANG>", (sourcelang.."-"..targetlang):lower() )

        network.request( _url..text, "GET", function(e)
            lib.cache[ cacheKey ] = table.concat(json.decode(e.response).text)

            lib.deferSave()

            if (callback) then
                callback( lib.cache[ cacheKey ] )
            end
        end, params )
    else
        callback( lib.cache[ cacheKey ] )
    end
end

-- simply loads the saved table into the lib table
function lib.load()
	local data = iolib.wrDocs( "translations.json" )
	
	if (data) then
        lib.cache = json.decode(data)
	end
end

-- simply saves the lib table without the function objects
function lib.save()
	-- print(json.prettify(json.encode(lib.cache)))
	iolib.wrDocs( "translations.json", lib.cache )
end

function lib.deferSave()
	if (lib.deferTimer) then
		lib.deferTimer = timer.cancel( lib.deferTimer )
	end

	lib.deferTimer = timer.performWithDelay( 500, function()
		lib.deferTimer = nil
		lib.save()
	end, 1 )
end

local function test()
    print(lib.currentUserLanguage())
    lib.translate( "Check out my Keep Calm and Carry On design !", "en", "fr", function(e)
        print(e)
    end )
    timer.performWithDelay(1000, function()
        lib.translate( "Check out my Keep Calm and Carry On design !", "en", "fr", function(e)
            print(e)
        end )
    end, 1)
end
-- test()

lib.load()

return lib
