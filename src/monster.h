// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#ifndef FS_MONSTER_H
#define FS_MONSTER_H

#include "monsters.h"

#include "creature.h"
#include "position.h"

class Item;
class Spawn;
class Tile;

using CreatureHashSet = std::unordered_set<Creature*>;
using CreatureList = std::list<Creature*>;

enum TargetSearchType_t {
	TARGETSEARCH_DEFAULT,
	TARGETSEARCH_RANDOM,
	TARGETSEARCH_ATTACKRANGE,
	TARGETSEARCH_NEAREST,
};

struct FamiliarWaypoint {
	constexpr FamiliarWaypoint(Position* pos, bool isTeleport) : pos(pos), isTeleport(isTeleport) {}

	Position* pos;
	bool isTeleport = false;
};

class Monster final : public Creature
{
	public:
		static Monster* createMonster(const std::string& name);
		static int32_t despawnRange;
		static int32_t despawnRadius;

		explicit Monster(MonsterType* mType);
		~Monster();

		// non-copyable
		Monster(const Monster&) = delete;
		Monster& operator=(const Monster&) = delete;

		Monster* getMonster() override {
			return this;
		}
		const Monster* getMonster() const override {
			return this;
		}

		void setID() override {
			if (id == 0) {
				id = monsterAutoID++;
			}
		}

		void addList() override;
		void removeList() override;

		const std::string& getName() const override;
		void setName(const std::string& name);

		const std::string& getNameDescription() const override;
		void setNameDescription(const std::string& nameDescription) {
			this->nameDescription = nameDescription;
		};

		std::string getDescription(int32_t) const override {
			return nameDescription + '.';
		}

		CreatureType_t getType() const override {
			return CREATURETYPE_MONSTER;
		}

		const Position& getMasterPos() const {
			return masterPos;
		}
		void setMasterPos(Position pos) {
			masterPos = pos;
		}

		RaceType_t getRace() const override {
			return mType->info.race;
		}
		int32_t getArmor() const override {
			return mType->info.armor;
		}
		int32_t getDefense() const override {
			return mType->info.defense;
		}
		bool isPushable() const override {
			return mType->info.pushable && baseSpeed != 0;
		}
		bool isAttackable() const override {
			return mType->info.isAttackable;
		}

		bool canPushItems() const;
		bool canPushCreatures() const {
			return mType->info.canPushCreatures;
		}
		bool isHostile() const {
			return mType->info.isHostile;
		}
		bool canSee(const Position& pos) const override;
		bool canSeeInvisibility() const override {
			return isImmune(CONDITION_INVISIBLE);
		}
		uint32_t getManaCost() const {
			return mType->info.manaCost;
		}
		void setSpawn(Spawn* spawn) {
			this->spawn = spawn;
		}
		bool canWalkOnFieldType(CombatType_t combatType) const;

		void onAttackedCreatureDisappear(bool isLogout) override;

		void onCreatureAppear(Creature* creature, bool isLogin) override;
		void onRemoveCreature(Creature* creature, bool isLogout) override;
		void onCreatureMove(Creature* creature, const Tile* newTile, const Position& newPos, const Tile* oldTile, const Position& oldPos, bool teleport) override;
		void onCreatureSay(Creature* creature, MessageClasses type, const std::string& text) override;

		void drainHealth(Creature* attacker, int32_t damage) override;
		void changeHealth(int32_t healthChange, bool sendHealthChange = true) override;

		bool isWalkingToSpawn() const {
			return walkingToSpawn;
		}
		bool walkToSpawn();
		void followMasterTrail();
		void onWalk() override;
		void onWalkComplete() override;
		bool getNextStep(Direction& direction, uint32_t& flags) override;
		void onFollowCreatureComplete(const Creature* creature) override;
		void onChangeZone(ZoneType_t zone) override;

		void onThink(uint32_t interval) override;

		bool challengeCreature(Creature* creature, bool force = false) override;

		void setNormalCreatureLight() override;
		bool getCombatValues(int32_t& min, int32_t& max) override;

		void doAttacking(uint32_t interval) override;
		bool hasExtraSwing() override {
			return lastMeleeAttack == 0;
		}

		void setFamiliar(bool familiarStatus);
		bool isFamiliar() const {
			return familiar && master && master->getPlayer();
		}

		bool searchTarget(TargetSearchType_t searchType = TARGETSEARCH_DEFAULT);
		bool selectTarget(Creature* creature);

		const CreatureList& getTargetList() const {
			return targetList;
		}
		const CreatureHashSet& getFriendList() const {
			return friendList;
		}

		bool isTarget(const Creature* creature) const;
		bool isFleeing() const {
			return !isSummon() && getHealth() <= mType->info.runAwayHealth && challengeFocusDuration <= 0;
		}

		bool getDistanceStep(const Position& targetPos, Direction& direction, bool flee = false);
		bool isTargetNearby() const {
			return stepDuration >= 1;
		}
		bool isIgnoringFieldDamage() const {
			return ignoreFieldDamage;
		}
		void setIgnoreFieldDamage(bool newMode) {
			ignoreFieldDamage = newMode;
		}

		BlockType_t blockHit(Creature* attacker, CombatType_t combatType, int32_t& damage,
		                     bool checkDefense = false, bool checkArmor = false, bool field = false, bool ignoreResistances = false) override;

		// monster icons
		auto& getMonsterIcons() const {
			return monsterIcons;
		}

		size_t getMonsterIconCount() const {
			return monsterIcons.size();
		}

		bool hasMonsterIcon(MonsterIcon_t iconId) {
			return monsterIcons.find(iconId) != monsterIcons.end();
		}

		uint16_t getMonsterIconValue(MonsterIcon_t iconId) {
			return hasMonsterIcon(iconId) ? monsterIcons[iconId] : 0;
		}

		bool setMonsterIconValue(MonsterIcon_t iconId, uint16_t value) {
			if (iconId < MONSTER_ICON_LAST) {
				monsterIcons[iconId] = value;
				refreshCreatureIcons();
				return true;
			}

			return false;
		}

		bool removeMonsterIcon(MonsterIcon_t iconId) {
			auto iter = monsterIcons.find(iconId);
			if (iter == monsterIcons.end()) {
				return false;
			}

			monsterIcons.erase(iter);
			refreshCreatureIcons();
			return true;
		}

		// waypoints cache for familiars
		void cacheWaypoint(Position* pos, bool isTeleport) {
			if (waypointsCache.size() >= 5) {
				waypointsCache.pop_front();
			}

			waypointsCache.push_back(FamiliarWaypoint(pos, isTeleport));
		}
		std::deque<FamiliarWaypoint>& getWaypointsCache() {
			return waypointsCache;
		}

		static uint32_t monsterAutoID;

	private:
		CreatureHashSet friendList;
		CreatureList targetList;

		std::string name;
		std::string nameDescription;

		MonsterType* mType;
		Spawn* spawn = nullptr;

		int64_t lastMeleeAttack = 0;

		uint32_t attackTicks = 0;
		uint32_t targetTicks = 0;
		uint32_t targetChangeTicks = 0;
		uint32_t defenseTicks = 0;
		uint32_t yellTicks = 0;
		int32_t minCombatValue = 0;
		int32_t maxCombatValue = 0;
		int32_t targetChangeCooldown = 0;
		int32_t challengeFocusDuration = 0;
		int32_t stepDuration = 0;

		Position masterPos;

		bool ignoreFieldDamage = true;
		bool isIdle = true;
		bool familiar = false;
		bool isMasterInRange = false;
		bool randomStepping = false;
		bool walkingToSpawn = false;

		std::deque<FamiliarWaypoint> waypointsCache;
		std::map<MonsterIcon_t, uint16_t> monsterIcons;

		void onCreatureEnter(Creature* creature);
		void onCreatureLeave(Creature* creature);
		void onCreatureFound(Creature* creature, bool pushFront = false);

		void updateLookDirection();

		void addFriend(Creature* creature);
		void removeFriend(Creature* creature);
		void addTarget(Creature* creature, bool pushFront = false);
		void removeTarget(Creature* creature);

		void updateTargetList();
		void clearTargetList();
		void clearFriendList();

		void death(Creature* lastHitCreature) override;
		Item* getCorpse(Creature* lastHitCreature, Creature* mostDamageCreature) override;

		void setIdle(bool idle);
		void updateIdleStatus();
		bool getIdleStatus() const {
			return isIdle;
		}

		void onAddCondition(ConditionType_t type) override;
		void onEndCondition(ConditionType_t type) override;

		bool canUseAttack(const Position& pos, const Creature* target) const;
		bool canUseSpell(const Position& pos, const Position& targetPos,
		                 const spellBlock_t& sb, uint32_t interval, bool& inRange, bool& resetTicks);
		bool getRandomStep(const Position& creaturePos, Direction& direction) const;
		bool getDanceStep(const Position& creaturePos, Direction& direction,
		                  bool keepAttack = true, bool keepDistance = true);
		bool isInSpawnRange(const Position& pos) const;
		bool canWalkTo(Position pos, Direction direction) const;

		static bool pushItem(Item* item);
		static void pushItems(Tile* tile);
		static bool pushCreature(Creature* creature);
		static void pushCreatures(Tile* tile);

		void onThinkTarget(uint32_t interval);
		void onThinkYell(uint32_t interval);
		void onThinkDefense(uint32_t interval);

		bool isFriend(const Creature* creature) const;
		bool isOpponent(const Creature* creature) const;

		uint64_t getLostExperience() const override {
			return skillLoss ? mType->info.experience : 0;
		}
		uint16_t getLookCorpse() const override {
			return mType->info.lookcorpse;
		}
		void dropLoot(Container* corpse, Creature* lastHitCreature) override;
		uint32_t getDamageImmunities() const override {
			return mType->info.damageImmunities;
		}
		uint32_t getConditionImmunities() const override {
			return mType->info.conditionImmunities;
		}
		void getPathSearchParams(const Creature* creature, FindPathParams& fpp) const override;
		bool useCacheMap() const override {
			return !randomStepping;
		}

		friend class LuaScriptInterface;
};

#endif
