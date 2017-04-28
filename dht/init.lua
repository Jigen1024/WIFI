-- init.lua --

require("config")
print("ssid = " .. ssid)
print("pwd = " .. pwd)
wifi.setmode(wifi.STATION)
wifi.sta.config(ssid, pwd)
wifi.sta.connect()
if file.exists("dht.lua") then
    node.compile("dht.lua")
    file.remove("dht.lua")
end
tmr.alarm(0, 5000, tmr.ALARM_AUTO, function()
    ip = wifi.sta.getip()
    if (ip == nil) then
        print("no ip")
    end
end)
dofile('dht.lc')
