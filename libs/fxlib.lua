-- effects library

local lib = {}

function lib.blur( group, removeOriginal )
	local capture = display.capture( group, { saveToPhotoLibrary=false, captureOffscreenArea=false } )
	capture.x, capture.y = group.x, group.y
	capture.fill.effect = "filter.blurGaussian"
	capture.fill.effect.horizontal.blurSize = 512
	capture.fill.effect.horizontal.sigma = 512
	capture.fill.effect.vertical.blurSize = 512
	capture.fill.effect.vertical.sigma = 512
	if (removeOriginal) then group:removeSelf() end
	return capture
end

function lib.greyed( group, removeOriginal )
	local capture = display.capture( group, { saveToPhotoLibrary=false, captureOffscreenArea=false } )
	capture.x, capture.y = group.x, group.y
	capture.fill.effect = "filter.grayscale"
	if (removeOriginal) then group:removeSelf() end
	return capture
end

function lib.shadow( group )
	local blurred = lib.blur(group, true)
	blurred = lib.blur(blurred, true)
	blurred = lib.blur(blurred, true)
	blurred = lib.blur(blurred, true)
	local greyed = lib.greyed(blurred, true)
	greyed.alpha = .3
	return greyed
end

return lib
