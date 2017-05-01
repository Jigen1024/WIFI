-- myfile.lua --

local myfile = {}

function myfile.save(fn, data) 
    file.open(fn, "w")
    file.write(data)
    file.close()
end

function myfile.load(fn)
	file.open(fn, "r")
	local content = file.read()
	file.close()
	if string.len(content) > 0 then 
		return content
	end
	return nil
end

return myfile
