// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#include "otpch.h"

#include "guild.h"

#include "game.h"

extern Game g_game;

void Guild::addMember(Player* player)
{
	membersOnline.push_back(player);
}

void Guild::removeMember(Player* player)
{
	membersOnline.remove(player);

	if (membersOnline.empty()) {
		g_game.removeGuild(id);
		delete this;
	}
}

GuildRank_ptr Guild::getRankById(uint32_t rankId)
{
	for (auto rank : ranks) {
		if (rank->id == rankId) {
			return rank;
		}
	}
	return nullptr;
}

GuildRank_ptr Guild::getRankByName(const std::string& name) const
{
	for (auto rank : ranks) {
		if (rank->name == name) {
			return rank;
		}
	}
	return nullptr;
}

GuildRank_ptr Guild::getRankByLevel(uint16_t level) const
{
	for (auto rank : ranks) {
		if (rank->level == level) {
			return rank;
		}
	}
	return nullptr;
}

void Guild::addRank(uint32_t rankId, const std::string& rankName, uint16_t level)
{
	if (level > leaderRankLevel) {
		leaderRankLevel = level;
	}

	ranks.emplace_back(std::make_shared<GuildRank>(rankId, rankName, level));
}

void Guild::saveMotd()
{
	Database& db = Database::getInstance();
	db.executeQuery(fmt::format("UPDATE `guilds` SET `motd` = {:s} WHERE `id` = {:d}", db.escapeString(getMotd()), getId()));
}

Guild* IOGuild::loadGuild(uint32_t guildId)
{
	Database& db = Database::getInstance();
	if (DBResult_ptr result = db.storeQuery(fmt::format("SELECT `name`, `motd` FROM `guilds` WHERE `id` = {:d}", guildId))) {
		Guild* guild = new Guild(guildId, result->getString("name"));
		const std::string& motd = result->getString("motd");
		if (!motd.empty()) {
			guild->setMotd(motd);
		}

		if ((result = db.storeQuery(fmt::format("SELECT `id`, `name`, `level` FROM `guild_ranks` WHERE `guild_id` = {:d}", guildId)))) {
			do {
				guild->addRank(result->getNumber<uint32_t>("id"), result->getString("name"), result->getNumber<uint16_t>("level"));
			} while (result->next());
		}
		return guild;
	}
	return nullptr;
}

uint32_t IOGuild::getGuildIdByName(const std::string& name)
{
	Database& db = Database::getInstance();

	DBResult_ptr result = db.storeQuery(fmt::format("SELECT `id` FROM `guilds` WHERE `name` = {:s}", db.escapeString(name)));
	if (!result) {
		return 0;
	}
	return result->getNumber<uint32_t>("id");
}
