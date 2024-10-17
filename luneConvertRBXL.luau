local remodel = require("./remodel")
local process = require("@lune/process")
local roblox = require("@lune/roblox")
local fs = require("@lune/fs")

if #process.args ~= 2 then
	error("Wrong Number of args supplied, " .. #process.args .. " received, 2 expected")
end

for test in process.args do
print(process.args[test])
end

print(fs)
if not fs.isDir(toString(process.args[2])) then 
fs.writeDir("process.args[2]")
end

-- One use for Remodel is to move the terrain of one place into another place.
local inputPlaceFile = fs.readFile(process.args[1])
local inputPlace = roblox.deserializePlace(inputPlaceFile)
local models = inputPlace.ReplicatedStorage.Models
 
for _, model in ipairs(Models:GetChildren()) do
	-- Save out each child as an rbxm model
	local outModel = roblox.serializePlace(model)
	fs.writeFile(process.args[2] .. model.Name .. ".rbxm", outModel)
end
