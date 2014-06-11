local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function creatureSayCallback(cid, type, msg)
	local TheNewFrontierQuestStorage = 12144 --TheNewFrontierQuestline_Storage

	local player = Player(cid)
	if not npcHandler:isFocused(cid) then
		return false
	elseif(msgcontains(msg, "mission")) then
		if(player:getStorageValue(TheNewFrontierQuestStorage) == 17) then
			npcHandler:say("You come here to ask us to spare your people? This land has no tolerance for the weak, we have it neither. If you want us to consider you as useful for us, you'll have to prove it in a {test} of strength and courage. ", cid)
			npcHandler.topic[cid] = 1
		elseif(player:getStorageValue(TheNewFrontierQuestStorage) == 19) then
			npcHandler:say({"We have seen that you can fight and survive. Yet, it will also need cleverness and courage to survive in these lands. We might see later if you've got what it takes. ... ",
							"However, I stand to my word - our hordes will spare your insignificant piece of rock for now. Time will tell if you are worthy living next to us. ... ",
							"Still, it will take years until we might consider you as an ally, but this is a start at least. "}, cid)
			player:setStorageValue(TheNewFrontierQuestStorage, 20)
			player:setStorageValue(12136, 3) --Questlog, The New Frontier Quest "Mission 06: Days Of Doom"
		end
	elseif(msgcontains(msg, "test")) then
		if(npcHandler.topic[cid] == 1) then
			npcHandler:say({"First we will test your strength and endurance. You'll have to face one of the most experienced Mooh'Tah masters. As you don't stand a chance to beat such an opponent, your test will be simply to survive. ... ",
							"Face him in a battle and survive for two minutes. If you do, we will be willing to assume that your are prepared for the life in these lands. Enter the ring of battle, close to my quarter. Return to me after you have passed this test. "}, cid)
			npcHandler.topic[cid] = 0
			player:setStorageValue(TheNewFrontierQuestStorage, 18)
			player:setStorageValue(12136, 2) --Questlog, The New Frontier Quest "Mission 06: Days Of Doom"
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
