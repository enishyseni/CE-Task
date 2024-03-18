-- InventoryModule

local InventoryModule = {}

local inventory = {
	Burger = 10,
	SaladBowl = 10,
	FruitsBowl = 10,
	GodVitamins = 10,
	Water = 10,
}

function InventoryModule.AddItem(itemName, amount)
	if inventory[itemName] then
		inventory[itemName] = inventory[itemName] + amount
		print(itemName .. " stock increased to " .. inventory[itemName])
	else
		warn("Attempted to add an invalid item: " .. itemName)
	end
end

function InventoryModule.RemoveItem(itemName, amount)
	if inventory[itemName] then
		if inventory[itemName] >= amount then
			inventory[itemName] = inventory[itemName] - amount
			print(itemName .. " stock decreased to " .. inventory[itemName])
		else
			warn("Not enough " .. itemName .. " in stock to remove the requested amount.")
		end
	else
		warn("Attempted to remove an invalid item: " .. itemName)
	end
end

function InventoryModule.CheckStock(itemName)
	if inventory[itemName] then
		return inventory[itemName]
	else
		warn("Attempted to check stock of an invalid item: " .. itemName)
		return nil
	end
end

return InventoryModule

