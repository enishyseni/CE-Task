print("Hello world, from client!")

local Players = game:GetService("Players")
local Roact = require(game.ReplicatedStorage.Roact)
-- local HealthBar = require(game.ReplicatedStorage.HealthBar) -- Adjust the path to your HealthBar component
local HealthBar = require(game.StarterPlayer.StarterPlayerScripts.Client.healthbar)

local playerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

local healthBarElement = Roact.createElement(HealthBar)
Roact.mount(healthBarElement, screenGui, "HealthBar")