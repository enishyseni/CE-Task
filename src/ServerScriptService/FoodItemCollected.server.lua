local Players = game:GetService("Players")

-- Table to store player inventories
local playerInventories = {}

-- Function to add a food item to the inventory
local function addFoodToInventory(player, foodItem)
    -- Initialize the player's inventory if it doesn't exist
    if not playerInventories[player.UserId] then
        playerInventories[player.UserId] = {}
    end
    
    local inventory = playerInventories[player.UserId]

    -- Name of the food item
    local foodName = foodItem.Name

    -- Add or update the food item in the player's inventory
    if inventory[foodName] then
        -- Increase the quantity if the item already exists
        inventory[foodName].quantity = inventory[foodName].quantity + 1
    else
        -- Add the new item with a quantity of 1
        inventory[foodName] = { name = foodName, quantity = 1 }
    end

    print(player.Name .. " picked up " .. foodName .. ". Total now: " .. inventory[foodName].quantity)
end

-- Function to handle when a player triggers a ProximityPrompt
local function onPromptTriggered(proximityPrompt, player)
    -- Check if the object triggering the prompt is indeed a 'FoodItem'
    if proximityPrompt.Parent and proximityPrompt.Parent:IsA("Model") and proximityPrompt.Parent:FindFirstChild("IsFoodItem") then
        addFoodToInventory(player, proximityPrompt.Parent)
        -- Optionally, remove the food item from the game world here if it should disappear after being picked up
        proximityPrompt.Parent:Destroy()
    end
end

-- Connect the event for all existing and future ProximityPrompts
for _, item in pairs(workspace:GetDescendants()) do
    if item:IsA("ProximityPrompt") then
        item.Triggered:Connect(onPromptTriggered)
    end
end

workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("ProximityPrompt") then
        descendant.Triggered:Connect(onPromptTriggered)
    end
end)