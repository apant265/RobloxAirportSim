local initialDistValue = 100  -- Starting distance for neighbor search
local increment = 1         -- Increment value for expanding search range
local maxDistValue = 111     -- Maximum allowable distance

-- Loop through each node in the Taxiways workspace
for _, mainNode in pairs(workspace.Taxiways:GetChildren()) do
	-- Create or retrieve the "Values" folder for each node
	local valuesFolder
	if not mainNode:FindFirstChild("Values") then
		valuesFolder = Instance.new("Folder", mainNode)
		valuesFolder.Name = "Values"
	else
		valuesFolder = mainNode.Values
	end

	-- Create or retrieve neighbor ObjectValues in the Values folder
	local function getOrCreateNeighbor(name)
		if not valuesFolder:FindFirstChild(name) then
			local neighbor = Instance.new("ObjectValue", valuesFolder)
			neighbor.Name = name
			return neighbor
		else
			return valuesFolder[name]
		end
	end

	local oneNeigh = getOrCreateNeighbor("neighborOne")
	local twoNeigh = getOrCreateNeighbor("neighborTwo")
	local threeNeigh = getOrCreateNeighbor("neighborThree")
	local fourNeigh = getOrCreateNeighbor("neighborFour")

	-- Track assigned nodes to avoid duplicates
	local assignedNodes = {}
	local filledNeighbors = 0
	local distValue = initialDistValue  -- Start with the initial distance

	-- Increase the search radius until four neighbors are found or maxDistValue is reached
	while filledNeighbors < 4 and distValue <= maxDistValue do
		for _, potentialNeighbor in pairs(workspace.Taxiways:GetChildren()) do
			-- Skip if the node is the same as the mainNode or already assigned
			if mainNode == potentialNeighbor or assignedNodes[potentialNeighbor] then
				continue
			end

			-- Check distance between mainNode and potentialNeighbor
			local distance = (mainNode.PrimaryPart.Position - potentialNeighbor.PrimaryPart.Position).magnitude
			if distance < distValue then
				-- Assign neighbors based on available ObjectValue slots
				if oneNeigh.Value == nil then
					oneNeigh.Value = potentialNeighbor
					assignedNodes[potentialNeighbor] = true
					filledNeighbors += 1
				elseif twoNeigh.Value == nil then
					twoNeigh.Value = potentialNeighbor
					assignedNodes[potentialNeighbor] = true
					filledNeighbors += 1
				elseif threeNeigh.Value == nil then
					threeNeigh.Value = potentialNeighbor
					assignedNodes[potentialNeighbor] = true
					filledNeighbors += 1
				elseif fourNeigh.Value == nil then
					fourNeigh.Value = potentialNeighbor
					assignedNodes[potentialNeighbor] = true
					filledNeighbors += 1
				end

				-- Break if we have assigned all four neighbors
				if filledNeighbors >= 4 then
					break
				end
			end
		end

		-- If fewer than four neighbors are found, increase distValue and try again
		if filledNeighbors < 4 then
			distValue = distValue + increment
		end
	end

	-- Remove unassigned ObjectValues if no neighbors were found for them
	if oneNeigh.Value == nil then oneNeigh:Destroy() end
	if twoNeigh.Value == nil then twoNeigh:Destroy() end
	if threeNeigh.Value == nil then threeNeigh:Destroy() end
	if fourNeigh.Value == nil then fourNeigh:Destroy() end
end




--Set Primary Part
for i, node in pairs(workspace.Taxiways:GetChildren())do
	node.PrimaryPart = node.Node
	node.Name = "Taxiway "..i
end

for i, node in pairs(workspace.Taxiways:GetChildren())do
	node.PrimaryPart.Transparency = 1
	node.PrimaryPart.CanCollide = false
	node.PrimaryPart.Locked = true
end

for i, node in pairs(workspace.Taxiways:GetChildren())do
	if node:FindFirstChild("Values") then
		node.Values:Destroy()
	end
end