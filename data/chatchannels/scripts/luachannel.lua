local CHAT_ID = 32

function Player:sendChannelConsoleMessage(name, msg, type, chatId)
	m = NetworkMessage()
	m:addByte(0xAA)
	m:addU32(0x00)
	m:addString(name)
	m:addU16(0x00)
	m:addByte(type)
	m:addU16(chatId)
	m:addString(msg)
	m:sendToPlayer(self)
end
--[[
local function setfenv(fn, env)
  local i = 1
  while true do
    local name = debug.getupvalue(fn, i)
    if name == "_ENV" then
      debug.upvaluejoin(fn, i, (function()
        return env
      end), 1)
      break
    elseif not name then
      break
    end

    i = i + 1
  end

  return fn
end
]]
--[[
local function getfenv(fn)
  local i = 1
  while true do
    local name, val = debug.getupvalue(fn, i)
    if name == "_ENV" then
      return val
    elseif not name then
      break
    end
    i = i + 1
  end
end
]]

function canJoin(player)
	return player:getAccountType() >= ACCOUNT_TYPE_GOD
end

local function InteractiveConsole(env)
	return coroutine.wrap(function(inp, out, err)
		local sandbox = setmetatable({ }, 
			{
				__index = function(t, index)
					return rawget(t, index) or env[index] or _G[index]
				end
			}
		)
		sandbox._G = sandbox
		sandbox.os = {
			time = function() return os.time() end,
			mtime = function() return os.mtime() end,
			date = function(...) return os.date(...) end,
			-- execute = function(...) return os.execute(...) end
		}
		sandbox.io = { }
		sandbox.pcall = { }
		sandbox.loadstring = { }
		sandbox.debug = { }		
		sandbox.error = err
		sandbox.print = function(...)
			local r = {}
			for _, v in ipairs({...}) do
				table.insert(r, tostring(v))
			end
			local s = table.concat(r, string.rep(' ', 4))
			return out(#s > 0 and s or 'nil')
		end		

		local chunks = {}
		local level = 1

		while true do
			table.insert(chunks, coroutine.yield())

			local func, e = loadstring(table.concat(chunks, ' '), 'console')
			if func then
				setfenv(func, sandbox)
				inp(string.rep('>', level) .. ' ' .. chunks[#chunks])
				local s, e = pcall(func)
				
				-- 
				-- if glitchy replace all with "if not s then err(e) end"
				if e then
					local et = type(e)
					local msg = ""
					if et == "string" or et == "number" then
						msg = e
					elseif et == "boolean" then
						if e then
							msg = "true"
						else
							msg = "false"
						end
					else
						msg = type(e)
					end
					
					err(msg)
				end
				--

				chunks = { }
				level = 1
			else
				if not e:find('near \'<eof>\'$') then
					inp(string.rep('>', level) .. ' ' .. chunks[#chunks])
					chunks = { }
					level = 1
					err(e)
				else					
					inp(string.rep('>', level) .. ' ' .. chunks[#chunks])
					level = 2
				end
			end
		end
	end)
end

local consoles = { }
function onSpeak(player, type, message)
	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end

	local pid = player:getId()
	local console = consoles[pid]
	if not console then
		console = InteractiveConsole {}
		console(
			function(inp)
				local player = Player(pid)
				if player then
					player:sendChannelMessage(nil, inp, TALKTYPE_CHANNEL_Y, CHAT_ID)
				end
			end,
			
			function(s)
				local player = Player(pid)
				if player then
					player:sendChannelMessage(nil, s, TALKTYPE_CHANNEL_O, CHAT_ID)
				end
			end,

			function(e)
				local player = Player(pid)
				if player then
					player:sendChannelMessage(nil, e, TALKTYPE_CHANNEL_R1, CHAT_ID)
				end
			end
		)

		consoles[pid] = console
	end

	console(message)
	return false
end