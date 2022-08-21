local playerPosition = {
	{x = 191, y = 118, z = 9},
	{x = 192, y = 118, z = 9},
	{x = 193, y = 118, z = 9},
	{x = 194, y = 118, z = 9}
}
local newPosition = {
	{x = 190, y = 118, z = 10},
	{x = 191, y = 118, z = 10},
	{x = 192, y = 118, z = 10},
	{x = 193, y = 118, z = 10}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 1945 then
		local players = {}
		for _, position in ipairs(playerPosition) do
			local topPlayer = Tile(position):getTopCreature()
			if not topPlayer or not topPlayer:isPlayer() or topPlayer:getLevel() < 100 or topPlayer:getStorageValue(PlayerStorageKeys.annihilatorReward) ~= -1 then
				player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
				return false
			end
			players[#players + 1] = topPlayer
		end

		for i, targetPlayer in ipairs(players) do
			Position(playerPosition[i]):sendMagicEffect(CONST_ME_POFF)
			targetPlayer:teleportTo(newPosition[i], false)
			targetPlayer:getPosition():sendMagicEffect(CONST_ME_ENERGYAREA)
		end
		item:transform(1946)
	elseif item.itemid == 1946 then
		player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
	end
	return true
end
