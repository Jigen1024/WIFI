-- dht.lua --

require("config")

function getData()
    pin = 1
    status, temp, humi = dht.read(pin)
    if status == dht.OK then
        return temp, humi
    end    
    return nil, nil
end

tmr.alarm(1, 5000, tmr.ALARM_AUTO, function() 
    mySocket = net.createConnection(net.TCP, 0)
    mySocket:on("receive", function(sck, response) 
        print(response)
        sck:close()
    end)
    mySocket:on("connection", function(sck, response) 
        local temp, humi = getData()
        if temp ~= nil and humi ~= nil then 
            text = string.format("{'temp':'%d', 'humi':'%d'}", 
                math.floor(temp),
                math.floor(humi))
        else
            text = "{'temp':'error', 'humi':'error'}"
        end
        sck:send(text)
    end)
    mySocket:connect(port, host)
end)
