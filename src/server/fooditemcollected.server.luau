local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FoodItemCollected = ReplicatedStorage:WaitForChild("FoodItemCollected")

-- Example function to simulate item pickup
local function onFoodItemPickedUp(player, foodItemId)
    FoodItemCollected:FireClient(player, foodItemId) -- Send the food item ID to the client
end

-- Simulation purposes: Every 10 seconds, pretend a food item is picked up
game.Players.PlayerAdded:Connect(function(player)
    while wait(10) do
        onFoodItemPickedUp(player, math.random(1, 5)) -- Randomly select an item ID between 1 and 5
    end
end)