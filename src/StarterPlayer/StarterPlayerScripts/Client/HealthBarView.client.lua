print("Hello world, from client - HealthBar!")
local Roact = require(game.ReplicatedStorage.Roact)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local playerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
local HealthUpdateEvent = ReplicatedStorage:WaitForChild("HealthUpdateEvent")

HealthBar = Roact.Component:extend("HealthBar")

function HealthBar:init()
    self:setState({
        health = 100,
    })

    HealthUpdateEvent.OnClientEvent:Connect(function(newHealth)
        self:setState({
            health = newHealth
        })
    end)
end

function HealthBar:render()
    local healthPercentage = self.state.health / 100

    return Roact.createElement("Frame", {
        Position = UDim2.new(0, 10, 0.5, 0),
        Size = UDim2.new(0, 20, 0, 300),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        AnchorPoint = Vector2.new(0, 0.5),
    }, {
        HealthFill = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, healthPercentage, 0),
            Position = UDim2.new(0, 0, 1, 0),
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = Color3.fromRGB(255, 0, 0),
        }),
    })
end

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

local healthBarElement = Roact.createElement(HealthBar)
Roact.mount(healthBarElement, screenGui, "HealthBar")