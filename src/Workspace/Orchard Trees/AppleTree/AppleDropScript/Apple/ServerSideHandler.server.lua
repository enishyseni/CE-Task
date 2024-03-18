local biteEvent = script.Parent.BiteTaken
local finishedEvent = script.Parent.AppleFinished
local configs = require(script.Parent.Configurations)

biteEvent.OnServerEvent:Connect(function(player)
	player.Character.Humanoid:TakeDamage(-configs.appleHealthRegen) -- negative value so we actually heal the player
end)

finishedEvent.OnServerEvent:Connect(function()
	script.Parent:Destroy()
end)