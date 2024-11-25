local TitleScreenClass = {}

local RoleSelector = require(script.Parent.RoleSelector)

function TitleScreenClass.StartGame(playerGui)
	-- Settings
	local orbitPart = game.Workspace["ATC Tower"].CameraPart -- Change "Part" to the name of your target part
	local orbitDistance = 60 -- Initial distance from the part
	local orbitSpeed = .5 -- Adjust this for the speed of the orbit
	local verticalOffset = 20 -- Adjust this for the vertical height of the camera

	-- Services
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")

	-- Get the local player and camera
	local player = Players.LocalPlayer
	local camera = game.Workspace.CurrentCamera

	-- Orbit logic
	local function updateCameraPosition(deltaTime)
		-- Calculate the orbit angle based on time and speed
		local angle = tick() * orbitSpeed

		-- Calculate the new position for the camera in a circular path around the part
		local offsetX = math.cos(angle) * orbitDistance
		local offsetZ = math.sin(angle) * orbitDistance

		-- Set the camera's position and look direction, with vertical offset
		camera.CFrame = CFrame.new(
			orbitPart.Position + Vector3.new(offsetX, verticalOffset, offsetZ), -- Camera position
			orbitPart.Position -- Look at the part
		)
	end

	-- Connect update functions
	local menuCamera = RunService.RenderStepped:Connect(updateCameraPosition)

	local titleScreen = playerGui.TitleScreen
	local roleSelection = playerGui.RoleSelection
	titleScreen.TitleBackground.ButtonsBackground.StartButton.Activated:Connect(function()
		titleScreen.Enabled = false
		roleSelection.Enabled = true
		RoleSelector.roleInitilize(menuCamera)
	end)

end

return TitleScreenClass
