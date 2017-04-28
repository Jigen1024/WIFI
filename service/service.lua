-- service.lua --

if sv ~= nil then 
    sv:close()
end

sv = net.createServer(net.TCP, 30)
if sv then 
	sv:listen(11272, function (conn)
	    conn:on("receive", function(sck, data) 
            print(data)
            sck:send(data)
        end)
	end)
end
