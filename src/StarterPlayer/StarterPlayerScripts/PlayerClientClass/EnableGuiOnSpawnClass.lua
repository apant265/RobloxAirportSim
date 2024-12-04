local EnableGuiOnSpawnClass = {}

function EnableGuiOnSpawnClass.main(playerGui)
	playerGui:WaitForChild("TitleScreen").Enabled = true
end

return EnableGuiOnSpawnClass
