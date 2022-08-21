function onCreatureAppear(cid) end
function onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)
  	msg = string.lower(msg)
 
  	if (string.find(msg, '(%a*)hi(%a*)')) and Creature(cid):getPosition():getDistance(Npc(getNpcCid()):getPosition()) < 4 then
  		selfSay('You do not talk about Fight Club.', cid, false)
  	end
end
function onThink() end
