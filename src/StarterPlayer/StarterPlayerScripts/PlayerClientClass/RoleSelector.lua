local RoleSelector = {}

local playerGui = game.Players.LocalPlayer.PlayerGui
local roleSelection = playerGui:WaitForChild("RoleSelection") 

function RoleSelector.roleInitilize(plrCamera)

	roleSelection.TitleBackground.ButtonsBackground.TowerSelection.Activated:Connect(function()
		roleSelection.Enabled = false
		plrCamera:Disconnect()
	end)

	roleSelection.TitleBackground.ButtonsBackground.GroundSelection.Activated:Connect(function()
		roleSelection.Enabled = false
		plrCamera:Disconnect()
	end)

	roleSelection.TitleBackground.ButtonsBackground.CenterSelection.Activated:Connect(function()
		roleSelection.Enabled = false
		plrCamera:Disconnect()
	end)

	roleSelection.TitleBackground.ButtonsBackground.ApproachSelection.Activated:Connect(function()
		roleSelection.Enabled = false
		plrCamera:Disconnect()
	end)

	roleSelection.TitleBackground.ButtonsBackground.DepartureSelection.Activated:Connect(function()
		roleSelection.Enabled = false
		plrCamera:Disconnect()
	end)
end

return RoleSelector
