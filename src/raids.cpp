// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#include "otpch.h"

#include "raids.h"

#include "configmanager.h"
#include "game.h"
#include "monster.h"
#include "pugicast.h"
#include "scheduler.h"

extern Game g_game;
extern ConfigManager g_config;

Raids::Raids()
{
	scriptInterface.initState();
}

Raids::~Raids()
{
	for (Raid* raid : raidList) {
		delete raid;
	}
}

bool Raids::loadFromXml()
{
	if (isLoaded()) {
		return true;
	}

	std::string location = "Raids::loadFromXml";

	pugi::xml_document doc;
	pugi::xml_parse_result result = doc.load_file("data/raids/raids.xml");
	if (!result) {
		printXMLError("Raids::loadFromXml", "data/raids/raids.xml", result);
		return false;
	}

	for (auto raidNode : doc.child("raids").children()) {
		std::string name, file;
		uint32_t interval, margin;

		pugi::xml_attribute attr;
		if ((attr = raidNode.attribute("name"))) {
			name = attr.as_string();
		} else {
			console::reportError(location, "Raid with missing name tag!");
			continue;
		}

		if ((attr = raidNode.attribute("file"))) {
			file = attr.as_string();
		} else {
			file = fmt::format("raids/{:s}.xml", name);
			console::reportWarning(location, "File tag missing for raid " + name + "! Using default: " + file);
		}

		interval = pugi::cast<uint32_t>(raidNode.attribute("interval2").value()) * 60;
		if (interval == 0) {
			console::reportError(location, "interval2 tag missing or zero (would divide by 0) for raid " + name + "!");
			continue;
		}

		if ((attr = raidNode.attribute("margin"))) {
			margin = pugi::cast<uint32_t>(attr.value()) * 60 * 1000;
		} else {
			console::reportWarning(location, "margin tag missing for raid " + name + "!");
			margin = 0;
		}

		bool repeat;
		if ((attr = raidNode.attribute("repeat"))) {
			repeat = booleanString(attr.as_string());
		} else {
			repeat = false;
		}

		Raid* newRaid = new Raid(name, interval, margin, repeat);
		if (newRaid->loadFromXml("data/raids/" + file)) {
			raidList.push_back(newRaid);
		} else {
			console::reportFileError(location, "raid " + name);
			delete newRaid;
		}
	}

	loaded = true;
	return true;
}

static constexpr int32_t MAX_RAND_RANGE = 10000000;

bool Raids::startup()
{
	if (!isLoaded() || isStarted()) {
		return false;
	}

	setLastRaidEnd(OTSYS_TIME());

	checkRaidsEvent = g_scheduler.addEvent(createSchedulerTask(CHECK_RAIDS_INTERVAL * 1000, [this]() { checkRaids(); }));

	started = true;
	return started;
}

void Raids::checkRaids()
{
	if (!getRunning()) {
		uint64_t now = OTSYS_TIME();

		for (auto it = raidList.begin(), end = raidList.end(); it != end; ++it) {
			Raid* raid = *it;
			if (now >= (getLastRaidEnd() + raid->getMargin())) {
				if (((MAX_RAND_RANGE * CHECK_RAIDS_INTERVAL) / raid->getInterval()) >= static_cast<uint32_t>(uniform_random(0, MAX_RAND_RANGE))) {
					setRunning(raid);
					raid->startRaid();

					if (!raid->canBeRepeated()) {
						raidList.erase(it);
					}
					break;
				}
			}
		}
	}

	checkRaidsEvent = g_scheduler.addEvent(createSchedulerTask(CHECK_RAIDS_INTERVAL * 1000, [this]() { checkRaids(); }));
}

void Raids::clear()
{
	g_scheduler.stopEvent(checkRaidsEvent);
	checkRaidsEvent = 0;

	for (Raid* raid : raidList) {
		raid->stopEvents();
		delete raid;
	}
	raidList.clear();

	loaded = false;
	started = false;
	running = nullptr;
	lastRaidEnd = 0;

	scriptInterface.reInitState();
}

bool Raids::reload()
{
	clear();
	return loadFromXml();
}

Raid* Raids::getRaidByName(const std::string& name)
{
	for (Raid* raid : raidList) {
		if (caseInsensitiveEqual(raid->getName(), name)) {
			return raid;
		}
	}
	return nullptr;
}

Raid::~Raid()
{
	for (RaidEvent* raidEvent : raidEvents) {
		delete raidEvent;
	}
}

bool Raid::loadFromXml(const std::string& filename)
{
	if (isLoaded()) {
		return true;
	}

	pugi::xml_document doc;
	pugi::xml_parse_result result = doc.load_file(filename.c_str());
	if (!result) {
		printXMLError("Raid::loadFromXml", filename, result);
		return false;
	}

	for (auto eventNode : doc.child("raid").children()) {
		RaidEvent* event;
		if (caseInsensitiveEqual(eventNode.name(), "announce")) {
			event = new AnnounceEvent();
		} else if (caseInsensitiveEqual(eventNode.name(), "singlespawn")) {
			event = new SingleSpawnEvent();
		} else if (caseInsensitiveEqual(eventNode.name(), "areaspawn")) {
			event = new AreaSpawnEvent();
		} else if (caseInsensitiveEqual(eventNode.name(), "script")) {
			event = new ScriptEvent(&g_game.raids.getScriptInterface());
		} else {
			continue;
		}

		if (event->configureRaidEvent(eventNode)) {
			raidEvents.push_back(event);
		} else {
			console::reportError("Raid::loadFromXml", "Error in file " + filename + ", eventNode: " + eventNode.name());
			delete event;
		}
	}

	//sort by delay time
	std::sort(raidEvents.begin(), raidEvents.end(), [](const RaidEvent* lhs, const RaidEvent* rhs) {
		return lhs->getDelay() < rhs->getDelay();
	});

	loaded = true;
	return true;
}

void Raid::startRaid()
{
	RaidEvent* raidEvent = getNextRaidEvent();
	if (raidEvent) {
		state = RAIDSTATE_EXECUTING;
		nextEventEvent = g_scheduler.addEvent(createSchedulerTask(raidEvent->getDelay(), [=]() { executeRaidEvent(raidEvent); }));
	}
}

void Raid::executeRaidEvent(RaidEvent* raidEvent)
{
	if (raidEvent->executeEvent()) {
		nextEvent++;
		RaidEvent* newRaidEvent = getNextRaidEvent();

		if (newRaidEvent) {
			uint32_t ticks = static_cast<uint32_t>(std::max<int32_t>(RAID_MINTICKS, newRaidEvent->getDelay() - raidEvent->getDelay()));
			nextEventEvent = g_scheduler.addEvent(createSchedulerTask(ticks, [=]() { executeRaidEvent(newRaidEvent); }));
		} else {
			resetRaid();
		}
	} else {
		resetRaid();
	}
}

void Raid::resetRaid()
{
	nextEvent = 0;
	state = RAIDSTATE_IDLE;
	g_game.raids.setRunning(nullptr);
	g_game.raids.setLastRaidEnd(OTSYS_TIME());
}

void Raid::stopEvents()
{
	if (nextEventEvent != 0) {
		g_scheduler.stopEvent(nextEventEvent);
		nextEventEvent = 0;
	}
}

RaidEvent* Raid::getNextRaidEvent()
{
	if (nextEvent < raidEvents.size()) {
		return raidEvents[nextEvent];
	}
	return nullptr;
}

bool RaidEvent::configureRaidEvent(const pugi::xml_node& eventNode)
{
	pugi::xml_attribute delayAttribute = eventNode.attribute("delay");
	if (!delayAttribute) {
		console::reportError("RaidEvent::configureRaidEvent", "Delay tag missing!");
		return false;
	}

	delay = std::max<uint32_t>(RAID_MINTICKS, pugi::cast<uint32_t>(delayAttribute.value()));
	return true;
}

bool AnnounceEvent::configureRaidEvent(const pugi::xml_node& eventNode)
{
	if (!RaidEvent::configureRaidEvent(eventNode)) {
		return false;
	}

	pugi::xml_attribute messageAttribute = eventNode.attribute("message");
	if (!messageAttribute) {
		console::reportError("AnnounceEvent::configureRaidEvent", "Missing message tag for announce event!");
		return false;
	}
	message = messageAttribute.as_string();

	pugi::xml_attribute typeAttribute = eventNode.attribute("type");
	if (typeAttribute) {
		std::string tmpStrValue = asLowerCaseString(typeAttribute.as_string());
		if (tmpStrValue == "warning") {
			messageType = MESSAGE_STATUS_WARNING;
		} else if (tmpStrValue == "event") {
			messageType = MESSAGE_EVENT_ADVANCE;
		} else if (tmpStrValue == "default") {
			messageType = MESSAGE_EVENT_DEFAULT;
		} else if (tmpStrValue == "description") {
			messageType = MESSAGE_INFO_DESCR;
		} else if (tmpStrValue == "smallstatus") {
			messageType = MESSAGE_STATUS_SMALL;
		} else if (tmpStrValue == "blueconsole" || tmpStrValue == "redconsole") {
			console::reportWarning("AnnounceEvent::configureRaidEvent", fmt::format("Deprecated type tag for announce event.Using default: {:d}", static_cast<uint32_t>(messageType)));
		} else {
			console::reportWarning("AnnounceEvent::configureRaidEvent", fmt::format("Unknown type tag for announce event.Using default: {:d}", static_cast<uint32_t>(messageType)));
		}
	} else {
		messageType = MESSAGE_EVENT_ADVANCE;
		console::reportWarning("AnnounceEvent::configureRaidEvent", fmt::format("Type tag for announce event. Using default: {:d}", static_cast<uint32_t>(messageType)));
	}
	return true;
}

bool AnnounceEvent::executeEvent()
{
	g_game.broadcastMessage(message, messageType);
	return true;
}

bool SingleSpawnEvent::configureRaidEvent(const pugi::xml_node& eventNode)
{
	if (!RaidEvent::configureRaidEvent(eventNode)) {
		return false;
	}

	pugi::xml_attribute attr;
	if ((attr = eventNode.attribute("name"))) {
		monsterName = attr.as_string();
	} else {
		console::reportError("Raid", "Name tag missing for singlespawn event!");
		return false;
	}

	if ((attr = eventNode.attribute("x"))) {
		position.x = pugi::cast<uint16_t>(attr.value());
	} else {
		console::reportError("Raid", "\"x\" tag missing for singlespawn event!");
		return false;
	}

	if ((attr = eventNode.attribute("y"))) {
		position.y = pugi::cast<uint16_t>(attr.value());
	} else {
		console::reportError("Raid", "\"y\" tag missing for singlespawn event!");
		return false;
	}

	if ((attr = eventNode.attribute("z"))) {
		position.z = pugi::cast<uint16_t>(attr.value());
	} else {
		console::reportError("Raid", "\"z\" tag missing for singlespawn event!");
		return false;
	}
	return true;
}

bool SingleSpawnEvent::executeEvent()
{
	Monster* monster = Monster::createMonster(monsterName);
	if (!monster) {
		console::reportError("Raid", "Unable to create monster \"" + monsterName + "\"!");
		return false;
	}

	if (!g_game.placeCreature(monster, position, false, true)) {
		delete monster;
		console::reportError("Raid", "Unable to place monster \"" + monsterName + "\"!");
		return false;
	}
	return true;
}

bool AreaSpawnEvent::configureRaidEvent(const pugi::xml_node& eventNode)
{
	if (!RaidEvent::configureRaidEvent(eventNode)) {
		return false;
	}

	pugi::xml_attribute attr;
	if ((attr = eventNode.attribute("radius"))) {
		int32_t radius = pugi::cast<int32_t>(attr.value());
		Position centerPos;

		if ((attr = eventNode.attribute("centerx"))) {
			centerPos.x = pugi::cast<uint16_t>(attr.value());
		} else {
			console::reportError("Raid", "centerx tag missing for areaspawn event!");
			return false;
		}

		if ((attr = eventNode.attribute("centery"))) {
			centerPos.y = pugi::cast<uint16_t>(attr.value());
		} else {
			console::reportError("Raid", "centery tag missing for areaspawn event!");
			return false;
		}

		if ((attr = eventNode.attribute("centerz"))) {
			centerPos.z = pugi::cast<uint16_t>(attr.value());
		} else {
			console::reportError("Raid", "centerz tag missing for areaspawn event!");
			return false;
		}

		fromPos.x = std::max<int32_t>(0, centerPos.getX() - radius);
		fromPos.y = std::max<int32_t>(0, centerPos.getY() - radius);
		fromPos.z = centerPos.z;

		toPos.x = std::min<int32_t>(0xFFFF, centerPos.getX() + radius);
		toPos.y = std::min<int32_t>(0xFFFF, centerPos.getY() + radius);
		toPos.z = centerPos.z;
	} else {
		if ((attr = eventNode.attribute("fromx"))) {
			fromPos.x = pugi::cast<uint16_t>(attr.value());
		} else {
			console::reportError("Raid", "fromx tag missing for areaspawn event!");
			return false;
		}

		if ((attr = eventNode.attribute("fromy"))) {
			fromPos.y = pugi::cast<uint16_t>(attr.value());
		} else {
			console::reportError("Raid", "fromy tag missing for areaspawn event!");
			return false;
		}

		if ((attr = eventNode.attribute("fromz"))) {
			fromPos.z = pugi::cast<uint16_t>(attr.value());
		} else {
			console::reportError("Raid", "fromz tag missing for areaspawn event!");
			return false;
		}

		if ((attr = eventNode.attribute("tox"))) {
			toPos.x = pugi::cast<uint16_t>(attr.value());
		} else {
			console::reportError("Raid", "tox tag missing for areaspawn event!");
			return false;
		}

		if ((attr = eventNode.attribute("toy"))) {
			toPos.y = pugi::cast<uint16_t>(attr.value());
		} else {
			console::reportError("Raid", "toy tag missing for areaspawn event!");
			return false;
		}

		if ((attr = eventNode.attribute("toz"))) {
			toPos.z = pugi::cast<uint16_t>(attr.value());
		} else {
			console::reportError("Raid", "toz tag missing for areaspawn event!");
			return false;
		}
	}

	for (auto monsterNode : eventNode.children()) {
		const char* name;

		if ((attr = monsterNode.attribute("name"))) {
			name = attr.value();
		} else {
			console::reportError("Raid", "name tag missing for monster node!");
			return false;
		}

		uint32_t minAmount;
		if ((attr = monsterNode.attribute("minamount"))) {
			minAmount = pugi::cast<uint32_t>(attr.value());
		} else {
			minAmount = 0;
		}

		uint32_t maxAmount;
		if ((attr = monsterNode.attribute("maxamount"))) {
			maxAmount = pugi::cast<uint32_t>(attr.value());
		} else {
			maxAmount = 0;
		}

		if (maxAmount == 0 && minAmount == 0) {
			if ((attr = monsterNode.attribute("amount"))) {
				minAmount = pugi::cast<uint32_t>(attr.value());
				maxAmount = minAmount;
			} else {
				console::reportError("Raid", "amount tag missing for monster node!");
				return false;
			}
		}

		spawnList.emplace_back(name, minAmount, maxAmount);
	}
	return true;
}

bool AreaSpawnEvent::executeEvent()
{
	for (const MonsterSpawn& spawn : spawnList) {
		uint32_t amount = uniform_random(spawn.minAmount, spawn.maxAmount);
		for (uint32_t i = 0; i < amount; ++i) {
			Monster* monster = Monster::createMonster(spawn.name);
			if (!monster) {
				console::reportError("AreaSpawnEvent::executeEvent", "Unable to create monster \"" + spawn.name + "\"!");
				return false;
			}

			bool success = false;
			for (int32_t tries = 0; tries < MAXIMUM_TRIES_PER_MONSTER; tries++) {
				Tile* tile = g_game.map.getTile(uniform_random(fromPos.x, toPos.x), uniform_random(fromPos.y, toPos.y), uniform_random(fromPos.z, toPos.z));
				if (tile && !tile->isMoveableBlocking() && !tile->hasFlag(TILESTATE_PROTECTIONZONE) && !tile->getTopCreature() && g_game.placeCreature(monster, tile->getPosition(), false, true)) {
					success = true;
					break;
				}
			}

			if (!success) {
				delete monster;
			}
		}
	}
	return true;
}

bool ScriptEvent::configureRaidEvent(const pugi::xml_node& eventNode)
{
	if (!RaidEvent::configureRaidEvent(eventNode)) {
		return false;
	}

	pugi::xml_attribute scriptAttribute = eventNode.attribute("script");
	if (!scriptAttribute) {
		console::reportError("ScriptEvent::configureRaidEvent", "Missing \"script\" tag for raid!");
		return false;
	}

	if (!loadScript("data/raids/scripts/" + std::string(scriptAttribute.as_string()))) {
		console::reportFileError("ScriptEvent::configureRaidEvent", "raid script " + std::string(scriptAttribute.as_string()));
		return false;
	}
	return true;
}

std::string ScriptEvent::getScriptEventName() const
{
	return "onRaid";
}

bool ScriptEvent::executeEvent()
{
	//onRaid()
	if (!scriptInterface->reserveScriptEnv()) {
		console::reportOverflow("ScriptEvent::onRaid");
		return false;
	}

	ScriptEnvironment* env = scriptInterface->getScriptEnv();
	env->setScriptId(scriptId, scriptInterface);

	scriptInterface->pushFunction(scriptId);

	return scriptInterface->callFunction(0);
}
