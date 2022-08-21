local defaultIcon = 0xFF
local defaultName = "Unknown"
local defaultDesc = "No effect"
local defaultTier = "Error"

-- last used altar cache
LastImbuingPosCache = {}

-- quick and easy to access list of products that are being used in imbuing
ImbuingProducts = {}
for _, imbuData in pairs(ImbuingTypes) do
	if imbuData.tiers then
		for _, tierData in pairs(imbuData.tiers) do
			for itemId, _ in pairs(tierData.products) do
				if not table.contains(ImbuingProducts, itemId) then
					ImbuingProducts[#ImbuingProducts + 1] = itemId
				end
			end
		end
	end
end

function NetworkMessage:addImbuementInfo(imbuId, tier, currentDuration)
	local icon = defaultIcon
	local name = defaultName
	local description = defaultDesc
	local tierName = defaultTier
	local neededItems = {}
	
	local imbuData = ImbuingTypes[imbuId]
	
	if imbuData and imbuData.tiers then
	
		local tierData = imbuData.tiers[tier]
		
		icon = tierData and tierData.icon or icon
		name = imbuData.tag or name
		description = imbuData.description or "missing description"
		
		-- format desc
		if tierData then
			if tierData.chance then
				if tierData.amount then
					description = string.format(description, tierData.amount, tierData.chance)
				else
					description = string.format(description, tierData.chance)
				end
			elseif tierData.amount then
				description = string.format(description, tierData.amount)
			end
			
			for itemId, count in pairs(tierData.products) do
				local itemType = ItemType(itemId)
				local clientId = itemType and itemType:getClientId() or 100
				local name = string.format("%d %s", count, itemType and itemType:getPluralName() or "(error)")
				neededItems[#neededItems + 1] = {clientId, name, count}
			end
		end
	end
	
	local tierMeta = getImbuingTierById(tier)
	local imbuDuration = math.max(currentDuration ~= -1 and tierMeta.duration or 1, currentDuration)
	
	-- add data to the packet
	self:addU32(icon)
	self:addString(string.format("%s %s", tierMeta.name, imbuData and imbuData.name or "Untitled"))
	self:addString(description)
	self:addString(imbuData.tag or "")
	self:addU16(icon)
	self:addU32(imbuDuration) -- max duration
	self:addByte(0x00) -- isPremium
	
	self:addByte(#neededItems) -- items to build	
	for _, itemData in pairs(neededItems) do
		self:addU16(itemData[1]) -- clientId
		self:addString(itemData[2]) -- name
		self:addU16(itemData[3]) -- count
	end
	
	self:addU32(tierMeta.price) -- price
	self:addByte(tierMeta.successChance) -- baseChance
	self:addU32(tierMeta.protectionCost) -- protection cost
end


function NetworkMessage:addImbuables(item)
	local imbuTypes, imbuCount = item:getAvailableImbuements()
	
	self:addU16(imbuCount) -- buffs count
	
	for imbuId, tierMap in pairs(imbuTypes) do
		local imbuData = ImbuingTypes[imbuId]
		for tierId, tierData in pairs(imbuData.tiers) do
			if bit.band(tierMap, 2^tierId-1) ~= 0 then
				self:addImbuementInfo(imbuId, tierId, 0)
			end
		end
	end
end

function Player:sendImbuingUI(item, altarId)
	-- check if item has imbuing slots
	local slotCount = item:getSocketCount()
	if slotCount == 0 then
		self:sendCancelMessage("This item is not imbuable.")
		return
	end

	local imbuCache = self:getPosition()
	imbuCache.altar = altarId
	LastImbuingPosCache[self:getId()] = imbuCache

	local imbuements = item:getImbuements()
	slotCount = math.max(item:getSocketCount(), #imbuements)

	local products = {}
	local productsSize = 0
	for i = 1, #ImbuingProducts do
		local itemId = ImbuingProducts[i]
		local count = self:getItemCount(itemId)
		if count > 0 then
			products[itemId] = count
			productsSize = productsSize + 1
		end
	end
	
	-- build the packet
	local msg = NetworkMessage()
	msg:addByte(0xEB) -- header
	
	-- selected item
	msg:addU16(item:getClientId())
	if item:getType():getClassification() > 0 then
		msg:addByte(item:getTier())
	end

	-- item sockets
	msg:addByte(slotCount)
	for i = 1, slotCount do
		local imbuement = imbuements[i]
		if imbuement then
			local imbuId = tonumber(imbuement[1])
			if imbuId > 0 then
				local tier = tonumber(imbuement[2])
				local currentDuration = tonumber(imbuement[3])
			
				msg:addByte(0x01)
				msg:addImbuementInfo(imbuId, tier, currentDuration)
				msg:addU32(currentDuration ~= -1 and currentDuration * 60 or 1) -- current duration
				msg:addU32(getImbuingTierById(tier).removeCost) -- remove cost
			else
				-- slot occupied by IMBUEMENT_NONE
				-- (situation when slot 1 is empty, but slot 2 still has active buff)
				msg:addByte(0x00)
			end
		else
			-- slot not declared
			msg:addByte(0x00)
		end
	end

	-- available buffs
	msg:addImbuables(item)
	
	-- available products
	msg:addU32(productsSize)
	for itemId, count in pairs(products) do
		local itemType = ItemType(itemId)
		msg:addU16(itemType and itemType:getClientId() or 100)
		msg:addU16(math.min(count, 0xFFFF))
	end
	
	msg:sendToPlayer(self)
	self:sendResourceBalance(RESOURCE_BANK_BALANCE, self:getBankBalance())
	self:sendResourceBalance(RESOURCE_GOLD_EQUIPPED, self:getMoney())
end

local altars = {
	-- regular
	27716, 27717,

	-- wrappable
	27830, 27831,

	-- wrappable (gilded)
	27838, 27839
}

local altar = Action()
function altar.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target and target:isItem() then
		player:sendImbuingUI(target, item:getId())
		return true
	end
	
	return false
end

for i = 1, #altars do
	altar:id(altars[i])
end
altar:register()
