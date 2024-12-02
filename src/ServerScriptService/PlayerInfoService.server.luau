local RoleSelectionEvent = game:GetService("ReplicatedStorage").Events.RoleSelectionEvent
local Players = game:GetService("Players")
local PlayerInfo = require("./PlayerInfo")

local function addPlayerRoleInfo(player, role)
	print(player)
	print(role)
	print("Setting " .. player.Name .. "\'s role to " .. role .. "!")
	PlayerInfo[player]["Role"] = role
end
local function onPlayerAdded(player)
	PlayerInfo[player] = {}
	print(PlayerInfo)
end
	
RoleSelectionEvent.OnServerEvent:Connect(addPlayerRoleInfo)
Players.PlayerAdded:Connect(onPlayerAdded)
