// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#include "otpch.h"

#include "spawn.h"

#include "configmanager.h"
#include "events.h"
#include "game.h"
#include "monster.h"
#include "npc.h"
#include "pugicast.h"
#include "scheduler.h"
#include "spectators.h"

extern ConfigManager g_config;
extern Monsters g_monsters;
extern Game g_game;
extern Events* g_events;

static constexpr int32_t MINSPAWN_INTERVAL = 10 * 1000; // 10 seconds to match RME
static constexpr int32_t MAXSPAWN_INTERVAL = 24 * 60 * 60 * 1000; // 1 day

bool Spawns::loadFromXml(const std::string& filename)
{
	if (loaded) {
		return true;
	}

	std::string location = "Spawns::loadFromXml";

	pugi::xml_document doc;
	pugi::xml_parse_result result = doc.load_file(filename.c_str());
	if (!result) {
		printXMLError(location, filename, result);
		return false;
	}

	this->filename = filename;
	loaded = true;

	for (auto spawnNode : doc.child("spawns").children()) {
		Position centerPos(
			pugi::cast<uint16_t>(spawnNode.attribute("centerx").value()),
			pugi::cast<uint16_t>(spawnNode.attribute("centery").value()),
			pugi::cast<uint16_t>(spawnNode.attribute("centerz").value())
		);

		int32_t radius;
		pugi::xml_attribute radiusAttribute = spawnNode.attribute("radius");
		if (radiusAttribute) {
			radius = pugi::cast<int32_t>(radiusAttribute.value());
		} else {
			radius = -1;
		}

		if (radius > 30) {
			std::ostringstream warnMsg;
			warnMsg << "Radius size bigger than 30 at position : ";
			warnMsg << centerPos << ", consider lowering it!";
			console::reportWarning(location, warnMsg.str());
		}

		if (!spawnNode.first_child()) {
			std::ostringstream warnMsg;
			warnMsg << "Empty spawn at position : ";
			warnMsg << centerPos << ", with radius: ";
			warnMsg << radius << "!";
			console::reportWarning(location, warnMsg.str());
			continue;
		}

		spawnList.emplace_front(centerPos, radius);
		Spawn& spawn = spawnList.front();

		for (auto childNode : spawnNode.children()) {
			if (caseInsensitiveEqual(childNode.name(), "monsters")) {
				Position pos(
					centerPos.x + pugi::cast<uint16_t>(childNode.attribute("x").value()),
					centerPos.y + pugi::cast<uint16_t>(childNode.attribute("y").value()),
					centerPos.z
				);

				int32_t interval = pugi::cast<int32_t>(childNode.attribute("spawntime").value()) * 1000;
				if (interval < MINSPAWN_INTERVAL) {
					std::ostringstream warnMsg;
					warnMsg << pos << " spawntime can not be less than ";
					warnMsg << MINSPAWN_INTERVAL / 1000 << " seconds!";
					console::reportWarning(location, warnMsg.str());
					continue;
				} else if (interval > MAXSPAWN_INTERVAL) {
					std::ostringstream warnMsg;
					warnMsg << pos << " spawntime can not be more than ";
					warnMsg << MAXSPAWN_INTERVAL / 1000 << " seconds!";
					console::reportWarning(location, warnMsg.str());
					continue;
				}

				size_t monstersCount = std::distance(childNode.children().begin(), childNode.children().end());
				if (monstersCount == 0) {
					std::ostringstream warnMsg;
					warnMsg << pos << " empty monsters set!";
					console::reportWarning(location, warnMsg.str());
					continue;
				}

				uint16_t totalChance = 0;
				spawnBlock_t sb;
				sb.pos = pos;
				sb.direction = DIRECTION_NORTH;
				sb.interval = interval;
				sb.lastSpawn = 0;

				for (auto monsterNode : childNode.children()) {
					pugi::xml_attribute nameAttribute = monsterNode.attribute("name");
					if (!nameAttribute) {
						continue;
					}

					MonsterType* mType = g_monsters.getMonsterType(nameAttribute.as_string());
					if (!mType) {
						std::ostringstream warnMsg;
						warnMsg << pos << " unknown monster type \"";
						warnMsg << nameAttribute.as_string() << "\"!";
						console::reportWarning(location, warnMsg.str());
						continue;
					}

					uint16_t chance = 100 / monstersCount;
					pugi::xml_attribute chanceAttribute = monsterNode.attribute("chance");
					if (chanceAttribute) {
						chance = pugi::cast<uint16_t>(chanceAttribute.value());
					}

					if (chance + totalChance > 100) {
						chance = 100 - totalChance;
						totalChance = 100;
						std::ostringstream warnMsg;
						warnMsg << pos << " total chance for set can not be higher than 100!";
						console::reportWarning(location, warnMsg.str());
					} else {
						totalChance += chance;
					}

					sb.mTypes.push_back({mType, chance});
				}

				if (sb.mTypes.empty()) {
					std::ostringstream warnMsg;
					warnMsg << pos << " empty monsters set!";
					console::reportWarning(location, warnMsg.str());
					continue;
				}

				sb.mTypes.shrink_to_fit();
				if (sb.mTypes.size() > 1) {
					std::sort(sb.mTypes.begin(), sb.mTypes.end(), [](std::pair<MonsterType*, uint16_t> a, std::pair<MonsterType*, uint16_t> b) {
						return a.second > b.second;
					});
				}

				spawn.addBlock(sb);
				++monsterCount;
			} else if (caseInsensitiveEqual(childNode.name(), "monster")) {
				pugi::xml_attribute nameAttribute = childNode.attribute("name");
				if (!nameAttribute) {
					continue;
				}

				Direction dir;

				pugi::xml_attribute directionAttribute = childNode.attribute("direction");
				if (directionAttribute) {
					dir = static_cast<Direction>(pugi::cast<uint16_t>(directionAttribute.value()));
				} else {
					dir = DIRECTION_NORTH;
				}

				Position pos(
					centerPos.x + pugi::cast<uint16_t>(childNode.attribute("x").value()),
					centerPos.y + pugi::cast<uint16_t>(childNode.attribute("y").value()),
					centerPos.z
				);
				int32_t interval = pugi::cast<int32_t>(childNode.attribute("spawntime").value()) * 1000;
				if (interval >= MINSPAWN_INTERVAL && interval <= MAXSPAWN_INTERVAL) {
					spawn.addMonster(nameAttribute.as_string(), pos, dir, static_cast<uint32_t>(interval));
				} else {
					if (interval < MINSPAWN_INTERVAL) {
						std::ostringstream warnMsg;
						warnMsg << nameAttribute.as_string() << " " << pos;
						warnMsg << " spawntime can not be less than " << MINSPAWN_INTERVAL / 1000 << " seconds!";
						console::reportWarning(location, warnMsg.str());
					} else {
						std::ostringstream warnMsg;
						warnMsg << nameAttribute.as_string() << " " << pos;
						warnMsg << " spawntime can not be more than " << MAXSPAWN_INTERVAL / 1000 << " seconds!";
						console::reportWarning(location, warnMsg.str());
					}
				}
				++monsterCount;
			} else if (caseInsensitiveEqual(childNode.name(), "npc")) {
				pugi::xml_attribute nameAttribute = childNode.attribute("name");
				if (!nameAttribute) {
					continue;
				}

				Npc* npc = Npc::createNpc(nameAttribute.as_string());
				if (!npc) {
					continue;
				}

				pugi::xml_attribute directionAttribute = childNode.attribute("direction");
				if (directionAttribute) {
					npc->setDirection(static_cast<Direction>(pugi::cast<uint16_t>(directionAttribute.value())));
				}

				npc->setMasterPos(Position(
					centerPos.x + pugi::cast<uint16_t>(childNode.attribute("x").value()),
					centerPos.y + pugi::cast<uint16_t>(childNode.attribute("y").value()),
					centerPos.z
				), radius);
				npcList.push_front(npc);
				++npcCount;
			}
		}
	}
	return true;
}

void Spawns::startup()
{
	if (!loaded || isStarted()) {
		return;
	}

	for (Npc* npc : npcList) {
		if (!g_game.placeCreature(npc, npc->getMasterPos(), false, true)) {
			std::ostringstream warnMsg;
			warnMsg << "Couldn't spawn NPC \"" << npc->getName() << "\"";
			warnMsg << " on position: " << npc->getMasterPos() << "!";
			console::reportWarning("Spawns::startup", warnMsg.str());
			delete npc;
		}
	}
	npcList.clear();

	for (Spawn& spawn : spawnList) {
		spawn.startup();
	}

	started = true;
}

void Spawns::clear()
{
	for (Spawn& spawn : spawnList) {
		spawn.stopEvent();
	}
	spawnList.clear();

	loaded = false;
	started = false;
	filename.clear();
}

bool Spawns::isInZone(const Position& centerPos, int32_t radius, const Position& pos)
{
	if (radius == -1) {
		return true;
	}

	return ((pos.getX() >= centerPos.getX() - radius) && (pos.getX() <= centerPos.getX() + radius) &&
			(pos.getY() >= centerPos.getY() - radius) && (pos.getY() <= centerPos.getY() + radius));
}

void Spawn::startSpawnCheck()
{
	if (checkSpawnEvent == 0) {
		checkSpawnEvent = g_scheduler.addEvent(createSchedulerTask(getInterval(), [this]() { checkSpawn(); }));
	}
}

Spawn::~Spawn()
{
	for (const auto& it : spawnedMap) {
		Monster* monster = it.second;
		monster->setSpawn(nullptr);
		monster->decrementReferenceCounter();
	}
}

bool Spawn::findPlayer(const Position& pos)
{
	SpectatorVec spectators;
	g_game.map.getSpectators(spectators, pos, false, true);
	for (Creature* spectator : spectators) {
		if (!spectator->getPlayer()->hasFlag(PlayerFlag_IgnoredByMonsters)) {
			return true;
		}
	}
	return false;
}

bool Spawn::isInSpawnZone(const Position& pos)
{
	return Spawns::isInZone(centerPos, radius, pos);
}

bool Spawn::spawnMonster(uint32_t spawnId, spawnBlock_t sb, bool startup/* = false*/)
{
	bool isBlocked = !startup && findPlayer(sb.pos);
	bool ignoreBlocking = !g_config.getBoolean(ConfigManager::ALLOW_SPAWN_BLOCKING);
	bool hasUnblockables = false;

	size_t monstersCount = sb.mTypes.size(), blockedMonsters = 0;

	const auto spawnFunc = [&](bool roll, bool force) {
		for (const auto& pair : sb.mTypes) {
			bool realIgnoreBlocking = ignoreBlocking || pair.first->info.isIgnoringSpawnBlock;
			if (realIgnoreBlocking) {
				hasUnblockables = true;
			}

			if (isBlocked && (!realIgnoreBlocking || !force)) {
				++blockedMonsters;
				continue;
			}

			if (!roll) {
				return spawnMonster(spawnId, pair.first, sb.pos, sb.direction, startup);
			}

			if (pair.second >= normal_random(1, 100) && spawnMonster(spawnId, pair.first, sb.pos, sb.direction, startup)) {
				sb.spawnTries = 0;
				return true;
			}
		}

		return false;
	};

	// Try to spawn something with chance check, unless it's single spawn
	if (spawnFunc(monstersCount > 1, false)) {
		sb.spawnTries = 0;
		return true;
	}

	// Every monster spawn is blocked, bail out
	if (monstersCount == blockedMonsters && !hasUnblockables) {
		return false;
	}

	// Spawn is blocked, warn about upcoming fight
	if (sb.spawnTries < 2) {
		++sb.spawnTries;
		g_game.addMagicEffect(sb.pos, CONST_ME_TELEPORT);
		g_scheduler.addEvent(createSchedulerTask(2000, [=]() { spawnMonster(spawnId, sb, false); }));
		return false;
	}

	// Force spawn
	sb.spawnTries = 0;
	return spawnFunc(false, true);
}

bool Spawn::spawnMonster(uint32_t spawnId, MonsterType* mType, const Position& pos, Direction dir, bool startup/*= false*/)
{
	std::unique_ptr<Monster> monster_ptr(new Monster(mType));
	if (!g_events->eventMonsterOnSpawn(monster_ptr.get(), pos, startup, false)) {
		return false;
	}

	if (startup) {
		//No need to send out events to the surrounding since there is no one out there to listen!
		if (!g_game.internalPlaceCreature(monster_ptr.get(), pos, true)) {
			std::ostringstream warnMsg;
			warnMsg << "Couldn't spawn monster \"" << monster_ptr->getName() << "\"";
			warnMsg << " on position: " << pos << "!";
			console::reportWarning("Spawns::startup", warnMsg.str());
			return false;
		}
	} else {
		if (!g_game.placeCreature(monster_ptr.get(), pos, false, true)) {
			return false;
		}
	}

	Monster* monster = monster_ptr.release();
	monster->setDirection(dir);
	monster->setSpawn(this);
	monster->setMasterPos(pos);
	monster->incrementReferenceCounter();

	spawnedMap.insert({spawnId, monster});
	spawnMap[spawnId].lastSpawn = OTSYS_TIME();
	return true;
}

void Spawn::startup()
{
	for (const auto& it : spawnMap) {
		uint32_t spawnId = it.first;
		const spawnBlock_t& sb = it.second;
		spawnMonster(spawnId, sb, true);
	}
}

void Spawn::checkSpawn()
{
	checkSpawnEvent = 0;

	cleanup();

	uint32_t spawnCount = 0;

	for (auto& it : spawnMap) {
		uint32_t spawnId = it.first;
		if (spawnedMap.find(spawnId) != spawnedMap.end()) {
			continue;
		}

		spawnBlock_t& sb = it.second;
		if (OTSYS_TIME() >= sb.lastSpawn + sb.interval) {
			if (!spawnMonster(spawnId, sb)) {
				sb.lastSpawn = OTSYS_TIME();
				continue;
			}

			if (++spawnCount >= static_cast<uint32_t>(g_config.getNumber(ConfigManager::RATE_SPAWN))) {
				break;
			}
		}
	}

	if (spawnedMap.size() < spawnMap.size()) {
		checkSpawnEvent = g_scheduler.addEvent(createSchedulerTask(getInterval(), [this]() { checkSpawn(); }));
	}
}

void Spawn::cleanup()
{
	auto it = spawnedMap.begin();
	while (it != spawnedMap.end()) {
		uint32_t spawnId = it->first;
		Monster* monster = it->second;
		if (monster->isRemoved()) {
			monster->decrementReferenceCounter();
			it = spawnedMap.erase(it);
		} else if (!isInSpawnZone(monster->getPosition()) && spawnId != 0) {
			spawnedMap.insert({0, monster});
			it = spawnedMap.erase(it);
		} else {
			++it;
		}
	}
}

bool Spawn::addBlock(spawnBlock_t sb)
{
	interval = std::min(interval, sb.interval);
	spawnMap[spawnMap.size() + 1] = sb;

	return true;
}

bool Spawn::addMonster(const std::string& name, const Position& pos, Direction dir, uint32_t interval)
{
	MonsterType* mType = g_monsters.getMonsterType(name);
	if (!mType) {
		std::ostringstream warnMsg;
		warnMsg << pos << " unknown monster type \"";
		warnMsg << name << "\"!";
		console::reportWarning("Spawn::addMonster", warnMsg.str());
		return false;
	}

	spawnBlock_t sb;
	sb.mTypes.push_back({mType, 100});
	sb.pos = pos;
	sb.direction = dir;
	sb.interval = interval;
	sb.lastSpawn = 0;

	return addBlock(sb);
}

void Spawn::removeMonster(Monster* monster)
{
	for (auto it = spawnedMap.begin(), end = spawnedMap.end(); it != end; ++it) {
		if (it->second == monster) {
			monster->decrementReferenceCounter();
			spawnedMap.erase(it);
			break;
		}
	}
}

void Spawn::stopEvent()
{
	if (checkSpawnEvent != 0) {
		g_scheduler.stopEvent(checkSpawnEvent);
		checkSpawnEvent = 0;
	}
}
