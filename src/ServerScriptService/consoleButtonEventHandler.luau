local ReplicatedStorage = game:GetService("ReplicatedStorage")
local consoleButtonEvent = ReplicatedStorage.Events.ConsoleButtonEvent

consoleButtonEvent.OnServerEvent:Connect( function (player, args) print("" .. player.Name .. " pressed " .. args .. ".") end)
