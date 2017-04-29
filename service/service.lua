-- service.lua --

if sv ~= nil then 
    sv:close()
end

function save(fn, data) 
    file.open(fn, "w")
    file.write(data)
    file.close()
end

function parse(data)
    if string.find(data, "error") then 
        return
    elseif string.find(data, "dht") then
        save("dht", data)
    end
end

sv = net.createServer(net.TCP, 30)
if sv then 
	sv:listen(11272, function (conn)
	    conn:on("receive", function(sck, data) 
            sck:send(data)
            parse(data)
        end)
	end)
end
