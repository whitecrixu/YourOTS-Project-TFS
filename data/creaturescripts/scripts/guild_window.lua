function checkNewNameWord(name_word, i)
	if name_word == "of" then return "of" end
	if name_word == "the" and i ~= 1 then return "the" end
	return name_word:gsub("^%l", string.upper)
end

function onModalWindow(player, modalWindowId, buttonId, choiceId)
	local cid = player:getId()
	if modalWindowId == 1980 then
		if buttonId == 1 then
			if not isInGuild(cid) then
				if choiceId == 1 then
					if getPlayerLevel(cid) >= guild_cfg.leaderlevel then
						setPlayerStorageValue(cid, guild_cfg.storage_text, guild_cfg.storage_status_rename)
						Player(cid):showTextDialog(12398, "<Type guild name here>", true, 30)
					else
						doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You need " .. guild_cfg.leaderlevel .. " level to found a guild.")
					end
					return true
				elseif choiceId == 2 then
					sendGuildInvites(cid)
					return true
				end
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "An error occured. Please try again.")
				return true
			else
				if choiceId == 1 then
					setPlayerStorageValue(cid, guild_cfg.storage_text, guild_cfg.storage_status_member_title)
					Player(cid):showTextDialog(12398, "<Insert title>", true, guild_cfg.maxnicklen)
					return true
				end
				
				if isGuildViceLeader(cid) then
					if choiceId == 2 then
						sendMemberList(cid)
						return true
					elseif choiceId == 3 then
						sendGuildInvites(cid)
						return true
					end
				end

				if isGuildLeader(cid) then
					if choiceId == 4 then
						setPlayerStorageValue(cid, guild_cfg.storage_text, guild_cfg.storage_status_rename)
						Player(cid):showTextDialog(12398, "<Type new guild name here>", true, 30)
						return true
					elseif choiceId == 5 then
						Player(cid):popupFYI("Feature unavailable.")
						return true
					elseif choiceId == 6 then
						Player(cid):popupFYI("Feature unavailable.")
						return true
					-- guildWindow:addChoice(5, "Rename ranks")
					-- guildWindow:addChoice(6, "Wars")
					elseif choiceId == 7 then
						sendDisbandWarning(cid)
						return true
					end
				else
					if choiceId == 7 then
						sendDisbandWarning(cid)
						return true
					end
				end
			end
		end
		return true
	elseif modalWindowId == 1981 then
		if isGuildViceLeader(cid) then
			if buttonId == 1 then
				local resultId = db.storeQuery("SELECT `player_id` FROM `guild_invites` WHERE `guild_id` = " .. getPlayerGuild(cid))
				if resultId ~= false then
					invite_choice_id = 0
					repeat
						gid = result.getDataInt(resultId, "player_id")
						invite_choice_id = invite_choice_id + 1
					until not result.next(resultId) or invite_choice_id == choiceId
					result.free(resultId)
					
					db.query("DELETE FROM `guild_invites` WHERE `player_id` = " .. gid .. " AND `guild_id` = " .. getPlayerGuild(cid))
					doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Invitation removed.")
					return true
				end
				return true
			elseif buttonId == 3 then
					setPlayerStorageValue(cid, guild_cfg.storage_text, guild_cfg.storage_status_member_invite)
					Player(cid):showTextDialog(12398, "<Type player name here>", true, 40)
				return true
			end
		else
			if isInGuild(cid) then
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Insufficient rank level.")
				return false
			else
				local resultId = db.storeQuery("SELECT `guild_id` FROM `guild_invites` WHERE `player_id` = " .. getPlayerGUID(cid))
				if resultId ~= false then
					invite_choice_id = 0
					repeat
						gid = result.getDataInt(resultId, "guild_id")
						invite_choice_id = invite_choice_id + 1
					until not result.next(resultId) or invite_choice_id == choiceId
					result.free(resultId)
					
					if buttonId == 1 then
						db.query("DELETE FROM `guild_invites` WHERE `player_id` = " .. getPlayerGUID(cid) .. " AND `guild_id` = " .. gid)
						doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Invitation to " .. getGuildName(gid) .. " refused.")
						return true
					elseif buttonId == 3 then
						doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have joined the " .. getGuildName(gid) .. ".")
						db.query("DELETE FROM `guild_invites` WHERE `player_id` = " .. getPlayerGUID(cid) .. " AND `guild_id` = " .. gid)
						db.query("INSERT INTO `guild_membership` (`player_id`,`guild_id`,`rank_id`) VALUES (" .. getPlayerGUID(cid) .. ", " .. gid .. ", " .. getLastGuildRank(gid) .. ")")
						return true
					end
				end
			end
		end
	elseif modalWindowId == 1982 then
		if isGuildLeader(cid) then
			if buttonId == 1 then
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Your guild has been disbanded.")
				db.query("DELETE FROM `guilds` WHERE `ownerid` = " .. getPlayerGUID(cid))
			end
		else
			if isInGuild(cid) then
				if buttonId == 1 then
					doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have left the guild.")
					db.query("DELETE FROM `guild_membership` WHERE `player_id` = " .. getPlayerGUID(cid))
				end
			else
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You don't have any guild membership.")
			end
		end
	return true
	elseif modalWindowId == 1983 then
		if isGuildViceLeader(cid) then
			local resultId = db.storeQuery("SELECT `player_id` FROM `guild_membership` WHERE `guild_id` = " .. getPlayerGuild(cid))
			if resultId ~= false then
				invite_choice_id = 0
				repeat
					gid = result.getDataInt(resultId, "player_id")
					invite_choice_id = invite_choice_id + 1
				until not result.next(resultId) or invite_choice_id == choiceId
				result.free(resultId)
			end
			
			if buttonId == 1 then
				sendExcludeWarning(cid, gid)
				return true
			elseif buttonId == 3 then
				if isGuildLeader(cid) then
					setPlayerStorageValue(cid, 802, gid)
					sendRankWindow(cid)
					return true
				end
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Insufficient rank level.")
				return true
			elseif buttonId == 4 then
				db.query("UPDATE `guild_membership` SET `nick` = '' WHERE `player_id` = " .. gid)
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, getPlayerNameByGUID(gid).. "'s title has been removed.")
				return true
			end
		end
	return true
	elseif modalWindowId == 1984 then
		if buttonId == 1 then
			local v = getPlayerStorageValue(cid, 802)
			local n = getPlayerNameByGUID(v)
			db.query("DELETE FROM `guild_membership` WHERE `player_id` = " .. v .. " AND `guild_id` = " .. getPlayerGuild(cid))
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, n .. " has been excluded.")
			if isPlayerOnline(n) then
				doPlayerSendTextMessage(getPlayerByName(n), MESSAGE_INFO_DESCR, "You have been excluded from your guild.")
			end
		end
	return true
	elseif modalWindowId == 1985 then
		if not isGuildLeader(cid) then
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Insufficient rank level.")
			return true
		end
		
		if buttonId == 1 then
			local target = getPlayerStorageValue(cid, 802)
			if choiceId == 1 then
				sendPassLeadershipWarning(cid)
				return true
			elseif choiceId == 2 then
				local a = db.storeQuery("SELECT `id` FROM `guild_ranks` WHERE `level` = 2 AND `guild_id` = " .. getPlayerGuild(cid))
				local vice = result.getDataInt(a, "id")
				local g = getPlayerNameByGUID(target)
				db.query("UPDATE `guild_membership` SET `rank_id` = " .. vice .. " WHERE `player_id` = " .. target .. " AND `guild_id` = " .. getPlayerGuild(cid))
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, g .. "'s rank has been updated.")
				if isPlayerOnline(g) then
					doPlayerSendTextMessage(getPlayerByName(g), MESSAGE_INFO_DESCR, "Your guild rank has been updated.")
				end
				return true
			elseif choiceId == 3 then
				local a = db.storeQuery("SELECT `id` FROM `guild_ranks` WHERE `level` = 1 AND `guild_id` = " .. getPlayerGuild(cid))
				local m = result.getDataInt(a, "id")
				db.query("UPDATE `guild_membership` SET `rank_id` = " .. m .. " WHERE `player_id` = " .. target .. " AND `guild_id` = " .. getPlayerGuild(cid))
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, getPlayerNameByGUID(target) .. "'s rank has been updated.")
				if isPlayerOnline(g) then
					doPlayerSendTextMessage(getPlayerByName(g), MESSAGE_INFO_DESCR, "Your guild rank has been updated.")
				end				
				return true
			end
		end
	return true
	elseif modalWindowId == 1986 then
		if not isGuildLeader(cid) then
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Insufficient rank level.")
			return true
		end
		
		if buttonId == 1 then
			local a = db.storeQuery("SELECT `id` FROM `guild_ranks` WHERE `level` = 3 AND `guild_id` = " .. getPlayerGuild(cid))
			local leader = result.getDataInt(a, "id")
			local g = getPlayerNameByGUID(getPlayerStorageValue(cid, 802))
			db.query("UPDATE `guild_membership` SET `rank_id` = " .. leader .. " WHERE `player_id` = " .. getPlayerStorageValue(cid, 802) .. " AND `guild_id` = " .. getPlayerGuild(cid))
			if isPlayerOnline(g) then
				doPlayerSendTextMessage(getPlayerByName(g), MESSAGE_INFO_DESCR, getPlayerName(cid) .. " has passed guild leadership to you.")
			end	
				
			local a = db.storeQuery("SELECT `id` FROM `guild_ranks` WHERE `level` = 2 AND `guild_id` = " .. getPlayerGuild(cid))
			local vice = result.getDataInt(a, "id")
			db.query("UPDATE `guild_membership` SET `rank_id` = " .. vice .. " WHERE `player_id` = " .. getPlayerGUID(cid) .. " AND `guild_id` = " .. getPlayerGuild(cid))
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have passed guild leadership to " .. g .. ".")
		end
	return true
	end
return false
end

function onTextEdit(player, item, text)
	if(item.itemid ~= 12398) then
		return true
	end

	local cid = player:getId()
	
	local people = getSpectators(player:getPosition(), 7, 7, false, false)
	if people == nil then
		return true
	end

	for i = 1, #people do
		if isNpc(people[i]) then
			if Creature(people[i]):getName() == "Guild Master" then
				local gstat = getPlayerStorageValue(cid, guild_cfg.storage_text)
				if gstat == guild_cfg.storage_status_rename then
					if isInGuild(cid) then
						if isGuildLeader(cid) then
							if #text > guild_cfg.maxnamelen then
								doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "This guild name is too long.")
								return false
							end
							
							if string.find(text, guild_cfg.allow_pattern) then					
								doRenameGuild(getPlayerGuild(cid), text)
								local g = Guild(getPlayerGuild(cid))
								if g ~= nil then
									sendGuildChannelMessage(getPlayerGuild(cid), TALKTYPE_CHANNEL_O, "Your guild is now known as " .. text)
								end
								doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Your guild has been renamed.")									
								return false
							else
								doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "This guild name contains forbidden characters.")
								return false
							end
						else
							doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Insufficient rank level.")
							return false
						end
					else
						if getPlayerLevel(cid) >= guild_cfg.leaderlevel then
							if #text > guild_cfg.maxnamelen then
								doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "This guild name is too long.")
							else
								if string.find(text, guild_cfg.allow_pattern) then
									local g = doCreateGuild(cid, text)
									doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, g)									
									return false
								else
									doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "This guild name contains forbidden characters.")
									return false
								end
							end
						else
							doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You need " .. guild_cfg.leaderlevel .. " level to found a guild.")
							return false
						end
					end
					return false
				elseif gstat == guild_cfg.storage_status_member_title then
					local _, count = string.gsub(text, "-", "")
					if string.find(text, guild_cfg.allow_pattern) and count < 2 then
						db.query("UPDATE `guild_membership` SET `nick` = " .. db.escapeString(text) .. " WHERE `player_id` = " .. getPlayerGUID(cid))
						doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Your title has been updated.")
					else
						if text == "" then
							db.query("UPDATE `guild_membership` SET `nick` = " .. db.escapeString(text) .. " WHERE `player_id` = " .. getPlayerGUID(cid))
							doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Your title has been updated.")
						else
							doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "This title contains forbidden characters.")
						end
					end
					return false
				elseif gstat == guild_cfg.storage_status_member_invite then
					if isGuildViceLeader(cid) then
						if playerExists(text) then
							if getPlayerGuildByGUID(getPlayerGUIDByName(text)) == 0 then
								db.query("INSERT INTO `guild_invites` (`player_id`, `guild_id`) VALUES (" .. getPlayerGUIDByName(text) .. ", " .. getPlayerGuild(cid) .. ")")
								doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, text .. " has been invited.")
								if isPlayerOnline(text) then
									doPlayerSendTextMessage(getPlayerByName(text), MESSAGE_INFO_DESCR, getPlayerName(cid) .. " invited you to " .. getGuildName(getPlayerGuild(cid)) .. " guild.")
								end
							else
								doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "This player is already a member of another guild.")
							end
						else
							doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Player not found.")
						end
					else
						doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Insufficient rank level.")
					end
					return false
				elseif gstat == guild_cfg.storage_status_rank_title then
					-- edit rank name, check leader status
					return false
				elseif gstat == guild_cfg.storage_status_war_enemies then

					-- todo
					
					doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Wars aren't handled yet.")
					return false
				else
					doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "An error occured. Please try again.")
					return false				
				end
				break
			end
		end
	end
	
	return true
end