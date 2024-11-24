local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local ConsoleButtonEvent = ReplicatedStorage.Events.ConsoleButtonEvent
local RoleSelectionEvent = ReplicatedStorage.Events.RoleSelectionEvent
local surfaceGUIsPrefab = ReplicatedStorage:WaitForChild("SurfaceGUIsPrefab")
local screenGUIsPrefab = ReplicatedStorage:WaitForChild("ScreenGUIsPrefab")

local surfaceGUIs = Instance.new("Folder")
local screenGUIs = screenGUIsPrefab:Clone()

local function enableSurfaceGUIs(isEnabled: boolean)
	for _,surfaceGUI in surfaceGUIs:GetChildren() do
		surfaceGUI.Enabled = true
	end
end

local function enableScreenGUIs(isEnabled: boolean)
	screenGUIs.Enabled = isEnabled
end

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local function CommandConsoleSetup()
	surfaceGUIs.Parent = playerGui
	surfaceGUIs.Name = "SurfaceGUIs"
	local RogerButton = surfaceGUIsPrefab:Clone()
	RogerButton.Name = "RogerButtonGUI"
	RogerButton.Button.Name = "RogerButton"
	RogerButton.Parent = surfaceGUIs
	RogerButton.Adornee = Workspace.CommandConsole.RogerButton
	RogerButton.Face = "Left"
end	

function initialize()
	-- Add new gui instance to player gui, hidden
	CommandConsoleSetup()
	enableSurfaceGUIs(false)

	screenGUIs.Name = "screenGUIs"
	screenGUIs.Parent = playerGui
	enableScreenGUIs(true)


	
end

initialize()
local towerButton = screenGUIs.RoleSelection.TowerSelection
towerButton.Activated:Connect(function()
	print("Tower button was clicked!")
	screenGUIs.RoleSelection.Enabled = false		
	enableSurfaceGUIs(true)
end)


-- Begin config for Command Console Buttons

local CommandConsoleEvent = ReplicatedStorage.Events.ConsoleButtonEvent


local rogerButton = surfaceGUIs.RogerButtonGUI.RogerButton
rogerButton.Activated:Connect(function()
	print("Roger button was clicked! (Client)")
	CommandConsoleEvent:FireServer("Roger")
	
end)

