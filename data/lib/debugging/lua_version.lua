function printLuaVersion()
	if type(jit) == 'table' then
		print('>> Using ' .. jit.version)  --LuaJIT 2.0.2
	else
		print('>> Using ' .. _VERSION)
	end
end

-- uncomment to print on startup
-- printLuaVersion()