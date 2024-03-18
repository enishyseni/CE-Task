print("Hello world, from client - Inventory!")
local Roact = require(game.ReplicatedStorage.Roact)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FoodItemCollectedEvent = ReplicatedStorage:WaitForChild("FoodItemCollectedEvent")

local FoodDisplay = Roact.Component:extend("FoodDisplay")

function FoodDisplay:init()
    self.state = {
        foodItems = {} -- Initially empty
    }

    -- Listen for food item collection events
	FoodItemCollectedEvent.OnClientEvent:Connect(function(foodItemId)
        local foodItems = self.state.foodItems
        if #foodItems < 5 then
            table.insert(foodItems, foodItemId)
            self:setState({foodItems = foodItems})
        end
    end)
end

function FoodDisplay:render()
    local slots = {}
    for i = 1, 5 do
        slots["Slot" .. i] = Roact.createElement("Frame", {
            Size = UDim2.new(0, 50, 0, 50),
            Position = UDim2.new((i-1) * 0.1, 300, 1, -10), -- Position slots at the bottom
            BackgroundColor3 = self.state.foodItems[i] and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255),
            BorderSizePixel = 2,
        })
    end

    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 50),
        Position = UDim2.new(0, 0, 1, -50),
        AnchorPoint = Vector2.new(0, 1),
        BackgroundTransparency = 1, -- Transparent background
    }, slots)
end

local playerGui = game.Players.LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

local app = Roact.createElement(FoodDisplay)
Roact.mount(app, screenGui, "FoodDisplay")