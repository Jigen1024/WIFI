-- init.lua --

wifi.setmode(wifi.SOFTAP)
cfg = {}
cfg.ssid = wifi.ap.getmac()
cfg.pwd = "IIIlll111"
print(cfg.ssid)
--cfg.hidden = true
wifi.ap.config(cfg)
print(wifi.ap.getip())
wifi.eventmon.register(wifi.eventmon.AP_STACONNECTED, function(T) 
	print("mac = " .. T.MAC .. "\naid = " .. T.AID)
end)

if file.exists("service.lua") then 
	node.compile("service.lua")
	file.remove("service.lua")
end
dofile("service.lc")
