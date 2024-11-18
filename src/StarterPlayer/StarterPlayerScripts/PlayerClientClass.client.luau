local enbaleGuiClass = require(script.EnableGuiOnSpawnClass)
local titleScreenClass = require(script.TitleScreenClass)

local player = game.Players.LocalPlayer
local playerGui = player.PlayerGui

task.wait(.5)

--Start
enbaleGuiClass.main(playerGui)
titleScreenClass.StartGame(playerGui)