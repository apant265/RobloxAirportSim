local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local catapultPlatform = Workspace.IntroToStudioCatapult.CatapultPlatform
local projectileMaterials = Workspace.IntroToStudioCatapult.ProjectileMaterials
local launchButton = catapultPlatform.LaunchButton.button
local reloadAttachment = catapultPlatform.Catapult.Swivel.Armature.Att_Reload

local resetGameEvent = ReplicatedStorage.Events.ResetGameEvent

local projectileSelected = nil
local projectileToLaunch = nil

local LAUNCH_RESET_TIME_ATTRIBUTE_NAME = "LaunchResetTime"
-- the amount of time the projectile launched will exist for after being launched
local PROJECTILE_LIFETIME = 10

-- enable or disable all projectile proximity prompts
local function enableProjectileProximityPrompts(isEnabled: boolean)
	for _, projectile in projectileMaterials:GetChildren() do
		local proximityPrompt = projectile.ProximityPrompt
		proximityPrompt.Enabled = isEnabled
	end
end

local function projectileSelectedToLoad(projectile: Part, player: Player)
	-- set new projectile on catapult
	local newProjectile = projectile:Clone()
	newProjectile:ClearAllChildren()
	newProjectile:PivotTo(CFrame.new(reloadAttachment.WorldPosition))
	newProjectile.Anchored = false
	newProjectile.Parent =  catapultPlatform.Catapult.Swivel.Armature
	
	-- set network owner of projectile to the player that selected it
	newProjectile:SetNetworkOwner(player)
	projectileToLaunch = newProjectile
	
	-- hide the selected projectileo to show user it was chosen
	projectileSelected = projectile
	projectileSelected.Transparency = 1
	projectileSelected.CanCollide = false
	
	-- disable all projectile proximity prompts
	enableProjectileProximityPrompts(false)
end

local function onCatapultLaunch()
	projectileSelected.Transparency = 0
	projectileSelected.CanCollide = true
	projectileSelected = nil
	
	-- destroy the projectile after some time in case it is in the way of the next launch
	local projectileLaunched = projectileToLaunch
	task.delay(PROJECTILE_LIFETIME, function()
		if projectileLaunched then
			projectileLaunched:Destroy()
			projectileLaunched = nil
		end	
	end)

	-- wait until launch resets to enable all projectile proximity prompts
	-- otherwise ball will not be loaded correctly
	task.delay(catapultPlatform:GetAttribute(LAUNCH_RESET_TIME_ATTRIBUTE_NAME), function()
		enableProjectileProximityPrompts(true)
	end)
end

local function onGameOver()
	enableProjectileProximityPrompts(false)
end

local function onGameReset()
	enableProjectileProximityPrompts(true)
end

local function initialize()
	for _, projectile in projectileMaterials:GetChildren() do
		projectile.ProximityPrompt.ActionText = projectile.Material.Name
		projectile.ProximityPrompt.Triggered:Connect(function(player: Player)
			projectileSelectedToLoad(projectile, player)
		end)
	end
	
	launchButton.ProximityPrompt.Triggered:Connect(onCatapultLaunch)
	
	catapultPlatform:GetAttributeChangedSignal("LaunchAttempts"):Connect(function()
		local numAttempts = catapultPlatform:GetAttribute("LaunchAttempts")
		if numAttempts == 0 then
			onGameOver()
		end
	end)
	
	resetGameEvent.OnServerEvent:Connect(onGameReset)
end

initialize()