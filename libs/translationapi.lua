-- yandex translation api

local json = require("json")

local url = "https://translate.yandex.net/api/v1.5/tr.json/translate?key=<KEY>&text=<TEXT>&lang=<LANG>"
local key = "<GET A KEY FROM tandex.net>"

local lib = {}

function lib.currentUserLanguage()
    return system.getPreference( "ui", "language" )
end

function lib.translate( text, lang, callback )
    local _url = string.gsub( url, "<KEY>", key )
    _url = string.gsub( _url, "<TEXT>", text )
    _url = string.gsub( _url, "<LANG>", lang )
    
    network.request( _url, "GET", function(e)
        if (callback) then
            callback( table.concat(json.decode(e.response).text) )
        end
    end, params )
end

return lib
