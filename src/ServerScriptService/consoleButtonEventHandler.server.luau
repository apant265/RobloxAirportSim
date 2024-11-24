local CommandConsoleEvent = game:GetService("ReplicatedStorage").Events.ConsoleButtonEvent


local function respondToButton(player, button)
	if button == "Roger" then
		print("RogerButton clicked!(Server)")
	else
		error("Invalid Command " .. button .. " recieved")
	end

end
	
CommandConsoleEvent.OnServerEvent:Connect(respondToButton)
