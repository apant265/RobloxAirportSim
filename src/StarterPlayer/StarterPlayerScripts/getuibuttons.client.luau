local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = player.PlayerGui
while true do
	print(gui:WaitForChild("screenGUIs"))
	print(gui:WaitForChild("surfaceGUIs"))
	wait(2)
end
