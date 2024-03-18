-- Assuming Roact is installed and required in your environment
local Roact = require(game.ReplicatedStorage.Roact)

-- Define the Popup Component
local PopupComponent = Roact.Component:extend("PopupComponent")

function PopupComponent:render()
    return Roact.createElement("ScreenGui", {}, {
        Popup = Roact.createElement("TextLabel", {
            Size = UDim2.new(0, 200, 0, 50),
            Position = UDim2.new(0.5, -100, 0.5, -25), -- Centered on screen
            Text = "Press E to grab the item",
            Visible = self.props.visible, -- Controlled by proximity to the item
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            TextColor3 = Color3.fromRGB(0, 0, 0),
        })
    })
end

-- Create a ScreenGui for the Roact tree
local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local app = Roact.createElement(PopupComponent, {visible = false}) -- Start invisible
local handle = Roact.mount(app, playerGui)

-- Detect proximity to the food item
local player = game.Players.LocalPlayer
local foodItem = game.Workspace:WaitForChild("FoodItem") -- Assuming a part named 'FoodItem'

game.RunService.Heartbeat:Connect(function()
    local distance = (player.Character.HumanoidRootPart.Position - foodItem.Position).magnitude
    if distance < 10 then -- Change 10 to your desired proximity
        -- Show the popup
        Roact.update(handle, Roact.createElement(PopupComponent, {visible = true}))
    else
        -- Hide the popup
        Roact.update(handle, Roact.createElement(PopupComponent, {visible = false}))
    end
end)