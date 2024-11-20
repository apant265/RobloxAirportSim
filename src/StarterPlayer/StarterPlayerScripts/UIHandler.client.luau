local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local ConsoleButtonEvent = ReplicatedStorage.Events.ConsoleButtonEvent
local RoleSelectionEvent = ReplicatedStorage.Events.RoleSelectionEvent
local surfaceGUIsPrefab = ReplicatedStorage:WaitForChild("SurfaceGUIsPrefab")
local screenGUIsPrefab = ReplicatedStorage:WaitForChild("ScreenGUIsPrefab")

local surfaceGUIs
local screenGUIs

local function enableSurfaceGUIs(isEnabled: boolean)
	surfaceGUIs.Enabled = isEnabled
end

local function enableScreenGUIs(isEnabled: boolean)
	screenGUIs.Enabled = isEnabled
end

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

function initialize()
	-- Add new gui instance to player gui, hidden
	surfaceGUIs = surfaceGUIsPrefab:Clone()
	surfaceGUIs.Name = "surfaceGUIs"
	enableSurfaceGUIs(false)
	surfaceGUIs.Parent = playerGui
	surfaceGUIs.Adornee = Workspace.CommandConsole.RogerButton

	screenGUIs = screenGUIsPrefab:Clone()
	screenGUIs.Name = "screenGUIs"
	enableScreenGUIs(false)
	screenGUIs.Parent = playerGui

	enableScreenGUIs(true)
	enableSurfaceGUIs(true)

	
end

initialize()
local towerButton = screenGUIs.RoleSelection.TowerSelection
towerButton.Activated:Connect(function()
	print("Tower button was clicked!")
	screenGUIs.RoleSelection.Enabled = false		
	surfaceGUIs.Enabled = true
end)

local rogerButton = surfaceGUIs.RogerButtonGUI
rogerButton.Activated:Connect(function()
	print("Roger button was clicked!")

end)

