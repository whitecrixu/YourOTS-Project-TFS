local ships = {
	-- from main to island
	[7002] = Position(188, 150, 7),
	
	-- from island to main
	[7003] = Position(236, 126, 7)
}

local wheel = Action()

function wheel.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local dest = ships[item.actionid]
   	if dest then
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(dest)
		dest:sendMagicEffect(CONST_ME_TELEPORT)
		return true
   	end

	return false
end

wheel:id(1280)
wheel:register()
