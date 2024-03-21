-- First, get the required services
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Make sure the RemoteEvent exists. Replace 'YourRemoteEventName' with your actual RemoteEvent's name.
local ConsumeItemClientEvent = ReplicatedStorage:WaitForChild("ConsumeItemClientEvent")

-- This function sends the type of item based on the key pressed
local function onKeyPress(input, gameProcessed)
	if gameProcessed then return end  -- If the game has already processed this input, we should ignore it.
	local itemType = nil

	if input.KeyCode == Enum.KeyCode.One then
		itemType = "Burger"
	elseif input.KeyCode == Enum.KeyCode.Two then
		itemType = "Salad"
	elseif input.KeyCode == Enum.KeyCode.Three then
		itemType = "Candy"
	elseif input.KeyCode == Enum.KeyCode.Four then
		itemType = "Supplement"
	end

	if itemType then
		-- Fire the remote event with the specified item type
		ConsumeItemClientEvent:FireServer(itemType)
	end
end

-- Connect the function to the UserInputService's InputBegan event
UserInputService.InputBegan:Connect(onKeyPress)
