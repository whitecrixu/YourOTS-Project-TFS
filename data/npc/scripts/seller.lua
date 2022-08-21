local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'rope'}, 2120, 50, 1, 'rope')
shopModule:addBuyableItem({'shovel'}, 2554, 20, 1, 'shovel')
shopModule:addBuyableItem({'backpack'}, 1988, 20, 1, 'backpack')
shopModule:addBuyableItem({'lifefluid'}, 2006, 60, 10, 'lifefluid')
shopModule:addBuyableItem({'manafluid'}, 2006, 100, 7, 'manafluid')
shopModule:addBuyableItem({'fishing rod'}, 2580, 100, 1, 'fishing rod')
shopModule:addBuyableItem({'torch'}, 2050, 2, 1, 'torch')
shopModule:addBuyableItem({'amulet of loss'}, 2173, 50000, 1, 'torch')
shopModule:addSellableItem({'vial'}, 2006, 10, 'vial', 0)

local topic = {}
local topicMain = 0
local topicSoft = 1
local topicFire = 2

local boots = {
	[topicSoft] = {fromId = 10021, toId = 6132, price = 10000},
	[topicFire] = {fromId = 10022, toId = 9933, price = 10000}
}

local dialogue = {
	repairSoft = string.format("Would you like to repair your soft boots for %d gold?", boots[topicSoft].price),
	repairFire = string.format("Would you like to repair your firewalker boots for %d gold?", boots[topicFire].price),
	repairItemMissing = "Your boots do not need any repairs yet.",
	repairComplete = "Here you are.",
	repairFailedItem = "Looks like you dropped your boots.",
	repairFailedGold = "You do not have enough money.",
	repairDeclined = "Ok then."
}

function greetCallback(cid)
	topic[cid] = topicMain
	return true
end

local function repairBoots(player, params)
	local item = player:getItemById(params.fromId)
	if not item then
		return 1
	elseif player:getTotalMoney() < params.price then
		return 2
	end

	player:removeTotalMoney(params.price)
	item:transform(params.toId)
	return 0
end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	
	local player = Player(cid)
	if not player then
		return false
	end
	
	if topic[cid] ~= topicMain then
		if msgcontains(msg, 'yes') then
			local ret = repairBoots(player, boots[topic[cid]])
			if ret == 0 then
				npcHandler:say(dialogue.repairComplete, cid)
			elseif ret == 1 then
				npcHandler:say(dialogue.repairFailedItem, cid)
			elseif ret == 2 then
				npcHandler:say(dialogue.repairFailedGold, cid)
			end
		else
			npcHandler:say(dialogue.repairDeclined, cid)
		end
		
		topic[cid] = topicMain
		return true
	end
	
	if msgcontains(msg, 'soft') then
		if player:getItemCount(boots[topicSoft].fromId) > 0 then
			npcHandler:say(dialogue.repairSoft, cid)
			topic[cid] = topicSoft
		else
			npcHandler:say(dialogue.repairItemMissing, cid)
			topic[cid] = topicMain
		end

		return true
	elseif msgcontains(msg, 'fire') then
		if player:getItemCount(boots[topicFire].fromId) > 0 then
			npcHandler:say(dialogue.repairFire, cid)
			topic[cid] = topicFire
		else
			npcHandler:say(dialogue.repairItemMissing, cid)
			topic[cid] = topicMain
		end
		
		return true
	end
	
	topic[cid] = topicMain
	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
