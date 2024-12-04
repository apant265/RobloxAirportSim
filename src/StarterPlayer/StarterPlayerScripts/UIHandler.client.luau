local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local ConsoleButtonEvent = ReplicatedStorage.Events.ConsoleButtonEvent
local RoleSelectionEvent = ReplicatedStorage.Events.RoleSelectionEvent
local surfaceGUIsPrefab = ReplicatedStorage:WaitForChild("SurfaceGUIsPrefab")
local screenGUIsPrefab = ReplicatedStorage:WaitForChild("ScreenGUIsPrefab")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local surfaceGUIs = surfaceGUIsPrefab:Clone()
surfaceGUIs.Parent = playerGui
surfaceGUIs.Name = "SurfaceGUIs"

local screenGUIs = screenGUIsPrefab:Clone()

local roles = {"Tower", "Ground", "Approach", "Departure", "Center"}
local commandConsoles = {
	Tower = Workspace.CommandConsoles.TowerCommandConsole,
	Ground = Workspace.CommandConsoles.GroundCommandConsole,
	Approach = Workspace.CommandConsoles.ApproachCommandConsole,
	Departure = Workspace.CommandConsoles.DepartureCommandConsole,
	Center = Workspace.CommandConsoles.CenterCommandConsole}


local roleSurfaceGUIs = {
	Tower = playerGui.SurfaceGUIs.Tower,
	Ground = playerGui.SurfaceGUIs.Ground,
	Approach = playerGui.SurfaceGUIs.Approach,
	Departure = playerGui.SurfaceGUIs.Departure,
	Center = playerGui.SurfaceGUIs.Center}

local function enableSurfaceGUIs(isEnabled: boolean)
	for _,surfaceGUI in surfaceGUIs:GetChildren() do
		surfaceGUI.Enabled = true
	end
end

local function enableScreenGUIs(isEnabled: boolean)
	screenGUIs.Enabled = isEnabled
end

local function RoleCommandConsoleSetup(Role)
	roleSurfaceGUIs[Role].Adornee = commandConsoles[Role].RogerButton
	roleSurfaceGUIs[Role].Face = "Left"
end

local function CommandConsoleSetup()
	RoleCommandConsoleSetup("Tower")
	RoleCommandConsoleSetup("Ground")
	RoleCommandConsoleSetup("Center")
	RoleCommandConsoleSetup("Approach")
	RoleCommandConsoleSetup("Departure")
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

-- Setup the role selection buttons
local RoleSelectionEvent = ReplicatedStorage.Events.RoleSelectionEvent
for _,button in screenGUIs.RoleSelection:GetChildren() do
	button.Activated:Connect(function()
		RoleSelectionEvent:FireServer(""..button.Name)
		print("" .. button.Name .." button was clicked!")
		screenGUIs.RoleSelection.Enabled = false
		enableScreenGUIs(false)
	end)
	end


-- Begin config for Command Console Buttons

local CommandConsoleEvent = ReplicatedStorage.Events.ConsoleButtonEvent

for _, gui in roleSurfaceGUIs do
	for _, button in gui:GetChildren() do
		button.Activated:Connect(function()
		 print("" .. button.Name .. " button was clicked! (Client)")
		 CommandConsoleEvent:FireServer(button.Name)

		end)
end
end
