local Roact = require(game.ReplicatedStorage.Roact)
local Rodux = require(game.ReplicatedStorage.Rodux)
local RoactRodux = require(game.ReplicatedStorage.RoactRodux)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local InventoryChangedEvent = ReplicatedStorage:WaitForChild("InventoryChangedEvent")

-- Actions
local function addItem(itemType)
	return {
		type = "AddItem",
		itemType = itemType,
	}
end

local function removeItem(itemType)
	return {
		type = "RemoveItem",
		itemType = itemType,
	}
end

-- Reducer
local function inventoryReducer(state, action)
	state = state or {
		items = {
			{ itemtype = "Burger", image = "rbxassetid://12462657942", quantity = 0 },
			{ itemtype = "Salad", image = "rbxassetid://13743491406", quantity = 0 },
			{ itemtype = "Candy", image = "rbxassetid://119966532", quantity = 0 },
			{ itemtype = "Supplement", image = "rbxassetid://366897011", quantity = 0 },
		}
	}

	if action.type == "AddItem" or action.type == "RemoveItem" then
		local newItems = {}
		for _, item in ipairs(state.items) do
			local newItem = {itemtype = item.itemtype, image = item.image, quantity = item.quantity}
			if newItem.itemtype == action.itemType then
				if action.type == "AddItem" then
					newItem.quantity = newItem.quantity + 1
				elseif action.type == "RemoveItem" then
					newItem.quantity = math.max(0, newItem.quantity - 1)
				end
			end
			table.insert(newItems, newItem)
		end
		return {
			items = newItems
		}
	end

	return state
end

-- Store
local store = Rodux.Store.new(inventoryReducer)

-- FoodDisplay Component
local FoodDisplay = Roact.Component:extend("FoodDisplay")

function FoodDisplay:init()
	-- Listen to the InventoryChangedEvent
	InventoryChangedEvent.OnClientEvent:Connect(function(operation, itemType)
		if operation == "add" then
			self.props.addItem(itemType)
		elseif operation == "remove" then
			self.props.removeItem(itemType)
		end
	end)
end

function FoodDisplay:render()
	local slots = {}
	for i, item in ipairs(self.props.items) do
		slots["Slot" .. i] = Roact.createElement("Frame", {
			Size = UDim2.new(0, 50, 0, 50),
			Position = UDim2.new((i-1) * 0.1, 400, 1, -10),
		}, {
			Image = Roact.createElement("ImageLabel", {
				Size = UDim2.new(1, 0, 1, 0),
				Image = item.image,
				BackgroundTransparency = 1,
			}),
			Quantity = Roact.createElement("TextLabel", {
				Position = UDim2.new(1, 0, 0, 0),
				Size = UDim2.new(0, 20, 0, 20),
				Text = tostring(item.quantity),
				BackgroundColor3 = Color3.new(0, 0, 0),
				TextColor3 = Color3.new(1, 1, 1),
				TextSize = 14,
			}),
		})
	end

	return Roact.createElement("Frame", {
		Size = UDim2.new(1, 0, 0, 50),
		Position = UDim2.new(0, 0, 1, -50),
		AnchorPoint = Vector2.new(0, 1),
		BackgroundTransparency = 1,
	}, slots)
end

-- Connect Component to Rodux
FoodDisplay = RoactRodux.connect(
	function(state)
		return {
			items = state.items
		}
	end,
	function(dispatch)
		return {
			addItem = function(itemType)
				return dispatch(addItem(itemType))
			end,
			removeItem = function(itemType)
				return dispatch(removeItem(itemType))
			end
		}
	end
)(FoodDisplay)

-- Rendering
local playerGui = game.Players.LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

-- RoactRodux connection and component rendering
local app = Roact.createElement(RoactRodux.StoreProvider, {store = store}, {
	FoodDisplayApp = Roact.createElement(FoodDisplay)
})

Roact.mount(app, screenGui, "FoodDisplay")






------------------------------Non Rodux version------------------------------------
--print("Hello world, from client - Inventory!")
--local Roact = require(game.ReplicatedStorage.Roact)
--local ReplicatedStorage = game:GetService("ReplicatedStorage")

--local InventoryChangedEvent = ReplicatedStorage:WaitForChild("InventoryChangedEvent")



--local FoodDisplay = Roact.Component:extend("FoodDisplay")

--local items = {
--	{ itemtype = "Burger", image = "rbxassetid://12462657942", quantity = 0 },
--	{ itemtype = "Salad", image = "rbxassetid://13743491406", quantity = 0 },
--	{ itemtype = "Candy", image = "rbxassetid://119966532", quantity = 0 },
--	{ itemtype = "Supplement", image = "rbxassetid://366897011", quantity = 0 },
--}

--function FoodDisplay:init()
--	self:setState({
--		itemsReactive = items
--	})

--	-- Adjusting this part to correctly refer to instance methods and handle the event.
--	InventoryChangedEvent.OnClientEvent:Connect(function(operation, itemType, quantity)
--		-- Update state based on the operation
--		if operation == "add" or operation == "remove" then
--			self:updateQuantity(operation, itemType)
--		end
--	end)
--end

--function FoodDisplay:updateQuantity(operation, itemType)
--	-- Copy the items array to modify
--	local updatedItems = {}
--	for i, item in ipairs(self.state.itemsReactive) do
--		if item.itemtype == itemType then
--			local newQuantity = item.quantity
--			if operation == "add" then
--				newQuantity = item.quantity + 1
--			elseif operation == "remove" then
--				newQuantity = math.max(0, item.quantity - 1) -- Ensure quantity does not go below zero
--			end
--			-- Update item quantity
--			table.insert(updatedItems, {
--				itemtype = item.itemtype,
--				image = item.image,
--				quantity = newQuantity
--			})
--		else
--			-- If not the item we're updating, add it unchanged
--			table.insert(updatedItems, item)
--		end
--	end

--	-- Update the state to trigger a re-render
--	self:setState({
--		itemsReactive = updatedItems
--	})
--end

--function FoodDisplay:render()
--	local itemData = self.state.itemsReactive
--	local slots = {}
--	for i = 1, 4 do
--		slots["Slot" .. i] = Roact.createElement("Frame", {
--			Size = UDim2.new(0, 50, 0, 50),
--			Position = UDim2.new((i-1) * 0.1, 400, 1, -10), -- Position slots at the bottom
--			--BackgroundColor3 = self.state.foodItems[i] and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255),
--			--BorderSizePixel = 2,
--		}, {
--			Image = Roact.createElement("ImageLabel", {
--				Size = UDim2.new(1, 0, 1, 0), -- Full size of the parent frame
--				Image = itemData[i].image, -- Image representing the item
--				BackgroundTransparency = 1,
--			}),
--			Quantity = Roact.createElement("TextLabel", {
--				Position = UDim2.new(1, 0, 0, 0), -- Positioned in the top-right corner
--				Size = UDim2.new(0, 20, 0, 20), -- Small size for the quantity
--				Text = tostring(itemData[i].quantity),
--				BackgroundColor3 = Color3.new(0, 0, 0), -- Black background for quantity
--				TextColor3 = Color3.new(1, 1, 1), -- White text
--				TextSize = 14,
--			}),
--		})
--	end

--	return Roact.createElement("Frame", {
--		Size = UDim2.new(1, 0, 0, 50),
--		Position = UDim2.new(0, 0, 1, -50),
--		AnchorPoint = Vector2.new(0, 1),
--		BackgroundTransparency = 1, -- Transparent background
--	}, slots)
--end

--local playerGui = game.Players.LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
--local screenGui = Instance.new("ScreenGui")
--screenGui.Parent = playerGui

--local app = Roact.createElement(FoodDisplay) -- Removed unnecessary props as they're not used
--Roact.mount(app, screenGui, "FoodDisplay")

----------------------
