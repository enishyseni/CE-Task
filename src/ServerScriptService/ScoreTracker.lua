-- PlayerScores ModuleScript
local ScoreTracker = {}
local scores = {}  -- Table to keep track of scores, using UserId as key

local ScoreUpdatedEvent = game.ReplicatedStorage:WaitForChild("ScoreUpdatedEvent")

-- Function to update and notify player of new score
function ScoreTracker.updatePlayerScore(userId, amount)
	ScoreTracker.IncrementScore(userId, amount)
	local newScore = ScoreTracker.GetScore(userId)
	-- Find player by UserId
	local player = game.Players:GetPlayerByUserId(userId)
	if player then
		--print("--ScoreUpdated FireClient--")
		--print(newScore)
		ScoreUpdatedEvent:FireClient(player, newScore)  -- Notify the player of their new score
	end
end

-- Function to initialize a player's score
function ScoreTracker.InitPlayerScore(userId)
	if not scores[userId] then
		scores[userId] = 0  -- Start with a score of 0
	end
end

-- Function to increment a player's score
function ScoreTracker.IncrementScore(userId, amount)
	if scores[userId] then
		scores[userId] = scores[userId] + (amount or 1)  -- Increment by amount, default is 1
	else
		-- If there's no score for this userId, initialize it first
		ScoreTracker.InitPlayerScore(userId)
		scores[userId] = scores[userId] + (amount or 1)
	end
end

-- Function to get a player's score
function ScoreTracker.GetScore(userId)
	return scores[userId] or 0  -- Return the score, or 0 if none exists
end

return ScoreTracker
