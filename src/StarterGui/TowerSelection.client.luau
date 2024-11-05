local gui = script.parent:WaitForChild("ScreenGui")
local button = gui:WaitForChild("TowerSelection")
local player = game:GetService("Players").LocalPlayer
local workspace = game:GetService("Workspace")
local playerModel = workspace:FindFirstChild(player.Name)
local commandselector = workspace:FindFirstChild("CommandSelector")

local function onTowerClicked()
	gui.Enabled = false;
	playerModel.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(20,3.927,-31),commandselector.Position)
end


button.Activated:Connect(onTowerClicked)


