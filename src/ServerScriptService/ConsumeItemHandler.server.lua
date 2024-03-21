local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ConsumeItemClientEvent = ReplicatedStorage:WaitForChild("ConsumeItemClientEvent")
local InventoryManager = require(game.ServerScriptService.InventoryManager)

local function handleEvent(player, itemType)
	print("---- key pressed ----" .. itemType)
	InventoryManager.RemoveItem(player, itemType, 1)
end

ConsumeItemClientEvent.OnServerEvent:Connect(handleEvent)
