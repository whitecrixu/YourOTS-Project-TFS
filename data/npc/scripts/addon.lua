local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
local topic = {}

function onCreatureAppear(cid)                npcHandler:onCreatureAppear(cid)             end
function onCreatureDisappear(cid)             npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)         npcHandler:onCreatureSay(cid, type, msg)     end
function onThink()                             npcHandler:onThink()                         end

npcHandler:setMessage(MESSAGE_GREET, "Greetings, |PLAYERNAME|. I need your help and I'll reward you with nice {addons} if you {help} me!")

-- male addon components
local itemsMage1 = {{2182, 1}, {2186, 1}, {2185, 1}, {8911, 1}, {2181, 1}, {2183, 1}, {2190, 1}, {2191, 1}, {2188, 1}, {8921, 1}, {2189, 1}, {2187, 1}, {2392, 30}, {5809, 1}, {2193, 20}}
local itemsMage2 = {{5903, 1}}
local itemsSummoner1 = {{5878, 20}}
local itemsSummoner2 = {{5894, 35}, {5911, 20}, {5883, 40}, {5922, 35}, {5879, 10}, {5881, 30}, {5882, 40}, {2392, 3}, {5905, 30}}

addonInfo = {
	['citizen']         = { outfit = {136, 128}, addon1 = {{5878, 20}}, addon2 = {{5890, 50}, {5902, 25}, {2480, 1}} },
	['hunter']          = { outfit = {137, 129}, addon1 = {{5876, 50}, {5948, 50}, {5891, 5}, {5887, 1}, {5889, 1}, {5888, 1}}, addon2 = {{5875, 1}} },
	['mage']            = { outfit = {138, 130}, opposite = {141, 133}, addon1_m = {itemsMage1}, addon2_m = {itemsMage2}, addon1_f = {itemsSummoner1}, addon2_f = {itemsSummoner2} },
	['knight']          = { outfit = {139, 131}, addon1 = {{5880, 50}, {5892, 1}}, addon2 = {{5893, 50}, {11422, 1}, {5885, 1}, {5887, 1}} },
	['nobleman']        = { outfit = {140, 132}, addon1Cost = 300000, addon2Cost = 300000 },
	['summoner']        = { outfit = {141, 133}, opposite = {138, 130}, addon1_m = {itemsSummoner1}, addon2_m = {itemsSummoner2}, addon1_f = {itemsMage1}, addon2_f = {itemsMage2} },
	['warrior']         = { outfit = {142, 134}, addon1 = {{5925, 40}, {5899, 40}, {5884, 1}, {5919, 1}}, addon2 = {{5880, 40}, {5887, 1}} },
	['barbarian']       = { outfit = {147, 143}, addon1 = {{5884, 1}, {5885, 1}, {5910, 25}, {5911, 25}, {5886, 10}}, addon2 = {{5880, 25}, {5892, 1}, {5893, 25}, {5876, 25}} },
	['druid']           = { outfit = {148, 144}, addon1 = {{5896, 20}, {5897, 20}}, addon2 = {{5906, 100}} },
	['wizard']          = { outfit = {149, 145}, addon1 = {{2536, 1}, {2492, 1}, {2488, 1}, {2123, 1}}, addon2 = {{5922, 40}} },
	['oriental']        = { outfit = {150, 146}, addon1 = {{5945, 1}}, addon2 = {{5883, 30}, {5895, 30}, {5891, 2}, {5912, 30}} },
	['pirate']          = { outfit = {155, 151}, addon1 = {{6098, 30}, {6126, 30}, {6097, 30}}, addon2 = {{6101, 1}, {6102, 1}, {6100, 1}, {6099, 1}} },
	['assassin']        = { outfit = {156, 152}, addon1 = {{5912, 20}, {5910, 20}, {5911, 20}, {5913, 20}, {5914, 20}, {5909, 20}, {5886, 10}}, addon2 = {{5804, 1}, {5930, 10}} },
	['beggar']          = { outfit = {157, 153}, addon1 = {{5878, 30}, {5921, 20}, {5913, 10}, {5894, 10}}, addon2 = {{5883, 30}, {2160, 2}} },
	['shaman']          = { outfit = {158, 154}, addon1 = {{5810, 5}, {3955, 5}, {5015, 1}}, addon2 = {{3966, 5}, {3967, 5}} },
	['norseman']        = { outfit = {252, 251}, addon1 = {{7290, 5}}, addon2 = {{7290, 10}} },
	['nightmare']       = { outfit = {269, 268}, addon1 = {{6500, 750}}, addon2 = {{6500, 750}} },
	['jester']          = { outfit = {270, 273}, addon1 = {{5912, 20}, {5913, 20}, {5914, 20}, {5909, 20}}, addon2 = {{5912, 20}, {5910, 20}, {5911, 20}, {5912, 20}} },
	['brotherhood']     = { outfit = {279, 278}, addon1 = {{6500, 750}}, addon2 = {{6500, 750}} },
	['demon hunter']    = { outfit = {288, 289}, addon1 = {{5905, 30}, {5906, 40}, {5954, 20}, {6500, 50}}, addon2 = {{5906, 50}, {6500, 200}} },
	['yalaharian']      = { outfit = {324, 325}, addon1 = {{9955, 1}}, addon2 = {{9955, 1}} },
	['warmaster']       = { outfit = {336, 335}, addon1 = {{11116, 1}}, addon2 = {{11115, 1}} },
	['wayfarer']        = { outfit = {366, 367}, addon1 = {{12657, 1}}, addon2 = {{12656, 1}} },
	['soil guardian']   = { outfit = {366, 367}, unlock = {{18517, 1}}, addon1 = {{18518, 1}}, addon2 = {{18519, 1}} },
	['crystal warlord'] = { outfit = {366, 367}, unlock = {{18520, 1}}, addon1 = {{18521, 1}}, addon2 = {{18522, 1}} },
}

-- add aliases
local addonAlias = {
	['noblewoman'] =  'nobleman',
	['norsewoman'] =  'norseman',
	['noble woman'] = 'nobleman',
	['norse woman'] = 'norseman',
	['demonhunter'] = 'demon hunter',
	['yalahari'] =    'yalaharian',
	['war master'] =  'warmaster',
	['way farer'] =   'wayfarer',
	['soilguardian'] =   'soil guardian',
	['crystalwarlord'] =   'crystal warlord',
}

local topicMain = 0
local topicFirstAddon = 1
local topicSecondAddon = 2
local topicUnlock = 3
local choice

local addonListCache = {}
for _, outfitInfo in pairs(Game.getOutfits(1)) do
	if addonInfo[outfitInfo.name:lower()] then
		addonListCache[#addonListCache + 1] = string.format("{%s}", outfitInfo.name)
	end
end
local addonLast = addonListCache[#addonListCache]
addonListCache[#addonListCache] = nil

local function getVarkhalOffer()
	return string.format("I can offer {first addon} and {second addon} for the following outfits: %s and %s", table.concat(addonListCache, ", "), addonLast)
end

local function getOutfitKeyword(msg)
	for key, _ in pairs(addonInfo) do
		if msgcontains(msg, key) then
			return key
		end
	end
	
	for key, alias in pairs(addonAlias) do
		if msgcontains(msg, key) then
			return alias
		end
	end
	
	return false
end

-- for internal use
local function exists(val)
	return val and #val > 0
end

local function getComponentName(val)
	local itemType = ItemType(val[1])
	if itemType and itemType:getId() ~= 0 then
		local plural = val[2] ~= 1
		local count = plural and string.format("%d ", val[2]) or ""
		local article = itemType:getArticle()
		article = not plural and article ~= "" and string.format("%s ", article) or ""
		local name = plural and itemType:getPluralName() or itemType:getName()
	
		return string.format("%s%s%s", count, article, name)
	end
		
	return string.format("%dx error item", val[2])
end

local function getComponents(key, topic, playerSex)
	local components = {}
	local outfitData = addonInfo[key]

	if topic == topicUnlock then
		local requiredItems = outfitData.unlock
		if exists(requiredItems) then
			for i = 1, #requiredItems do
				components[#components + 1] = getComponentName(requiredItems[i])
			end
		end
	elseif topic == topicFirstAddon then
		local requiredItems = outfitData.addon1
		if exists(requiredItems) then
			for i = 1, #requiredItems do
				components[#components + 1] = getComponentName(requiredItems[i])
			end
		end
		
		if playerSex == PLAYERSEX_MALE then
			requiredItems = outfitData.addon1_m
		else
			requiredItems = outfitData.addon1_f
		end
		
		if exists(requiredItems) then
			for i = 1, #requiredItems do
				components[#components + 1] = getComponentName(requiredItems[i])
			end
		end
		
		if outfitData.addon1Cost then
			components[#components + 1] = string.format("%d gold", outfitData.addon1Cost)
		end
	elseif topic == topicSecondAddon then
		local requiredItems = outfitData.addon2
		if exists(requiredItems) then
			for i = 1, #requiredItems do
				components[#components + 1] = getComponentName(requiredItems[i])
			end
		end
		
		if playerSex == PLAYERSEX_MALE then
			requiredItems = outfitData.addon2_m
		else
			requiredItems = outfitData.addon2_f
		end
		
		if exists(requiredItems) then
			for i = 1, #requiredItems do
				components[#components + 1] = getComponentName(requiredItems[i])
			end
		end
		
		if outfitData.addon2Cost then
			components[#components + 1] = string.format("%d gold", outfitData.addon1Cost)
		end
	end
	
	if #components > 0 then
		if #components == 1 then
			return components[1]
		end
		
		local lastComponent = components[#components]
		components[#components] = nil
		
		return string.format("%s and %s", table.concat(components, ", "), lastComponent)
	end
	
	return "free"
end

local function checkComponentList(player, list)
	if not list then
		return true
	end

	if #list > 0 then
		for i = 1, #list do
			if player:getItemCount(list[i][1]) < list[i][2] then
				return false
			end
		end
	end
			
	return true
end

local function hasComponents(player, key, topic)
	local outfitData = addonInfo[key]
	if not outfitData then
		return false
	end

	if topic == topicUnlock then
		if not checkComponentList(player, outfitData.unlock) then
			return false
		end
	elseif topic == topicFirstAddon then
		local requiredItems = outfitData.addon1
		if not checkComponentList(player, requiredItems) then
			return false
		end
		
		if playerSex == PLAYERSEX_MALE then
			requiredItems = outfitData.addon1_m
		else
			requiredItems = outfitData.addon1_f
		end
		
		if not checkComponentList(player, requiredItems) then
			return false
		end
		
		if outfitData.addon1Cost then
			if player:getTotalMoney() < outfitData.addon1Cost then
				return false
			end
		end
	elseif topic == topicSecondAddon then
		local requiredItems = outfitData.addon2
		if not checkComponentList(player, requiredItems) then
			return false
		end
		
		if playerSex == PLAYERSEX_MALE then
			requiredItems = outfitData.addon2_m
		else
			requiredItems = outfitData.addon2_f
		end
		
		if not checkComponentList(player, requiredItems) then
			return false
		end
		
		if outfitData.addon2Cost then
			if player:getTotalMoney() < outfitData.addon1Cost then
				return false
			end
		end
	end
	
	return true
end

local function internalConsumeComponents(player, list)
	if list then
		if #list > 0 then
			for i = 1, #list do
				player:removeItem(list[i][1], list[i][2])
			end
		end
	end
end

local function internalUnlockAddon(player, key, topic)
	local outfitData = addonInfo[key]
	if not outfitData then
		return false
	end

	local lookTypeMale = outfitData.outfit[1]
	local lookTypeFemale = outfitData.outfit[2]
	if outfitData.opposite then
		if player:getSex() == PLAYERSEX_MALE then
			lookTypeFemale = outfitData.opposite[2]
		else
			lookTypeMale = outfitData.opposite[1]
		end
	end

	local addon = 0
	if topic == topicUnlock then
		internalConsumeComponents(player, outfitData.unlock)
	elseif topic == topicFirstAddon then
		local requiredItems = outfitData.addon1
		internalConsumeComponents(player, requiredItems)
		
		if playerSex == PLAYERSEX_MALE then
			requiredItems = outfitData.addon1_m
		else
			requiredItems = outfitData.addon1_f
		end
		
		internalConsumeComponents(player, requiredItems)
		
		if outfitData.addon1Cost then
			player:removeTotalMoney(outfitData.addon1Cost)
		end
		
		addon = 1
	elseif topic == topicSecondAddon then
		local requiredItems = outfitData.addon2
		internalConsumeComponents(player, requiredItems)
		
		if playerSex == PLAYERSEX_MALE then
			requiredItems = outfitData.addon2_m
		else
			requiredItems = outfitData.addon2_f
		end
		
		internalConsumeComponents(player, requiredItems)
		
		if outfitData.addon2Cost then
			player:removeTotalMoney(outfitData.addon2Cost)
		end
		
		addon = 2
	end
	
	if addon > 0 then
		player:addOutfitAddon(lookTypeMale, addon)
		player:addOutfitAddon(lookTypeFemale, addon)
	else
		player:addOutfit(lookTypeMale)
		player:addOutfit(lookTypeFemale)
	end
	
	return true
end

local function greetCallback(cid)
	topic[cid] = topicMain
	return true
end

function creatureSayCallback(cid, type, msg)
	-- check focus
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	-- validate player
	local player = Player(cid)
	if not player then
		return false
	end
	
	-- check topic
	if not topic[cid] then
		topic[cid] = topicMain
	end

	-- handle yes/no question
	-- do you want x for y?
	if topic[cid] ~= topicMain and choice then
		if msgcontains(msg, "yes") then		
			if hasComponents(player, choice, topic[cid]) then
				if internalUnlockAddon(player, choice, topic[cid]) then
					player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
					npcHandler:say("Here you are!", cid)
				else
					npcHandler:say("An error occured. Please try again later.", cid)
				end
			else
				npcHandler:say("You do not have all the components.", cid)
			end
		else
			npcHandler:say("Come back when you change your mind.", cid)
		end
		
		choice = nil
		topic[cid] = topicMain
		npcHandler:resetNpc()
		return true
	end

	-- handle other keywords
	if msgcontains(msg, "first") then
		local key = getOutfitKeyword(msg)
		if key then
			local outfitData = addonInfo[key]
			local playerSex = player:getSex()
			local lookType = outfitData.outfit[playerSex + 1]
			
			if not player:hasOutfit(lookType) then
				npcHandler:say("You have to unlock this outfit first.", cid)
				topic[cid] = topicMain
				npcHandler:resetNpc()
				return true
			elseif player:hasOutfit(lookType, 1) then
				npcHandler:say("You already have this addon.", cid)
				topic[cid] = topicMain
				npcHandler:resetNpc()
				return true
			end
			
			local outfit = Outfit(lookType)
			if not outfit then
				npcHandler:say("Unable to unlock addons for this outfit.", cid)
				topic[cid] = topicMain
				npcHandler:resetNpc()
				return true
			end
			
			npcHandler:say(string.format("Do you want to unlock {First %s Addon} for %s?", outfit.name, getComponents(key, topicFirstAddon, playerSex)), cid)
			topic[cid] = topicFirstAddon
			choice = key
			npcHandler:resetNpc()
			return true
		end
		
		npcHandler:say("To unlock first addon, please say first outfit addon, for example {first citizen addon}.", cid)
	elseif msgcontains(msg, "second") then
		local key = getOutfitKeyword(msg)
		if key then
			local outfitData = addonInfo[key]
			local playerSex = player:getSex()
			local lookType = outfitData.outfit[playerSex + 1]
			
			if not player:hasOutfit(lookType) then
				npcHandler:say("You have to unlock this outfit first.", cid)
				topic[cid] = topicMain
				npcHandler:resetNpc()
				return true
			elseif player:hasOutfit(lookType, 2) then
				npcHandler:say("You already have this addon.", cid)
				topic[cid] = topicMain
				npcHandler:resetNpc()
				return true
			end
			
			local outfit = Outfit(lookType)
			if not outfit then
				npcHandler:say("Unable to unlock addons for this outfit.", cid)
				topic[cid] = topicMain
				npcHandler:resetNpc()
				return true
			end
			
			npcHandler:say(string.format("Do you want to unlock {Second %s Addon} for %s?", outfit.name, getComponents(key, topicSecondAddon, playerSex)), cid)
			topic[cid] = topicSecondAddon
			choice = key
			npcHandler:resetNpc()
			return true
		end
		
		npcHandler:say("To unlock second addon, please say second outfit addon, for example {second citizen addon}.", cid)
	elseif msgcontains(msg, "unlock") then
		local key = getOutfitKeyword(msg)
		if key then
			local outfitData = addonInfo[key]
			if not outfitData.unlock then
				npcHandler:say("I do not offer unlocking this outfit.", cid)
				topic[cid] = topicMain
				npcHandler:resetNpc()
				return true	
			end
		
			local playerSex = player:getSex()
			local lookType = outfitData.outfit[playerSex + 1]
			if player:hasOutfit(lookType) then
				npcHandler:say("You already have this outfit.", cid)
				topic[cid] = topicMain
				npcHandler:resetNpc()
				return true	
			end
			
			local outfit = Outfit(lookType)
			if not outfit then
				npcHandler:say("Unable to unlock this outfit.", cid)
				topic[cid] = topicMain
				npcHandler:resetNpc()
				return true	
			end
			
			npcHandler:say(string.format("Do you want to {unlock %s Outfit} for %s?", outfit.name, getComponents(key, topicUnlock, playerSex)), cid)
			topic[cid] = topicUnlock
			choice = key
			npcHandler:resetNpc()
			return true
		end
		
		npcHandler:say("To unlock outfit, please say unlock outfit, for example {unlock soil guardian outfit}.", cid)
	elseif msgcontains(msg, "help") then
		npcHandler:say(string.format("If you help me, I can {unlock} an outfit for you or reward you with {addons}.", getVarkhalOffer()), cid)
	elseif msgcontains(msg, "addon") then
		npcHandler:say(getVarkhalOffer(), cid)
	else
		local key = getOutfitKeyword(msg)
		if key then
			local outfitData = addonInfo[key]
			if outfitData then
				local offers = {}
				if outfitData.unlock then
					offers[#offers + 1] = string.format("to {unlock %s outfit}", key)
				end
				
				if outfitData.addon1 or outfitData.addon1Cost or outfitData.addon1_m then
					offers[#offers + 1] = string.format("{first %s addon}", key)
				end

				if outfitData.addon2 or outfitData.addon2Cost or outfitData.addon2_m then
					offers[#offers + 1] = string.format("{second %s addon}", key)
				end
				
				local offer
				if #offers > 1 then
					local lastOffer = offers[#offers]
					offers[#offers] = nil
					offer = string.format("I can offer %s and %s", table.concat(offers, ", "), lastOffer)
				elseif #offers == 1 then
					offer = string.format("I can offer %s", offers[1])
				else
					offer = "This outfit is unavailable."
				end
				
				npcHandler:say(offer, cid)
			end
		end
	end

	topic[cid] = topicMain
	npcHandler:resetNpc()	
	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())