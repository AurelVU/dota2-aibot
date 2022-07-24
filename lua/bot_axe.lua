-- -- bot_axe.lua
 
-- --------------------------------------------------------------------------------
 
-- local fountainLocation = Vector(-5923.0, -5337.0, 384.0);
-- local fountainRadius = 400.0;
 
-- --------------------------------------------------------------------------------
 
-- function Think()
 
--     print( "test" );
--     print("test.lua");

--     local npcBot = GetBot();
--     dofile("test.lua");
--     local angle = math.rad(math.fmod(npcBot:GetFacing()+30, 360)); -- Calculate next position's angle
--     local newLocation = Vector(fountainLocation.x+fountainRadius*math.cos(angle), fountainLocation.y+fountainRadius*math.sin(angle), fountainLocation.z);
--     npcBot:Action_MoveToLocation(newLocation);
--     DebugDrawLine(fountainLocation, newLocation, 255, 0, 0);
--     print("test_end");
 
-- end
 
-- -----------------------------------------------------------------------

count = 1
function Think()
	
	--[[for key,unit in pairs(location) do
		print(key,value)
	end]]

	--location = bot:GetLocation()

	local bot = GetBot();

	bot:Action_MoveDirectly(Vector(-1350.0, -150.0, 0.0));
	--[[if DotaTime() > 0 then
		--bot:ActionQueue_Delay(20);
		bot:Action_MoveDirectly(Vector(0.0, 0.0, 0.0));
	end]]--
	
	local loc = tostring(bot:GetLocation());
	local mana = tostring(bot:GetMana());
	local maxMana = tostring(bot:GetMaxMana());
	local hp = tostring(bot:GetHealth());
	local maxHp = tostring(bot:GetMaxHealth());

	local state = "state is: {" ..
        '"loc" : [' .. loc  .. '], ' ..
		'"hp" : ' .. hp .. ', ' ..
		'"max_hp" : ' .. maxHp .. ', ' ..
		'"mana" : ' .. mana .. ', ' ..
		'"max_mana" : ' .. maxMana .. ', ' ..
		'"dota_time" : ' .. DotaTime();

	--loc;hp;maxHp;mana;maxMana;DotaTime(); escrever com uma determinada ordem e fazer o parse com a mesma ordem
	
	print(state)

	local oldCount = count;

	local cmd, err = loadfile(GetScriptDirectory()..'/test');
    print(err);
    print(GetScriptDirectory()..'/test.lua');
    print(cmd);
    cmd();
	if cmd == nil then
		return
	end


	if string.starts(cmd(), "MoveToLocation") then
		cmd_split = split(cmd());
		x = cmd_split[2];
		y = cmd_split[3];

		bot:Action_MoveDirectly(Vector(x, y, 0.0));

	elseif cmd() == 'hello' then
		print("Hi there");
		
	else
		print("");
	end

	count = count + 1;

end


function string.starts(String,Start)
	return string.sub(String,1,string.len(Start))==Start
end


--split = function(s, pattern, maxsplit)
function split(s, pattern, maxsplit)
	local pattern = pattern or ' '
	local maxsplit = maxsplit or -1
	local s = s
	local t = {}
	local patsz = #pattern
	while maxsplit ~= 0 do
		local curpos = 1
		local found = string.find(s, pattern)
		if found ~= nil then
			table.insert(t, string.sub(s, curpos, found - 1))
			curpos = found + patsz
			s = string.sub(s, curpos)
		else
			table.insert(t, string.sub(s, curpos))
			break
		end
		maxsplit = maxsplit - 1
		if maxsplit == 0 then
			table.insert(t, string.sub(s, curpos - patsz - 1))
		end
	end
	return t
end