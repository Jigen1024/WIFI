-- init.lua --

local files = {"dht"}
for num, fn in pairs(files) do 
	if not file.exists(fn) then 
		file.open(fn, "w")
		file.close()
	end
end

uart.on("data", "\n", function(data) 
    --print("receive: " .. data)
    
    -- DANGER --
    if data == "quit\r\n" then  
        uart.on("data")
    -- DANGER --
    elseif data == "hello\r\n" then
        print("hello")
    elseif data == "dht\r\n" then 
        file.open("dht", "r")
        content = file.read()
        file.close()
        if content ~= nil and string.len(content) > 0 then 
            print(content .. "\r\n")
        else
            print("stdin\r\n")
        end
    end
end, 0)

wifi.setmode(wifi.SOFTAP)
cfg = {}
cfg.ssid = wifi.ap.getmac()
cfg.pwd = "IIIlll111"
print(cfg.ssid)
--cfg.hidden = true
wifi.ap.config(cfg)
print(wifi.ap.getip())
--wifi.eventmon.register(wifi.eventmon.AP_STACONNECTED, function(T) 
	--print("connected: mac = " .. T.MAC .. "\taid = " .. T.AID)
--end)
--wifi.eventmon.register(wifi.eventmon.AP_STADISCONNECTED, function(T) 
    --print("disconnected: mac = " .. T.MAC .. "\taid = " .. T.AID)
--end)

if file.exists("service.lua") then 
	node.compile("service.lua")
	file.remove("service.lua")
end
dofile("service.lc")
