local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HealthUpdateEvent = ReplicatedStorage:WaitForChild("HealthUpdateEvent")

local function onPlayerAdded(player)
    local health = 100 -- Starting health

    while true do
        wait(5) -- Simulate health change over time
        health = math.max(0, health - 10) -- Decrease health
        HealthUpdateEvent:FireClient(player, health) -- Send update to client
        
        if health == 0 then
            health = 100 -- Reset health for demonstration
        end
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)