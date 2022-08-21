local backpacks = {
	[1987] = { }, -- bags are not imbuable
	[1988] = { sockets = 1 },
	[1991] = { },
	[1992] = { },
	[1993] = { },
	[1994] = { },
	[1995] = { },
	[1996] = { },
	[1997] = { },
	[1998] = { sockets = 1 },
	[1999] = { sockets = 1 },
	[2000] = { sockets = 1 },
	[2001] = { sockets = 1 },
	[2002] = { sockets = 1 },
	[2003] = { sockets = 1 },
	[2004] = { sockets = 1 },
	[2365] = { sockets = 1 },
	[3939] = { },
	[3940] = { sockets = 1 },
	[3960] = { sockets = 1 },
	[5801] = { sockets = 1 },
	[5926] = { sockets = 1 },
	[5927] = { },
	[5949] = { sockets = 1 },
	[5950] = { },
	[7342] = { sockets = 1 },
	[7343] = { },
	[9774] = { sockets = 1 },
	[9775] = { },
	[10518] = { sockets = 1 },
	[10519] = { sockets = 1 },
	[10520] = { },
	[10521] = { sockets = 1 },
	[10522] = { sockets = 1 },
	[11119] = { sockets = 1 },
	[11241] = { sockets = 1 },
	[11242] = { },
	[11243] = { sockets = 1 },
	[11244] = { sockets = 1 },
	[11263] = { sockets = 1 },
	[15645] = { sockets = 1 },
	[15646] = { sockets = 1 },
	[16007] = { sockets = 1 },
	[18393] = { sockets = 1 },
	[18394] = { sockets = 1 },
	[21475] = { sockets = 1 },
	[22696] = { sockets = 1 },
	[23663] = { sockets = 1 }, -- feedbag
	[23666] = { sockets = 1 }, -- glooth backpack
	[23816] = { sockets = 1 },
	[24740] = { sockets = 1 },
	[26181] = { sockets = 1 },
	[27049] = { sockets = 1 },
	[27051] = { sockets = 1 },
	[28436] = { }, -- blossom bag (not imbuable)
	[31227] = { sockets = 1 },
	[32853] = { sockets = 1 },
	[34281] = { sockets = 1 },
	[35276] = { sockets = 1 },
	[38233] = { sockets = 1 },
	[39469] = { sockets = 1 },
	[40686] = { sockets = 1 }, -- changing backpack
}

local lightSources = {
	[2041] = {},
	[2042] = {},
	[2043] = {},
	[2044] = {},
	[2045] = {},
	[2046] = {},
	[2047] = {},
	[2048] = {},
	[2049] = {},
	[2050] = {},
	[2051] = {},
	[2052] = {},
	[2053] = {},
	[2054] = {},
	[2055] = {},
	[2056] = {},
	[2057] = {},
	[2096] = {},
	[2097] = {},
	[2162] = {},
	[2163] = {},
	[2174] = {},
	[2361] = {}, -- frozen starlight
	[5812] = {},
	[5813] = {},
	[9742] = {},
	[9948] = {},
	[9949] = {},
	[9953] = {},
	[9954] = {},
	[9956] = {},
	[9969] = {},
	[12635] = {},
	[20608] = {},
	[20609] = {},
	[20610] = {},
	[20611] = {},
	[20612] = {},
	[20613] = {},
	[20614] = {},
	[20615] = {},
	[20616] = {},
	[20617] = {},
	[20618] = {},
	[20619] = {},
	[21695] = {},
	[21699] = {},
	[21703] = {},
	[21705] = {},
	[23588] = {},
	[28385] = {}, -- dark moon mirror
	[28386] = {}, -- lit moon mirror
	[28387] = {}, -- empty starlight vial
	[28388] = {}, -- gleaming starlight vial
	[28389] = {}, -- dark sun catcher
	[28390] = {}, -- shining sun catcher
	[28631] = {}, -- moon mirror
	[28632] = {}, -- starlight vial
	[28633] = {}, -- sun catcher
	[31148] = {}, -- bone fiddle without strings
	[31149] = {}, -- bone fiddle
	[35247] = {}, -- soulforged lantern
	[36672] = {}, -- lit torch
	[40958] = {}, -- Morshabaal's extract
}

local rings = {
	[2121] = {}, -- wedding ring
	[2123] = {}, -- ring of the sky
	[2124] = {}, -- crystal ring
	[2164] = {}, -- might ring
	[2165] = {}, -- stealth ring
	[2166] = {}, -- power ring
	[2167] = {}, -- energy ring
	[2168] = {}, -- life ring
	[2169] = {}, -- time ring
	[2179] = {}, -- gold ring
	[2202] = {}, -- stealth ring
	[2203] = {}, -- power ring
	[2204] = {}, -- energy ring
	[2205] = {}, -- life ring
	[2206] = {}, -- time ring
	[2207] = {}, -- sword ring
	[2208] = {}, -- axe ring
	[2209] = {}, -- club ring
	[2210] = {}, -- sword ring
	[2211] = {}, -- axe ring
	[2212] = {}, -- club ring
	[2213] = {}, -- dwarven ring
	[2214] = {}, -- ring of healing
	[2216] = {}, -- ring of healing
	[2357] = {}, -- ring of wishes
	[6093] = {}, -- crystal ring
	[6300] = {}, -- death ring
	[6301] = {}, -- death ring
	[7697] = {}, -- suspicious signet ring
	[7708] = {}, -- family signet ring
	[7967] = {}, -- shapeshifter ring
	[7968] = {}, -- shapeshifter ring
	[8752] = {}, -- the ring of the count
	[10309] = { level = 100 }, -- claw of 'The Noxious Spawn'
	-- handled from other script
	--[10310] = { level = 100 }, -- claw of 'The Noxious Spawn'
	[10311] = { level = 100 }, -- claw of 'The Noxious Spawn'
	[10312] = { level = 100 }, -- claw of 'The Noxious Spawn'
	[10314] = { level = 100 }, -- claw of 'The Noxious Spawn'
	[10315] = { level = 100 }, -- claw of 'The Noxious Spawn'
	[10502] = {}, -- engraved wedding ring
	[10510] = {}, -- broken wedding ring
	[13825] = { vocs = {0} }, -- star ring
	[13826] = { vocs = {0} }, -- star ring
	[13877] = {}, -- broken ring of ending
	[14327] = {}, -- shapeshifter ring
	[18408] = { level = 120 }, -- prismatic ring
	[18528] = { level = 120 }, -- prismatic ring
	[21693] = {}, -- horn
	[22516] = { level = 200 }, -- ring of ending
	[24324] = {}, -- sweetheart ring
	[26185] = { level = 100, vocs = {3} }, -- ring of blue plasma
	[26186] = {}, -- ring of blue plasma
	[26187] = { level = 100, vocs = {1, 2} }, -- ring of green plasma
	[26188] = {}, -- ring of green plasma
	[26189] = { level = 100, vocs = {4} }, -- ring of red plasma
	[26190] = {}, -- ring of red plasma
	[28354] = {}, -- butterfly ring
	[34272] = {}, -- blister ring 
	[34277] = {}, -- blister ring
	[35277] = {}, -- ring of souls
	[35291] = {}, -- ring of souls
	[35292] = {}, -- ring of souls
	[34248] = {}, -- signet ring
	[36736] = {}, -- lion ring
}

local necklaces = {
	[2125] = {}, -- crystal necklace
	[2126] = {}, -- bronze necklace
	[2129] = {}, -- wolf tooth chain
	[2130] = {}, -- golden amulet
	[2131] = {}, -- star amulet
	[2132] = {}, -- silver necklace
	[2133] = {}, -- ruby necklace
	[2135] = {}, -- scarab amulet
	[2136] = {}, -- demonbone amulet
	[2138] = {}, -- sapphire amulet
	[2142] = {}, -- ancient amulet
	[2161] = {}, -- strange talisman
	[2170] = {}, -- silver amulet
	[2171] = {}, -- platinum amulet
	[2172] = {}, -- bronze amulet
	[2173] = {}, -- amulet of loss
	[2196] = {}, -- broken amulet
	[2197] = {}, -- stone skin amulet
	[2198] = {}, -- elven amulet
	[2199] = {}, -- garlic necklace
	[2200] = {}, -- protection amulet
	[2201] = {}, -- dragon necklace
	[2661] = {}, -- scarf
	[5940] = {}, -- Ceiron's wolf tooth chain
	[7887] = { level = 60 }, -- terra amulet
	[7888] = { level = 60 }, -- glacier amulet
	[7889] = { level = 60 }, -- lightning pendant
	[7890] = { level = 60 }, -- magma amulet
	[8266] = {}, -- Koshei's ancient amulet
	[10218] = { level = 80 }, -- bonfire amulet
	[10219] = { level = 80 }, -- sacred tree amulet
	[10220] = { level = 80 }, -- leviathan's amulet
	[10221] = { level = 80 }, -- shockwave amulet
	[11329] = {}, -- wailing widow's necklace
	[11374] = {}, -- beetle necklace
	[11393] = {}, -- lucky clover amulet
	[12424] = {}, -- ornamented brooch
	[14333] = {}, -- demonbone amulet
	[15403] = { level = 120 }, -- necklace of the deep
	[18402] = { level = 150 }, -- gill necklace
	[18407] = { level = 150 }, -- prismatic necklace
	[21469] = {}, -- friendship amulet
	[21691] = { level = 150 }, -- shrunken head necklace
	[22691] = {}, -- jade amulet
	[23541] = { level = 75 }, -- gearwheel chain
	[23554] = { level = 75, vocs = {1, 2} }, -- glooth amulet
	[23750] = {}, -- strange amulet
	[24716] = {}, -- werewolf amulet
	[24717] = {}, -- enchanted werewolf amulet
	[24718] = {}, -- werewolf helmet
	[24790] = {}, -- enchanted werewolf amulet
	[24851] = { level = 60 }, -- onyx pendant
	[25402] = {}, -- ancient amulet
	[25423] = { level = 100 }, -- Ferumbras' amulet
	[25424] = { level = 100 }, -- Ferumbras' amulet
	[26182] = {}, -- collar of blue plasma
	[26183] = {}, -- collar of green plasma
	[26184] = {}, -- collar of red plasma
	[26198] = { level = 150, vocs = {3} }, -- collar of blue plasma
	[26199] = { level = 150, vocs = {1, 2} }, -- collar of green plasma
	[26200] = { level = 150, vocs = {4} }, -- collar of red plasma
	[30221] = {}, -- foxtail amulet
	[32084] = {}, -- sleep shawl
	[32085] = {}, -- pendulet
	[32979] = {}, -- rainbow necklace
	[32998] = {}, -- enchanted sleep shawl
	[32999] = {}, -- enchanted sleep shawl
	[33000] = {}, -- enchanted pendulet
	[33001] = {}, -- enchanted pendulet
	[33057] = {}, -- amulet of theurgy
	[33058] = {}, -- enchanted theurgic amulet
	[33059] = {}, -- enchanted theurgic amulet
	[33924] = {}, -- jade amulet
	[34251] = {}, -- noble amulet
	[34287] = {}, -- the cobra amulet
	[34757] = {}, -- traditional neckerchief
	[36814] = {}, -- lion amulet
	[38179] = {}, -- exotic amulet
	[38260] = {}, -- sapphire necklace
	[38261] = {}, -- emerald necklace
	[38262] = {}, -- garnet necklace
	[38263] = {}, -- diamond necklace
	[38264] = {}, -- rhodolith necklace
	[38265] = {}, -- amethyst necklace
	[39364] = {}, -- the Eye of Suon
	[39715] = {}, -- lucky clover amulet
}

local weapons_magic = {
	[2181] = { level = 26, vocs = {2} }, -- terra rod
	[2182] = { level = 7, vocs = {2} }, -- snakebite rod
	[2183] = { level = 33, vocs = {2} }, -- hailstorm rod
	[2185] = { level = 19, vocs = {2} }, -- necrotic rod
	[2186] = { level = 13, vocs = {2} }, -- moonlight rod
	[2187] = { level = 33, vocs = {1} }, -- wand of inferno
	[2188] = { level = 19, vocs = {1} }, -- wand of decay
	[2189] = { level = 26, vocs = {1} }, -- wand of cosmic energy
	[2190] = { level = 7, vocs = {1} }, -- wand of vortex
	[2191] = { level = 13, vocs = {1}, sockets = 2 }, -- wand of dragonbreath
	[8910] = { level = 42, vocs = {2}, sockets = 2 }, -- underworld rod
	[8911] = { level = 22, vocs = {2}, sockets = 2 }, -- northwind rod
	[8912] = { level = 37, vocs = {2} }, -- springsprout rod
	[8920] = { level = 37, vocs = {1} }, -- wand of starstorm
	[8921] = { level = 22, vocs = {1}, sockets = 2 }, -- wand of draconia
	[8922] = { level = 42, vocs = {1}, sockets = 2 }, -- wand of voodoo
	[13760] = { level = 37, vocs = {1} }, -- wand of dimensions
	[13872] = { level = 40, vocs = {2} }, -- shimmer rod
	[13880] = { level = 40, vocs = {1} }, -- shimmer wand
	[18390] = { level = 65, vocs = {1} }, -- wand of defiance
	[18409] = { level = 65, vocs = {1} }, -- wand of everblazing
	[18411] = { level = 65, vocs = {2} }, -- muck rod
	[18412] = { level = 65, vocs = {2} }, -- glacial rod
	[19391] = { level = 1 }, -- sorcerer and druid staff
	[23719] = { level = 1, vocs = {1} }, -- scorcher
	[23721] = { level = 1, vocs = {2} }, -- chiller
	[24839] = { level = 37, vocs = {2}, sockets = 2 }, -- ogre scepta
	
	--[[
	[25887] = {}, -- wand of mayhem
	[25888] = {}, -- rod of mayhem
	[25897] = {}, -- wand of mayhem
	[25898] = {}, -- rod of mayhem
	[25907] = {}, -- wand of mayhem
	[25908] = {}, -- rod of mayhem
	[25917] = {}, -- wand of mayhem
	[25918] = {}, -- rod of mayhem
	[25951] = {}, -- wand of remedy
	[25952] = {}, -- wand of remedy
	[25953] = {}, -- wand of remedy
	[25954] = {}, -- wand of remedy
	[25955] = {}, -- rod of remedy
	[25956] = {}, -- rod of remedy
	[25957] = {}, -- rod of remedy
	[25958] = {}, -- rod of remedy
	[25991] = {}, -- wand of carving
	[25992] = {}, -- wand of carving
	[25993] = {}, -- wand of carving
	[25994] = {}, -- wand of carving
	[25995] = {}, -- rod of carving
	[25996] = {}, -- rod of carving
	[25997] = {}, -- rod of carving
	[25998] = {}, -- rod of carving
	[26294] = {}, -- wand of remedy
	[26295] = {}, -- wand of remedy
	[26297] = {}, -- wand of remedy
	[26299] = {}, -- rod of remedy
	[26301] = {}, -- rod of remedy
	[26302] = {}, -- rod of remedy
	[26312] = {}, -- wand of carving
	[26313] = {}, -- wand of carving
	[26314] = {}, -- wand of carving
	[26315] = {}, -- rod of carving
	[26316] = {}, -- rod of carving
	[26317] = {}, -- rod of carving
	[26318] = {}, -- wand of mayhem
	[26319] = {}, -- wand of mayhem
	[26320] = {}, -- wand of mayhem
	[26321] = {}, -- rod of mayhem
	[26322] = {}, -- rod of mayhem
	[26323] = {}, -- rod of mayhem
	]]
	
	[28356] = { sockets = 2 }, -- dream blossom staff
	[28416] = {}, -- wand of darkness
	
	--[[
	[28451] = {}, -- test wand of voodoo
	[28663] = {}, -- plain mayhem wand
	[28664] = {}, -- valuable mayhem wand
	[28665] = {}, -- ornate mayhem wand
	[28666] = {}, -- plain mayhem rod
	[28667] = {}, -- valuable mayhem rod
	[28668] = {}, -- ornate mayhem rod
	[28694] = {}, -- plain remedy wand
	[28695] = {}, -- valuable remedy wand
	[28696] = {}, -- ornate remedy wand
	[28697] = {}, -- plain remedy rod
	[28698] = {}, -- valuable remedy rod
	[28699] = {}, -- ornate remedy rod
	[28724] = {}, -- plain carving wand
	[28725] = {}, -- valuable carving wand
	[28726] = {}, -- ornate carving wand
	[28727] = {}, -- plain carving rod
	[28728] = {}, -- valuable carving rod
	[28729] = {}, -- ornate carving rod
	]]
	
	[30113] = { level = 200, vocs = {1}, sockets = 2 }, -- wand of destruction
	[30114] = { level = 200, vocs = {2}, sockets = 2 }, -- rod of destruction
	-- [31122] = {}, -- sorcerer test weapon TEST
	-- [31135] = {}, -- wand of destruction TEST
	[31372] = { sockets = 2 }, -- falcon rod
	[31373] = { sockets = 2 }, -- falcon wand
	[31482] = { sockets = 2 }, -- deepling fork
	[33055] = { sockets = 2 }, -- cobra wand
	[33056] = { sockets = 2 }, -- cobra rod
	[32081] = { sockets = 2 }, -- energized limb
	[36746] = { sockets = 2 }, -- soultainter
	[36747] = { sockets = 2 }, -- soulhexer
	[36807] = { sockets = 2 }, -- lion rod
	[36808] = { sockets = 2 }, -- lion wand
	[38177] = { sockets = 2 }, -- jungle rod
	[38178] = { sockets = 2 }, -- jungle wand
	[39324] = { sockets = 2 }, -- eldritch wand
	[39325] = { sockets = 2 }, -- gilded eldritch wand
	[39330] = { sockets = 2 }, -- eldritch rod
	[39331] = { sockets = 2 }, -- gilded eldritch rod
}

local throwables = {
	[1294] = { breakChance = 3, maxHitChance = 75, }, -- small stone
	[2111] = { breakChance = 100 }, -- snowball
	[2389] = { breakChance = 3, maxHitChance = 80 }, -- spear
	[2399] = { breakChance = 10, maxHitChance = 75 }, -- throwing star
	[2410] = { breakChance = 7, maxHitChance = 75 }, -- throwing knife
	[3965] = { breakChance = 6, level = 20, maxHitChance = 80 }, -- hunting spear
	[7366] = { breakChance = 10, callback = generateViperStar }, -- viper star
	[7367] = { breakChance = 1, level = 42, maxHitChance = 80 }, -- enchanted spear
	[7368] = { breakChance = 33, level = 80, maxHitChance = 95 }, -- assassin star
	[7378] = { breakChance = 3, level = 25, maxHitChance = 80 }, -- royal spear
	[19390] = { breakChance = 3, maxHitChance = 80 }, -- mean paladin spear
	[23529] = { breakChance = 20, level = 60, maxHitChance = 80 }, -- glooth spear
	[25526] = { breakChance = 33, level = 250, maxHitChance = 95 }, -- throwing star of sula
	[28391] = { breakChance = 40, maxHitChance = 85 }, -- leaf star
	[28415] = { breakChance = 30, level = 120, maxHitChance = 95 }, -- royal star
}

local weapons_distance = {
	[2455] = { sockets = 3 }, -- crossbow
	[2456] = {}, -- bow
	[5803] = { level = 75, vocs = {3} }, -- arbalest
	[7438] = { sockets = 3 }, -- elvish bow
	[8849] = { level = 45, vocs = {3}, sockets = 3 }, -- modified crossbow
	[8850] = { level = 60, vocs = {3}, sockets = 3 }, -- chain bolter
	[8851] = { level = 130, vocs = {3}, sockets = 3 }, -- royal crossbow
	[8852] = { level = 100, vocs = {3}, sockets = 3 }, -- the devileye
	[8853] = { level = 80, vocs = {3}, sockets = 3 }, -- the ironworker
	[8854] = { level = 80, vocs = {3}, sockets = 3 }, -- warsinger bow
	[8855] = { level = 50, vocs = {3}, sockets = 3 }, -- composite hornbow
	[8856] = { level = 60, vocs = {3} }, -- Yol's bow
	[8857] = { level = 40, vocs = {3}, sockets = 3 }, -- silkweaver bow
	[8858] = { level = 70, vocs = {3} }, -- Elethriel's elemental bow
	[10295] = { sockets = 3 }, -- musician's bow
	[13873] = { level = 40, vocs = {3} }, -- shimmer bow
	[15643] = { level = 85, vocs = {3}, sockets = 3 }, -- hive bow
	[15644] = { level = 50, vocs = {3} }, -- ornate crossbow
	[16111] = { level = 150, vocs = {3}, sockets = 3 }, -- thorn spitter
	[18453] = { level = 90, vocs = {3} }, -- crystal crossbow
	[18454] = { level = 105, vocs = {3}, sockets = 3 }, -- mycological bow
	[21690] = { level = 70, vocs = {3}, sockets = 3 }, -- triple bolt crossbow	
	[21696] = { sockets = 3 }, -- icicle bow
	[22416] = { level = 75, vocs = {3} }, -- crude umbral bow
	[22417] = { level = 150, vocs = {3}, sockets = 1 }, -- umbral bow
	[22418] = { level = 250, vocs = {3}, sockets = 2 }, -- umbral master bow
	[22419] = { level = 75, vocs = {3} }, -- crude umbral crossbow
	[22420] = { level = 150, vocs = {3}, sockets = 1 }, -- umbral crossbow
	[22421] = { level = 250, vocs = {3}, sockets = 2 }, -- umbral master crossbow
	[25522] = { level = 120, vocs = {3}, sockets = 3 }, -- rift bow
	[25523] = { level = 120, vocs = {3}, sockets = 3 }, -- rift crossbow
	
	--[[
	[25885] = {}, -- bow of mayhem
	[25886] = {}, -- crossbow of mayhem
	[25895] = {}, -- bow of mayhem
	[25896] = {}, -- crossbow of mayhem
	[25905] = {}, -- crossbow of mayhem
	[25906] = {}, -- bow of mayhem
	[25915] = {}, -- bow of mayhem
	[25916] = {}, -- crossbow of mayhem
	[25943] = {}, -- bow of remedy
	[25944] = {}, -- bow of remedy
	[25945] = {}, -- bow of remedy
	[25946] = {}, -- bow of remedy
	[25947] = {}, -- crossbow of remedy
	[25948] = {}, -- crossbow of remedy
	[25949] = {}, -- crossbow of remedy
	[25950] = {}, -- crossbow of remedy
	[25983] = {}, -- bow of carving
	[25984] = {}, -- bow of carving
	[25985] = {}, -- bow of carving
	[25986] = {}, -- bow of carving
	[25987] = {}, -- crossbow of carving
	[25988] = {}, -- crossbow of carving
	[25989] = {}, -- crossbow of carving
	[25990] = {}, -- crossbow of carving
	[26251] = {}, -- bow of mayhem
	[26253] = {}, -- bow of mayhem
	[26254] = {}, -- bow of mayhem
	[26264] = {}, -- crossbow of mayhem
	[26266] = {}, -- crossbow of mayhem
	[26268] = {}, -- crossbow of mayhem
	[26285] = {}, -- bow of remedy
	[26286] = {}, -- bow of remedy
	[26288] = {}, -- bow of remedy
	[26289] = {}, -- crossbow of remedy
	[26291] = {}, -- crossbow of remedy
	[26292] = {}, -- crossbow of remedy
	[26306] = {}, -- bow of carving
	[26307] = {}, -- bow of carving
	[26308] = {}, -- bow of carving
	[26309] = {}, -- crossbow of carving
	[26310] = {}, -- crossbow of carving
	[26311] = {}, -- crossbow of carving
	[28657] = {}, -- plain mayhem bow
	[28658] = {}, -- valuable mayhem bow
	[28659] = {}, -- ornate mayhem bow
	[28660] = {}, -- plain mayhem crossbow
	[28661] = {}, -- valuable mayhem crossbow
	[28662] = {}, -- ornate mayhem crossbow
	[28688] = {}, -- plain remedy bow
	[28689] = {}, -- valuable remedy bow
	[28690] = {}, -- ornate remedy bow
	[28691] = {}, -- plain remedy crossbow
	[28692] = {}, -- valuable remedy crossbow
	[28693] = {}, -- ornate remedy crossbow
	[28718] = {}, -- plain carving bow
	[28719] = {}, -- valuable carving bow
	[28720] = {}, -- ornate carving bow
	[28721] = {}, -- plain carving crossbow
	[28722] = {}, -- valuable carving crossbow
	[28723] = {}, -- ornate carving crossbow
	]]
	
	[30111] = { level = 200, vocs = {3}, sockets = 3 }, -- bow of destruction
	[30112] = { level = 200, vocs = {3}, sockets = 3 }, -- crossbow of destruction
	--[31121] = {}, -- bow of destruction TEST
	--[31134] = {}, -- umbral master bow TEST
	[31374] = { sockets = 3 }, -- falcon bow
	[32073] = { sockets = 3 }, -- living vine bow
	[33049] = { sockets = 2 }, -- cobra crossbow
	[34237] = { sockets = 3 }, -- bow of cataclysm
	[36744] = { sockets = 3 }, -- soulbleeder
	[36745] = { sockets = 3 }, -- soulpiercer
	[36806] = { sockets = 3 }, -- lion longbow
	[38174] = { sockets = 2 }, -- jungle bow
	[39320] = { sockets = 3 }, -- eldritch bow
	[39321] = { sockets = 3 }, -- gilded eldritch bow

}

local ammo = {
	[2543] = {}, -- bolt
	[2544] = {}, -- arrow
	[2545] = { callback = generatePoisonArrow }, -- poison arrow
	[2546] = { callback = generateBurstArrow }, -- burst arrow
	[2547] = { level = 55 }, -- power bolt
	[6529] = { level = 110 }, -- infernal bolt
	[7363] = { level = 30 }, -- piercing bolt
	[7364] = { level = 20 }, -- sniper arrow
	[7365] = { level = 40 }, -- onyx arrow
	[7838] = { level = 20 }, -- flash arrow
	[7839] = { level = 20 }, -- shiver arrow
	[7840] = { level = 20 }, -- flaming arrow
	[7850] = { level = 20 }, -- earth arrow
	[15648] = { level = 30 }, -- tarsal arrow
	[15649] = { level = 40 }, -- vortex bolt
	[18435] = { level = 90 }, -- prismatic bolt
	[18436] = { level = 70 }, -- drill bolt
	[18437] = { level = 70 }, -- envenomed arrow
	[23839] = { level = 1 }, -- simple arrow
	[24699] = {}, -- arrow
	[24702] = {}, -- bolt
	[24703] = { level = 55 }, -- power bolt
	[24704] = { level = 20 }, -- sniper arrow
	[24705] = { level = 30 }, -- piercing bolt
	[24706] = { level = 1 }, -- simple arrow
	[24775] = { callback = generateBurstArrow }, -- burst arrow
	[28413] = { level = 150, callback = generateDiamondArrow }, -- diamond arrow
	[28414] = { level = 150 }, -- spectral bolt
	[38557] = { level = 150, callback = generateDiamondArrow }, -- diamond arrow
	[38558] = { level = 150 }, -- spectral bolt
}

local quivers = {
	[38180] = { level = 150, vocs = {3} }, -- jungle quiver
	[38218] = { vocs = {3, 0} }, -- quiver
	[38504] = { vocs = {3, 0} }, -- blue quiver
	[38505] = { vocs = {3, 0} }, -- red quiver
	[39322] = { level = 250, vocs = {3} }, -- eldritch quiver
}

local weapons = {
	[2321] = {}, -- giant smithhammer
	[2376] = { sockets = 2 }, -- sword
	[2377] = { level = 20, vocs = {4} }, -- two handed sword
	[2378] = { vocs = {4} }, -- battle axe
	[2379] = {}, -- dagger
	[2380] = {}, -- hand axe
	[2381] = { level = 25 }, -- halberd
	[2382] = {}, -- club
	[2383] = { sockets = 2 }, -- spike sword
	[2384] = {}, -- rapier
	[2385] = {}, -- sabre
	[2386] = {}, -- axe
	[2387] = { level = 25, vocs = {4} }, -- double axe
	[2388] = {}, -- hatchet
	[2390] = { level = 140, vocs = {4} }, -- magic longsword
	[2391] = { level = 50, vocs = {4}, sockets = 3 }, -- war hammer
	[2392] = { level = 30 }, -- fire sword
	[2393] = { level = 55, vocs = {4}, sockets = 3 }, -- giant sword
	[2394] = {}, -- morning star
	[2395] = {}, -- carlin sword
	[2396] = {}, -- ice rapier
	[2397] = {}, -- longsword
	[2398] = {}, -- mace
	[2400] = { level = 80, sockets = 2 }, -- magic sword
	[2401] = {}, -- staff
	[2402] = {}, -- silver dagger
	[2403] = {}, -- knife
	[2404] = {}, -- combat knife
	[2405] = {}, -- sickle
	[2406] = {}, -- short sword
	[2407] = { level = 30, sockets = 2 }, -- bright sword
	[2408] = { level = 120, vocs = {4} }, -- warlord sword
	[2409] = {}, -- serpent sword
	[2411] = {}, -- poison dagger
	[2412] = {}, -- katana
	[2413] = { vocs = {4}, sockets = 3 }, -- broadsword
	[2414] = { level = 60, sockets = 3 }, -- dragon lance
	[2415] = { level = 95, vocs = {4}, sockets = 2 }, -- great axe
	[2416] = { alreadyScripted = true }, -- crowbar
	[2417] = {}, -- battle hammer
	[2418] = {}, -- golden sickle
	[2419] = {}, -- scimitar
	[2420] = { alreadyScripted = true }, -- machete
	[2421] = { level = 85, sockets = 2 }, -- thunder hammer
	[2422] = {}, -- iron hammer
	[2423] = { level = 20, sockets = 2 }, -- clerical mace
	[2424] = { level = 45, sockets = 2 }, -- silver mace
	[2425] = { level = 20 }, -- obsidian lance
	[2426] = { level = 25 }, -- naginata
	[2427] = { level = 55, sockets = 3 }, -- guardian halberd
	[2428] = {}, -- orcish axe
	[2429] = { level = 20, sockets = 2 }, -- barbarian axe
	[2430] = { level = 25, sockets = 2 }, -- knight axe
	[2431] = { level = 90, sockets = 1 }, -- stonecutter axe
	[2432] = { level = 35 }, -- fire axe
	[2433] = {}, -- enchanted staff
	[2434] = { level = 25 }, -- dragon hammer
	[2435] = { level = 20, sockets = 2 }, -- dwarven axe
	[2436] = { level = 30, sockets = 2 }, -- skull staff
	[2437] = {}, -- light mace
	[2438] = { level = 30, sockets = 2 }, -- epee
	[2439] = {}, -- daramian mace
	[2440] = { level = 25, vocs = {4} }, -- daramian waraxe
	[2441] = {}, -- daramian axe
	[2442] = { alreadyScripted = true }, -- heavy machete
	[2443] = { level = 70, vocs = {4}, sockets = 3 }, -- ravager's axe
	[2444] = { level = 65, vocs = {4}, sockets = 3 }, -- hammer of wrath
	[2445] = { level = 35, sockets = 2 }, -- crystal mace
	[2446] = { level = 45 }, -- pharaoh sword
	[2447] = { level = 50, vocs = {4}, sockets = 3 }, -- twin axe
	[2448] = {}, -- studded club
	[2449] = {}, -- bone club
	[2450] = {}, -- bone sword
	[2451] = { level = 35, sockets = 2 }, -- djinn blade
	[2452] = { level = 70, vocs = {4}, sockets = 3 }, -- heavy mace
	[2453] = { level = 75, sockets = 2 }, -- arcane staff
	[2454] = { level = 65, vocs = {4}, sockets = 3 }, -- war axe
	[2550] = { alreadyScripted = true }, -- scythe
	[3961] = { level = 40 }, -- lich staff
	[3962] = { level = 30, sockets = 2 }, -- beastslayer axe
	[3963] = {}, -- templar scytheblade
	[3964] = {}, -- ripper lance
	[3966] = {}, -- banana staff
	[6101] = {}, -- Ron the Ripper's sabre
	[6528] = { level = 75, vocs = {4}, sockets = 2 }, -- the avenger
	[6553] = { level = 75, vocs = {4}, sockets = 2 }, -- ruthless axe
	[7379] = { level = 25 }, -- brutetamer's staff
	[7380] = { level = 35, vocs = {4}, sockets = 3 }, -- headchopper
	[7381] = { level = 20 }, -- mammoth whopper
	[7382] = { level = 60, vocs = {4}, sockets = 3 }, -- demonrage sword
	[7383] = { level = 50, sockets = 2 }, -- relic sword
	[7384] = { level = 60, sockets = 2 }, -- mystic blade
	[7385] = { level = 20, sockets = 2 }, -- crimson sword
	[7386] = { level = 40, vocs = {4} }, -- mercenary sword
	[7387] = { level = 25 }, -- diamond sceptre
	[7388] = { level = 55 }, -- vile axe
	[7389] = { level = 60, sockets = 2 }, -- heroic axe
	[7390] = { level = 75 }, -- the justice seeker
	[7391] = { level = 50, vocs = {4}, sockets = 3 }, -- thaian sword
	[7392] = { level = 35, sockets = 3 }, -- orcish maul
	[7402] = { level = 45, vocs = {4}, sockets = 3 }, -- dragon slayer
	[7403] = { level = 65, vocs = {4}, sockets = 3 }, -- berserker
	[7404] = { level = 40, sockets = 2 }, -- assassin dagger
	[7405] = { level = 70, vocs = {4}, sockets = 3 }, -- havoc blade
	[7406] = { level = 35, vocs = {4}, sockets = 3 }, -- blacksteel sword
	[7407] = { level = 30, vocs = {4}, sockets = 3 }, -- haunted blade
	[7408] = { level = 25, sockets = 2 }, -- wyvern fang
	[7409] = { level = 50 }, -- northern star
	[7410] = { level = 55, sockets = 2 }, -- queen's sceptre
	[7411] = { level = 50 }, -- ornamented axe
	[7412] = { level = 45, sockets = 2 }, -- butcher's axe
	[7413] = { level = 40, vocs = {4} }, -- titan axe
	[7414] = { level = 60, vocs = {4}, sockets = 3 }, -- abyss hammer
	[7415] = { level = 60, sockets = 2 }, -- cranial basher
	[7416] = { level = 55, sockets = 2 }, -- bloody edge
	[7417] = { level = 65, sockets = 2 }, -- runed sword
	[7418] = { level = 70, sockets = 2 }, -- nightmare blade
	[7419] = { level = 40, sockets = 2 }, -- dreaded cleaver
	[7420] = { level = 70 }, -- reaper's axe
	[7421] = { level = 65, sockets = 2 }, -- onyx flail
	[7422] = { level = 75 }, -- jade hammer
	[7423] = { level = 85, vocs = {4}, sockets = 2 }, -- skullcrusher
	[7424] = { level = 30, sockets = 3 }, -- lunar staff
	[7425] = { level = 20 }, -- taurus mace
	[7426] = { level = 40, sockets = 3 }, -- amber staff
	[7427] = { level = 45 }, -- chaos mace
	[7428] = { level = 55, vocs = {4} }, -- bonebreaker
	[7429] = { level = 75, sockets = 2 }, -- blessed sceptre
	[7430] = { level = 30, sockets = 2 }, -- dragonbone staff
	[7431] = { level = 80, sockets = 2 }, -- demonbone
	[7432] = { level = 20 }, -- furry club
	[7433] = { level = 65 }, -- ravenwing
	[7434] = { level = 75, sockets = 2 }, -- royal axe
	[7435] = { level = 85, sockets = 2 }, -- impaler
	[7436] = { level = 45, vocs = {4} }, -- angelic axe
	[7437] = { level = 30, sockets = 2 }, -- sapphire hammer
	[7449] = { level = 25, vocs = {4} }, -- crystal sword
	[7450] = { level = 120, vocs = {4} }, -- hammer of prophecy
	[7451] = { level = 35, sockets = 2 }, -- shadow sceptre
	[7452] = { level = 30, vocs = {4}, sockets = 3 }, -- spiked squelcher
	[7453] = { level = 85, vocs = {4}, sockets = 2 }, -- executioner
	[7454] = { level = 30, vocs = {4} }, -- glorious axe
	[7455] = { level = 80, sockets = 2 }, -- mythril axe
	[7456] = { level = 35, sockets = 2 }, -- noble axe
	[7744] = {}, -- fiery spike sword
	[7745] = { level = 50 }, -- fiery relic sword
	[7746] = { level = 60 }, -- fiery mystic blade
	[7747] = { level = 35, vocs = {4} }, -- fiery blacksteel sword
	[7748] = { level = 45, vocs = {4} }, -- fiery dragon slayer
	[7749] = { level = 20 }, -- fiery barbarian axe
	[7750] = { level = 25 }, -- fiery knight axe
	[7751] = { level = 60 }, -- fiery heroic axe
	[7752] = { level = 35, vocs = {4} }, -- fiery headchopper
	[7753] = { level = 65, vocs = {4} }, -- fiery war axe
	[7754] = { level = 20 }, -- fiery clerical mace
	[7755] = { level = 35 }, -- fiery crystal mace
	[7756] = { level = 60 }, -- fiery cranial basher
	[7757] = { level = 35 }, -- fiery orcish maul
	[7758] = { level = 50, vocs = {4} }, -- fiery war hammer
	[7763] = {}, -- icy spike sword
	[7764] = { level = 50 }, -- icy relic sword
	[7765] = { level = 60 }, -- icy mystic blade
	[7766] = { level = 35, vocs = {4} }, -- icy blacksteel sword
	[7767] = { level = 45, vocs = {4} }, -- icy dragon slayer
	[7768] = { level = 20 }, -- icy barbarian axe
	[7769] = { level = 25 }, -- icy knight axe
	[7770] = { level = 60 }, -- icy heroic axe
	[7771] = { level = 35, vocs = {4} }, -- icy headchopper
	[7772] = { level = 65, vocs = {4} }, -- icy war axe
	[7773] = { level = 20 }, -- icy clerical mace
	[7774] = { level = 35 }, -- icy crystal mace
	[7775] = { level = 60 }, -- icy cranial basher
	[7776] = { level = 35 }, -- icy orcish maul
	[7777] = { level = 50, vocs = {4} }, -- icy war hammer
	[7854] = {}, -- earth spike sword
	[7855] = { level = 50 }, -- earth relic sword
	[7856] = { level = 60 }, -- earth mystic blade
	[7857] = { level = 35, vocs = {4} }, -- earth blacksteel sword
	[7858] = { level = 45, vocs = {4} }, -- earth dragon slayer
	[7859] = { level = 20 }, -- earth barbarian axe
	[7860] = { level = 25 }, -- earth knight axe
	[7861] = { level = 60 }, -- earth heroic axe
	[7862] = { level = 35, vocs = {4} }, -- earth headchopper
	[7863] = { level = 65, vocs = {4} }, -- earth war axe
	[7864] = { level = 20 }, -- earth clerical mace
	[7865] = { level = 35 }, -- earth crystal mace
	[7866] = { level = 60 }, -- earth cranial basher
	[7867] = { level = 35 }, -- earth orcish maul
	[7868] = { level = 50, vocs = {4} }, -- earth war hammer
	[7869] = {}, -- energy spike sword
	[7870] = { level = 50 }, -- energy relic sword
	[7871] = { level = 60 }, -- energy mystic blade
	[7872] = { level = 35, vocs = {4} }, -- energy blacksteel sword
	[7873] = { level = 45, vocs = {4} }, -- energy dragon slayer
	[7874] = { level = 20 }, -- energy barbarian axe
	[7875] = { level = 25 }, -- energy knight axe
	[7876] = { level = 60 }, -- energy heroic axe
	[7877] = { level = 35, vocs = {4} }, -- energy headchopper
	[7878] = { level = 65, vocs = {4} }, -- energy war axe
	[7879] = { level = 20 }, -- energy clerical mace
	[7880] = { level = 35 }, -- energy crystal mace
	[7881] = { level = 60 }, -- energy cranial basher
	[7882] = { level = 35 }, -- energy orcish maul
	[7883] = { level = 50, vocs = {4} }, -- energy war hammer
	[8209] = {}, -- crimson sword
	[8601] = {}, -- steel axe
	[8602] = {}, -- jagged sword
	[8924] = { level = 110, sockets = 1 }, -- hellforged axe
	[8925] = { level = 130, sockets = 1 }, -- solar axe
	[8926] = { level = 120, vocs = {4}, sockets = 2 }, -- demonwing axe
	[8927] = { level = 120 }, -- dark trinity mace
	[8928] = { level = 100, sockets = 1 }, -- obsidian truncheon
	[8929] = { level = 100, vocs = {4}, sockets = 2 }, -- the stomper
	[8930] = { level = 100, sockets = 2 }, -- emerald sword
	[8931] = { level = 120, sockets = 1 }, -- the epiphany
	[8932] = { level = 100, vocs = {4} }, -- the calamity
	[10290] = {}, -- glutton's mace
	[10292] = {}, -- pointed rabbitslayer
	[10293] = {}, -- stale bread of ancientness
	[10301] = {}, -- scythe of the reaper
	[10302] = {}, -- club of the fury
	[10303] = {}, -- farmer's avenger
	[10304] = {}, -- poet's fencing quill
	[10313] = {}, -- incredible mumpiz slayer
	[11305] = { level = 60, sockets = 3 }, -- drakinata
	[11306] = { level = 50, vocs = {4} }, -- sai
	[11307] = { level = 55, sockets = 2 }, -- Zaoan sword
	[11308] = { level = 55, vocs = {4} }, -- drachaku
	[11309] = { level = 20, vocs = {4}, sockets = 3 }, -- twin hooks
	[11323] = { level = 25, sockets = 3 }, -- Zaoan halberd
	[11395] = {}, -- crimson sword
	[11426] = {}, -- the Ron the Ripper's sabre
	[12613] = { level = 58, vocs = {4}, sockets = 3 }, -- twiceslicer
	[12648] = { level = 82, sockets = 2 }, -- snake god's sceptre
	[12649] = { level = 82, sockets = 2 }, -- blade of corruption
	[13838] = { level = 25 }, -- heavy trident
	[13871] = { level = 40, vocs = {4} }, -- shimmer sword
	[14334] = {}, -- giant smithhammer
	[15400] = { level = 38 }, -- deepling staff
	[15404] = { level = 80 }, -- deepling axe
	[15414] = { level = 90, sockets = 2 }, -- ornate mace
	[15451] = { level = 40, sockets = 2 }, -- warrior's axe
	[15454] = { level = 50 }, -- guardian axe
	[15492] = { level = 70, sockets = 2 }, -- hive scythe
	[15647] = { level = 48, sockets = 2 }, -- deepling squelcher
	[18450] = { level = 62 }, -- crystalline sword
	[18451] = { level = 120, sockets = 1 }, -- crystalline axe
	[18452] = { level = 120, sockets = 1 }, -- mycological mace
	[18465] = { level = 120, sockets = 1 }, -- shiny blade
	[19389] = {}, -- mean knight sword
	[20092] = { level = 15 }, -- ratana
	[20093] = { level = 15, sockets = 2 }, -- life preserver
	[20139] = { level = 20 }, -- spiky club
	[21470] = {}, -- Mexcalibur
	[22398] = { level = 75, vocs = {4} }, -- crude umbral blade
	[22399] = { level = 120, vocs = {4}, sockets = 1 }, -- umbral blade
	[22400] = { level = 250, vocs = {4}, sockets = 1 }, -- umbral masterblade
	[22401] = { level = 75, vocs = {4} }, -- crude umbral slayer
	[22402] = { level = 120, vocs = {4}, sockets = 1 }, -- umbral slayer
	[22403] = { level = 250, vocs = {4}, sockets = 2 }, -- umbral master slayer
	[22404] = { level = 75, vocs = {4} }, -- crude umbral axe
	[22405] = { level = 120, vocs = {4}, sockets = 1 }, -- umbral axe
	[22406] = { level = 250, vocs = {4}, sockets = 1 }, -- umbral master axe
	[22407] = { level = 75, vocs = {4} }, -- crude umbral chopper
	[22408] = { level = 120, vocs = {4}, sockets = 1 }, -- umbral chopper
	[22409] = { level = 250, vocs = {4}, sockets = 2 }, -- umbral master chopper
	[22410] = { level = 75, vocs = {4} }, -- crude umbral mace
	[22411] = { level = 120, vocs = {4}, sockets = 1 }, -- umbral mace
	[22412] = { level = 250, vocs = {4}, sockets = 1 }, -- umbral master mace
	[22413] = { level = 75, vocs = {4} }, -- crude umbral hammer
	[22414] = { level = 120, vocs = {4}, sockets = 1 }, -- umbral hammer
	[22415] = { level = 250, vocs = {4}, sockets = 2 }, -- umbral master hammer
	[22678] = {}, -- arcane staff
	[22690] = {}, -- light rapier	
	[23542] = { level = 55 }, -- metal bat
	[23543] = { level = 25, sockets = 2 }, -- glooth whip
	[23544] = { level = 60 }, -- moohtant cudgel
	[23545] = { level = 45 }, -- mino lance
	[23547] = { level = 55 }, -- execowtioner axe
	[23548] = { level = 25 }, -- cowtana
	[23549] = { level = 75, vocs = {4} }, -- glooth club
	[23550] = { level = 75, vocs = {4} }, -- glooth blade
	[23551] = { level = 75, vocs = {4} }, -- glooth axe
	[23590] = { level = 70 }, -- one hit wonder
	[24827] = { level = 50 }, -- ogre klubba
	[24828] = { level = 25 }, -- ogre choppa
	[25383] = { level = 70, sockets = 3 }, -- rift lance
	[25415] = { level = 150 }, -- plague bite
	[25416] = { level = 150 }, -- impaler of the igniter
	[25418] = { level = 150, sockets = 1 }, -- maimer
	[25420] = { level = 100, alreadyScripted = true }, -- Ferumbras' staff
	[25421] = { level = 65, vocs = {1} }, -- Ferumbras' staff
	[25422] = { level = 100, vocs = {1} }, -- Ferumbras' staff
	
	--[[
	[25879] = {}, -- blade of mayhem
	[25880] = {}, -- slayer of mayhem
	[25881] = {}, -- axe of mayhem
	[25882] = {}, -- chopper of mayhem
	[25883] = {}, -- mace of mayhem
	[25884] = {}, -- hammer of mayhem
	[25889] = {}, -- blade of mayhem
	[25890] = {}, -- slayer of mayhem
	[25891] = {}, -- axe of mayhem
	[25892] = {}, -- chopper of mayhem
	[25893] = {}, -- mace of mayhem
	[25894] = {}, -- hammer of mayhem
	[25899] = {}, -- blade of mayhem
	[25900] = {}, -- slayer of mayhem
	[25901] = {}, -- axe of mayhem
	[25902] = {}, -- chopper of mayhem
	[25903] = {}, -- mace of mayhem
	[25904] = {}, -- hammer of mayhem
	[25909] = {}, -- blade of mayhem
	[25910] = {}, -- slayer of mayhem
	[25911] = {}, -- axe of mayhem
	[25912] = {}, -- chopper of mayhem
	[25913] = {}, -- mace of mayhem
	[25914] = {}, -- hammer of mayhem
	[25919] = {}, -- blade of remedy
	[25920] = {}, -- blade of remedy
	[25921] = {}, -- blade of remedy
	[25922] = {}, -- blade of remedy
	[25923] = {}, -- slayer of remedy
	[25924] = {}, -- slayer of remedy
	[25925] = {}, -- slayer of remedy
	[25926] = {}, -- slayer of remedy
	[25927] = {}, -- axe of remedy
	[25928] = {}, -- axe of remedy
	[25929] = {}, -- axe of remedy
	[25930] = {}, -- axe of remedy
	[25931] = {}, -- chopper of remedy
	[25932] = {}, -- chopper of remedy
	[25933] = {}, -- chopper of remedy
	[25934] = {}, -- chopper of remedy
	[25935] = {}, -- mace of remedy
	[25936] = {}, -- mace of remedy
	[25937] = {}, -- mace of remedy
	[25938] = {}, -- mace of remedy
	[25939] = {}, -- hammer of remedy
	[25940] = {}, -- hammer of remedy
	[25941] = {}, -- hammer of remedy
	[25942] = {}, -- hammer of remedy
	[25959] = {}, -- blade of carving
	[25960] = {}, -- blade of carving
	[25961] = {}, -- blade of carving
	[25962] = {}, -- blade of carving
	[25963] = {}, -- slayer of carving
	[25964] = {}, -- slayer of carving
	[25965] = {}, -- slayer of carving
	[25966] = {}, -- slayer of carving
	[25967] = {}, -- axe of carving
	[25968] = {}, -- axe of carving
	[25969] = {}, -- axe of carving
	[25970] = {}, -- axe of carving
	[25971] = {}, -- chopper of carving
	[25972] = {}, -- chopper of carving
	[25973] = {}, -- chopper of carving
	[25974] = {}, -- chopper of carving
	[25975] = {}, -- mace of carving
	[25976] = {}, -- mace of carving
	[25977] = {}, -- mace of carving
	[25978] = {}, -- mace of carving
	[25979] = {}, -- hammer of carving
	[25980] = {}, -- hammer of carving
	[25981] = {}, -- hammer of carving
	[25982] = {}, -- hammer of carving
	[26233] = {}, -- blade of mayhem
	[26234] = {}, -- blade of mayhem
	[26235] = {}, -- blade of mayhem
	[26236] = {}, -- slayer of mayhem
	[26237] = {}, -- slayer of mayhem
	[26238] = {}, -- slayer of mayhem
	[26239] = {}, -- axe of mayhem
	[26240] = {}, -- axe of mayhem
	[26241] = {}, -- axe of mayhem
	[26242] = {}, -- chopper of mayhem
	[26243] = {}, -- chopper of mayhem
	[26244] = {}, -- chopper of mayhem
	[26245] = {}, -- mace of mayhem
	[26246] = {}, -- mace of mayhem
	[26247] = {}, -- mace of mayhem
	[26248] = {}, -- hammer of mayhem
	[26249] = {}, -- hammer of mayhem
	[26250] = {}, -- hammer of mayhem
	[26252] = {}, -- blade of remedy
	[26255] = {}, -- blade of remedy
	[26256] = {}, -- blade of remedy
	[26257] = {}, -- slayer of remedy
	[26258] = {}, -- slayer of remedy
	[26260] = {}, -- slayer of remedy
	[26261] = {}, -- blade of carving
	[26262] = {}, -- axe of remedy
	[26263] = {}, -- axe of remedy
	[26265] = {}, -- blade of carving
	[26267] = {}, -- axe of remedy
	[26269] = {}, -- chopper of remedy
	[26270] = {}, -- blade of carving
	[26271] = {}, -- chopper of remedy
	[26272] = {}, -- slayer of carving
	[26273] = {}, -- chopper of remedy
	[26274] = {}, -- slayer of carving
	[26275] = {}, -- mace of remedy
	[26276] = {}, -- mace of remedy
	[26277] = {}, -- slayer of carving
	[26278] = {}, -- mace of remedy
	[26279] = {}, -- hammer of remedy
	[26280] = {}, -- axe of carving
	[26281] = {}, -- hammer of remedy
	[26282] = {}, -- axe of carving
	[26283] = {}, -- hammer of remedy
	[26284] = {}, -- axe of carving
	[26287] = {}, -- chopper of carving
	[26290] = {}, -- chopper of carving
	[26293] = {}, -- chopper of carving
	[26296] = {}, -- mace of carving
	[26298] = {}, -- mace of carving
	[26300] = {}, -- mace of carving
	[26303] = {}, -- hammer of carving
	[26304] = {}, -- hammer of carving
	[26305] = {}, -- hammer of carving
	[28571] = {}, -- fiery spike sword replica
	[28572] = {}, -- fiery relic sword replica
	[28573] = {}, -- fiery mystic blade replica
	[28574] = {}, -- fire blacksteel replica
	[28575] = {}, -- fiery dragon slayer replica
	[28576] = {}, -- fiery barbarian axe replica
	[28577] = {}, -- fiery knight axe replica
	[28578] = {}, -- fiery heroic axe replica
	[28579] = {}, -- fiery headchopper replica
	[28580] = {}, -- fiery war axe replica
	[28581] = {}, -- fiery clerical mace replica
	[28582] = {}, -- fiery crystal mace replica
	[28583] = {}, -- fiery basher replica
	[28584] = {}, -- fiery orcish maul replica
	[28585] = {}, -- fiery war hammer replica
	[28586] = {}, -- icy spike sword replica
	[28587] = {}, -- icy relic sword replica
	[28588] = {}, -- icy mystic blade replica
	[28589] = {}, -- icy blacksteel replica
	[28590] = {}, -- icy dragon slayer replica
	[28591] = {}, -- icy barbarian axe replica
	[28592] = {}, -- icy knight axe replica
	[28593] = {}, -- icy heroic axe replica
	[28594] = {}, -- icy headchopper replica
	[28595] = {}, -- icy war axe replica
	[28596] = {}, -- icy clerical mace replica
	[28597] = {}, -- icy crystal mace replica
	[28598] = {}, -- icy cranial basher replica
	[28599] = {}, -- icy orcish maul replica
	[28600] = {}, -- icy war hammer replica
	[28601] = {}, -- earth spike sword replica
	[28602] = {}, -- earth relic sword replica
	[28603] = {}, -- earth mystic blade replica
	[28604] = {}, -- earth blacksteel replica
	[28605] = {}, -- earth slayer replica
	[28606] = {}, -- earth barbaric axe replica
	[28607] = {}, -- earth knight axe replica
	[28608] = {}, -- earth heroic axe replica
	[28609] = {}, -- earth headchopper replica
	[28610] = {}, -- earth war axe replica
	[28611] = {}, -- earth cleric mace replica
	[28612] = {}, -- earth crystal mace replica
	[28613] = {}, -- earth basher replica
	[28614] = {}, -- earth orcish maul replica
	[28615] = {}, -- earth war hammer replica
	[28616] = {}, -- energy spike sword replica
	[28617] = {}, -- energy relic sword replica
	[28618] = {}, -- energy blade replica
	[28619] = {}, -- energy blacksteel replica
	[28620] = {}, -- energy slayer replica
	[28621] = {}, -- energy axe replica
	[28622] = {}, -- energy knight axe replica
	[28623] = {}, -- energy heroic axe replica
	[28624] = {}, -- energy headchopper replica
	[28625] = {}, -- energy war axe replica
	[28626] = {}, -- energy cleric mace replica
	[28627] = {}, -- energy mace replica
	[28628] = {}, -- energy basher replica
	[28629] = {}, -- energy orcish maul replica
	[28630] = {}, -- energy war hammer replica
	[28639] = {}, -- plain mayhem blade
	[28640] = {}, -- valuable mayhem blade
	[28641] = {}, -- ornate mayhem blade
	[28642] = {}, -- plain mayhem slayer
	[28643] = {}, -- valuable mayhem slayer
	[28644] = {}, -- ornate mayhem slayer
	[28645] = {}, -- plain mayhem axe
	[28646] = {}, -- valuable mayhem axe
	[28647] = {}, -- ornate mayhem axe
	[28648] = {}, -- plain mayhem chopper
	[28649] = {}, -- valuable mayhem chopper
	[28650] = {}, -- ornate mayhem chopper
	[28651] = {}, -- plain mayhem mace
	[28652] = {}, -- valuable mayhem mace
	[28653] = {}, -- ornate mayhem mace
	[28654] = {}, -- plain mayhem hammer
	[28655] = {}, -- valuable mayhem hammer
	[28656] = {}, -- ornate mayhem hammer
	[28670] = {}, -- plain remedy blade
	[28671] = {}, -- valuable remedy blade
	[28672] = {}, -- ornate remedy blade
	[28673] = {}, -- plain remedy slayer
	[28674] = {}, -- valuable remedy slayer
	[28675] = {}, -- ornate remedy slayer 
	[28676] = {}, -- plain remedy axe
	[28677] = {}, -- valuable remedy axe
	[28678] = {}, -- ornate remedy axe
	[28679] = {}, -- plain remedy chopper
	[28680] = {}, -- valuable remedy chopper
	[28681] = {}, -- ornate remedy chopper
	[28682] = {}, -- plain remedy mace
	[28683] = {}, -- valuable remedy mace
	[28684] = {}, -- ornate remedy mace
	[28685] = {}, -- plain remedy hammer
	[28686] = {}, -- valuable remedy hammer
	[28687] = {}, -- ornate remedy hammer
	[28700] = {}, -- plain carving blade
	[28701] = {}, -- valuable carving blade
	[28702] = {}, -- ornate carving blade
	[28703] = {}, -- plain carving slayer
	[28704] = {}, -- valuable carving slayer
	[28705] = {}, -- ornate carving slayer
	[28706] = {}, -- plain carving axe
	[28707] = {}, -- valuable carving axe
	[28708] = {}, -- ornate carving axe
	[28709] = {}, -- plain carving chopper
	[28710] = {}, -- valuable carving chopper
	[28711] = {}, -- ornate carving chopper
	[28712] = {}, -- plain carving mace
	[28713] = {}, -- valuable carving mace
	[28714] = {}, -- ornate carving mace
	[28715] = {}, -- plain carving hammer
	[28716] = {}, -- valuable carving hammer
	[28717] = {}, -- ornate carving hammer
	]]
	
	[30105] = { level = 200, vocs = {4}, sockets = 2 }, -- blade of destruction
	[30106] = { level = 200, vocs = {4}, sockets = 3 }, -- slayer of destruction
	[30107] = { level = 200, vocs = {4}, sockets = 2 }, -- axe of destruction
	[30108] = { level = 200, vocs = {4}, sockets = 3 }, -- chopper of destruction
	[30109] = { level = 200, vocs = {4}, sockets = 2 }, -- mace of destruction
	[30110] = { level = 200, vocs = {4}, sockets = 3 }, -- hammer of destruction
	[30179] = {}, -- strange mallet
	[30181] = {}, -- mallet handle
	[30307] = { sockets = 2 }, -- gnome sword
	[31120] = {}, -- test weapon for knights 
	[31379] = { sockets = 2 }, -- falcon longsword
	[31380] = { sockets = 2 }, -- falcon battleaxe
	[31381] = { sockets = 2 }, -- falcon mace
	[31402] = {}, -- zathroth' redeemer
	[31403] = {}, -- zathroth' redeemer
	[31404] = {}, -- zathroth' redeemer
	[31405] = {}, -- zathroth' redeemer
	[31481] = { sockets = 2 }, -- deepling ceremonial dagger
	[31485] = { sockets = 2 }, -- rotten demonbone
	[31486] = { sockets = 2 }, -- energized demonbone
	[31487] = { sockets = 2 }, -- unliving demonbone
	[31488] = { sockets = 2 }, -- sulphurous demonbone
	[31942] = {}, -- golden axe
	[32075] = { sockets = 2 }, -- resizer
	[32077] = { sockets = 2 }, -- summerblade
	[32078] = { sockets = 2 }, -- winterblade
	[33051] = { sockets = 2 }, -- cobra club
	[33052] = { sockets = 2 }, -- cobra axe
	[33054] = { sockets = 2 }, -- cobra sword
	[34236] = { sockets = 2 }, -- mortal mace
	[34270] = { sockets = 2 }, -- tagralt blade
	[34666] = {}, -- meat hammer
	[34669] = {}, -- orc hammer
	[34749] = {}, -- schnitzel meat grinder
	[35272] = { sockets = 2 }, -- phantasmal axe
	[36738] = { sockets = 2 }, -- soulcutter
	[36739] = { sockets = 3 }, -- soulshredder
	[36740] = { sockets = 2 }, -- soulbiter
	[36741] = { sockets = 3 }, -- souleater
	[36742] = {}, -- soulcrusher
	[36743] = { sockets = 3 }, -- soulmaimer
	[36811] = { sockets = 2 }, -- lion longsword
	[36909] = { sockets = 2 }, -- lion axe
	[36910] = { sockets = 2 }, -- lion hammer
	[36987] = {}, -- golden magic longsword
	[37882] = {}, -- rascoohan rat revealer
	[38170] = { sockets = 2 }, -- jungle flail
	[38171] = { sockets = 1 }, -- throwing axe
	[39313] = { sockets = 2 }, -- eldritch claymore
	[39314] = { sockets = 2 }, -- gilded eldritch claymore
	[39315] = { sockets = 2 }, -- eldritch warmace
	[39316] = { sockets = 2 }, -- gilded eldritch warmace
	[39317] = { sockets = 2 }, -- eldritch greataxe
	[39318] = { sockets = 2 }, -- gilded eldritch greataxe
}

local helmets = {
	[2128] = {}, -- crown
	[2139] = { sockets = 2 }, -- ancient tiara
	[2323] = { vocs = {1, 2}, sockets = 1 }, -- hat of the mad
	[2339] = {}, -- damaged helmet
	[2342] = {}, -- helmet of the ancients
	[2343] = {}, -- helmet of the ancients
	[2457] = {}, -- steel helmet
	[2458] = {}, -- chain helmet
	[2459] = {}, -- iron helmet
	[2460] = {}, -- brass helmet
	[2461] = {}, -- leather helmet
	[2462] = {}, -- devil helmet
	[2471] = { sockets = 2 }, -- golden helmet
	[2473] = {}, -- viking helmet
	[2474] = {}, -- winged helmet
	[2475] = { sockets = 2 }, -- warrior helmet
	[2479] = {}, -- strange helmet
	[2480] = {}, -- legion helmet
	[2481] = {}, -- soldier helmet
	[2482] = {}, -- studded helmet
	[2490] = {}, -- dark helmet
	[2491] = { sockets = 2 }, -- crown helmet
	[2493] = { sockets = 2 }, -- demon helmet
	[2496] = {}, -- horned helmet
	[2497] = { sockets = 2 }, -- crusader helmet
	[2498] = { sockets = 2 }, -- royal helmet
	[2499] = { sockets = 2 }, -- amazon helmet
	[2501] = {}, -- ceremonial mask
	[2502] = { sockets = 2 }, -- dwarven helmet
	[2506] = {}, -- dragon scale helmet
	[2662] = { sockets = 2 }, -- magician hat
	[2663] = {}, -- mystic turban
	[2664] = { vocs = {3} }, -- wood cape
	[2665] = {}, -- post officer's hat
	[3967] = {}, -- tribal mask
	[3969] = {}, -- horseman helmet
	[3970] = {}, -- feather headdress
	[3971] = {}, -- charmer's tiara
	[3972] = { sockets = 2 }, -- bonelord helmet
	[5461] = {}, -- helmet of the deep
	[5741] = { sockets = 2 }, -- skull helmet
	[5903] = {}, -- Ferumbras' hat
	[5917] = {}, -- bandana
	[5924] = {}, -- damaged steel helmet
	[6096] = {}, -- pirate hat
	[6531] = {}, -- santa hat
	[6578] = {}, -- party hat
	[7458] = { sockets = 2 }, -- fur cap
	[7459] = {}, -- pair of earmuffs
	[7461] = {}, -- krimhorn helmet
	[7462] = {}, -- ragnir helmet
	[7497] = {}, -- mining helmet
	[7900] = { vocs = {1, 2} }, -- magma monocle
	[7901] = { vocs = {1, 2} }, -- lightning headband
	[7902] = { vocs = {1, 2} }, -- glacier mask
	[7903] = { vocs = {1, 2} }, -- terra hood
	[7939] = {}, -- mining helmet
	[7957] = {}, -- jester hat
	[8820] = { vocs = {1, 2}, sockets = 2 }, -- mage hat
	[9080] = {}, -- hat of the mad
	[9778] = { level = 80, vocs = {1, 2}, sockets = 1 }, -- yalahari mask
	[9927] = {}, -- flower wreath
	[10016] = { level = 50, vocs = {1, 2}, sockets = 1 }, -- batwing hat
	[10291] = { sockets = 2 }, -- odd hat
	[10298] = { sockets = 2 }, -- helmet of ultimate terror
	[10299] = { sockets = 2 }, -- helmet of nature
	[10316] = {}, -- mighty helm of green sparks
	[10570] = { vocs = {1, 2}, sockets = 1 }, -- witch hat
	[11302] = { vocs = {4, 3}, sockets = 1 }, -- Zaoan helmet
	[11368] = { level = 60, vocs = {1, 2}, sockets = 1 }, -- jade hat
	[12541] = {}, -- helmet of the deep
	[12630] = { vocs = {1, 2} }, -- cobra crown
	[12645] = { level = 100, vocs = {3}, sockets = 1 }, -- elite draken helmet
	[12656] = {}, -- sedge hat
	[13756] = { vocs = {1, 2} }, -- mage's cap
	[13946] = {}, -- epic wisdom
	[13947] = {}, -- epic wisdom
	[15408] = { level = 150 }, -- depth galea
	[15651] = {}, -- depth galea
	[18398] = { level = 150, vocs = {1, 2} }, -- gill gugel
	[18403] = { level = 150, vocs = {4} }, -- prismatic helmet
	[20132] = { sockets = 2 }, -- helmet of the lost
	[23536] = { level = 70, vocs = {1, 2} }, -- rubber cap
	[24261] = { level = 80 }, -- crest of the deep seas
	[24744] = {}, -- enchanted werewolf helmet
	[24769] = {}, -- enchanted werewolf helmet
	[24770] = {}, -- enchanted werewolf helmet
	[24771] = {}, -- enchanted werewolf helmet
	[24772] = {}, -- enchanted werewolf helmet
	[24783] = {}, -- enchanted werewolf helmet
	[24784] = {}, -- enchanted werewolf helmet
	[24785] = {}, -- enchanted werewolf helmet
	[24786] = {}, -- enchanted werewolf helmet
	[24788] = {}, -- enchanted werewolf helmet
	[24809] = {}, -- dark wizard's crown
	[24810] = {}, -- dark wizard's crown
	[24848] = { sockets = 2 }, -- shamanic mask
	[25410] = { sockets = 2 }, -- visage of the end days
	[25413] = { level = 150 }, -- shroud of despair
	[26130] = { vocs = {1, 2} }, -- tiara of power
	[26131] = {}, -- tiara of power
	[27053] = {}, -- Ferumbras' Candy Hat
	[27061] = {}, -- rusty winged helmet
	[27744] = {}, -- porcelain mask
	[28843] = {}, -- leaf crown
	[28844] = {}, -- iron crown
	[28845] = {}, -- incandescent crown
	[28846] = {}, -- reflecting crown
	[30178] = {}, -- blue spectacles
	[30303] = { sockets = 2 }, -- gnome helmet
	[31370] = { sockets = 2 }, -- falcon circlet
	[31371] = { sockets = 2 }, -- falcon coif
	[32931] = {}, -- the crown of the percht queen
	[32932] = {}, -- the crown of the percht queen
	[33053] = { sockets = 2 }, -- cobra hood
	[34025] = {}, -- gryphon mask
	[34026] = {}, -- silver mask
	[34027] = {}, -- ivory mask
	[34028] = {}, -- mirror mask
	[34233] = { sockets = 1 }, -- terra helmet
	[34238] = { sockets = 2 }, -- galea mortis -- helmet
	[34756] = {}, -- traditional gamsbart hat
	[35581] = {}, -- golden crown
	[36812] = { sockets = 2 }, -- lion spangenhelm
	[39326] = { sockets = 2 }, -- eldritch cowl
	[39327] = { sockets = 2 }, -- eldritch hood
	[39634] = {}, -- magic hat
	[39635] = {}, -- magic hat
	[39820] = {}, -- golden horned helmet
	[40758] = {}, -- green demon helmet
	[40760] = {}, -- Morshabaal's mask
}

local armors = {
	[2463] = {}, -- plate armor
	[2464] = { sockets = 2 }, -- chain armor
	[2465] = {}, -- brass armor
	[2466] = { vocs = {4, 3}, sockets = 2 }, -- golden armor
	[2467] = {}, -- leather armor
	[2472] = { vocs = {4, 3}, sockets = 2 }, -- magic plate armor
	[2476] = { vocs = {4, 3}, sockets = 2 }, -- knight armor
	[2483] = {}, -- scale armor
	[2484] = {}, -- studded armor
	[2485] = {}, -- doublet
	[2486] = { sockets = 2 }, -- noble armor
	[2487] = { vocs = {4, 3}, sockets = 1 }, -- crown armor
	[2489] = {}, -- dark armor
	[2492] = { vocs = {4, 3}, sockets = 1 }, -- dragon scale mail
	[2494] = { sockets = 2 }, -- demon armor
	[2500] = { level = 60, vocs = {3}, sockets = 2 }, -- amazon armor
	[2503] = { sockets = 2 }, -- dwarven armor
	[2505] = { sockets = 3 }, -- elven mail
	[2508] = {}, -- native armor
	[2650] = {}, -- jacket
	[2651] = {}, -- coat
	[2652] = {}, -- green tunic
	[2653] = {}, -- red tunic
	[2654] = {}, -- cape
	[2655] = {}, -- red robe
	[2656] = { sockets = 2 }, -- blue robe
	[2657] = {}, -- simple dress
	[2658] = {}, -- white dress
	[2659] = {}, -- ball gown
	[2660] = { vocs = {3} }, -- ranger's cloak
	[3968] = { sockets = 2 }, -- leopard armor
	[4847] = {}, -- spectral dress
	[6095] = {}, -- pirate shirt
	[7463] = { sockets = 2 }, -- mammoth fur cape
	[7884] = { level = 50, vocs = {1, 2} }, -- terra mantle
	[7897] = { level = 50, vocs = {1, 2} }, -- glacier robe
	[7898] = { level = 50, vocs = {1, 2} }, -- lightning robe
	[7899] = { level = 50, vocs = {1, 2} }, -- magma coat
	[8819] = { vocs = {1, 2} }, -- magician's robe
	[8821] = { level = 50 }, -- witchhunter's coat
	[8865] = { level = 65, vocs = {1} }, -- dark lord's cape
	[8866] = { level = 75, vocs = {2} }, -- robe of the ice queen
	[8867] = { level = 75, vocs = {1} }, -- dragon robe
	[8868] = { level = 75, vocs = {1} }, -- velvet mantle
	[8869] = { level = 75, vocs = {2} }, -- greenwood coat
	[8870] = { vocs = {1, 2} }, -- spirit cloak
	[8871] = { vocs = {1, 2} }, -- focus cape
	[8872] = { vocs = {3} }, -- belted cape
	[8873] = {}, -- hibiscus dress
	[8874] = {}, -- summer dress
	[8875] = {}, -- tunic
	[8876] = {}, -- girl's dress
	[8877] = { level = 60, vocs = {4, 3} }, -- lavos armor
	[8878] = { level = 60, vocs = {4, 3} }, -- crystalline armor
	[8879] = { level = 60, vocs = {4, 3} }, -- voltage armor
	[8880] = { level = 60, vocs = {4, 3} }, -- swamplair armor
	[8881] = { level = 100, vocs = {4} }, -- fireborn giant armor
	[8882] = { level = 100, vocs = {4} }, -- earthborn titan armor
	[8883] = { level = 100, vocs = {4} }, -- windborn colossus armor
	[8884] = { level = 100, vocs = {4} }, -- oceanborn leviathan armor
	[8885] = { level = 75, vocs = {3} }, -- divine plate
	[8886] = { level = 75, vocs = {3} }, -- molten plate
	[8887] = { level = 75, vocs = {3} }, -- frozen plate
	[8888] = { level = 100, vocs = {3}, sockets = 1 }, -- master archer's armor
	[8889] = { level = 85, vocs = {4} }, -- skullcracker armor
	[8890] = { level = 100, vocs = {1} }, -- robe of the underworld
	[8891] = { vocs = {3}, sockets = 1 }, -- paladin armor
	[8892] = { vocs = {1, 2} }, -- ethno coat
	[9776] = { level = 80, vocs = {4} }, -- yalahari armor
	[9929] = {}, -- flower dress
	[10296] = { sockets = 2 }, -- heavy metal t-shirt
	[10317] = {}, -- rain coat
	[10363] = {}, -- rain coat
	[11301] = { level = 50, vocs = {4, 3} }, -- Zaoan armor
	[11355] = { level = 60, vocs = {1, 2} }, -- spellweaver's robe
	[11356] = { level = 60, vocs = {1, 2} }, -- Zaoan robe
	[12607] = { level = 100, vocs = {4, 3}, sockets = 2 }, -- elite draken mail
	[12642] = { level = 100, vocs = {4} }, -- royal draken mail
	[12643] = { level = 100, vocs = {1, 2} }, -- royal scale robe
	[12657] = {}, -- old cape
	[15406] = { level = 200, vocs = {4}, sockets = 2 }, -- ornate chestplate
	[15407] = { level = 150, vocs = {3}, sockets = 2 }, -- depth lorica
	[15489] = { level = 80, vocs = {1, 2} }, -- calopteryx cape
	[18399] = { level = 150, vocs = {1, 2} }, -- gill coat
	[18404] = { level = 120, vocs = {4, 3}, sockets = 1 }, -- prismatic armor
	[20126] = {}, -- leather harness
	[21692] = { sockets = 2 }, -- albino plate
	[21706] = {}, -- goo shell
	[21725] = { level = 130, vocs = {1, 2} }, -- furious frock
	[23535] = { level = 40, vocs = {1, 2} }, -- glooth cape
	[23537] = { vocs = {4, 3}, sockets = 2 }, -- mooh'tah plate
	[23538] = { sockets = 2 }, -- heat core
	[24741] = { level = 50 }, -- fur armor
	[25174] = { level = 200, vocs = {4} }, -- fireheart cuirass
	[25175] = { level = 200, vocs = {4} }, -- fireheart hauberk
	[25176] = { level = 200, vocs = {4} }, -- fireheart platemail
	[25177] = {}, -- earthheart cuirass
	[25178] = {}, -- earthheart hauberk
	[25179] = {}, -- earthheart platemail
	[25180] = { level = 200, vocs = {4} }, -- thunderheart cuirass
	[25181] = { level = 200, vocs = {4} }, -- thunderheart hauberk
	[25182] = { level = 200, vocs = {4} }, -- thunderheart platemail
	[25183] = { level = 200, vocs = {4} }, -- frostheart cuirass
	[25184] = { level = 200, vocs = {4} }, -- frostheart hauberk
	[25185] = { level = 200, vocs = {4} }, -- frostheart platemail
	[25186] = { level = 200, vocs = {3} }, -- firesoul tabard
	[25187] = {}, -- earthsoul tabard
	[25188] = { level = 200, vocs = {3} }, -- thundersoul tabard
	[25189] = { level = 200, vocs = {3} }, -- frostsoul tabard
	[25190] = { level = 200, vocs = {1, 2} }, -- firemind raiment
	[25191] = {}, -- earthmind raiment
	[25192] = { level = 200, vocs = {1, 2} }, -- thundermind raiment
	[25193] = { level = 200, vocs = {1, 2} }, -- frostmind raiment
	[28435] = {}, -- swan feather cloak
	[30304] = { sockets = 2 }, -- gnome armor
	[31131] = {}, -- ornate testtplate
	[31375] = { sockets = 2 }, -- falcon plate
	[32074] = { sockets = 1 }, -- living armor
	[32079] = { sockets = 1 }, -- dream shroud
	[34234] = { sockets = 1 }, -- bear skin
	[34235] = { sockets = 1 }, -- embrace of nature
	[34239] = { sockets = 1 }, -- toga mortis
	[34755] = {}, -- traditional shirt
	[35241] = {}, -- burial shroud
	[35284] = { sockets = 2 }, -- ghost chestplate
	[36750] = { sockets = 2 }, -- soulshell
	[36751] = { sockets = 2 }, -- soulmantle
	[36752] = { sockets = 2 }, -- soulshroud
	[36813] = { sockets = 2 }, -- lion plate
	[39319] = { sockets = 2 }, -- eldritch cuirass
	[40757] = { sockets = 2 }, -- green demon armor
}

local legs = {
	[2468] = {}, -- studded legs
	[2469] = {}, -- dragon scale legs
	[2470] = { vocs = {4, 3} }, -- golden legs
	[2477] = { vocs = {4, 3} }, -- knight legs
	[2478] = {}, -- brass legs
	[2488] = { vocs = {4, 3} }, -- crown legs
	[2495] = {}, -- demon legs
	[2504] = {}, -- dwarven legs
	[2507] = {}, -- elven legs
	[2647] = {}, -- plate legs
	[2648] = {}, -- chain legs
	[2649] = {}, -- leather legs
	[3983] = {}, -- bast skirt
	[5918] = {}, -- pirate knee breeches
	[7464] = {}, -- mammoth fur shorts
	[7730] = {}, -- blue legs
	[7885] = { level = 40, vocs = {1, 2} }, -- terra legs
	[7894] = { level = 40, vocs = {1, 2} }, -- magma legs
	[7895] = { level = 40, vocs = {1, 2} }, -- lightning legs
	[7896] = { level = 40, vocs = {1, 2} }, -- glacier kilt
	[8923] = { vocs = {3} }, -- ranger legs
	[9777] = { level = 80, vocs = {3} }, -- yalahari leg piece
	[9928] = {}, -- leaf legs
	[10300] = {}, -- trousers of the ancients
	[11304] = {}, -- Zaoan legs
	[15409] = { level = 130, vocs = {1, 2} }, -- depth ocrea
	[15412] = { level = 185, vocs = {4} }, -- ornate legs
	[15490] = { level = 75 }, -- grasshopper legs
	[18400] = { level = 150, vocs = {1, 2} }, -- gill legs
	[18405] = { level = 150, vocs = {3} }, -- prismatic legs
	[21700] = { vocs = {1, 2} }, -- icy culottes
	[23539] = { level = 60 }, -- alloy legs
	[24743] = {}, -- wereboar loincloth
	[27058] = {}, -- chocolatey dragon scale legs
	[27060] = {}, -- tatty dragon scale legs
	[30305] = {}, -- gnome legs
	[31376] = {}, -- falcon greaves
	[32083] = { sockets = 2 }, -- dark whispers
	[34753] = {}, -- lederhosen -- legs
	[35273] = {}, -- fabulous legs
	[35274] = {}, -- soulful legs
	[36748] = {}, -- soulshanks
	[36749] = {}, -- soulstrider
	[38172] = {}, -- exotic legs
	[38173] = {}, -- bast legs
	[39323] = {}, -- eldritch breeches
	[40756] = {}, -- green demon legs
}

local boots = {
	[2195] = { sockets = 1 }, -- boots of haste
	[2358] = {}, -- boots of waterwalking
	[2640] = {}, -- pair of soft boots
	[2641] = { sockets = 1 }, -- patched boots
	[2642] = { sockets = 1 }, -- sandals
	[2643] = { sockets = 1 }, -- leather boots
	[2644] = { sockets = 1 }, -- bunnyslippers
	[2645] = { sockets = 1 }, -- steel boots
	[2646] = { sockets = 1 }, -- golden boots
	[3982] = { sockets = 1 }, -- crocodile boots
	[5462] = { sockets = 1 }, -- pirate boots
	[6132] = {}, -- pair of soft boots
	[6530] = {}, -- worn leather boots
	[7457] = { sockets = 1 }, -- fur boots
	[7886] = { level = 35, vocs = {1, 2}, sockets = 1 }, -- terra boots
	[7891] = { level = 35, vocs = {1, 2}, sockets = 1 }, -- magma boots
	[7892] = { level = 35, vocs = {1, 2}, sockets = 1 }, -- glacier shoes
	[7893] = { level = 35, vocs = {1, 2}, sockets = 1 }, -- lightning boots
	[9931] = { sockets = 1 }, -- coconut shoes
	[9932] = { level = 130 }, -- firewalker boots
	[9933] = { level = 130 }, -- firewalker boots
	[9934] = {}, -- worn leather boots
	[10021] = {}, -- worn soft boots
	[10022] = {}, -- worn firewalker boots
	[11117] = { level = 70, vocs = {4, 3}, sockets = 1 }, -- crystal boots
	[11118] = { level = 70, vocs = {4, 3}, sockets = 1 }, -- dragon scale boots
	[11240] = { level = 70, vocs = {4, 3}, sockets = 1 }, -- guardian boots
	[11303] = { sockets = 1 }, -- Zaoan shoes
	[12498] = {}, -- fish tail
	[12499] = {}, -- fish tail
	[12646] = { level = 80, vocs = {4, 3}, sockets = 1 }, -- draken boots
	[13580] = {}, -- fish tail
	[15410] = { level = 150, vocs = {4}, sockets = 1 }, -- depth calcei
	[18406] = { level = 150, vocs = {3} }, -- prismatic boots
	[21708] = { sockets = 1 }, -- vampire silk slippers
	[23540] = { level = 50, vocs = {4, 3}, sockets = 1 }, -- metal spats
	[24637] = { level = 80, vocs = {1, 2}, sockets = 1 }, -- oriental shoes
	[24742] = { level = 60, sockets = 1 }, -- badger boots
	[25412] = { sockets = 1 }, -- treader of torment
	[25429] = { level = 100 }, -- boots of homecoming
	[25430] = {}, -- boots of homecoming
	[26132] = { level = 150 }, -- void boots
	[26133] = {}, -- void boots
	[27065] = {}, -- filthy bunnyslippers
	[32080] = { sockets = 1 }, -- pair of dreamwalkers
	[32852] = {}, -- yetislippers
	[33050] = { sockets = 1 }, -- cobra boots
	[34273] = { sockets = 1 }, -- winged boots
	[34754] = {}, -- traditional leather shoes
	[35275] = { sockets = 1 }, -- pair of nightmare boots
	[36753] = { sockets = 1 }, -- pair of soulwalkers
	[36754] = { sockets = 1 }, -- pair of soulstalkers
	[38175] = { sockets = 1 }, -- makeshift boots
	[38176] = { sockets = 1 }, -- make-do boots
	[40759] = { sockets = 1 }, -- green demon slippers
}

local shields = {
	[2175] = { vocs = {1, 2}, sockets = 1 }, -- spellbook
	[2509] = { sockets = 1 }, -- steel shield
	[2510] = {}, -- plate shield
	[2511] = {}, -- brass shield
	[2512] = {}, -- wooden shield
	[2513] = {}, -- battle shield
	[2514] = { sockets = 1 }, -- mastermind shield
	[2515] = {}, -- guardian shield
	[2516] = { sockets = 1 }, -- dragon shield
	[2517] = {}, -- shield of honour
	[2518] = { sockets = 1 }, -- bonelord shield
	[2519] = { sockets = 1 }, -- crown shield
	[2520] = { sockets = 1 }, -- demon shield
	[2521] = {}, -- dark shield
	[2522] = { sockets = 1 }, -- great shield
	[2523] = {}, -- blessed shield
	[2524] = { sockets = 1 }, -- ornamented shield
	[2525] = {}, -- dwarven shield
	[2526] = {}, -- studded shield
	[2527] = {}, -- rose shield
	[2528] = { sockets = 1 }, -- tower shield
	[2529] = {}, -- black shield
	[2530] = {}, -- copper shield
	[2531] = { sockets = 1 }, -- viking shield
	[2532] = {}, -- ancient shield
	[2533] = { sockets = 1 }, -- griffin shield
	[2534] = {}, -- vampire shield
	[2535] = { sockets = 1 }, -- castle shield
	[2536] = { sockets = 1 }, -- medusa shield
	[2537] = { sockets = 1 }, -- amazon shield
	[2538] = {}, -- eagle shield
	[2539] = { sockets = 1 }, -- phoenix shield
	[2540] = {}, -- scarab shield
	[2541] = {}, -- bone shield
	[2542] = { sockets = 1 }, -- tempest shield
	[3973] = {}, -- tusk shield
	[3974] = { sockets = 1 }, -- sentinel shield
	[3975] = {}, -- salamander shield
	[6131] = {}, -- tortoise shield
	[6391] = { sockets = 1 }, -- nightmare shield
	[6433] = { sockets = 1 }, -- necromancer shield
	[7460] = { sockets = 1 }, -- norse shield
	[8900] = { level = 30, vocs = {1, 2}, sockets = 1 }, -- spellbook of enlightenment
	[8901] = { level = 40, vocs = {1, 2}, sockets = 1 }, -- spellbook of warding
	[8902] = { level = 50, vocs = {1, 2} }, -- spellbook of mind control
	[8903] = { level = 60, vocs = {1, 2} }, -- spellbook of lost souls
	[8904] = { level = 70, vocs = {1, 2} }, -- spellscroll of prophecies
	[8905] = { level = 100, vocs = {4} }, -- rainbow shield
	[8906] = { level = 100, vocs = {4} }, -- fiery rainbow shield
	[8907] = { level = 100, vocs = {4} }, -- icy rainbow shield
	[8908] = { level = 100, vocs = {4} }, -- sparking rainbow shield
	[8909] = { level = 100, vocs = {4} }, -- terran rainbow shield
	[8918] = { level = 80, vocs = {1, 2} }, -- spellbook of dark mysteries
	[10289] = { sockets = 1 }, -- meat shield
	[10294] = { sockets = 1 }, -- shield of the white knight
	[10297] = { sockets = 1 }, -- shield of care
	[10318] = {}, -- shield Nevermourn
	[10364] = {}, -- shield Nevermourn
	[12644] = { level = 80, vocs = {4}, sockets = 1 }, -- shield of corruption
	[12647] = { level = 100, vocs = {1, 2} }, -- snake god's wristguard
	[14353] = {}, -- shield of the white knight
	[15411] = { level = 120, vocs = {1, 2}, sockets = 1 }, -- depth scutum
	[15413] = { level = 130, vocs = {4}, sockets = 1 }, -- ornate shield
	[15453] = { sockets = 1 }, -- warrior's shield
	[15491] = { sockets = 1 }, -- carapace shield
	[16103] = {}, -- mathmaster shield
	[16104] = {}, -- mathmaster shield
	[16109] = {}, -- majestic shield
	[16110] = {}, -- majestic shield
	[16112] = { level = 150, vocs = {1, 2} }, -- spellbook of ancient arcana
	[18401] = { level = 130, vocs = {1, 2} }, -- spellbook of vigilance
	[18410] = { level = 150, vocs = {4} }, -- prismatic shield
	[20090] = {}, -- spike shield
	[21697] = { sockets = 1 }, -- runic ice shield
	[21707] = { sockets = 1 }, -- haunted mirror piece
	[22422] = { level = 75, vocs = {1, 2} }, -- crude umbral spellbook
	[22423] = { level = 120, vocs = {1, 2}, sockets = 1 }, -- umbral spellbook
	[22424] = { level = 250, vocs = {1, 2}, sockets = 1 }, -- umbral master spellbook
	[22474] = {}, -- eerie song book
	[23546] = {}, -- mino shield
	[23771] = { vocs = {1, 2} }, -- spellbook of the novice
	[23772] = {}, -- broken wooden shield
	[25382] = { sockets = 1 }, -- rift shield
	[25411] = { level = 150, vocs = {1, 2}, sockets = 1 }, -- book of lies
	[25414] = { level = 200, sockets = 1 }, -- death gaze
	[25545] = {}, -- shield of destiny
	[25546] = {}, -- shield of destiny
	[28355] = { sockets = 1 }, -- wooden spellbook
	[28638] = {}, -- mathmaster shield
	[30306] = { sockets = 1 }, -- gnome shield
	[31377] = { sockets = 1 }, -- falcon shield
	[31378] = { sockets = 1 }, -- falcon escutcheon
	[31571] = {}, -- adamant shield
	[31572] = {}, -- adamant shield
	[31573] = {}, -- adamant shield
	[31574] = {}, -- adamant shield
	[32076] = {sockets = 1}, -- shoulder plate
	[32082] = { sockets = 1 }, -- brain in a jar
	[32086] = { sockets = 1 }, -- ectoplasmic shield
	[32087] = { sockets = 1 }, -- spirit guide
	[32837] = {}, -- shield of endless search
	[32838] = {}, -- shield of endless search
	[36755] = { sockets = 1 }, -- soulbastion
	[36809] = { sockets = 1 }, -- lion spellbook
	[36810] = { sockets = 1 }, -- lion shield
	[36920] = {}, -- Encyclopedia
	[36921] = {}, -- Encyclopedia
	[36922] = {}, -- Encyclopedia
	[36923] = {}, -- Encyclopedia
	[39312] = { sockets = 1 }, -- eldritch shield
	[39328] = { sockets = 1 }, -- eldritch folio
	[39329] = { sockets = 1 }, -- eldritch tome
	[39650] = {}, -- golden blessed shield
	[39708] = {}, -- bonelord tome
	[39709] = {}, -- bonelord tome
	[39716] = {}, -- shield of endless search
}

--[[
local unequippable = {
	[2122] = {}, -- elven brooch
	[2127] = {}, -- emerald bangle
	[2134] = {}, -- silver brooch
	[2137] = {}, -- some golden fruits
	[2140] = {}, -- holy scarab
	[2141] = {}, -- holy falcon
}

local unused = {
	[2184] = {}, -- crystal wand
	[13875] = {}, -- shimmer glower
	[13876] = {}, -- babel swimmer
	[13944] = {}, -- shimmer ball
}
]]

Equippables = {
	backpacks = backpacks,
	lightSources = lightSources,
	rings = rings,
	necklaces = necklaces,
	weapons_magic = weapons_magic,
	throwables = throwables,
	weapons_distance = weapons_distance,
	ammo = ammo,
	quivers = quivers,
	weapons = weapons,
	helmets = helmets,
	armors = armors,
	legs = legs,
	boots = boots,
	shields = shields
}

---- REGISTER EQUIP SCRIPTS
local slotTypes = {
	backpacks = "backpack",
	lightSources = "ammo",
	rings = "ring",
	necklaces = "necklace",
	weapons_magic = "hand",
	throwables = "hand",
	weapons_distance = "hand",
	ammo = "ammo",
	quivers = "shield",
	weapons = "hand",
	helmets = "head",
	armors = "armor",
	legs = "legs",
	boots = "feet",
	shields = "shield"
}

local weaponAction = Action()
for slotType, slotItems in pairs(Equippables) do
	for itemId, itemData in pairs(slotItems) do
		if slotType == "weapons" and not itemData.alreadyScripted then
			weaponAction:id(itemId)
		end
	
		local eq = MoveEvent()
		eq:type("equip")
		eq:slot(slotTypes[slotType])
		eq:id(itemId)
				
		-- required level
		if itemData.level then
			eq:level(itemData.level)
		end

		-- required voc + autogenerate promos
		if itemData.vocs then
			local vocPromoData = {}
			local realVocs = {}
			local lastVocId = -1
			for a, vocId in pairs(itemData.vocs) do
				vocPromoData[vocId] = true
				realVocs[#realVocs + 1] = vocId
				lastVocId = vocId
				local promos = Vocation(vocId):getAllPromotions()
				if promos then
					for b, promoVocId in pairs(promos) do
						vocPromoData[promoVocId] = false
						realVocs[#realVocs + 1] = promoVocId
					end
				end
			end
		
			for _, vocId in pairs(realVocs) do
				eq:vocation(Vocation(vocId):getName(), vocPromoData[vocId], vocId == lastVocId)
			end
		end
		
		eq:register()
		
		local de = MoveEvent()
		de:type("deequip")
		de:slot(slotTypes[slotType])
		de:id(itemId)
		de:register()
	end
end
		
weaponAction.onUse = function(player, item, fromPosition, target, toPosition, isHotkey)
	return destroyItem(player, target, toPosition)
end
weaponAction:register()

---- REGISTER AMMO SCRIPTS
for itemId, itemData in pairs(Equippables.ammo) do
	if itemData.callback then
		itemData.callback(itemId)
	else
		generateDefaultArrow(itemId)
	end
end

---- REGISTER MISSILES (spears, throwing stars)
for itemId, itemData in pairs(Equippables.throwables) do
	if itemData.callback then
		itemData.callback(itemId)
	else
		generateDefaultMissile(itemId)
	end
end

-- helper for imbuing altar
function ItemType:getEquippableCategory()
	local itemId = self:getId()
	for categoryType, category in pairs(Equippables) do
		if category[itemId] then
			return categoryType
		end
	end
	
	return "NONE"
end