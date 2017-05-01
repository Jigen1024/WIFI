-- light.lua --

local config = require("config")

local backup = nil
tmr.alarm(1, 3000, tmr.ALARM_AUTO, function() 
    mySocket = net.createConnection(net.TCP, 0)
    mySocket:on("receive", function(sck, response)
        if response ~= backup then 
            backup = response
            print(response)
            if string.find(response, "on") then 
                gpio.write(4, gpio.HIGH)
            elseif string.find(response, "off") then
                gpio.write(4, gpio.LOW)
            end
        else 
            print("no change")
        end
        sck:close()
    end)
    mySocket:on("connection", function(sck, response)
        sck:send("light")
    end)
    mySocket:connect(config.port, config.host)
end)

