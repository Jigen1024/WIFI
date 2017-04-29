-- init.lua --

local config = require("config")

wifi.setmode(wifi.STATION)
wifi.sta.config(config.ssid, config.pwd)
wifi.sta.connect()
if file.exists("dht.lua") then
    node.compile("dht.lua")
    file.remove("dht.lua")
end
local count = 0
tmr.alarm(0, 5000, tmr.ALARM_AUTO, function() 
    ip = wifi.sta.getip()
    if wifi.sta.getip() ~= nil then
        print(ip)
        dofile("dht.lc")
        tmr.stop(0)
    else
        count = count + 1
        if count >= config.timeout then 
            node.restart()
        end
        print('getting ip address')
    end 
end)
