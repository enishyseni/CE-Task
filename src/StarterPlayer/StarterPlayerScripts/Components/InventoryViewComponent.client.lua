---- FoodDisplay.lua
--local Roact = require(game.ReplicatedStorage.Roact)
--local RoactRodux = require(game.ReplicatedStorage.RoactRodux)
--local Actions = require(game.StarterPlayer.StarterPlayerScripts.Rodux.Actions)
--local FoodDisplay = Roact.Component:extend("FoodDisplay")

---- No need to initialize 'itemsReactive' in 'init' since it will come from the store

--function FoodDisplay:render()
--	local itemData = self.props.items
--	local slots = {}
--	local itemData = self.state.itemsReactive
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

--local function mapStateToProps(state)
--	return {
--		items = state
--	}
--end

--local function mapDispatchToProps(dispatch)
--	return {
--		onAddItem = function(itemType)
--			dispatch(Actions.addItemQuantity(itemType, 1))
--		end,
--		onRemoveItem = function(itemType)
--			dispatch(Actions.removeItemQuantity(itemType, 1))
--		end,
--	}
--end

--FoodDisplay = RoactRodux.connect(mapStateToProps, mapDispatchToProps)(FoodDisplay)

--return FoodDisplay





























----print("Hello world, from client - Inventory!")
----local Roact = require(game.ReplicatedStorage.Roact)
----local ReplicatedStorage = game:GetService("ReplicatedStorage")
----local RoactRodux = require(game.ReplicatedStorage.RoactRodux)
----local InventoryChangedEvent = ReplicatedStorage:WaitForChild("InventoryChangedEvent")

----local Rodux = require(game.ReplicatedStorage.Rodux)
----local ItemsReducer = require(game.StarterPlayer.StarterPlayerScripts.Rodux.ItemsReducer)
----local Actions = require(game.StarterPlayer.StarterPlayerScripts.Rodux.Actions)

----local store = Rodux.Store.new(ItemsReducer)

----local FoodDisplay = Roact.Component:extend("FoodDisplay")

----local items = {
----	{ itemtype = "Burger", image = "rbxassetid://12462657942", quantity = 0 },
----	{ itemtype = "Salad", image = "rbxassetid://13743491406", quantity = 0 },
----	{ itemtype = "Candy", image = "rbxassetid://119966532", quantity = 0 },
----	{ itemtype = "Supplement", image = "rbxassetid://366897011", quantity = 0 },
----}

----function FoodDisplay:init()
----	self:setState({
----		itemsReactive = items
----	})

----	InventoryChangedEvent.OnClientEvent:Connect(function(operation, itemType, quantity)
----		print(operation .. "-" .. itemType .. "-" .. quantity)

----		if operation == "add" then
----			--FoodDisplay.updateQuantity(operation, operation, itemType)
----			store:dispatch(Actions.addItemQuantity(itemType, 1))
----		end
----		if operation == "remove" then
----			--FoodDisplay.updateQuantity(operation, operation, itemType)
----			store:dispatch(Actions.removeItemQuantity(itemType, 1))
----		end

----	end)
----end

----function FoodDisplay:updateQuantity(operation, itemType)
----	print("operation: " .. operation)
----	print("itemTypeToUpdate: " .. itemType)
----	print(items)
----	print(itemType .. "-|-" .. operation)
----	for i, item in ipairs(items) do
----		if item.itemtype == itemType then
----			if operation == "add" then
----				item.quantity = math.max(0, item.quantity + 1) -- Ensure quantity does not go below zero
----			end
----			if operation == "remove" then
----				item.quantity = math.max(0, item.quantity - 1) -- Ensure quantity does not go below zero
----			end
----			break -- Exit the loop once the item is found and updated
----		end
----	end

----	self:setState({
----		itemsReactive = items
----	})
----end

----function FoodDisplay:render()
----	local itemData = self.state.itemsReactive
----	local slots = {}
----	for i = 1, 4 do
----		slots["Slot" .. i] = Roact.createElement("Frame", {
----			Size = UDim2.new(0, 50, 0, 50),
----			Position = UDim2.new((i-1) * 0.1, 400, 1, -10), -- Position slots at the bottom
----			--BackgroundColor3 = self.state.foodItems[i] and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255),
----			--BorderSizePixel = 2,
----		}, {
----			Image = Roact.createElement("ImageLabel", {
----				Size = UDim2.new(1, 0, 1, 0), -- Full size of the parent frame
----				Image = itemData[i].image, -- Image representing the item
----				BackgroundTransparency = 1,
----			}),
----			Quantity = Roact.createElement("TextLabel", {
----				Position = UDim2.new(1, 0, 0, 0), -- Positioned in the top-right corner
----				Size = UDim2.new(0, 20, 0, 20), -- Small size for the quantity
----				Text = tostring(itemData[i].quantity),
----				BackgroundColor3 = Color3.new(0, 0, 0), -- Black background for quantity
----				TextColor3 = Color3.new(1, 1, 1), -- White text
----				TextSize = 14,
----			}),
----		})
----	end

----	return Roact.createElement("Frame", {
----		Size = UDim2.new(1, 0, 0, 50),
----		Position = UDim2.new(0, 0, 1, -50),
----		AnchorPoint = Vector2.new(0, 1),
----		BackgroundTransparency = 1, -- Transparent background
----	}, slots)
----end

----local playerGui = game.Players.LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
----local screenGui = Instance.new("ScreenGui")
----screenGui.Parent = playerGui

----local app = Roact.createElement(FoodDisplay, { itemsReactive = items })
----Roact.mount(app, screenGui, "FoodDisplay")