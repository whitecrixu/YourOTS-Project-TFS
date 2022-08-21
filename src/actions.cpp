// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#include "otpch.h"

#include "actions.h"
#include "bed.h"
#include "configmanager.h"
#include "container.h"
#include "game.h"
#include "housetile.h"
#include "pugicast.h"
#include "spells.h"

extern Game g_game;
extern Spells* g_spells;
extern Actions* g_actions;
extern ConfigManager g_config;

Actions::Actions() :
	scriptInterface("Action Interface")
{
	scriptInterface.initState();
}

Actions::~Actions()
{
	clear(false);
}

void Actions::clearMap(ActionUseMap& map, bool fromLua)
{
	for (auto it = map.begin(); it != map.end(); ) {
		if (fromLua == it->second.fromLua) {
			it = map.erase(it);
		} else {
			++it;
		}
	}
}

void Actions::clear(bool fromLua)
{
	clearMap(useItemMap, fromLua);
	clearMap(uniqueItemMap, fromLua);
	clearMap(actionItemMap, fromLua);

	reInitState(fromLua);
}

LuaScriptInterface& Actions::getScriptInterface()
{
	return scriptInterface;
}

std::string Actions::getScriptBaseName() const
{
	return "actions";
}

Event_ptr Actions::getEvent(const std::string& nodeName)
{
	if (!caseInsensitiveEqual(nodeName, "action")) {
		return nullptr;
	}
	return Event_ptr(new Action(&scriptInterface));
}

bool Actions::registerEvent(Event_ptr event, const pugi::xml_node& node)
{
	// console output
	const std::string location = "Actions::registerEvent";

	// event is guaranteed to be an Action
	Action_ptr action{static_cast<Action*>(event.release())};
	

	pugi::xml_attribute attr;
	if ((attr = node.attribute("itemid"))) {
		std::vector<int32_t> idList = vectorAtoi(explodeString(attr.as_string(), ";"));
		bool success = true;

		for (const auto& id : idList) {
			auto result = useItemMap.emplace(id, std::move(*action));
			if (!result.second) {
				console::reportWarning(location, fmt::format("Duplicate registered item with id: {:d}!", id));
				success = false;
			}
		}

		return success;
	} else if ((attr = node.attribute("fromid"))) {
		pugi::xml_attribute toIdAttribute = node.attribute("toid");
		if (!toIdAttribute) {
			console::reportWarning(location, fmt::format("Missing toid in fromid: {:s}!", attr.as_string()));
			return false;
		}

		uint16_t fromId = pugi::cast<uint16_t>(attr.value());
		uint16_t iterId = fromId;
		uint16_t toId = pugi::cast<uint16_t>(toIdAttribute.value());

		auto result = useItemMap.emplace(iterId, *action);
		if (!result.second) {
			console::reportWarning(location, fmt::format("Duplicate registered item with id {:d} in range {:d}-{:d}!", iterId, fromId, toId));
		}

		bool success = result.second;
		while (++iterId <= toId) {
			result = useItemMap.emplace(iterId, *action);
			if (!result.second) {
				console::reportWarning(location, fmt::format("Duplicate registered item with id {:d} in range {:d}-{:d}!", iterId, fromId, toId));
				continue;
			}
			success = true;
		}
		return success;
	} else if ((attr = node.attribute("uniqueid"))) {
		std::vector<int32_t> uidList = vectorAtoi(explodeString(attr.as_string(), ";"));
		bool success = true;

		for (const auto& uid : uidList) {
			auto result = uniqueItemMap.emplace(uid, std::move(*action));
			if (!result.second) {
				console::reportWarning(location, fmt::format("Duplicate registered item with uniqueid: {:d}!", uid));
				success = false;
			}
		}

		return success;
	} else if ((attr = node.attribute("fromuid"))) {
		pugi::xml_attribute toUidAttribute = node.attribute("touid");
		if (!toUidAttribute) {
			console::reportWarning(location, fmt::format("Missing touid in fromuid: {:s}!", attr.as_string()));
			return false;
		}

		uint16_t fromUid = pugi::cast<uint16_t>(attr.value());
		uint16_t iterUid = fromUid;
		uint16_t toUid = pugi::cast<uint16_t>(toUidAttribute.value());

		auto result = uniqueItemMap.emplace(iterUid, *action);
		if (!result.second) {
			console::reportWarning(location, fmt::format("Duplicate registered item with unique id {:d} in range {:d}-{:d}!", iterUid, fromUid, toUid));
		}

		bool success = result.second;
		while (++iterUid <= toUid) {
			result = uniqueItemMap.emplace(iterUid, *action);
			if (!result.second) {
				console::reportWarning(location, fmt::format("Duplicate registered item with unique id {:d} in range {:d}-{:d}!", iterUid, fromUid, toUid));
				continue;
			}
			success = true;
		}
		return success;
	} else if ((attr = node.attribute("actionid"))) {
		std::vector<int32_t> aidList = vectorAtoi(explodeString(attr.as_string(), ";"));
		bool success = true;

		for (const auto& aid : aidList) {
			auto result = actionItemMap.emplace(aid, std::move(*action));
			if (!result.second) {
				console::reportWarning(location, fmt::format("Duplicate registered item with actionid: {:d}!", aid));
				success = false;
			}
		}

		return success;
	} else if ((attr = node.attribute("fromaid"))) {
		pugi::xml_attribute toAidAttribute = node.attribute("toaid");
		if (!toAidAttribute) {
			console::reportWarning(location, fmt::format("Missing toaid in fromaid: {:s}!", attr.as_string()));
			return false;
		}

		uint16_t fromAid = pugi::cast<uint16_t>(attr.value());
		uint16_t iterAid = fromAid;
		uint16_t toAid = pugi::cast<uint16_t>(toAidAttribute.value());

		auto result = actionItemMap.emplace(iterAid, *action);
		if (!result.second) {
			console::reportWarning(location, fmt::format("Duplicate registered item with action id {:d} in range {:d}-{:d}!", iterAid, fromAid, toAid));
		}

		bool success = result.second;
		while (++iterAid <= toAid) {
			result = actionItemMap.emplace(iterAid, *action);
			if (!result.second) {
				console::reportWarning(location, fmt::format("Duplicate registered item with action id {:d} in range {:d}-{:d}!", iterAid, fromAid, toAid));
				continue;
			}
			success = true;
		}
		return success;
	}
	return false;
}

bool Actions::registerLuaEvent(Action* event)
{
	// console output
	const std::string location = "Actions::registerLuaEvent";

	Action_ptr action{ event };
	if (!action->getItemIdRange().empty()) {
		const auto& range = action->getItemIdRange();
		for (auto id : range) {
			auto result = useItemMap.emplace(id, *action);
			if (!result.second) {
				console::reportWarning(location, fmt::format("Duplicate registered item with id {:d} in range {:d}-{:d}!", id, range.front(), range.back()));
			}
		}
		return true;
	} else if (!action->getUniqueIdRange().empty()) {
		const auto& range = action->getUniqueIdRange();
		for (auto id : range) {
			auto result = uniqueItemMap.emplace(id, *action);
			if (!result.second) {
				console::reportWarning(location, fmt::format("Duplicate registered item with unique id {:d} in range {:d}-{:d}!", id, range.front(), range.back()));
			}
		}
		return true;
	} else if (!action->getActionIdRange().empty()) {
		const auto& range = action->getActionIdRange();
		for (auto id : range) {
			auto result = actionItemMap.emplace(id, *action);
			if (!result.second) {
				console::reportWarning(location, fmt::format("Duplicate registered item with action id {:d} in range {:d}-{:d}!", id, range.front(), range.back()));
			}
		}
		return true;
	}

	console::reportWarning(location, "Event with missing item / action / unique id!");
	return false;
}

ReturnValue Actions::canUse(const Player* player, const Position& pos)
{
	if (pos.x != 0xFFFF) {
		const Position& playerPos = player->getPosition();
		if (playerPos.z != pos.z) {
			return playerPos.z > pos.z ? RETURNVALUE_FIRSTGOUPSTAIRS : RETURNVALUE_FIRSTGODOWNSTAIRS;
		}

		if (!Position::areInRange<1, 1>(playerPos, pos)) {
			return RETURNVALUE_TOOFARAWAY;
		}
	}
	return RETURNVALUE_NOERROR;
}

ReturnValue Actions::canUse(const Player* player, const Position& pos, const Item* item)
{
	Action* action = getAction(item);
	if (action) {
		return action->canExecuteAction(player, pos);
	}
	return RETURNVALUE_NOERROR;
}

ReturnValue Actions::canUseFar(const Creature* creature, const Position& toPos, bool checkLineOfSight, bool checkFloor)
{
	if (toPos.x == 0xFFFF) {
		return RETURNVALUE_NOERROR;
	}

	const Position& creaturePos = creature->getPosition();
	if (checkFloor && creaturePos.z != toPos.z) {
		return creaturePos.z > toPos.z ? RETURNVALUE_FIRSTGOUPSTAIRS : RETURNVALUE_FIRSTGODOWNSTAIRS;
	}

	if (!Position::areInRange<Map::maxClientViewportX - 1, Map::maxClientViewportY - 1>(toPos, creaturePos)) {
		return RETURNVALUE_TOOFARAWAY;
	}

	if (checkLineOfSight && !g_game.canThrowObjectTo(creaturePos, toPos, checkLineOfSight, checkFloor)) {
		return RETURNVALUE_CANNOTTHROW;
	}

	return RETURNVALUE_NOERROR;
}

Action* Actions::getAction(const Item* item)
{
	if (item->hasAttribute(ITEM_ATTRIBUTE_UNIQUEID)) {
		auto it = uniqueItemMap.find(item->getUniqueId());
		if (it != uniqueItemMap.end()) {
			return &it->second;
		}
	}

	if (item->hasAttribute(ITEM_ATTRIBUTE_ACTIONID)) {
		auto it = actionItemMap.find(item->getActionId());
		if (it != actionItemMap.end()) {
			return &it->second;
		}
	}

	auto it = useItemMap.find(item->getID());
	if (it != useItemMap.end()) {
		return &it->second;
	}

	//rune items
	return g_spells->getRuneSpell(item->getID());
}

ReturnValue Actions::internalUseItem(Player* player, const Position& pos, uint8_t index, Item* item, bool isHotkey)
{
	if (Door* door = item->getDoor()) {
		if (!door->canUse(player)) {
			return RETURNVALUE_NOTPOSSIBLE;
		}
	}

	Action* action = getAction(item);
	if (action) {
		if (action->isScripted()) {
			if (action->executeUse(player, item, pos, nullptr, pos, isHotkey)) {
				return RETURNVALUE_NOERROR;
			}

			if (item->isRemoved()) {
				return RETURNVALUE_CANNOTUSETHISOBJECT;
			}
		} else if (action->function && action->function(player, item, pos, nullptr, pos, isHotkey)) {
			return RETURNVALUE_NOERROR;
		}
	}

	if (BedItem* bed = item->getBed()) {
		if (!bed->canUse(player)) {
			if (!bed->getHouse()) {
				return RETURNVALUE_YOUCANNOTUSETHISBED;
			}

			if (!player->isPremium()) {
				return RETURNVALUE_YOUNEEDPREMIUMACCOUNT;
			}
			return RETURNVALUE_CANNOTUSETHISOBJECT;
		}

		if (bed->trySleep(player)) {
			player->setBedItem(bed);
			g_game.sendOfflineTrainingDialog(player);
		}

		return RETURNVALUE_NOERROR;
	}

	if (Container* container = item->getContainer()) {
		Container* openContainer;

		// depot container
		if (DepotLocker* depot = container->getDepotLocker()) {
			DepotLocker& myDepotLocker = player->getDepotLocker();
			myDepotLocker.setParent(depot->getParent()->getTile());
			openContainer = &myDepotLocker;
		} else {
			openContainer = container;
		}

		uint32_t corpseOwner = container->getCorpseOwner();
		if (corpseOwner != 0 && !player->canOpenCorpse(corpseOwner)) {
			return RETURNVALUE_YOUARENOTTHEOWNER;
		}

		// open/close container
		int32_t containerId = player->getContainerID(openContainer);
		if (containerId == -1) {
			// replace the old container if limit reached
			if (index == player->getOpenedContainersLimit() - 1) {
				if (Container* oldContainer = player->getContainerByID(index)) {
					player->onCloseContainer(oldContainer);
					player->closeContainer(index);
				}
			}

			// open a new container
			player->addContainer(index, openContainer);
			player->onSendContainer(openContainer);
		} else {
			player->onCloseContainer(openContainer);
			player->closeContainer(containerId);
		}

		return RETURNVALUE_NOERROR;
	}

	const ItemType& it = Item::items[item->getID()];
	if (it.canReadText) {
		if (it.canWriteText) {
			player->setWriteItem(item, it.maxTextLen);
			player->sendTextWindow(item, it.maxTextLen, true);
		} else {
			player->setWriteItem(nullptr);
			player->sendTextWindow(item, 0, false);
		}

		return RETURNVALUE_NOERROR;
	}

	return RETURNVALUE_CANNOTUSETHISOBJECT;
}


static void showUseHotkeyMessage(Player* player, const Item* item, uint32_t count)
{
	const ItemType& it = Item::items[item->getID()];

	// show tier on hotkey
	bool hasTier = false;
	if (it.classification > 0 && item->getTier() > 0) {
		hasTier = true;
	}
	const std::string& tierSuffix = hasTier ? fmt::format(" (tier {:d})", item->getTier()) : "";

	if (!it.showCount) {
		player->sendTextMessage(MESSAGE_HOTKEY_PRESSED, fmt::format("Using one of {:s}{:s}...", item->getName(), tierSuffix));
	} else if (count == 1) {
		player->sendTextMessage(MESSAGE_HOTKEY_PRESSED, fmt::format("Using the last {:s}{:s}...", item->getName(), tierSuffix));
	} else {
		player->sendTextMessage(MESSAGE_HOTKEY_PRESSED, fmt::format("Using one of {:d} {:s}{:s}...", count, item->getPluralName(), tierSuffix));
	}
}

bool Actions::useItem(Player* player, const Position& pos, uint8_t index, Item* item, bool isHotkey)
{
	// apply use item cooldown
	int32_t cooldown = g_config.getNumber(ConfigManager::ACTIONS_DELAY_INTERVAL);
	player->setNextAction(OTSYS_TIME() + cooldown);

	// clicking on containers does not send cooldown icon
	if (!item->getContainer()) {
		player->sendUseItemCooldown(cooldown);
	}

	if (isHotkey) {
		uint16_t subType = item->getSubType();
		showUseHotkeyMessage(player, item, player->getItemTypeCount(item->getID(), subType != item->getItemCount() ? subType : -1, Item::items[item->getID()].classification > 0, item->getTier()));
	}

	if (g_config.getBoolean(ConfigManager::ONLY_INVITED_CAN_MOVE_HOUSE_ITEMS)) {
		if (const HouseTile* const houseTile = dynamic_cast<const HouseTile*>(item->getTile())) {
			if (!item->getTopParent()->getCreature() && !houseTile->getHouse()->isInvited(player)) {
				player->sendCancelMessage(RETURNVALUE_PLAYERISNOTINVITED);
				return false;
			}
		}
	}

	ReturnValue ret = internalUseItem(player, pos, index, item, isHotkey);
	if (ret == RETURNVALUE_YOUCANNOTUSETHISBED) {
		g_game.internalCreatureSay(player, TALKTYPE_MONSTER_SAY, getReturnMessage(ret), false);
		return false;
	}

	if (ret != RETURNVALUE_NOERROR) {
		player->sendCancelMessage(ret);
		return false;
	}

	return true;
}

bool Actions::useItemEx(Player* player, const Position& fromPos, const Position& toPos,
                        uint8_t toStackPos, Item* item, bool isHotkey, Creature* creature/* = nullptr*/)
{
	int32_t cooldown = g_config.getNumber(ConfigManager::EX_ACTIONS_DELAY_INTERVAL);
	player->setNextAction(OTSYS_TIME() + cooldown);
	player->sendUseItemCooldown(cooldown);

	Action* action = getAction(item);
	if (!action) {
		player->sendCancelMessage(RETURNVALUE_CANNOTUSETHISOBJECT);
		return false;
	}

	ReturnValue ret = action->canExecuteAction(player, toPos);
	if (ret != RETURNVALUE_NOERROR) {
		player->sendCancelMessage(ret);
		return false;
	}

	if (isHotkey) {
		uint16_t subType = item->getSubType();
		showUseHotkeyMessage(player, item, player->getItemTypeCount(item->getID(), subType != item->getItemCount() ? subType : -1, Item::items[item->getID()].classification > 0, item->getTier()));
	}

	if (g_config.getBoolean(ConfigManager::ONLY_INVITED_CAN_MOVE_HOUSE_ITEMS)) {
		if (const HouseTile* const houseTile = dynamic_cast<const HouseTile*>(item->getTile())) {
			if (!item->getTopParent()->getCreature() && !houseTile->getHouse()->isInvited(player)) {
				player->sendCancelMessage(RETURNVALUE_PLAYERISNOTINVITED);
				return false;
			}
		}
	}

	if (action->executeUse(player, item, fromPos, action->getTarget(player, creature, toPos, toStackPos), toPos, isHotkey)) {
		return true;
	}

	if (!action->hasOwnErrorHandler()) {
		player->sendCancelMessage(RETURNVALUE_CANNOTUSETHISOBJECT);
	}

	return false;
}

Action::Action(LuaScriptInterface* interface) :
	Event(interface), function(nullptr), allowFarUse(false), checkFloor(true), checkLineOfSight(true) {}

bool Action::configureEvent(const pugi::xml_node& node)
{
	pugi::xml_attribute allowFarUseAttr = node.attribute("allowfaruse");
	if (allowFarUseAttr) {
		allowFarUse = allowFarUseAttr.as_bool();
	}

	pugi::xml_attribute blockWallsAttr = node.attribute("blockwalls");
	if (blockWallsAttr) {
		checkLineOfSight = blockWallsAttr.as_bool();
	}

	pugi::xml_attribute checkFloorAttr = node.attribute("checkfloor");
	if (checkFloorAttr) {
		checkFloor = checkFloorAttr.as_bool();
	}

	return true;
}

namespace {

bool enterMarket(Player* player, Item*, const Position&, Thing*, const Position&, bool)
{
	player->sendMarketEnter();
	return true;
}

}

bool Action::loadFunction(const pugi::xml_attribute& attr, bool isScripted)
{
	const char* functionName = attr.as_string();
	if (caseInsensitiveEqual(functionName, "market")) {
		function = enterMarket;
	} else {
		if (!isScripted) {
			console::reportWarning("Action::loadFunction", fmt::format("Function {:s} does not exist!", functionName));
			return false;
		}
	}

	if (!isScripted) {
		scripted = false;
	}
	return true;
}

std::string Action::getScriptEventName() const
{
	return "onUse";
}

ReturnValue Action::canExecuteAction(const Player* player, const Position& toPos)
{
	if (allowFarUse) {
		return g_actions->canUseFar(player, toPos, checkLineOfSight, checkFloor);
	}
	return g_actions->canUse(player, toPos);
}

Thing* Action::getTarget(Player* player, Creature* targetCreature, const Position& toPosition, uint8_t toStackPos) const
{
	if (targetCreature) {
		return targetCreature;
	}
	return g_game.internalGetThing(player, toPosition, toStackPos, 0, STACKPOS_USETARGET);
}

bool Action::executeUse(Player* player, Item* item, const Position& fromPosition, Thing* target, const Position& toPosition, bool isHotkey)
{
	//onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if (!scriptInterface->reserveScriptEnv()) {
		console::reportOverflow("Actions::executeUse");
		return false;
	}

	ScriptEnvironment* env = scriptInterface->getScriptEnv();
	env->setScriptId(scriptId, scriptInterface);

	lua_State* L = scriptInterface->getLuaState();

	scriptInterface->pushFunction(scriptId);

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushThing(L, item);
	LuaScriptInterface::pushPosition(L, fromPosition);

	LuaScriptInterface::pushThing(L, target);
	LuaScriptInterface::pushPosition(L, toPosition);

	LuaScriptInterface::pushBoolean(L, isHotkey);
	return scriptInterface->callFunction(6);
}
