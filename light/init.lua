-- init.lua --

local config = require("config")

gpio.mode(4, gpio.OUTPUT)
gpio.write(4, gpio.LOW)

wifi.setmode(wifi.STATION)
wifi.sta.config(config.ssid, config.pwd)
wifi.sta.connect()
if file.exists("light.lua") then
    node.compile("light.lua")
    file.remove("light.lua")
end
local count = 0
local flag = 0
tmr.alarm(0, 7000, tmr.ALARM_AUTO, function() 
    ip = wifi.sta.getip()
    if wifi.sta.getip() ~= nil then
        print(ip)
        if flag == 0 then 
            flag = 1
            dofile("light.lc")
        end
    else
        count = count + 1
        if count >= config.timeout then 
            node.restart()
        end
        print('getting ip address')
    end 
end)
