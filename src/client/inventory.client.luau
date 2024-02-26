print("Hello world, from client - Inventory!")
-- local playerGui = game.Players.LocalPlayer.WaitForChild("PlayerGui")
-- local Roact = require(game.ReplicatedStorage.Roact)

-- local InventoryComponent = Roact.Component:extend("InventoryComponent")

-- function Interface(props)

-- function InventoryComponent:init()
--     self.state = {
--         items = {}, -- Initial inventory items
--     }
-- end

-- function InventoryComponent:render()
--     local itemList = {}
--     for i, item in ipairs(self.state.items) do
--         table.insert(itemList, Roact.createElement("TextLabel", {
--             Text = item.name,
--             Size = UDim2.new(0, 100, 0, 50),
--             Position = UDim2.new(0, 0, 0, i * 50), -- Simple vertical list
--         }))
--     end

--     return Roact.createElement("Frame", {
--         Size = UDim2.new(0, 100, 0, #self.state.items * 50),
--         -- Additional styling here
--     }, itemList)
-- end
