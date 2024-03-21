local Enhancements = {}

-- Function to increase player walking speed
function Enhancements.increaseSpeed(player, newSpeed, duration)
	if player and player.Character and player.Character:FindFirstChild("Humanoid") then
		local originalSpeed = player.Character.Humanoid.WalkSpeed
		player.Character.Humanoid.WalkSpeed = newSpeed

		-- Set the speed back to normal after the duration
		wait(duration)
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.WalkSpeed = originalSpeed
		end
	end
end

-- Function to increase player height
function Enhancements.increaseHeight(player, additionalHeight, duration)
	if player and player.Character and player.Character:FindFirstChild("Humanoid") then
		local originalHeight = player.Character.Humanoid.BodyDepthScale.Value
		local originalWidth = player.Character.Humanoid.BodyWidthScale.Value
		local originalHead = player.Character.Humanoid.HeadScale.Value

		-- Increase the size
		player.Character.Humanoid.BodyDepthScale.Value = originalHeight + additionalHeight
		player.Character.Humanoid.BodyWidthScale.Value = originalWidth + additionalHeight
		player.Character.Humanoid.HeadScale.Value = originalHead + additionalHeight

		-- Set the size back to normal after the duration
		wait(duration)
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.BodyDepthScale.Value = originalHeight
			player.Character.Humanoid.BodyWidthScale.Value = originalWidth
			player.Character.Humanoid.HeadScale.Value = originalHead
		end
	end
end

-- Function to increase player jump height
function Enhancements.increaseJumpHeight(player, newJumpHeight, duration)
	if player and player.Character and player.Character:FindFirstChild("Humanoid") then
		local originalJumpHeight = player.Character.Humanoid.JumpHeight
		player.Character.Humanoid.JumpHeight = newJumpHeight

		-- Set the jump height back to normal after the duration
		wait(duration)
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.JumpHeight = originalJumpHeight
		end
	end
end

-- Function to increase player width (make player "fatter")
function Enhancements.increaseWidth(player, additionalWidth, duration)
	if player and player.Character and player.Character:FindFirstChild("Humanoid") then
		print(player.Character.Humanoid.BodyWidthScale.Value)
		local originalWidth = player.Character.Humanoid.BodyWidthScale.Value
		local originalDepth = player.Character.Humanoid.BodyDepthScale.Value
		player.Character.Humanoid.BodyWidthScale.Value += additionalWidth
		player.Character.Humanoid.BodyDepthScale.Value += additionalWidth

		-- Set the width back to normal after the duration
		wait(duration)
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.BodyWidthScale.Value = originalWidth
			player.Character.Humanoid.BodyDepthScale.Value = originalDepth
		end
	end
end

return Enhancements
