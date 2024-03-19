local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HealthUpdateEvent = ReplicatedStorage:WaitForChild("HealthUpdateEvent")
local pickupSound = workspace.PickupSound

function onTouched(hit)
	local player = game.Players:findFirstChild(hit.Parent.Name)
	if player then  -- Make sure a player touched the item
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		-- Play the pickup sound if it exists
		if pickupSound then
			pickupSound:Play()
		end

		shared.playerHealthBarValue = math.max(0, shared.playerHealthBarValue + 10) -- Update health, you might need to adjust this part based on actual logic

		-- Update the player's health on the client side
		HealthUpdateEvent:FireClient(player, shared.playerHealthBarValue)

		-- Remove the item after the sound has been played and other actions have been taken
		script.Parent:remove()
		
		table.remove(shared.playersItems[player.UserId], 1)
	end
end

script.Parent.Touched:connect(onTouched)