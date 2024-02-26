-- print("Hello world, from server!")

-- local foodItem = game.ServerStorage.YourItem                              -- Your item model in ServerStorage
local foodItem = game.ServerStorage.Burger
foodItem.PrimaryPart = foodItem:FindFirstChild("MeshPart") -- Replace "NameOfThePart" with the actual name of the part you want to use as the PrimaryPart.


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

    local spawnPosition = playerPosition + randomPosition

    -- Assuming foodItem is your item to spawn and it's a Model with a PrimaryPart
    local clone = foodItem:Clone()
    if clone.PrimaryPart then
        -- Adjust Y position as necessary, e.g., to place it above the ground
        clone:SetPrimaryPartCFrame(CFrame.new(spawnPosition + Vector3.new(0, 0, 0))) -- Adding 10 to Y to ensure it spawns above the ground
        clone.Parent = game.Workspace
    else
        warn("No PrimaryPart set for " .. clone.Name)
    end
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
