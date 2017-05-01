-- service.lua --

local myfile = require("myfile")

if sv ~= nil then 
    sv:close()
end

function parse(data)
    if string.find(data, "error") then 
        return nil
    elseif string.find(data, "dht") then
        myfile.save("dht", data)
    elseif string.find(data, "light") then
    	return myfile.load("light")
    end
    return nil
end

sv = net.createServer(net.TCP, 30)
if sv then 
	sv:listen(11272, function (conn)
	    conn:on("receive", function(sck, data) 
            -- print(data)
            local content = parse(data)
            if content ~= nil then 
            	sck:send(content)
            else 
            	sck:send(data)
            end
        end)
	end)
end
