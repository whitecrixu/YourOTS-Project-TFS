local levers = {
	[7005] = {
		-- lever states
		stateOff = 1945,
		stateOn = 1946,
		
		-- walls to create/remove
		walls = {
			-- wall id, wall pos, relocate items/creatures pos, remove effect, place effect
			{
				id = 1052,
				wallPos = Position(1496, 1488, 5),
				relocatePos = Position(1496, 1489, 5),
				removeEffect = CONST_ME_POFF,
				placeEffect = CONST_ME_POFF
			},
			{
				id = 1052,
				wallPos = Position(1497, 1488, 5),
				relocatePos = Position(1497, 1489, 5),
				removeEffect = CONST_ME_POFF,
				placeEffect = CONST_ME_POFF
			},
		},
		
		-- levers to toggle
		levers = {7005, 7006}, -- transform these levers on toggle
	},
	[7007] = {
		stateOff = 1945,
		stateOn = 1946,
		walls = {
			{
				id = 1498,
				wallPos = Position(1021, 1070, 8),
				relocatePos = Position(1008, 1066, 8),
				removeEffect = CONST_ME_POFF,
				placeEffect = CONST_ME_POFF
			},
			{
				id = 1498,
				wallPos = Position(1022, 1070, 8),
				relocatePos = Position(1008, 1066, 8),
				removeEffect = CONST_ME_POFF,
				placeEffect = CONST_ME_POFF
			},
		},
	},
	[7008] = {
		stateOff = 1945,
		stateOn = 1946,
		walls = {
			{
				id = 1498,
				wallPos = Position(1023, 1070, 8),
				relocatePos = Position(1008, 1066, 8),
				removeEffect = CONST_ME_POFF,
				placeEffect = CONST_ME_POFF
			},
			{
				id = 1498,
				wallPos = Position(1024, 1070, 8),
				relocatePos = Position(1008, 1066, 8),
				removeEffect = CONST_ME_POFF,
				placeEffect = CONST_ME_POFF
			},
		},
	},
}

-- copy 7005 behaviour
levers[7006] = levers[7005]

local leverAction = Action()
function leverAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local leverInfo = levers[item.uid]
	if not leverInfo then
		return false
	end
	
	local leverState = item:getId()
	if leverState == leverInfo.stateOff then
		-- open gate
		
		-- transform all levers
		if leverInfo.levers then
			for _, uid in pairs(leverInfo.levers) do
				local otherLever = Item(uid)
				if otherLever then
					otherLever:transform(leverInfo.stateOn)
				end
			end
		else
			item:transform(leverInfo.stateOn)
		end
		
		-- remove all walls
		for _, wallData in pairs(leverInfo.walls) do
			local wall = Tile(wallData.wallPos):getItemById(wallData.id)
			if wall then
				wall:remove()
				wallData.wallPos:sendMagicEffect(wallData.removeEffect)
			end
		end
		
		return true
	elseif leverState == leverInfo.stateOn then
		-- close gate
		
		-- transform all levers
		if leverInfo.levers then
			for _, uid in pairs(leverInfo.levers) do
				local otherLever = Item(uid)
				if otherLever then
					otherLever:transform(leverInfo.stateOff)
				end
			end
		else
			item:transform(leverInfo.stateOff)
		end
		
		-- place all walls, relocate everything
		for _, wallData in pairs(leverInfo.walls) do
			local wall = Tile(wallData.wallPos):getItemById(wallData.id)
			if not wall then
				doRelocate(wallData.wallPos, wallData.relocatePos, true, true, true)
				Game.createItem(wallData.id, 1, wallData.wallPos)
				wallData.wallPos:sendMagicEffect(wallData.placeEffect)
			end
		end

		return true
	end

	return false
end

for uid, _ in pairs(levers) do
	leverAction:uid(uid)
end
leverAction:register()
