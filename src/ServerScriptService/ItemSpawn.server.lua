shared.playersItems = {}
shared.playersScore = {}

-- Your item model in ServerStorage
local foodItemBurger = game.ServerStorage.Burger
local foodItemSalad = game.ServerStorage.Salad
foodItemBurger.PrimaryPart = foodItemBurger:FindFirstChild("MeshPart") -- Replace "NameOfThePart" with the actual name of the part you want to use as the PrimaryPart.
foodItemSalad.PrimaryPart = foodItemSalad:FindFirstChild("Bowl") -- Replace "NameOfThePart" with the actual name of the part you want to use as the PrimaryPart.

-- Function to insert an item for a specific player
local function insertItemForPlayer(player, itemId)
	-- Ensure there's a table for this player based on their UserId
	if not shared.playersItems[player.UserId] then
		shared.playersItems[player.UserId] = {}
	end

	-- Insert the item into the player's specific item list
	table.insert(shared.playersItems[player.UserId], itemId)
end

local function getNumberOfItemsPerPlayer(player)
	local itemsCount = 0 -- This will store the number of items per player

	for userId, items in pairs(shared.playersItems) do
		-- The key is the userId, and the value is the table of items
		-- Count the number of items for this player and store it in itemCounts
		if userId == player.userId then
			itemsCount = #items  -- #items returns the length of the table (number of items)
		end
	end

	return itemsCount -- Return the table containing item counts for each player
end

function spawnFoodNearPlayer(player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    local playerPosition = player.Character.HumanoidRootPart.Position

    -- Define a range for how close or far you want the spawn from the player
    local spawnRange = 50 -- Adjust this value as needed

    -- Calculate a random spawn position near the player
    local randomPosition = Vector3.new(
        math.random(-spawnRange, spawnRange),
        0, -- You might want to adjust this based on your game's terrain or use a method to find the ground level
        math.random(-spawnRange, spawnRange)
	)
	
	print("ITMES Count: " .. getNumberOfItemsPerPlayer(player))
	--print(shared.playersItems)
	
	if getNumberOfItemsPerPlayer(player) == 5 then
		return -- don't spwan more items if player has reached 5 items around its humanoid
	end
	
	local uniqueId = tostring(math.random()) .. tostring(tick())

	local spawnPosition = playerPosition + randomPosition
	
	-- If you add another type of item you have to increase range
	local foodTypeToSpawn = math.random(1,2)
	
	print(foodTypeToSpawn)

	-- Assuming foodItem is your item to spawn and it's a Model with a PrimaryPart
	local clone = nil
	
	if foodTypeToSpawn == 1 then
		clone = foodItemBurger:Clone()
	end
	
	if foodTypeToSpawn == 2 then
		clone = foodItemSalad:Clone()
	end
	
	if clone.PrimaryPart then
		print("New item: " .. clone.Name)
		-- Adjust Y position as necessary, e.g., to place it above the ground
		clone:SetPrimaryPartCFrame(CFrame.new(spawnPosition + Vector3.new(0, 1, 0))) -- Adding 10 to Y to ensure it spawns above the ground
		clone.Parent = game.Workspace
	else
		warn("No PrimaryPart set for " .. clone.Name)
	end
	
	insertItemForPlayer(player, uniqueId)
end

while true do
    wait(1) -- Wait for 10 seconds before spawning another item

    -- Get a list of all players in the game
    local players = game.Players:GetPlayers()
    if #players > 0 then
        local randomIndex = math.random(#players)
        local randomPlayer = players[randomIndex]
        spawnFoodNearPlayer(randomPlayer) -- Spawn food near the randomly selected player
    end
end