--local function ItemsReducer(state, action)
--	state = state or {
--		Burger = { image = "rbxassetid://12462657942", quantity = 0 },
--		Salad = { image = "rbxassetid://13743491406", quantity = 0 },
--		Candy = { image = "rbxassetid://119966532", quantity = 0 },
--		Supplement = { image = "rbxassetid://366897011", quantity = 0 },
--	}

--	if action.type == "AddItemQuantity" then
--		local newState = {}
--		for itemType, item in pairs(state) do
--			newState[itemType] = {
--				image = item.image,
--				quantity = item.itemType == action.itemType and math.max(0, item.quantity + action.amount) or item.quantity
--			}
--		end
--		return newState
--	elseif action.type == "RemoveItemQuantity" then
--		local newState = {}
--		for itemType, item in pairs(state) do
--			newState[itemType] = {
--				image = item.image,
--				quantity = item.itemType == action.itemType and math.max(0, item.quantity - action.amount) or item.quantity
--			}
--		end
--		return newState
--	end

--	return state
--end

--return ItemsReducer