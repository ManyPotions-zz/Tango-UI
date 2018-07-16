
print("Hello " .. UnitName("player"));

--------------------------------------------------------------------------------------------------------------
-- Addon Initialisation
--------------------------------------------------------------------------------------------------------------

--Getting Mainpower information
mainPower = {"0", "1", "2", "3", "4", "5", "12"}
for  i = 1, 7 do
	

local pm = UnitPowerMax("player",mainPower[i])	
local pt = mainPower[i]	
	if pm > 0  then
		PlayerMainPowerType = pt
		break
   end
end

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
-- player Power bar
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
pPowerBar:SetStatusBarColor(0,1,1, 1)
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
self:SetValue(UnitPower("player",mainPower[PlayerMainPowerType])/UnitPowerMax("player",mainPower[PlayerMainPowerType])*100) 


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

secondaryPower = {"6", "7", "8", "9", "13", "14", "15", "16", "17"}












