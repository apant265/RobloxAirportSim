local process = require("@lune/process")
local fs = require("@lune/fs")
local roblox = require("@lune/roblox")
local io = require("@lune/stdio")


-- Here we load a file just like in the first example

local confirm = io.prompt("confirm", "The file to convert is currently " .. process.args[1] .. ". Is this correct?")
if not confirm then 
print("Please re-run the program with the correct file")
process.exit(0)
else 
print("Converting file now...")
end

local file = fs.readFile(process.args[1])
local game = roblox.deserializePlace(file)
local workspace = game:GetService("Workspace")
 
-- Make sure a directory exists to save our models in
fs.writeDir("assets")
 
-- Then we save all of our instances in Workspace as model files, in our new directory
-- Note that a model file can actually contain several instances at once, so we pass a table here
for _, child in workspace:GetChildren() do
	file = roblox.serializeModel({ child })
	fs.writeFile("assets/" .. child.Name .. ".rbxm", file)
	print("writing file assets/" .. child.Name .. ".rbxm")
end
