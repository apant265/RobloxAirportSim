local Players = game:GetService("Players") local player = Players.LocalPlayer

print("This is a test")
local screengui = player.PlayerGui:WaitForChild("ScreenGui")
screengui.Enabled = true
print("Enabled GUI")

