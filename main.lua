
print("|cFF0099ff Tango-UI |r Bonjour " .. UnitName("player") .. " !");
print("|cFF0099ff Tango-UI |r v.8.0.1.27101");

--------------------------------------------------------------------------------------------------------------
-- Addon Initialisation
--------------------------------------------------------------------------------------------------------------

--Array for Color by power
powerColor = {
    {"0","0.39","0.62","1"}, -- mana
	{"1","1","0","0"}, -- rage
	{"2","1","0.5","0.25"}, -- focus
	{"3","1","1","0"}, -- energy
	{"4","1","0.96","0.41"}, -- combo point
	{"5","0.5","0.5","0.5"}, -- Runes
	{"6","0","0.82","1"}, -- Runic Power
	{"7","0.96","0.39","0.83"}, -- soul shards
	{"8","0.3","0.52","0.9"}, -- lunar/astral power
	{"9","0.95","0.90","0.60"}, -- holy power
	{"10","0","0.5","1"}, -- Alternate power (i think its not use)
	{"11","0","0.5","1"}, -- maelstrom
	{"12","0.71","1","0.92"}, -- chi
	{"13","0.4","0","0.8"}, -- insanity
	{"14","0","1","0"}, -- obsolete
	{"15","0","1","0"}, -- obsolete 2
	{"16","0.1","0.1","0.98"}, -- arcane charge
	{"17","0.78","0.26","0.99"}, -- Fury
    {"18","1","0.61","0"} -- Pain
    }


	
--------------------------------------------------------------------------------------------------------------
-- General fonction
--------------------------------------------------------------------------------------------------------------
--getting basic information
playerClass = UnitClass("player")
playerCurrentSpec =  GetSpecialization()


--Function pour definir les value qui on besoin d'etre mise a jours a PLAYER_ENTERING_WORLD
local function setAddonDefault(self,elapsed)


	--Getting player powertype information for Druid	
	if playerClass == "Druid" then	
		--local MoonkinisKnown = IsSpellKnown(197625) -- check if player know Moonkin Form
		local playerForm = GetShapeshiftForm("player")
		if playerForm == 0 then
			--print "Humanoid"			
			playerMainPowerType = 0
			local powerIndex = powerColor[1]			
			mainPowerColorR = powerIndex[2]
			mainPowerColorG = powerIndex[3]
			mainPowerColorB = powerIndex[4]	
			--Humanoid form dont have secondary power
			secondaryPowerType = nil
		
		elseif playerForm == 1 then
			--print "bear"			
			playerMainPowerType = 1
			local powerIndex = powerColor[2]			
			mainPowerColorR = powerIndex[2]
			mainPowerColorG = powerIndex[3]
			mainPowerColorB = powerIndex[4]	
			--Bear form dont have secondary power
			secondaryPowerType = nil

		elseif playerForm == 2 then
			--print "cat"
			playerMainPowerType = 3
			local powerIndex = powerColor[4]			
			mainPowerColorR = powerIndex[2]
			mainPowerColorG = powerIndex[3]
			mainPowerColorB = powerIndex[4]	
			secondaryPowerType = 4
			local powerIndex2 = powerColor[5]		
			secondaryPowerColorR = powerIndex2[2]
			secondaryPowerColorG = powerIndex2[3]
			secondaryPowerColorB = powerIndex2[4]
					
		elseif playerForm == 3 then
			--print "travel" 
			playerMainPowerType = 0
			local powerIndex = powerColor[1]			
			mainPowerColorR = powerIndex[2]
			mainPowerColorG = powerIndex[3]
			mainPowerColorB = powerIndex[4]	
			secondaryPowerType = nil
				
		elseif playerForm == 4 and playerCurrentSpec == 1 then
			--print "Mookin" -- playerCurrentSpec est utiliser parceque les moonkin on un astral bar selement avec leur Main spec
			playerMainPowerType = 8
			local powerIndex = powerColor[9]			
			mainPowerColorR = powerIndex[2]
			mainPowerColorG = powerIndex[3]
			mainPowerColorB = powerIndex[4]	
			secondaryPowerType = 0
			local powerIndex2 = powerColor[1]			
			secondaryPowerColorR = powerIndex2[2]
			secondaryPowerColorG = powerIndex2[3]
			secondaryPowerColorB = powerIndex2[4]		
		else 
			--print "tree/stag/humanoid again"
			playerMainPowerType = 0
			local powerIndex = powerColor[1]			
			mainPowerColorR = powerIndex[2]
			mainPowerColorG = powerIndex[3]
			mainPowerColorB = powerIndex[4]	
			--tree/stag form dont have secondary power
			secondaryPowerType = nil		
		end

	elseif playerClass == "Demon Hunter" and playerCurrentSpec == 2 then
		--print ("this is a Vengeance Demon Hunter")
		playerMainPowerType = 18
		local powerIndex = powerColor[19]			
		mainPowerColorR = powerIndex[2]
		mainPowerColorG = powerIndex[3]
		mainPowerColorB = powerIndex[4]	
		--local powerIndex2 = powerColor[5]
	
	elseif playerClass == "Death Knight" then
		--print ("this is a Death Knight")
		playerMainPowerType = 6
		local powerIndex = powerColor[7]			
		mainPowerColorR = powerIndex[2]
		mainPowerColorG = powerIndex[3]
		mainPowerColorB = powerIndex[4]	
			
		secondaryPowerType = 5
		local powerIndex2 = powerColor[6]			
		secondaryPowerColorR = powerIndex2[2]
		secondaryPowerColorG = powerIndex2[3]
		secondaryPowerColorB = powerIndex2[4]	
		
	elseif playerClass == "Mage" and playerCurrentSpec == 3 then
		--print ("this is a Death Knight")
		playerMainPowerType = 0
		local powerIndex = powerColor[7]			
		mainPowerColorR = powerIndex[2]
		mainPowerColorG = powerIndex[3]
		mainPowerColorB = powerIndex[4]	
			
		--secondaryPowerType = 5
		--local powerIndex2 = powerColor[6]			
		--secondaryPowerColorR = powerIndex2[2]
		--secondaryPowerColorG = powerIndex2[3]
		--secondaryPowerColorB = powerIndex2[4]	
		
		
			
	else
		--Getting Mainpower information
		mainPower = {"0", "1", "2", "3", "5", "12", "17", "18"}
		for  i = 1, 8 do
			local pm = UnitPowerMax("player",mainPower[i])	
			local pt = mainPower[i]	
			if pm > 0  then
				playerMainPowerType = pt			
				break
			end
		end
		--Getting bar color for mainpower 

		for i = 1, 18 do
		local powerIndex = powerColor[i]
		local colorIndex = powerIndex[1]
			if colorIndex == playerMainPowerType then
			mainPowerColorR = powerIndex[2]
			mainPowerColorG = powerIndex[3]
			mainPowerColorB = powerIndex[4]
			end
		end
	
		--Getting secondaryPower information
		secondaryPower = {"4", "6", "7", "8", "9", "11", "13", "16"}
		for  i = 1, 8 do
		local pm = UnitPowerMax("player",secondaryPower[i])	
		local pt = secondaryPower[i]	
			if pm > 0  then
				secondaryPowerType = pt
				break
		   else
				--this class dont have secondary power
				secondaryPowerType = nil	
		   end
		end

		--Getting bar color for secondaryPower 
		for i = 1, 18 do
		 colorIndex = powerColor[i]
		 powerIndex = colorIndex[1]
			if powerIndex == secondaryPowerType then
			secondaryPowerColorR = colorIndex[2]
			secondaryPowerColorG = colorIndex[3]
			secondaryPowerColorB = colorIndex[4]	
			break
			end
		end		
	end	
end

--exectution de la function setAddonDefault
local addonDefaultFrame = CreateFrame("frame")
addonDefaultFrame:RegisterEvent("PLAYER_ENTERING_WORLD"); 
addonDefaultFrame:RegisterEvent("UPDATE_SHAPESHIFT_FORM");
addonDefaultFrame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
addonDefaultFrame:RegisterEvent("CHARACTER_POINTS_CHANGED");
addonDefaultFrame:RegisterEvent("ADDON_LOADED");
--addonDefaultFrame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED"); --je sais pas pourquois mon event ne trigger pas.
addonDefaultFrame:SetScript("OnEvent", setAddonDefault);

--Trasforme les chiffre trop gros en chirffre lisible
local function ReadableNumber(num, places)
    local ret
	if  num >= 1000000 then
		placeValue = ("%%.%df"):format(places or 1)
	else
		placeValue = ("%%.%df"):format(places or 0)
	end
    if not num then
        return 0
    elseif num >= 1000000000000 then
        ret = placeValue:format(num / 1000000000000) .. " t" -- trillion
    elseif num >= 1000000000 then
        ret = placeValue:format(num / 1000000000) .. " b" -- billion
    elseif num >= 1000000 then
        ret = placeValue:format(num / 1000000) .. " m" -- million
    elseif num >= 1000 then
        ret = placeValue:format(num / 1000) .. " k" -- thousand
    else
        ret = num -- hundreds
    end
	if ret == 0 then
	ret = "Dead"
	end
    return ret
end

--------------------------------------------------------------------------------------------------------------
-- player healt bar
--------------------------------------------------------------------------------------------------------------

--Drawing Player Status Bar
local pUnit = "player" 
playerHealthBar = CreateFrame("Statusbar",nil,UIParent)
playerHealthBar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
local pStatusbar = playerHealthBar
pStatusbar.unit = pUnit
pStatusbar:SetMinMaxValues(0,100)
pStatusbar:SetPoint("CENTER",-300,-245)
pStatusbar:SetSize(200,20)
pStatusbar:Show()
pStatusbar:SetValue(100)
pStatusbar:SetStatusBarColor(0,1,0, 1)
pStatusbar.text = pStatusbar:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
pStatusbar.text:SetAllPoints()

--Drawing  Background and border under the healt Bar
playerHealthBarBg = CreateFrame("Statusbar",BORDER,UIParent)
local pStatusbarBg = playerHealthBarBg
pStatusbarBg:SetPoint("CENTER",-300,-250)
pStatusbarBg:SetSize(209,39)
pStatusbarBg:Show()
pStatusbarBg:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                            tile = true, tileSize = 16, edgeSize = 16, 
                                            insets = { left = 4, right = 4, top = 4, bottom = 4 }});
pStatusbarBg:SetBackdropColor(0,0,0,1);

--Run Script uptade a l'event OnUpdate (chaque Frame).
pStatusbar:SetScript("OnUpdate",function(self) 
	self:SetValue(UnitHealth(self.unit)/UnitHealthMax(self.unit)*100) 
	pStatusbar.text:SetText(ReadableNumber(UnitHealth(self.unit)))
	-- checking if player have a target to displayer the Target tStatusbar
	if UnitExists("target") then
		tStatusbar:Show()
	else
		tStatusbar:Hide()
	end

end)

--------------------------------------------------------------------------------------------------------------
-- player mainPower bar
--------------------------------------------------------------------------------------------------------------

--Drawing player Power bar
playerPowerBar = CreateFrame("Statusbar",nil,UIParent)
playerPowerBar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
local pPowerBar = playerPowerBar
pPowerBar.unit = "player"
pPowerBar:SetMinMaxValues(0,100)
pPowerBar:SetPoint("CENTER",-300,-260)
pPowerBar:SetSize(200,10)
pPowerBar:Show()
pPowerBar:SetValue(100)
--pPowerBar:SetStatusBarColor(mainPowerColorR,mainPowerColorG,mainPowerColorB)
pPowerBar.text = pPowerBar:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
pPowerBar.text:SetAllPoints()

--Drawing  Background and border under the playerpower Bar
--[[
playerPowerBarBg = CreateFrame("Statusbar",BORDER,UIParent)
local pPowerBarBg = playerPowerBarBg
pPowerBarBg:SetPoint("CENTER",-300,-20)
pPowerBarBg:SetSize(160,20)
pPowerBarBg:Show()
pPowerBarBg:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                            tile = true, tileSize = 16, edgeSize = 16, 
                                            insets = { left = 4, right = 4, top = 4, bottom = 4 }});
pPowerBarBg:SetBackdropColor(0,0,0,1);
]]
--Run Script uptade a l'event OnUpdate (chaque Frame).
pPowerBar:SetScript("OnUpdate",function(self) 
self:SetValue(UnitPower("player",playerMainPowerType)/UnitPowerMax("player",playerMainPowerType)*100) 
self:SetStatusBarColor(mainPowerColorR,mainPowerColorG,mainPowerColorB)




end)

--------------------------------------------------------------------------------------------------------------
-- player secondaryPower bar
--------------------------------------------------------------------------------------------------------------

--Drawing player secondary Power bar
playerPowerBar2 = CreateFrame("Statusbar",nil,UIParent)
playerPowerBar2:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
local pPowerBar2 = playerPowerBar2
pPowerBar2.unit = "player"
pPowerBar2:SetMinMaxValues(0,100)
pPowerBar2:SetPoint("CENTER",-300,-277)
pPowerBar2:SetSize(200,12)
pPowerBar2:Show()
pPowerBar2:SetValue(100)
--pPowerBar2:SetStatusBarColor(secondaryPowerColorR,secondaryPowerColorG,secondaryPowerColorB)
pPowerBar2.text = pPowerBar2:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
pPowerBar2.text:SetAllPoints()

--Drawing  Background and border under the secondary /Power Bar
playerPowerBar2Bg = CreateFrame("Statusbar",BORDER,UIParent)
local pPowerBar2Bg = playerPowerBar2Bg
pPowerBar2Bg:SetPoint("CENTER",-300,-277)
pPowerBar2Bg:SetSize(208,20)
pPowerBar2Bg:Show()
pPowerBar2Bg:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                            tile = true, tileSize = 16, edgeSize = 16, 
                                            insets = { left = 4, right = 4, top = 4, bottom = 4 }});
pPowerBar2Bg:SetBackdropColor(0,0,0,1);



print ()

pPowerBar2:SetScript("OnUpdate",function(self) 
	if (secondaryPowerType == nil ) then
		pPowerBar2Bg:Hide()
		pPowerBar2:SetValue(0)
		
	else
		pPowerBar2Bg:Show()
		self:SetStatusBarColor(secondaryPowerColorR,secondaryPowerColorG,secondaryPowerColorB)
		
		if playerClass == "Death Knight" then
			pPowerBar2:SetValue(50)
			local runeAmount = 0
			for i=1,6 do
				local start, duration, runeReady = GetRuneCooldown(i)
				if runeReady == true then
					runeAmount = runeAmount+1
				end			
			end
			self:SetValue(runeAmount/6*100) 
		else
			self:SetValue(UnitPower("player",secondaryPowerType)/UnitPowerMax("player",secondaryPowerType)*100) 
		end
		
	end
end)


--------------------------------------------------------------------------------------------------------------
-- Target tStatusbar
--------------------------------------------------------------------------------------------------------------
 
--Drawing Target Status Bar
local tUnit = "target" 
targetHealthBar = CreateFrame("Statusbar",nil,UIParent)
targetHealthBar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")

tStatusbar = targetHealthBar
tStatusbar.unit = tUnit
tStatusbar:SetMinMaxValues(0,100)
tStatusbar:SetPoint("CENTER",300,-250)
tStatusbar:SetSize(200,30)
tStatusbar:Show()
tStatusbar:SetValue(100)
tStatusbar.text = tStatusbar:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
tStatusbar.text:SetAllPoints()


--Drawing Player Background and border under the Target Bar
targetHealthBarBg = CreateFrame("Statusbar",nil,UIParent)
local tStatusbarBg = targetHealthBarBg
tStatusbarBg:SetPoint("CENTER",300,-250)
tStatusbarBg:SetSize(209,39)
tStatusbarBg:Hide()
tStatusbarBg:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                            tile = true, tileSize = 16, edgeSize = 16, 
                                            insets = { left = 4, right = 4, top = 4, bottom = 4 }});
tStatusbarBg:SetBackdropColor(0,0,0,1);



--Run Script uptade a l'event OnUpdate (chaque Frame). also matching life bar w/ class color
tStatusbar:SetScript("OnUpdate",function(self)
	self:SetValue(UnitHealth(self.unit)/UnitHealthMax(self.unit)*100) 
	

	if UnitExists("target") then
  
		if (UnitIsPlayer("target")) then --if target is a player
			playerclass,PLAYERCLASS = UnitClass("target")
			classcolor = RAID_CLASS_COLORS[PLAYERCLASS]
			tStatusbarBg:Show()
			tStatusbar.text:Show()
			r,g,b = classcolor.r,classcolor.g,classcolor.b
			self:SetStatusBarColor(r,g,b)
			tStatusbar.text:SetText(ReadableNumber(UnitHealth(self.unit)))
		else  --if TARGET is a NPC
			if  UnitIsFriend("player", "target") then --set color for neutral/friendly/hostile
			self:SetStatusBarColor(0,1,0)			 
			elseif UnitIsEnemy("player","target") then 
			self:SetStatusBarColor(1,0,0)
			else
			self:SetStatusBarColor(1,1,0)
			end	
					
			tStatusbarBg:Show()
			tStatusbar.text:Show()				
			tStatusbar.text:SetText(ReadableNumber(UnitHealth(self.unit)))
			
		end	
		
		corruptionFrame:Show() --warlock ui
		agonyFrame:Show() --warlock ui
		hauntFrame:Show() --warlock ui
		siphonLifeFrame:Show() --warlock ui
		PhantomSingularityFrame:Show()--warlock ui
		unstableAffliction1Frame:Show()--warlock ui
		unstableAffliction2Frame:Show()--warlock ui
		unstableAffliction3Frame:Show()--warlock ui
		unstableAffliction4Frame:Show()--warlock ui
		unstableAffliction5Frame:Show()--warlock ui
		rakeFrame:Show()--druid ui
		ripeFrame:Show()--druid ui
		frostFrame:Show()--Mage ui
	else
		corruptionFrame:Hide() --warlock ui
		agonyFrame:Hide() --warlock ui
		hauntFrame:Hide() --warlock ui
		siphonLifeFrame:Hide() --warlock ui
		PhantomSingularityFrame:Hide()--warlock ui
		unstableAffliction1Frame:Hide()--warlock ui
		unstableAffliction2Frame:Hide()--warlock ui
		unstableAffliction3Frame:Hide()--warlock ui
		unstableAffliction4Frame:Hide()--warlock ui
		unstableAffliction5Frame:Hide()--warlock ui
		rakeFrame:Hide()--druid ui
		ripeFrame:Hide()--druid ui
		frostFrame:Hide()--Mage ui
		tStatusbarBg:Hide()
		tStatusbar.text:Hide()
	end

end)		
--------------------------------------------------------------------------------------------------------------
-- Afflication  Spesific UI -- 
--------------------------------------------------------------------------------------------------------------
warlockUiFrame = CreateFrame("Statusbar",nil,UIParent)
local warlockUiBar = warlockUiFrame
warlockUiBar.unit = "target"
warlockUiBar:SetMinMaxValues(0,100)
warlockUiBar:SetPoint("CENTER",300,-220)
warlockUiBar:SetSize(200,15)
warlockUiBar:Hide()
warlockUiBar:SetValue(0)
warlockUiBar:SetStatusBarColor(1,0.1,0.1, 1)
warlockUiBar:SetScript("OnUpdate",function(self)
for i=1,40 do
		local name, _, _, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitDebuff("target",i)
		
		if name == "Corruption" and unitCaster == "player" then
			local corruTimer = expirationTime - GetTime()
			self:SetValue(corruTimer/duration*100)
		
			break
		else
			self:SetValue(0)	
	  end
	end
end)

--Curruption frame config
corruptionFrame = CreateFrame("Statusbar",nil,UIParent)
corruptionFrame:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
local corruptionBar = corruptionFrame
corruptionBar.unit = "target"
corruptionBar:SetMinMaxValues(0,100)
corruptionBar:SetPoint("CENTER",300,-220)
corruptionBar:SetSize(200,15)
--corruptionBar:Hide()
corruptionBar:SetValue(0)
corruptionBar:SetStatusBarColor(1,0.1,0.1, 1)


--Corruption bar tick 
corruptionBar:SetScript("OnUpdate",function(self)
	for i=1,40 do
		local name, _, _, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitDebuff("target",i)
		
		if name == "Corruption" and unitCaster == "player" then
			local corruTimer = expirationTime - GetTime()
			self:SetValue(corruTimer/duration*100)
			break
		else
			self:SetValue(0)	
	  end
	end
end)
--Agony frame config
agonyFrame = CreateFrame("Statusbar",nil,UIParent)
agonyFrame:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
local agonyBar = agonyFrame
agonyBar.unit = target
agonyBar:SetMinMaxValues(0,100)
agonyBar:SetPoint("CENTER",300,-205)
agonyBar:SetSize(200,15)
agonyBar:Hide()
agonyBar:SetValue(0)
agonyBar:SetStatusBarColor(0.9,0.9,0.9, 1)

--Agony bar tick
agonyBar:SetScript("OnUpdate",function(self)
for i=1,40 do
		local name, _, _, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitDebuff("target",i)
		if name == "Agony" and unitCaster == "player" then
		local agonyTimer = expirationTime - GetTime()
		self:SetValue(agonyTimer/duration*100)
		break
	else
		self:SetValue(0)	
	  end
	end
end)

--Haunt frame config
hauntFrame = CreateFrame("Statusbar",nil,UIParent)
hauntFrame:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
local hauntBar = hauntFrame
hauntBar.unit = target
hauntBar:SetMinMaxValues(0,100)
hauntBar:SetPoint("CENTER",300,-190)
hauntBar:SetSize(200,15)
hauntBar:Hide()
hauntBar:SetValue(0)
hauntBar:SetStatusBarColor(0.7,0.1,0.7, 1)

--Haunt bar tick
hauntBar:SetScript("OnUpdate",function(self)
for i=1,40 do
		local name, _, _, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitDebuff("target",i,"player")
		if name == "Haunt" then
		local hauntTimer = expirationTime - GetTime()
		self:SetValue(hauntTimer/duration*100)
		break
	else
		self:SetValue(0)	
	  end
	end
end)

--Siphon Life config
siphonLifeFrame = CreateFrame("Statusbar",nil,UIParent)
siphonLifeFrame:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
local siphonLifeBar = siphonLifeFrame
siphonLifeBar.unit = target
siphonLifeBar:SetMinMaxValues(0,100)
siphonLifeBar:SetPoint("CENTER",300,-175)
siphonLifeBar:SetSize(200,15)
siphonLifeBar:Hide()
siphonLifeBar:SetValue(0)
siphonLifeBar:SetStatusBarColor(0.2,0.9,0.2, 1)

--Siphon Life bar tick
siphonLifeBar:SetScript("OnUpdate",function(self)
for i=1,40 do
		local name, _, _, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitDebuff("target",i)
		if name == "Siphon Life" and unitCaster == "player" then
		local siphonLifeTimer = expirationTime - GetTime()
		self:SetValue(siphonLifeTimer/duration*100)
		break
	else
		self:SetValue(0)	
	  end
	end
end)

--Phantom Singularity and Vile Taint config
PhantomSingularityFrame = CreateFrame("Statusbar",nil,UIParent)
PhantomSingularityFrame:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
local PhantomSingularityBar = PhantomSingularityFrame
PhantomSingularityBar.unit = target
PhantomSingularityBar:SetMinMaxValues(0,100)
PhantomSingularityBar:SetPoint("CENTER",300,-175)
PhantomSingularityBar:SetSize(200,15)
PhantomSingularityBar:Hide()
PhantomSingularityBar:SetValue(0)
PhantomSingularityBar:SetStatusBarColor(0.2,0.2,0.99, 1)

--Phantom Singularity and Vile Taint bar tick
PhantomSingularityBar:SetScript("OnUpdate",function(self)
for i=1,40 do
		local name, _, _, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitDebuff("target",i)
		if name == "Phantom Singularity" or name == "Vile Taint" and unitCaster == "player" then
		local siphonLifeTimer = expirationTime - GetTime()
		self:SetValue(siphonLifeTimer/duration*100)
		break
	else
		self:SetValue(0)	
	  end
	end
end)

--Unstable Affliction 1 config
unstableAffliction1Frame = CreateFrame("Statusbar",nil,UIParent)
unstableAffliction1Frame:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
local unstableAffliction1Bar = unstableAffliction1Frame
unstableAffliction1Bar.unit = target
unstableAffliction1Bar:SetMinMaxValues(0,100)
unstableAffliction1Bar:SetPoint("CENTER",300,-160)
unstableAffliction1Bar:SetSize(200,15)
unstableAffliction1Bar:Hide()
unstableAffliction1Bar:SetValue(0)
unstableAffliction1Bar:SetStatusBarColor(1,0.8,0.16, 1)

----Unstable Affliction 1 bar tick
unstableAffliction1Bar:SetScript("OnUpdate",function(self)
for i=1,40 do
		local name, _, _, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitDebuff("target",i)		
		if spellId == 233490 and unitCaster == "player" then
		local unstableAffliction1Timer = expirationTime - GetTime()
		self:SetValue(unstableAffliction1Timer/duration*100)		
		break
	else
		self:SetValue(0)	
	  end
	end
end)

--Unstable Affliction 2 config
unstableAffliction2Frame = CreateFrame("Statusbar",nil,UIParent)
unstableAffliction2Frame:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
local unstableAffliction2Bar = unstableAffliction2Frame
unstableAffliction2Bar.unit = target
unstableAffliction2Bar:SetMinMaxValues(0,100)
unstableAffliction2Bar:SetPoint("CENTER",300,-145)
unstableAffliction2Bar:SetSize(200,15)
unstableAffliction2Bar:Hide()
unstableAffliction2Bar:SetValue(0)
unstableAffliction2Bar:SetStatusBarColor(1,0.8,0.16, 1)

----Unstable Affliction 2 bar tick
unstableAffliction2Bar:SetScript("OnUpdate",function(self)
for i=1,40 do
		local name, _, _, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitDebuff("target",i)		
		if spellId == 233496 and unitCaster == "player" then
		local unstableAffliction1Timer = expirationTime - GetTime()
		self:SetValue(unstableAffliction1Timer/duration*100)		
		break
	else
		self:SetValue(0)	
	  end
	end
end)

--Unstable Affliction 3 config
unstableAffliction3Frame = CreateFrame("Statusbar",nil,UIParent)
unstableAffliction3Frame:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
local unstableAffliction3Bar = unstableAffliction3Frame
unstableAffliction3Bar.unit = target
unstableAffliction3Bar:SetMinMaxValues(0,100)
unstableAffliction3Bar:SetPoint("CENTER",300,-130)
unstableAffliction3Bar:SetSize(200,15)
unstableAffliction3Bar:Hide()
unstableAffliction3Bar:SetValue(0)
unstableAffliction3Bar:SetStatusBarColor(1,0.8,0.16, 1)

----Unstable Affliction 3 bar tick
unstableAffliction3Bar:SetScript("OnUpdate",function(self)
for i=1,40 do
		local name, _, _, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitDebuff("target",i)		
		if spellId == 233497 and unitCaster == "player" then
		local unstableAffliction1Timer = expirationTime - GetTime()
		self:SetValue(unstableAffliction1Timer/duration*100)		
		break
	else
		self:SetValue(0)	
	  end
	end
end)

--Unstable Affliction 4 config
unstableAffliction4Frame = CreateFrame("Statusbar",nil,UIParent)
unstableAffliction4Frame:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
local unstableAffliction4Bar = unstableAffliction4Frame
unstableAffliction4Bar.unit = target
unstableAffliction4Bar:SetMinMaxValues(0,100)
unstableAffliction4Bar:SetPoint("CENTER",300,-115)
unstableAffliction4Bar:SetSize(200,15)
unstableAffliction4Bar:Hide()
unstableAffliction4Bar:SetValue(0)
unstableAffliction4Bar:SetStatusBarColor(1,0.8,0.16, 1)

----Unstable Affliction 4 bar tick
unstableAffliction4Bar:SetScript("OnUpdate",function(self)
for i=1,40 do
		local name, _, _, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitDebuff("target",i)		
		if spellId == 233498 and unitCaster == "player" then
		local unstableAffliction1Timer = expirationTime - GetTime()
		self:SetValue(unstableAffliction1Timer/duration*100)		
		break
	else
		self:SetValue(0)	
	  end
	end
end)

--Unstable Affliction 5 config
unstableAffliction5Frame = CreateFrame("Statusbar",nil,UIParent)
unstableAffliction5Frame:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
local unstableAffliction5Bar = unstableAffliction5Frame
unstableAffliction5Bar.unit = target
unstableAffliction5Bar:SetMinMaxValues(0,100)
unstableAffliction5Bar:SetPoint("CENTER",300,-100)
unstableAffliction5Bar:SetSize(200,15)
unstableAffliction5Bar:Hide()
unstableAffliction5Bar:SetValue(0)
unstableAffliction5Bar:SetStatusBarColor(1,0.8,0.16, 1)

----Unstable Affliction 5 bar tick
unstableAffliction5Bar:SetScript("OnUpdate",function(self)
for i=1,40 do
		local name, _, _, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitDebuff("target",i)		
		if spellId == 233499 and unitCaster == "player" then
		local unstableAffliction1Timer = expirationTime - GetTime()
		self:SetValue(unstableAffliction1Timer/duration*100)		
		break
	else
		self:SetValue(0)	
	  end
	end
end)



--------------------------------------------------------------------------------------------------------------
-- Warrior Spesific UI -- 
--------------------------------------------------------------------------------------------------------------


--ignorePain config
ignorePainFrame = CreateFrame("Statusbar",nil,UIParent)
ignorePainFrame:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
local ignorePainBar = ignorePainFrame
ignorePainBar.unit = target
ignorePainBar:SetMinMaxValues(0,100)
ignorePainBar:SetPoint("CENTER",300,-100)
ignorePainBar:SetSize(200,15)
ignorePainBar:Show()
ignorePainBar:SetValue(0)
ignorePainBar:SetStatusBarColor(1,0.8,0.16, 1)

----ignore Pain bar tick
--print (playerClass)
if playerClass == "Warrior" then
	ignorePainBar:SetScript("OnUpdate",function(self)
		for i=1,40 do
			local name, icon, _, _, _, etime = UnitBuff("player",i)
			if name then
				--print(("%d=%s, %s, %.2f minutes left."):format(i,name,icon,(etime-GetTime())/60))
			end
		end
	end)
end

--------------------------------------------------------------------------------------------------------------
-- Druid Feral  Spesific UI -- 
--------------------------------------------------------------------------------------------------------------
--Rake frame config
rakeFrame = CreateFrame("Statusbar",nil,UIParent)
rakeFrame:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
local rakeBar = rakeFrame
rakeBar.unit = "target"
rakeBar:SetMinMaxValues(0,100)
rakeBar:SetPoint("CENTER",300,-220)
rakeBar:SetSize(200,15)
rakeBar:Hide()
rakeBar:SetValue(0)
rakeBar:SetStatusBarColor(1,0.1,0.1, 1)
--Rake bar tick
rakeBar:SetScript("OnUpdate",function(self)
for i=1,40 do
		local name, _, _, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitDebuff("target",i)
		
		if name == "Rake" and unitCaster == "player" then
			local rakeTimer = expirationTime - GetTime()
			self:SetValue(rakeTimer/duration*100)
		
			break
		else
			self:SetValue(0)	
	  end
	end
end)

--Ripe frame config
ripeFrame = CreateFrame("Statusbar",nil,UIParent)
ripeFrame:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
local ripeBar = ripeFrame
ripeBar.unit = target
ripeBar:SetMinMaxValues(0,100)
ripeBar:SetPoint("CENTER",300,-205)
ripeBar:SetSize(200,15)
ripeBar:Hide()
ripeBar:SetValue(0)
ripeBar:SetStatusBarColor(0.9,0.9,0.9, 1)

--Ripe bar tick
ripeBar:SetScript("OnUpdate",function(self)
for i=1,40 do
		local name, _, _, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitDebuff("target",i)
		if name == "Rip" and unitCaster == "player" then
		local ripeTimer = expirationTime - GetTime()
		self:SetValue(ripeTimer/duration*100)
		break
	else
		self:SetValue(0)	
	  end
	end
end)

--------------------------------------------------------------------------------------------------------------
-- Mage  Spesific UI -- 
--------------------------------------------------------------------------------------------------------------
frostFrame = CreateFrame("Statusbar",nil,UIParent)
frostFrame:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
local frostBar = frostFrame
frostBar.unit = "target"
frostBar:SetMinMaxValues(0,100)
frostBar:SetPoint("CENTER",300,-220)
frostBar:SetSize(200,15)
frostBar:Show()
frostBar:SetValue(100)
frostBar:SetStatusBarColor(0.3,0.3,1, 1)
frostBar:SetScript("OnUpdate",function(self)
for i=1,40 do
		local name, _, _, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitDebuff("target",i)
		if name == "Chilled" and unitCaster == "player" then
			
			local frostTimer = expirationTime - GetTime()
			self:SetValue(frostTimer/duration*100)
		
			break
		else
			self:SetValue(0)	
	  end
	end
end)


--[[
function playerIsWarrior()
	if (UnitClass("player") == "Warrior") then
	-- --marche pas
	

    local name,_,_,_,_,_,expirationTime ,_,_,_,_,_,_,_,_,_,value2 = UnitBuff("player", "Ignore Pain")--Trouver  Ignore Pain
		if name then
			ignorePainValue = value2
			ignorePainSeconds = (expirationTime - GetTime())		   
			ignorePainValue = ignorePainValue / 1000000
			abbr = "m"
			ignorePainValue = liferound(ignorePainValue) .. abbr
			--Create the Ignor Pain BAR ----------------------
				local START = 15
				local END = 0
				clearThatFrame(ignorePainBar)
				ignorePainBar = CreateFrame("StatusBar", nil, UIParent)
				ignorePainBar:SetSize(150, 16)
				ignorePainBar:SetPoint("CENTER",UIParent,"CENTER", -275, -220)	
				ignorePainBar:SetBackdropColor(0, 0, 0, 0.7)
				ignorePainBar:SetStatusBarTexture(Interface\TargetingFrame\UI-StatusBar)
				ignorePainBar:SetStatusBarColor(1, 0.63, 0.05)
				ignorePainBarText = ignorePainBar:CreateFontString(nil, "OVERLAY", "GameFontHighlightMedium")
				ignorePainBarText:SetPoint("LEFT", 10, 0)
				ignorePainBarText:SetText(ignorePainValue)
				ignorePainBar:SetMinMaxValues(END, START)
				local timer = ignorePainSeconds
				-- this function will run repeatedly, incrementing the value of timer as it goes
				ignorePainBar:SetScript("OnUpdate", function(self, elapsed)
				timer = timer - elapsed
				self:SetValue(timer)

				end)-- end ignor Pain Time Update Script
		else	
		clearThatFrame(ignorePainBar)
		end--end Check for Ignor Pain
		
	end-- end check if warrior
end--end function if warrior 
]]
--------------------------------------------------------------------------------------------------------------
-- temp code a
--------------------------------------------------------------------------------------------------------------




