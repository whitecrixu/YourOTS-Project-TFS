function Player:sendItemInspection(item, descriptions, openCyclopedia, isVirtual)
	local response = NetworkMessage()
	response:addByte(0x76)
	response:addByte(0x00) -- responseType 0x00 = ok
	response:addByte(openCyclopedia and 0x01 or 0x00)
	response:addByte(0x01) --?
	
	if tonumber(item) then
		local itemType = ItemType(item)
		if not itemType then
			self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
			return
		end
		
		response:addString(
			string.format("%s", itemType:getNameDescription(nil, true))
		)
		
		response:addItemType(itemType)
		item = itemType
	else
		response:addString(
			string.format("%s", item:getNameDescription(item:getSubType(), true))
		)

		response:addItem(item)
	end

	-- imbuements count (5 max, 6th gets cut in view window)
	-- structure: u16 imbuement icon id
	if ImbuingSystem then
		response:addImbuements(item, isVirtual)
	else
		response:addByte(0)
	end

	-- fields count
	-- structure:
	-- string key
	-- string value
	if descriptions and #descriptions > 0 then
		response:addByte(#descriptions)
		
		-- structure:
		-- descriptions = {{"Name", "Test item"}, {"Weight", "3.10 oz"}}
		for i = 1, #descriptions do
			response:addString(descriptions[i][1])
			response:addString(descriptions[i][2])
		end
	else
		response:addByte(0)
	end
	
	response:sendToPlayer(self)
end

local showAtkWeaponTypes = {WEAPON_FIST, WEAPON_CLUB, WEAPON_SWORD, WEAPON_AXE, WEAPON_DISTANCE}
local showDefWeaponTypes = {WEAPON_FIST, WEAPON_CLUB, WEAPON_SWORD, WEAPON_AXE, WEAPON_DISTANCE, WEAPON_SHIELD}

-- Item, itemType or item id
function getItemDetails(item)
	local isVirtual = false
	local itemType
	
	if tonumber(item) then
		-- number in function argument
		-- pull data from itemType instead
		isVirtual = true
		itemType = ItemType(item)
		if not itemType then
			return
		end
		
		-- polymorphism for item attributes (atk, def, etc)
		item = itemType
	elseif item:isItemType() then
		isVirtual = true
		itemType = item
	else
		itemType = item:getType()
	end
	
	local descriptions = {}
	
	-- container capacity
	local isContainer = itemType:isContainer()
	if isContainer then
		descriptions[#descriptions + 1] = {"Capacity", itemType:getCapacity()}
	end
	
	-- key
	if not isVirtual and itemType:isKey() then
		descriptions[#descriptions + 1] = {"Key", string.format("%0.4d", item:getActionId())}
	end

	-- description
	local desc = itemType:getDescription()
	if not isVirtual and item:hasAttribute(ITEM_ATTRIBUTE_DESCRIPTION) then
		desc = item:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION)
	end
	
	if desc and #desc > 0 then
		descriptions[#descriptions + 1] = {"Description", desc}
	end
	
	-- read weapon type
	local weaponType = itemType:getWeaponType()
	local ammoType = itemType:getAmmoType()
	
	-- atk
	local showAtk = table.contains(showAtkWeaponTypes, weaponType)
	if showAtk then
		local atk = item:getAttack()
		if itemType:isBow() then
			local atkAttrs = {}
			if atk ~= 0 then
				atkAttrs[#atkAttrs + 1] = string.format("attack %+d", atk)
			end
			
			local hitChance = item:getHitChance()
			if hitChance ~= 0 then
				atkAttrs[#atkAttrs + 1] = string.format("chance to hit %+d%%", hitChance)
			end
			
			atkAttrs[#atkAttrs + 1] = string.format("%d fields", item:getShootRange())
			descriptions[#descriptions + 1] = {"Attack", table.concat(atkAttrs, ", ")}
		else
			descriptions[#descriptions + 1] = {"Attack", atk}
		end
	end
	
	-- bonus element
	local elementDmg = itemType:getElementDamage()
	if elementDmg and elementDmg ~= 0 then
		descriptions[#descriptions][2] = string.format("%d %+d %s", descriptions[#descriptions][2], elementDmg, getCombatName(itemType:getElementType()))
	end
	
	-- atk speed
	local atkSpeed = item:getAttackSpeed()
	if atkSpeed ~= 0 then
		descriptions[#descriptions + 1] = {"Attack Speed", string.format("%0.2f/turn", 2000 / atkSpeed)}
	end
	
	-- def
	-- note: "defence" is actual spelling, it is a correct form in British English
	local showDef = table.contains(showDefWeaponTypes, weaponType)
	if showDef then
		local def = item:getDefense()
		if weaponType == WEAPON_DISTANCE then
			-- throwables
			if ammoType ~= AMMO_ARROW and ammoType ~= AMMO_BOLT then
				descriptions[#descriptions + 1] = {"Defence", def}
			end
		else
			descriptions[#descriptions + 1] = {"Defence", def}
		end
	end
	
	-- extra def
	local xD = item:getExtraDefense()
	if xD ~= 0 then
		descriptions[#descriptions][2] = string.format("%d %+d", descriptions[#descriptions][2], xD)
	end
	
	-- armor
	local arm = item:getArmor()
	if arm > 0 then
		descriptions[#descriptions + 1] = {"Armor", arm}
	end

	local abilities = itemType:getAbilities()
	
	-- protection
	local protections = {}
	for element, value in pairs(abilities.absorbPercent) do
		if value ~= 0 then
			protections[#protections + 1] = string.format("%s %+d%%", getCombatName(2^(element-1)), value)
		end
	end
	
	if #protections > 0 then
		descriptions[#descriptions + 1] = {"Protection", table.concat(protections, ", ")}
	end
	protections = nil
	
	-- skill boost
	local skillBoosts = {}
	
	-- regeneration
	if abilities.manaGain > 0 or abilities.healthGain > 0 or abilities.regeneration then
		skillBoosts[#skillBoosts + 1] = "faster regeneration"
	end
	
	-- invisibility
	if abilities.invisible then
		skillBoosts[#skillBoosts + 1] = "invisibility"
	end

	-- magic shield (classic)
	if abilities.manaShield then
		skillBoosts[#skillBoosts + 1] = "magic shield"
	end
	
	-- stats (hp/mp/soul/ml/cap)
	for stat, value in pairs(abilities.stats) do
		if value ~= 0 then
			if stat ~= STAT_CAPACITY+1 then
				skillBoosts[#skillBoosts + 1] = string.format("%s %+d", getStatName(stat-1), value)
			else
				skillBoosts[#skillBoosts + 1] = string.format("%s %+d", getStatName(stat-1), value/100)			
			end
		end
	end
	
	-- stats but in %
	for stat, value in pairs(abilities.statsPercent) do
		if value ~= 0 then
			skillBoosts[#skillBoosts + 1] = string.format("%s %+d%%", getStatName(stat-1), value - 100)
		end
	end
	
	-- speed
	if abilities.speed ~= 0 then
		skillBoosts[#skillBoosts + 1] = string.format("speed %+d", math.floor(abilities.speed / 2))
	end

	-- skills
	for skill, value in pairs(abilities.skills) do
		if value ~= 0 then
			skillBoosts[#skillBoosts + 1] = string.format("%s %+d", getSkillName(skill-1), value)
		end
	end
	
	-- element magic level
	for element, value in pairs(abilities.specialMagicLevel) do
		if value ~= 0 then
			skillBoosts[#skillBoosts + 1] = string.format("%s magic level %+d", getCombatName(2^(element-1)), value)
		end
	end
	
	-- special skills
	for skill, value in pairs(abilities.specialSkills) do
		if value ~= 0 then
			-- add + symbol to special skill "amount" fields
			if skill-1 < 6 and skill % 2 == 1 then
				value = string.format("%+d", value)
			elseif skill-1 >= 6 then
				-- fatal, dodge, momentum coming from the item natively
				-- (stats coming from tier are near tier info)
				value = string.format("%0.2f", value/100)
			end
			
			skillBoosts[#skillBoosts + 1] = string.format("%s %s%%", getSpecialSkillName(skill-1), value)
		end
	end
	
	if #skillBoosts > 0 then
		descriptions[#descriptions + 1] = {"Skill Boost", table.concat(skillBoosts, ", ")}
	end
	skillBoosts = nil
	
	-- damage boost
	do
		local boostInfo = item:getAllBoosts()
		local boosts = {}
		
		local allElements = true
		local identicalValue = true
		local currentValue = -1

		for combatId, boost in pairs(boostInfo) do
			if boost > 0 then
				boosts[#boosts + 1] = {element = getCombatName(2^(combatId-1)), percent = boost}
			else
				allElements = false
			end
		end
		
		if #boosts > 0 then
			local boostResponse = ""
			
			if allElements and identicalValue then
				-- all elements identical value
				-- display short info
				boostResponse = string.format("damage and healing %+d%%", boosts[1].percent)

			else
				-- incomplete elements list/different values
				-- display full info
				local boostValues = {}
				for i = 1, #boosts do
					boostValues[#boostValues + 1] = string.format("%s %+d%%", boosts[i].element, boosts[i].percent)
				end
				
				boostResponse = table.concat(boostValues, ", ")
			end
												
			descriptions[#descriptions + 1] = {"Damage Boost", boostResponse}
		end
	end
	
	-- damage reflection
	do
		local reflectInfo = item:getAllReflects()
		local reflects = {}
		
		local allElements = true
												
		local identicalChance = true
		local currentChance = -1
												
		for combatId, reflect in pairs(reflectInfo) do
			if reflect.chance > 0 and reflect.percent > 0 then
				reflects[#reflects + 1] = {element = getCombatName(2^(combatId-1)), percent = reflect.percent, chance = reflect.chance}
				
				if currentChance == -1 then
					currentChance = reflect.chance
				elseif currentChance ~= reflect.chance then
					identicalChance = false
				end
			else
				allElements = false
			end
		end
		
		if #reflects > 0 then
			local reflectResponse = ""
			
			if allElements and identicalChance then
				-- chance and amount are identical
				-- display single values for chance and amount
				local chanceInfo = reflects[1].chance ~= 100 and string.format(" (%d%% chance)", reflects[1].chance) or ""
				reflectResponse = string.format("%+d%%%s", reflects[1].percent, chanceInfo)
				
			elseif identicalChance then
				-- incomplete elements list (chances still identical)
				-- display single value for chance only
				local reflectValues = {}
				for i = 1, #reflects do
					reflectValues[#reflectValues + 1] = string.format("%s %+d%%", reflects[i].element, reflects[i].percent)
				end
				
				local chanceInfo = reflects[1].chance ~= 100 and string.format(" (%d%% chance)", reflects[1].chance) or ""
				reflectResponse = string.format("%s%s", table.concat(reflectValues, ", "), chanceInfo)
			else
				-- chances or amounts are different
				-- display full info
				local reflectValues = {}
				for i = 1, #reflects do
					reflectValues[#reflectValues + 1] = string.format("%s %+d%% (%d%% chance)", reflects[i].element, reflects[i].percent, reflects[i].chance)
				end
				
				reflectResponse = table.concat(reflectValues, ", ")
			end
												
			descriptions[#descriptions + 1] = {"Damage Reflection", reflectResponse}
		end
	end
	
	-- item classification (will be reused later)
	local classification = itemType:getClassification()
	
	-- tier
	local tier = 0
	if not isVirtual then
		tier = item:getTier() or 0
		if classification > 0 or tier > 0 then
			local tierString = tier
			if tier > 0 then
				local bonusType, bonusValue = itemType:getTierBonus(tier)
				if bonusType ~= -1 then
					if bonusType > 5 then
						tierString = string.format("%d (%0.2f%% %s)", tier, bonusValue, getSpecialSkillName(bonusType))
					else
						tierString = string.format("%d (%d%% %s)", tier, bonusValue, getSpecialSkillName(bonusType))
					end
				end
			end
			
			descriptions[#descriptions + 1] = {"Tier", tierString}
		end
	end

	-- imbuements
	if ImbuingSystem then
		for _, imbuement in pairs(getInspectImbuements(item, isVirtual)) do
			descriptions[#descriptions + 1] = imbuement
		end
	end
		
	-- spell
	local spellName = itemType:getRuneSpellName()
	if spellName then
		descriptions[#descriptions + 1] = {"Rune", spellName}
	end
	
	-- charges
	if itemType:hasShowCharges() then
		if isVirtual then
			descriptions[#descriptions + 1] = {"Total Charges", itemType:getCharges()}
		else
			descriptions[#descriptions + 1] = {"Charges", string.format("%d/%d", item:getCharges(), itemType:getCharges())}
		end
	end
	
	-- expires
	if itemType:hasShowDuration() then
		local duration = item:getDuration()
		if isVirtual then
			if duration == 0 then
				local transferType = itemType:getTransformEquipId()
				if transferType ~= 0 then
					transferType = ItemType(transferType)
					duration = transferType and transferType:getDuration() or duration
				end
			end
		
			descriptions[#descriptions + 1] = {"Total Expire Time", (duration ~= 0 and Game.getCountdownString(duration, false, true) or "unknown")}
		else
			if duration == 0 then
				local transferType = itemType:getTransformEquipId()
				
				-- magic light wand (exception)
				if itemType:getId() == 2162 then
					transferType = 2163
				end
			
				if transferType ~= 0 then
					transferType = ItemType(transferType)
					duration = transferType and transferType:getDuration() * 1000 or duration
				end
			end
			
			descriptions[#descriptions + 1] = {"Expires", duration ~= 0 and Game.getCountdownString(math.floor(duration/1000), false, true)}
		end		
	end
	
	-- weight
	if itemType:isMovable() and itemType:isPickupable() then
		local itemWeight = item:getWeight()
		local typeWeight = itemType:getWeight()
		
		descriptions[#descriptions + 1] = {
			-- key
			(itemWeight == typeWeight and "Weight" or "Total Weight"),
			-- value
			string.format("%0.2f oz", itemWeight/100)
		}
	end
	
	-- level
	local minLevel = itemType:getMinReqLevel()
	if minLevel and minLevel > 0 then
		descriptions[#descriptions + 1] = {"Required Level", minLevel}
	end
	
	-- magic level
	local minMagicLevel = itemType:getMinReqMagicLevel()
	if minMagicLevel and minMagicLevel > 0 then
		descriptions[#descriptions + 1] = {"Required Magic Level", minMagicLevel}
	end
	
	-- vocation
	local vocations = itemType:getVocationString()
	if vocations and vocations:len() > 0 then
		descriptions[#descriptions + 1] = {"Professions", vocations}
	end
	
	-- weapon type
	local isTwoHanded = itemType:isTwoHanded()
	local isWeapon = itemType:isWeapon()
	if isWeapon then	
		descriptions[#descriptions + 1] = {"Weapon Type", itemType:getWeaponString()}
	end
	
	-- tradeable
	local tradeable = not item:isStoreItem()
	if not isVirtual then
		descriptions[#descriptions + 1] = {"Tradeable", tradeable and "yes" or "no"}	
	end

	tradeable = tradeable and itemType:getWareId() ~= 0
	if isVirtual then
		-- store item or wareId == 0
		descriptions[#descriptions + 1] = {"Tradeable In Market", tradeable and "yes" or "no"}
	else
		-- item with edited attributes
		tradeable = tradeable and item:isMarketable()
		if not tradeable and not isContainer then
			descriptions[#descriptions + 1] = {"Tradeable In Market", "no"}
		end
	end
	
	-- slot
	local bodyPosition
	if isTwoHanded then
		bodyPosition = "both hands"
	elseif isContainer then
		bodyPosition = "container"
	elseif weaponType == WEAPON_SHIELD then -- or quiver
		bodyPosition = "shield hand"
	elseif isWeapon then
		bodyPosition = "weapon hand"
	elseif itemType:isHelmet() then
		bodyPosition = "head"
	elseif itemType:isNecklace() then
		bodyPosition = "neck"
	elseif itemType:isArmor() then
		bodyPosition = "body"
	elseif itemType:isLegs() then
		bodyPosition = "legs"
	elseif itemType:isBoots() then
		bodyPosition = "feet"
	elseif itemType:isRing() then
		bodyPosition = "finger"
	elseif itemType:isTrinket() then
		bodyPosition = "extra slot"
	end
	
	if bodyPosition then
		descriptions[#descriptions + 1] = {"Body Position", bodyPosition}
	end

	if classification > 0 or tier > 0 then
		if classification == 0 then
			classification = "other"
		end

		descriptions[#descriptions + 1] = {"Classification", classification}
	end

	return descriptions
end

local onInspectItem = function(self, item)
	local descriptions = getItemDetails(item)
	
	if self:getGroup():getAccess() then
		descriptions[#descriptions + 1] = {"Server ID", item:getId()}
		descriptions[#descriptions + 1] = {"Client ID", item:getType():getClientId()}
	end
	
	self:sendItemInspection(item, descriptions, false, false)
end

local onInspectTradeItem = function(self, tradePartner, item)
	local descriptions = getItemDetails(item)

	if self:getGroup():getAccess() then
		descriptions[#descriptions + 1] = {"Server ID", item:getId()}
		descriptions[#descriptions + 1] = {"Client ID", item:getType():getClientId()}
	end

	self:sendItemInspection(item, descriptions, false, false)
end

local onInspectNpcTradeItem = function(self, npc, itemId)
	local descriptions = getItemDetails(itemId)

	if self:getGroup():getAccess() then
		descriptions[#descriptions + 1] = {"Server ID", itemId}
		descriptions[#descriptions + 1] = {"Client ID", ItemType(itemId):getClientId()}
	end

	self:sendItemInspection(itemId, descriptions, false, true)
end

local onInspectCyclopediaItem = function(self, itemId)
	local descriptions = getItemDetails(itemId)

	if self:getGroup():getAccess() then
		descriptions[#descriptions + 1] = {"Server ID", itemId}
		descriptions[#descriptions + 1] = {"Client ID", ItemType(itemId):getClientId()}
	end

	self:sendItemInspection(itemId, descriptions, true, true)
end

local callbacks = {
	["onInspectItem"] = onInspectItem,
	["onInspectTradeItem"] = onInspectTradeItem,
	["onInspectNpcTradeItem"] = onInspectNpcTradeItem,
	["onInspectCyclopediaItem"] = onInspectCyclopediaItem
}

for callName, callback in pairs(callbacks) do
	local ec = EventCallback
	ec[callName] = callback
	ec:register()
end