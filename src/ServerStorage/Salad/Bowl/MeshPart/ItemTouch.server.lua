local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HealthUpdateEvent = ReplicatedStorage:WaitForChild("HealthUpdateEvent")

function onTouched(hit)
	script.Parent:remove()
	local player = game.Players:findFirstChild(hit.Parent.Name)
	-- Assume 'player' is a variable representing a specific player.
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")


	shared.playerHealthBarValue = math.max(0, shared.playerHealthBarValue + 10) -- Decrease health

	--humanoid.Health = health
	HealthUpdateEvent:FireClient(player, shared.playerHealthBarValue) -- Send update to client
end

script.Parent.Touched:connect(onTouched)