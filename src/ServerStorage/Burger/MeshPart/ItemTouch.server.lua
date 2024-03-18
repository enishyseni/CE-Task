--ammo = 1337 --> Change this to how much ammo you want to recharge.
--function onTouched(hit)
--	local human = hit.Parent:findFirstChild("Humanoid")
--	local player = game.Players:findFirstChild(hit.Parent.Name)
--	if (human ~= nil) then
--		script.Parent:remove()
--		local Ammo = human.Parent.CHANGE.AmmoScript.Ammo --Change the 'CHANGE' for the weapon that you want to recharge.
--		if (Ammo~=nil) then
--			Ammo.Value = Ammo.Value + ammo
--		end
--	end
--	if (player ~= nil) then
--		script.Parent:remove()
--		local Ammo = player.Backpack.CHANGE.AmmoScript.Ammo --Change the 'CHANGE' for the weapon that you want to recharge.
--		if (Ammo~=nil) then
--			Ammo.Value = Ammo.Value + ammo
--		end
--	end
--end

--script.Parent.Touched:connect(onTouched)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HealthUpdateEvent = ReplicatedStorage:WaitForChild("HealthUpdateEvent")

function onTouched(hit)
	script.Parent:remove()
	local player = game.Players:findFirstChild(hit.Parent.Name)
	-- Assume 'player' is a variable representing a specific player.
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	
		
	shared.playerHealthBarValue = math.max(0, shared.playerHealthBarValue + 5) -- Decrease health

		--humanoid.Health = health
	HealthUpdateEvent:FireClient(player, shared.playerHealthBarValue) -- Send update to client
end

script.Parent.Touched:connect(onTouched)