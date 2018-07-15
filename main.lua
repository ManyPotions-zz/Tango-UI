
print("Hello " .. UnitName("player"));


--------------------------------------------------------------------------------------------------------------
-- player pStatusbar
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







--Run Script uptade a l'event OnUpdate (chaque Frame).
pStatusbar:SetScript("OnUpdate",function(self) self:SetValue(UnitHealth(self.unit)/UnitHealthMax(self.unit)*100) end)

--Drawing Player Background and border under the Status Bar
playerHealthBarBg = CreateFrame("Statusbar",nil,UIParent)
local pStatusbarBg = playerHealthBarBg
pStatusbarBg:SetPoint("CENTER",-300,0)
pStatusbarBg:SetSize(160,30)
pStatusbarBg:Show()
pStatusbarBg:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                            tile = true, tileSize = 16, edgeSize = 16, 
                                            insets = { left = 4, right = 4, top = 4, bottom = 4 }});
pStatusbarBg:SetBackdropColor(0,0,0,1);
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
	playerclass,PLAYERCLASS = UnitClass("target")
	classcolor = RAID_CLASS_COLORS[PLAYERCLASS]
	if (classcolor == nil or classcolor == '') then
		tStatusbarBg:Hide()
		else
		tStatusbarBg:Show()
		r,g,b = classcolor.r,classcolor.g,classcolor.b
		self:SetStatusBarColor(r,g,b)
		end		
end)		


--------------------------------------------------------------------------------------------------------------
-- temp code a
--------------------------------------------------------------------------------------------------------------
