-- dht.lua --

local config = require("config")

function getData()
    pin = 1
    status, temp, humi = dht.read(pin)
    if status == dht.OK then
        return temp, humi
    end    
    return nil, nil
end

mySocket = net.createConnection(net.TCP, 0)
mySocket:on("receive", function(sck, response) 
    print(response)
    sck:close()
    wifi.sta.disconnect()
    node.dsleep(config.sleeptime*1000000, 2)
end)
mySocket:on("connection", function(sck, response) 
    local temp, humi = getData()
    if temp ~= nil and humi ~= nil then 
        text = string.format('{"dev":"dht", "temp":"%d", "humi":"%d"}', 
            math.floor(temp),
            math.floor(humi))
    else
        text = '{"dev":"dht", "temp":"error", "humi":"error"}'
    end
    sck:send(text)
end)
mySocket:connect(config.port, config.host)
