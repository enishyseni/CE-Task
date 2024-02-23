# CE-Task

I recommend getting the following tools and familiarizing yourself with them so that you'd be ready:

- Roblox Studio
- Rojo (a tool that allows you to sync a filesystem into Roblox Studio). There is a plugin for both Roblox Studio and VSCode (if that's the editor of your choice)
- Familiarize yourself with Lua & Roblox's API (check out their documentation site)

## Project Details:

1. Create a simple game utilizing Roact and Rodux (two popular open source libraries. Links below) that requires the player to gather food to feed themselves.

2. Different types of food should randomly spawn on the map, and the player should be able to walk up to a piece of food and press a key to add it to their inventory.

3. The inventory should be a simple row on the bottom of the screen, with each icon showing the food type and the number of that type of food the player has.

4. The food should be able to be equipped and unequipped. Pressing a key should make the player consume the equipped food, causing it to be removed from their inventory.

5. The player should have a Hunger meter that depletes over time, and consuming food replenishes it. If the meter reaches empty, the player dies, and their inventory is emptied and the food is cleared from the map.

6. You can use Tool instances to accomplish the equipping and unequipping behavior, but please create an inventory GUI from scratch with Roact.

7. It should not be possible for an exploiter to change their hunger or add items to their inventory.

## Libraries:

#### Roact - https://roblox.github.io/roact/
#### Rodux - https://roblox.github.io/rodux/
