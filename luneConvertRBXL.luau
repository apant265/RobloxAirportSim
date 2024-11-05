local process = require("@lune/process")
local fs = require("@lune/fs")
local roblox = require("@lune/roblox")
local io = require("@lune/stdio")

local classFileName = "./classes.txt"

if not fs.isFile(classFileName) then
	fs.writeFile(classFileName, "")
end

local classes = fs.readFile(classFileName)
local classT = {}
classes = string.gmatch(classes, "([^\n]+)")
for class in classes do
	table.insert(classT,class)
end
classes = classT
if classes == nil then classes = {} end
function writeToFS(name, ext, location, file)
	if not fs.isDir(location) then
		fs.writeDir(location)
	end
	local out = ""
	if type(file) == "table" then
		for _,item in table do
			out = out .. tostring(item)
		end
		file = out
	end
	print("writing " .. location ..  name .. ext)
	fs.writeFile(location .. name .. ext, file)
end


function isModel(className)
	if classes == "" then return false end
	if classes == nil then return false end
	for _, class in classes do
		if className == class then
			return true
		end
	end
	return false
end

function addClass(className)
	if classes == nil then return end
	classes[table.getn(classes)+1] = className
	local out = ""
	for _, class in classes do 
		out = out .. class .. "\n"
	end
	writeToFS(classFileName, "", "", out)
end	


function convertInstance(instance, location)
	if instance == nil then
		return
	end

	for _, child in instance:GetChildren() do
		local nestedChildren = child:GetChildren()
		local name = child.Name
		local class = child.ClassName
		if child.ClassName == "Folder" or class == "StarterPlayerScripts" or class == "StarterCharacterScripts" or class == "StarterGui" then
			fs.writeDir(location .. name .. "/")
			convertInstance(child, location .. name .. "/")
		elseif isModel(class) then
			for i, nestedChild in nestedChildren do
				if nestedChild == nil then break end
				if nestedChild.ClassName == "MeshPart" then
					print("Found Mesh " .. nestedChild.Name .. " and MeshID " .. nestedChild.MeshId)
				end
			end
			out = roblox.serializeModel({ child })
			writeToFS(name, ".rbxm", location, out)
		elseif child:IsA("LuaSourceContainer") then 
			if class == "ModuleScript" then
				writeToFS(name, ".luau", location, child.Source)
			elseif class == "LocalScript" then
				writeToFS(name, ".client.luau", location, child.Source)
			elseif class == "ServerScript" then
				writeToFS(name, ".server.luau", location, child.Source)
			elseif class == "Script" then 
				writeToFS(name, ".luau", location, child.Source)
			else
				print("Non-Standard Script found of class " .. class .. " and name " .. name .. " please let one of the script developers know so that it can be properly handled, or convert the script to a standard type i.e. ServerScript, LocalScript, or ModuleScript.")
			end
		else
			print("The class type " .. child.ClassName .. " on item " .. child.Name .. " slated for location " .. location .. " has not been implemented yet.") 
			if io.prompt("confirm", "Would you like this file to be stored as a .rbxm (model) file?") then 
				if io.prompt("confirm", "Would you like for all files of this class to be converted to .rbxm in the future?") then
					addClass(class)
				end
				local out = roblox.serializeModel({ child })
				writeToFS(child.Name, ".rbxm", location, out) 
			else
				print("Exiting...")
				process.exit(0)
			end

		end
	end
end

	

-- Load the file, confirm correct file

local confirm = io.prompt("confirm", "The file to convert is currently " .. process.args[1] .. ". Is this correct?")
if not confirm then 
print("Please re-run the program with the correct file")
process.exit(0)
else 
print("Converting file now...")
end

-- Break the loaded file down into its components

local file = fs.readFile(process.args[1])
local game = roblox.deserializePlace(file)
local workspace = game:GetService("Workspace")
local replicatedstorage = game:GetService("ReplicatedStorage")
local serverscriptservice = game:GetService("ServerScriptService")
local starterplayer = game:GetService("StarterPlayer")
local startergui = game:GetService("StarterGui")
 
 

convertInstance(workspace, "./assets/")
convertInstance(replicatedstorage, "./src/ReplicatedStorage/")
convertInstance(serverscriptservice, "./src/ServerScriptService/")
convertInstance(starterplayer, "./src/StarterPlayer/")
convertInstance(startergui, "./src/StarterGui/")
