// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#ifndef FS_EVENTS_H
#define FS_EVENTS_H

#include "const.h"
#include "creature.h"
#include "networkmessage.h"
#include "luascript.h"

class ItemType;
class Party;
class Tile;

enum class EventInfoId {
	CREATURE_ONHEAR
};

class Events
{
	struct EventsInfo {
		// Creature
		int32_t creatureOnChangeOutfit = -1;
		int32_t creatureOnAreaCombat = -1;
		int32_t creatureOnTargetCombat = -1;
		int32_t creatureOnHear = -1;
		int32_t creatureOnAddCondition = -1;

		// Party
		int32_t partyOnJoin = -1;
		int32_t partyOnLeave = -1;
		int32_t partyOnDisband = -1;
		int32_t partyOnShareExperience = -1;

		// Player
		int32_t playerOnBrowseField = -1;
		int32_t playerOnLook = -1;
		int32_t playerOnLookInBattleList = -1;
		int32_t playerOnLookInTrade = -1;
		int32_t playerOnLookInShop = -1;
		int32_t playerOnLookInMarket = -1;
		int32_t playerOnMoveItem = -1;
		int32_t playerOnItemMoved = -1;
		int32_t playerOnMoveCreature = -1;
		int32_t playerOnReportRuleViolation = -1;
		int32_t playerOnReportBug = -1;
		int32_t playerOnTurn = -1;
		int32_t playerOnTradeRequest = -1;
		int32_t playerOnTradeAccept = -1;
		int32_t playerOnTradeCompleted = -1;
		int32_t playerOnPodiumRequest = -1;
		int32_t playerOnPodiumEdit = -1;
		int32_t playerOnGainExperience = -1;
		int32_t playerOnLoseExperience = -1;
		int32_t playerOnGainSkillTries = -1;
		int32_t playerOnWrapItem = -1;
		int32_t playerOnQuickLoot = -1;
		int32_t playerOnInspectItem = -1;
		int32_t playerOnInspectTradeItem = -1;
		int32_t playerOnInspectNpcTradeItem = -1;
		int32_t playerOnInspectCyclopediaItem = -1;
		int32_t playerOnMinimapQuery = -1;
		int32_t playerOnInventoryUpdate = -1;
		int32_t playerOnGuildMotdEdit = -1;
		int32_t playerOnSetLootList = -1;
		int32_t playerOnManageLootContainer = -1;
		int32_t playerOnFuseItems = -1;
		int32_t playerOnTransferTier = -1;
		int32_t playerOnForgeConversion = -1;
		int32_t playerOnForgeHistoryBrowse = -1;
		int32_t playerOnRequestPlayerTab = -1;
		int32_t playerOnBestiaryInit = -1;
		int32_t playerOnBestiaryBrowse = -1;
		int32_t playerOnBestiaryRaceView = -1;
		int32_t playerOnFrameView = -1;

		int32_t playerOnConnect = -1;
		int32_t playerOnExtendedProtocol = -1;

		// Monster
		int32_t monsterOnDropLoot = -1;
		int32_t monsterOnSpawn = -1;
	};

	public:
		Events();

		bool load();

		// Creature
		bool eventCreatureOnChangeOutfit(Creature* creature, const Outfit_t& outfit);
		ReturnValue eventCreatureOnAreaCombat(Creature* creature, Tile* tile, bool aggressive);
		ReturnValue eventCreatureOnTargetCombat(Creature* creature, Creature* target);
		void eventCreatureOnHear(Creature* creature, Creature* speaker, const std::string& words, MessageClasses type);
		ReturnValue eventCreatureOnAddCondition(Creature* creature, Condition* condition, bool isForced);

		// Party
		bool eventPartyOnJoin(Party* party, Player* player);
		bool eventPartyOnLeave(Party* party, Player* player);
		bool eventPartyOnDisband(Party* party);
		void eventPartyOnShareExperience(Party* party, uint64_t& exp);

		// Player
		bool eventPlayerOnBrowseField(Player* player, const Position& position);
		void eventPlayerOnLook(Player* player, const Position& position, Thing* thing, uint8_t stackpos, int32_t lookDistance);
		void eventPlayerOnLookInBattleList(Player* player, Creature* creature, int32_t lookDistance);
		void eventPlayerOnLookInTrade(Player* player, Player* partner, Item* item, int32_t lookDistance);
		bool eventPlayerOnLookInShop(Player* player, const ItemType* itemType, uint8_t count, Npc* npc);
		bool eventPlayerOnLookInMarket(Player* player, const ItemType* itemType, uint8_t tier);
		ReturnValue eventPlayerOnMoveItem(Player* player, Item* item, uint16_t count, const Position& fromPosition, const Position& toPosition, Cylinder* fromCylinder, Cylinder* toCylinder);
		void eventPlayerOnItemMoved(Player* player, Item* item, uint16_t count, const Position& fromPosition, const Position& toPosition, Cylinder* fromCylinder, Cylinder* toCylinder);
		bool eventPlayerOnMoveCreature(Player* player, Creature* creature, const Position& fromPosition, const Position& toPosition);
		void eventPlayerOnReportRuleViolation(Player* player, const std::string& targetName, uint8_t reportType, uint8_t reportReason, const std::string& comment, const std::string& translation);
		bool eventPlayerOnReportBug(Player* player, const std::string& message, const Position& position, uint8_t category);
		bool eventPlayerOnTurn(Player* player, Direction direction);
		bool eventPlayerOnTradeRequest(Player* player, Player* target, Item* item);
		bool eventPlayerOnTradeAccept(Player* player, Player* target, Item* item, Item* targetItem);
		void eventPlayerOnTradeCompleted(Player* player, Player* target, Item* item, Item* targetItem, bool isSuccess);
		void eventPlayerOnPodiumRequest(Player* player, Item* item);
		void eventPlayerOnPodiumEdit(Player* player, Item* item, const Outfit_t& outfit, bool podiumVisible, Direction direction);
		void eventPlayerOnGainExperience(Player* player, Creature* source, uint64_t& exp, uint64_t rawExp);
		void eventPlayerOnLoseExperience(Player* player, uint64_t& exp);
		void eventPlayerOnGainSkillTries(Player* player, skills_t skill, uint64_t& tries);
		void eventPlayerOnWrapItem(Player* player, Item* item);
		void eventPlayerOnQuickLoot(Player* player, const Position& position, uint8_t stackPos, uint16_t spriteId);
		void eventPlayerOnInspectItem(Player* player, Item* item);
		void eventPlayerOnInspectTradeItem(Player* player, Player* tradePartner, Item* item);
		void eventPlayerOnInspectNpcTradeItem(Player* player, Npc* npc, uint16_t itemId);
		void eventPlayerOnInspectCyclopediaItem(Player* player, uint16_t itemId);
		void eventPlayerOnMinimapQuery(Player* player, const Position& position);
		void eventPlayerOnInventoryUpdate(Player* player, Item* item, slots_t slot, bool equip);
		const std::string eventPlayerOnGuildMotdEdit(Player* player, const std::string& message);
		void eventPlayerOnSetLootList(Player* player, const std::vector<uint16_t>& lootList, bool isSkipMode);
		void eventPlayerOnManageLootContainer(Player* player, Item* item, uint8_t modePrimary, uint8_t modeSecondary);
		void eventPlayerOnFuseItems(Player* player, const ItemType* fromItemType, uint8_t fromTier, const ItemType* toItemType, bool successCore, bool tierLossCore);
		void eventPlayerOnTransferTier(Player* player, const ItemType* fromItemType, uint8_t fromTier, const ItemType* toItemType);
		void eventPlayerOnForgeConversion(Player* player, ForgeConversionTypes_t conversionType);
		void eventPlayerOnForgeHistoryBrowse(Player* player, uint8_t page);
		void eventPlayerOnRequestPlayerTab(Player* player, Player* targetPlayer, PlayerTabTypes_t infoType, uint16_t currentPage, uint16_t entriesPerPage);
		void eventPlayerOnBestiaryInit(Player* player);
		void eventPlayerOnBestiaryBrowse(Player* player, const std::string& category, std::vector<uint16_t> raceList);
		void eventPlayerOnBestiaryRaceView(Player* player, uint16_t raceId);
		uint8_t eventPlayerOnFrameView(Player* player, const Creature* target);

		void eventPlayerOnConnect(Player* player, bool isLogin);

#ifdef LUA_EXTENDED_PROTOCOL
		void eventPlayerOnExtendedProtocol(Player* player, uint8_t recvbyte, std::unique_ptr<NetworkMessage> message);
#endif

		// Monster
		void eventMonsterOnDropLoot(Monster* monster, Container* corpse);
		bool eventMonsterOnSpawn(Monster* monster, const Position& position, bool startup, bool artificial);

		int32_t getScriptId(EventInfoId eventInfoId) {
			switch (eventInfoId)
			{
			case EventInfoId::CREATURE_ONHEAR:
				return info.creatureOnHear;
			default:
				return -1;
			}
		};

	private:
		LuaScriptInterface scriptInterface;
		EventsInfo info;
};

#endif
