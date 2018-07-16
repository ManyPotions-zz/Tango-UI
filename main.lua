
print("Hello " .. UnitName("player"));

--------------------------------------------------------------------------------------------------------------
-- Addon Initialisation
--------------------------------------------------------------------------------------------------------------

--Array for Color by power
powerColor = {
    {"0","0","0","1"}, -- mana
	{"1","1","0","0"}, -- rage
	{"2","1","0.5","0.25"}, -- focus
	{"3","1","1","0"}, -- energy
	{"4","0","0.96","0.41"}, -- combo point
	{"5","0.5","0.5","0.5"}, -- Runes
	{"6","0","0.82","1"}, -- Runic Power
	{"7","0.5","0.32","0.55"}, -- soul shards
	{"8","0.3","0.52","0.9"}, -- lunar power
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

--Getting player powertype information

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
		--print (secondaryPowerType)
		break
   end
end

--Getting bar color for secondaryPower 
for i = 1, 18 do
local colorIndex = powerColor[i]
local powerIndex = colorIndex[1]
	if powerIndex == secondaryPowerType then
	secondaryPowerColorR = colorIndex[2]
	secondaryPowerColorG = colorIndex[3]
	secondaryPowerColorB = colorIndex[4]
	print (mainPowerColorR)
	print (mainPowerColorG) 
	print (mainPowerColorB) 	
	break
	end
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
pStatusbar:SetPoint("CENTER",-300,0)
pStatusbar:SetSize(150,20)
pStatusbar:Show()
pStatusbar:SetValue(100)
pStatusbar:SetStatusBarColor(0,1,0, 1)
pStatusbar.text = pStatusbar:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
pStatusbar.text:SetAllPoints()

--Drawing  Background and border under the healt Bar
playerHealthBarBg = CreateFrame("Statusbar",BORDER,UIParent)
local pStatusbarBg = playerHealthBarBg
pStatusbarBg:SetPoint("CENTER",-300,0)
pStatusbarBg:SetSize(160,30)
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
pPowerBar:SetPoint("CENTER",-300,-20)
pPowerBar:SetSize(150,10)
pPowerBar:Show()
pPowerBar:SetValue(100)
pPowerBar:SetStatusBarColor(mainPowerColorR,mainPowerColorG,mainPowerColorB)
pPowerBar.text = pPowerBar:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
pPowerBar.text:SetAllPoints()

--Drawing  Background and border under the playerpower Bar
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

--Run Script uptade a l'event OnUpdate (chaque Frame).
pPowerBar:SetScript("OnUpdate",function(self) 
self:SetValue(UnitPower("player",playerMainPowerType)/UnitPowerMax("player",playerMainPowerType)*100) 


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
pPowerBar2:SetPoint("CENTER",-300,-40)
pPowerBar2:SetSize(150,10)
pPowerBar2:Show()
pPowerBar2:SetValue(100)
pPowerBar2:SetStatusBarColor(secondaryPowerColorR,secondaryPowerColorG,secondaryPowerColorB)
pPowerBar2.text = pPowerBar2:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
pPowerBar2.text:SetAllPoints()

--Drawing  Background and border under the secondary /Power Bar
playerPowerBar2Bg = CreateFrame("Statusbar",BORDER,UIParent)
local pPowerBar2Bg = playerPowerBar2Bg
pPowerBar2Bg:SetPoint("CENTER",-300,-40)
pPowerBar2Bg:SetSize(160,20)
pPowerBar2Bg:Show()
pPowerBar2Bg:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                            tile = true, tileSize = 16, edgeSize = 16, 
                                            insets = { left = 4, right = 4, top = 4, bottom = 4 }});
pPowerBar2Bg:SetBackdropColor(0,0,0,1);

--Run Script uptade a l'event OnUpdate (chaque Frame).
pPowerBar2:SetScript("OnUpdate",function(self) 
self:SetValue(UnitPower("player",secondaryPowerType)/UnitPowerMax("player",secondaryPowerType)*100) 


end)

--------------------------------------------------------------------------------------------------------------
-- Target tStatusbar
--------------------------------------------------------------------------------------------------------------
 
--Drawing Target Status Bar
local tUnit = "target" 
targetHealthBar = CreateFrame("Statusbar",nil,UIParent)
targetHealthBar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")

local tStatusbar = targetHealthBar
tStatusbar.unit = tUnit
tStatusbar:SetMinMaxValues(0,100)
tStatusbar:SetPoint("CENTER",300,0)
tStatusbar:SetSize(150,20)
tStatusbar:Show()
tStatusbar:SetValue(100)
tStatusbar.text = tStatusbar:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
tStatusbar.text:SetAllPoints()


--Drawing Player Background and border under the Target Bar
targetHealthBarBg = CreateFrame("Statusbar",nil,UIParent)
local tStatusbarBg = targetHealthBarBg
tStatusbarBg:SetPoint("CENTER",300,0)
tStatusbarBg:SetSize(160,30)
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
	else
		tStatusbarBg:Hide()
		tStatusbar.text:Hide()
	end

end)		


--------------------------------------------------------------------------------------------------------------
-- temp code a
--------------------------------------------------------------------------------------------------------------
--main power 0,1,2,3,5,12,17,18
--secondary 6,7,8,9,13,14,15














