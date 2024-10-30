local gui = script.parent:WaitForChild("ScreenGui")
local button = gui:WaitForChild("TowerSelection")
local player = game:GetService("Players").LocalPlayer
local playerModel = game:GetService("Workspace"):FindFirstChild(player.Name)

local function onTowerClicked()
	gui.Enabled = false;
	playerModel.HumanoidRootPart.CFrame = CFrame.new(10,0,10)
end

button.Activated:Connect(onTowerClicked)


