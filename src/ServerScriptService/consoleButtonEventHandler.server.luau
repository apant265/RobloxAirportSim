local CommandConsoleEvent = game:GetService("ReplicatedStorage").Events.ConsoleButtonEvent
local PlayerInfo = require("./PlayerInfo")

local function respondToButton(player, button)
	print("Responding to button")
	if button == "Roger" then
		print("Player " .. player.Name .. " with role " .. PlayerInfo[player]["Role"] .. " Clicked RogerButton!(Server)")
	else
		error("Invalid Command " .. button .. " recieved")
	end

end
	
CommandConsoleEvent.OnServerEvent:Connect(respondToButton)
