guild_cfg = {
	storage_text = 801,
	storage_status_rename = 0,
	storage_status_member_title = 1,
	storage_status_member_invite = 2,
	storage_status_rank_title = 3,
	storage_status_war_enemies = 4,
	maxnamelen = 30,
	maxranklen = 20, -- unused
	maxnicklen = 15,
	leaderlevel = 1,
	allow_pattern = "^[a-zA-Z -]+$" -- allow_pattern = '^[a-zA-Z0-9 -]+$' -- todo: allow ' - once
}

guild_ranks = {"[M]", "[V]", "[L]"}

-- manage ranks
-- manage wars
-- manage members
-- pass leadership

function getPlayerNameByGUID(guid)
		local a = db.storeQuery('SELECT `name` FROM `players` WHERE `id` = ' .. guid .. ' LIMIT 1')
		if a then
		return result.getDataString(a, "name")
		end
	return nil
end

function playerExists(name)
	local a = db.storeQuery('SELECT `name` FROM `players` WHERE `name` = ' .. db.escapeString(name) .. ' LIMIT 1')
	if a then return true end
	return false
end

function isPlayerOnline(name)
	if getPlayerByName(name) then
		return true
	end
	return false
end

function getGuildRankLevel(rank_id)
	local a = db.storeQuery("SELECT `level` FROM `guild_ranks` WHERE `id` = ".. rank_id)
	if a then
		return result.getDataInt(a, "level")
	end
end

function getPlayerGuildRank(guid)
	local a = db.storeQuery("SELECT `rank_id` FROM `guild_membership` WHERE `player_id` = " .. guid)
	if a then
		return getGuildRankLevel(result.getDataInt(a, "rank_id"))
	end
	return 0
end

function getPlayerGuildNickGUID(guid)
	if playerExists(getPlayerNameByGUID(guid)) then
		local a = db.storeQuery("SELECT `nick` FROM `guild_membership` WHERE `player_id` = " .. guid)
		if a then
			return result.getDataString(a, "nick")
		end
	end
end

function isGuildLeader(cid)
	local a = db.storeQuery("SELECT `rank_id` FROM `guild_membership` WHERE `player_id` = " .. getPlayerGUID(cid))
	if a then
		return getGuildRankLevel(result.getDataInt(a, "rank_id")) == 3
	end
	return false
end

function isGuildViceLeader(cid)
	local a = db.storeQuery("SELECT `rank_id` FROM `guild_membership` WHERE `player_id` = " .. getPlayerGUID(cid))
	if a then
		return getGuildRankLevel(result.getDataInt(a, "rank_id")) > 1
	end
	return false
end

function isInGuild(cid)
	local a = db.storeQuery("SELECT `player_id` FROM `guild_membership` WHERE `player_id` = " .. getPlayerGUID(cid))
	if a then
		return true
	end
	return false
end

function doRenameGuild(guild_id, text)
	db.query("UPDATE `guilds` SET `name` = " .. db.escapeString(text) .. " WHERE `id` = ".. guild_id)
	return false
end

function getFirstGuildRank(guild_id)
	local a = db.storeQuery("SELECT `id` FROM `guild_ranks` WHERE `guild_id` = " .. guild_id .. " LIMIT 1")
	if a then
		return result.getDataInt(a, "id")
	end
	return 0
end

function getLastGuildRank(guild_id)
local resultId = db.storeQuery("SELECT `id` FROM `guild_ranks` WHERE `guild_id` = " .. guild_id)
	if resultId ~= false then
		repeat
			gid = result.getDataInt(resultId, "id")
		until not result.next(resultId)
		result.free(resultId)
		return gid
	end
	return false
end

function getGuildName(guild_id)
	local a = db.storeQuery("SELECT `name` FROM `guilds` WHERE `id` = " .. guild_id)
	if a then
		return result.getDataString(a, "name")
	end
	return nil
end

function getPlayerGuild(cid)
	local a = db.storeQuery("SELECT `guild_id` FROM `guild_membership` WHERE `player_id` = " .. getPlayerGUID(cid))
	if a then
		return result.getDataInt(a, "guild_id")
	end
	local b = db.storeQuery("SELECT `id` FROM `guilds` WHERE `ownerid` = " .. getPlayerGUID(cid))
	if b then
		db.query("INSERT INTO `guild_membership` (`player_id`,`guild_id`,`rank_id`) VALUES (" .. getPlayerGUID(cid) .. ", " .. result.getDataInt(b, "id") .. ", " .. getFirstGuildRank(result.getDataInt(b, "id")) .. ")")
		return result.getDataInt(b, "id")
	end
	return 0
end

function getPlayerGuildByGUID(guid)
	local a = db.storeQuery("SELECT `guild_id` FROM `guild_membership` WHERE `player_id` = " .. guid)
	if a then
		return result.getDataInt(a, "guild_id")
	end
	local b = db.storeQuery("SELECT `id` FROM `guilds` WHERE `ownerid` = " .. guid)
	if b then
		db.query("INSERT INTO `guild_membership` (`player_id`,`guild_id`,`rank_id`) VALUES (" .. guid .. ", " .. result.getDataInt(b, "id") .. ", " .. getFirstGuildRank(result.getDataInt(b, "id")) .. ")")
		return result.getDataInt(b, "id")
	end
	return 0
end

function doCreateGuild(cid, guildname)
	if isInGuild(cid) then
		return "You already have a guild membership."
	end
	
	local a = db.storeQuery("SELECT `name` FROM `guilds` WHERE `name` = " .. db.escapeString(guildname) .. " LIMIT 1")
	if a then
		return "Guild with name " .. result.getDataString(a, "name") .. " already exist."
	else
		db.query("INSERT INTO `guilds` (`name`,`ownerid`,`creationdata`) VALUES (" .. db.escapeString(guildname) .. "," .. getPlayerGUID(cid) .. "," .. os.time() .. ")")
		getPlayerGuild(cid)
		return "Your guild has been created."
	end
end

function sendGuildWindow(cid)
	guildWindow = ModalWindow(1980, "Guild Management", "Available options:")
	if guildWindow:getId() == 1980 then
		guildWindow:addButton(1, "Select")
		guildWindow:setDefaultEnterButton(1)
		guildWindow:addButton(2, "Cancel")
		guildWindow:setDefaultEscapeButton(2)
		
		if not isInGuild(cid) then
			if getPlayerLevel(cid) >= guild_cfg.leaderlevel then
				guildWindow:addChoice(1, "Found")
			end
			guildWindow:addChoice(2, "Join")
		else
			guildWindow:addChoice(1, "Edit title")
			if isGuildViceLeader(cid) then
				guildWindow:addChoice(2, "Member list")
				guildWindow:addChoice(3, "Invites")
			end

			if isGuildLeader(cid) then
				guildWindow:addChoice(4, "Rename guild")
				guildWindow:addChoice(5, "Rename ranks")
				guildWindow:addChoice(6, "Wars")
				guildWindow:addChoice(7, "Disband guild")
			else
				guildWindow:addChoice(7, "Leave guild")
			end
		end
	end
	guildWindow:sendToPlayer(cid)
	return true
end

function sendGuildInvites(cid)
	if isGuildViceLeader(cid) then
		inviteWindow = ModalWindow(1981, "Guild Management", "Invited players:")
		inviteWindow:addButton(1, "Remove")
		inviteWindow:addButton(2, "Exit")
		inviteWindow:addButton(3, "Add")
		inviteWindow:setDefaultEnterButton(1)
		inviteWindow:setDefaultEscapeButton(2)
		
		if inviteWindow:getId() == 1981 then
			local resultId = db.storeQuery("SELECT `player_id` FROM `guild_invites` WHERE `guild_id` = " .. getPlayerGuild(cid))
			if resultId ~= false then
				invite_choice_id = 0
				repeat
					local pid = result.getDataInt(resultId, "player_id")
					invite_choice_id = invite_choice_id + 1
					inviteWindow:addChoice(invite_choice_id, getPlayerNameByGUID(pid))
				until not result.next(resultId)
				result.free(resultId)
			end
		end
		inviteWindow:sendToPlayer(cid)
	else
		if isInGuild(cid) then
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Insufficient rank level.")
			return false
		else
			inviteWindow = ModalWindow(1981, "Guild", "Invitations:")
			inviteWindow:addButton(1, "Refuse")
			inviteWindow:addButton(2, "Exit")
			inviteWindow:addButton(3, "Accept")
			inviteWindow:setDefaultEnterButton(3)
			inviteWindow:setDefaultEscapeButton(2)
			
			if inviteWindow:getId() == 1981 then
			local resultId = db.storeQuery("SELECT `guild_id` FROM `guild_invites` WHERE `player_id` = " .. getPlayerGUID(cid))
			if resultId ~= false then
				invite_choice_id = 0
				repeat
					local gid = result.getDataInt(resultId, "guild_id")
					invite_choice_id = invite_choice_id + 1
					inviteWindow:addChoice(invite_choice_id, getGuildName(gid))
				until not result.next(resultId)
				result.free(resultId)
			end
		end
		inviteWindow:sendToPlayer(cid)
		end
	end
	return true
end

function sendDisbandWarning(cid)
	if isGuildLeader(cid) then
		disbandWindow = ModalWindow(1982, "Warning", "This action will DELETE your guild! Are you sure?")
		disbandWindow:addButton(1, "Disband")
		disbandWindow:addButton(2, "Cancel")
		disbandWindow:setDefaultEnterButton(1)
		disbandWindow:setDefaultEscapeButton(2)
	else
		if isInGuild(cid) then
			disbandWindow = ModalWindow(1982, "Warning", "You will leave your guild. Are you sure?")
			disbandWindow:addButton(1, "Leave")
			disbandWindow:addButton(2, "Cancel")
			disbandWindow:setDefaultEnterButton(1)
			disbandWindow:setDefaultEscapeButton(2)
		end
	end
	disbandWindow:sendToPlayer(cid)
	return true
end

function sendMemberList(cid)
	if not isGuildViceLeader(cid) then
		return false
	end

	-- getPlayerGuild(cid)
	memberWindow = ModalWindow(1983, "Guild", "Members:")
	memberWindow:addButton(1, "Exclude")
	memberWindow:addButton(2, "Exit")
	if isGuildLeader(cid) then
		memberWindow:addButton(3, "Rank")
		memberWindow:setDefaultEnterButton(3)
	else
		memberWindow:setDefaultEnterButton(1)
	end
	memberWindow:addButton(4, "Rem. Title")
	memberWindow:setDefaultEscapeButton(2)
	
	local resultId = db.storeQuery("SELECT `player_id` FROM `guild_membership` WHERE `guild_id` = " .. getPlayerGuild(cid))
	if resultId ~= false then
		guild_member_id = 0
		repeat
			local pid = result.getDataInt(resultId, "player_id")
			guild_member_id = guild_member_id + 1
			if getPlayerGuildNickGUID(pid) == "" then
				memberWindow:addChoice(guild_member_id, guild_ranks[getPlayerGuildRank(pid)] .. " " .. getPlayerNameByGUID(pid))
			else
				memberWindow:addChoice(guild_member_id, guild_ranks[getPlayerGuildRank(pid)] .. " " .. getPlayerNameByGUID(pid) .. " (" .. getPlayerGuildNickGUID(pid) .. ")")			
			end
		until not result.next(resultId)
		result.free(resultId)
	end
		
	memberWindow:sendToPlayer(cid)
	return true
end

function sendExcludeWarning(cid, target_guid)
	if getPlayerGUID(cid) == target_guid then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You can't exclude yourself.")
		return true
	end
	
	if getPlayerGuildRank(target_guid) >= getPlayerGuildRank(getPlayerGUID(cid)) then
		if not isGuildLeader(cid) then
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Insufficient rank level.")
			return true
		end
	end

	setPlayerStorageValue(cid, 802, target_guid)
	excludeWindow = ModalWindow(1984, "Warning", "Are you sure you want to EXCLUDE " .. getPlayerNameByGUID(target_guid) .. " from guild?")
	excludeWindow:addButton(1, "Exclude")
	excludeWindow:addButton(2, "Cancel")
	excludeWindow:setDefaultEnterButton(1)
	excludeWindow:setDefaultEscapeButton(2)
	excludeWindow:sendToPlayer(cid)
	return true
end

function sendRankWindow(cid)
local target_guid = getPlayerStorageValue(cid, 802)
	if getPlayerGUID(cid) == target_guid then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You can't edit your own rank.")
		return true
	end

	if getPlayerGuildRank(target_guid) >= getPlayerGuildRank(getPlayerGUID(cid)) then
		if not isGuildLeader(cid) then
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Insufficient rank level.")
			return true
		end
	end

	rankWindow = ModalWindow(1985, "Guild", "Set " .. getPlayerNameByGUID(target_guid) .. "'s rank to:")
	rankWindow:addChoice(1, "Pass leadership to " .. getPlayerNameByGUID(target_guid))
	rankWindow:addChoice(2, "Vice leader")
	rankWindow:addChoice(3, "Member")
	rankWindow:addButton(1, "Select")
	rankWindow:addButton(2, "Cancel")
	rankWindow:setDefaultEnterButton(1)
	rankWindow:setDefaultEscapeButton(2)
	rankWindow:sendToPlayer(cid)
	return true
end

function sendPassLeadershipWarning(cid)
	if not isGuildLeader(cid) then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Insufficient rank level.")
		return true
	end
	
	passLeaderWindow = ModalWindow(1986, "Warning", "YOU WILL LOSE YOUR LEADER STATUS!\nAre you sure that you want to pass guild leadership to " .. getPlayerNameByGUID(getPlayerStorageValue(cid, 802)) .. "?")
	passLeaderWindow:addButton(1, "Confirm")
	passLeaderWindow:addButton(2, "Cancel")
	passLeaderWindow:setDefaultEnterButton(1)
	passLeaderWindow:setDefaultEscapeButton(2)
	passLeaderWindow:sendToPlayer(cid)
end