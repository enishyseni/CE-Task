local Roact = require(game.ReplicatedStorage.Roact)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local playerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
local ScoreUpdatedEvent = ReplicatedStorage:WaitForChild("ScoreUpdatedEvent")

local ScoreDisplay = Roact.Component:extend("ScoreDisplay")

function ScoreDisplay:init()
	self:setState({
		score = 0  -- Initial score
	})

	-- Listen for score updates
	ScoreUpdatedEvent.OnClientEvent:Connect(function(newScore)
		self:setState({
			score = newScore
			
		})
		print("-------" .. newScore)
	end)
end

function ScoreDisplay:render()
	return Roact.createElement("TextLabel", {
		Text = "Score: " .. self.state.score,
		Size = UDim2.new(0, 200, 0, 50),
		Position = UDim2.new(0, 20, 0.9, 0),  -- Centered at the top of the screen
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		TextColor3 = Color3.fromRGB(0, 0, 0),
		TextSize = 24,
	})
end

-- Create and mount the component
--local tree = Roact.mount(Roact.createElement(ScoreDisplay), game.Players.LocalPlayer:WaitForChild("ScreenGui"), "ScoreDisplay")



local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

local scoreViewElement = Roact.createElement(ScoreDisplay)
Roact.mount(scoreViewElement, screenGui, "ScoreDisplay")

