local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HealthUpdateEvent = ReplicatedStorage:WaitForChild("HealthUpdateEvent")

shared.playersHealthBarTracking = {}


local function onPlayerAdded(player)
	shared.playersHealthBarTracking[player.Name] = 100
	-- Assume 'player' is a variable representing a specific player.
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	shared.playerHealthBarValue = 100 -- Starting health
	--humanoid.Health = health

    while true do
		wait(5) -- Simulate health change over time
		--shared.playerHealthBarValue = humanoid.Health
		shared.playerHealthBarValue = math.max(0, shared.playerHealthBarValue - 10) -- Decrease health
		
		--humanoid.Health = health
		HealthUpdateEvent:FireClient(player, shared.playerHealthBarValue) -- Send update to client
        
		if shared.playerHealthBarValue == 0 then
			humanoid.Health = 0 -- kill the player because it did not eat enough food
        end
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)
--Players.CharacterAdded:Connect(onPlayerAdded)