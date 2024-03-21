local InventoryManager = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HealthUpdateEvent = ReplicatedStorage:WaitForChild("HealthUpdateEvent")
local InventoryChangedEvent = ReplicatedStorage:FindFirstChild("InventoryChangedEvent")
local Enhancements = require(game.ServerScriptService.Enhancements)

-- Define ItemTypes enum
local ItemTypes = {
	Burger = "Burger",
	Salad = "Salad",
	Candy = "Candy",
	Supplement = "Supplement",
}

-- Check if the InventoryChanged RemoteEvent exists, otherwise create it.

if not InventoryChangedEvent then
	InventoryChangedEvent = Instance.new("RemoteEvent")
	InventoryChangedEvent.Name = "InventoryChangedEvent"
	InventoryChangedEvent.Parent = ReplicatedStorage
end

-- Table to store user inventories.
local userInventories = {}

-- Initialize inventory with item types set to 0.
function InventoryManager.initializeInventory()
	local inventory = {}
	for _, itemType in pairs(ItemTypes) do
		inventory[itemType] = 0
	end
	return inventory
end

-- Function to get the user's inventory, creating a new one if none exists.
function InventoryManager.GetInventory(player)
	if not userInventories[player.UserId] then
		userInventories[player.UserId] = InventoryManager.initializeInventory()
	end
	return userInventories[player.UserId]
end

-- Function to add a quantity of an item type to the user's inventory.
function InventoryManager.AddItem(player, itemType, quantity)
	local inventory = InventoryManager.GetInventory(player)
	if inventory[itemType] ~= nil then  -- Check if the itemType is valid
		inventory[itemType] = inventory[itemType] + quantity  -- Update the quantity for the item type
		InventoryChangedEvent:FireClient(player, "add", itemType, quantity)
	else
		warn("Invalid item type: "..itemType)
	end
end

-- Function to remove a quantity of an item type from the user's inventory.
function InventoryManager.RemoveItem(player, itemType, quantity)
	local inventory = InventoryManager.GetInventory(player)
	
	if itemType == "Burger" then
		if inventory ~= nil then
			for _, itemType in pairs(ItemTypes) do
				if itemType == ItemTypes.Burger then
					if inventory[itemType] > 0 then 
						shared.playerHealthBarValue = math.max(0, shared.playerHealthBarValue + 10) 
						HealthUpdateEvent:FireClient(player, shared.playerHealthBarValue)
						Enhancements.increaseWidth(player, 0.7, 5)
					end
				end
			end
		end
	end
	
	if itemType == "Salad" then
		if inventory ~= nil then
			for _, itemType in pairs(ItemTypes) do
				if itemType == ItemTypes.Salad then
					if inventory[itemType] > 0 then 
						shared.playerHealthBarValue = math.max(0, shared.playerHealthBarValue + 5)
						HealthUpdateEvent:FireClient(player, shared.playerHealthBarValue)
						-- increase player walking speed by .2 for 5 seconds
						Enhancements.increaseSpeed(player, 30, 10)
						
					end
				end
			end
		end
	end
	
	if itemType == "Candy" then
		if inventory ~= nil then
			for _, itemType in pairs(ItemTypes) do
				if itemType == ItemTypes.Candy then
					if inventory[itemType] > 0 then 
						shared.playerHealthBarValue = math.max(0, shared.playerHealthBarValue + 3)
						HealthUpdateEvent:FireClient(player, shared.playerHealthBarValue)
						-- increase player walking speed by .3 for 5 seconds
						Enhancements.increaseSpeed(player, 40, 5)

					end
				end
			end
		end
	end
	
	if itemType == "Supplement" then
		if inventory ~= nil then
			for _, itemType in pairs(ItemTypes) do
				if itemType == ItemTypes.Supplement then
					if inventory[itemType] > 0 then 
						Enhancements.increaseSpeed(player, 50, 10)
						--Enhancements.increaseHeight(player, 50, 10)
						Enhancements.increaseJumpHeight(player, 30, 10)
						-- increase player walking speed by .4 for 5 seconds
						-- increase jump height by 2x for 5 seconds

					end
				end
			end
		end
	end
	
	if inventory[itemType] ~= nil then
		inventory[itemType] = math.max(0, inventory[itemType] - quantity)  -- Decrease the quantity for the item type but not below 0
		InventoryChangedEvent:FireClient(player, "remove", itemType, quantity)
	else
		warn("Invalid item type: "..itemType)
	end
	
	HealthUpdateEvent:FireClient(player, shared.playerHealthBarValue)
	
end

-- Export the ItemTypes and module
InventoryManager.ItemTypes = ItemTypes
return InventoryManager
