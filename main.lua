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
pStatusbar:SetScript("OnUpdate",function(self) self:SetValue(UnitHealth(self.unit)/UnitHealthMax(self.unit)*100) end)

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

tStatusbar:SetScript("OnUpdate",function(self)
	self:SetValue(UnitHealth(self.unit)/UnitHealthMax(self.unit)*100) 
	playerclass,PLAYERCLASS = UnitClass("target")
	classcolor = RAID_CLASS_COLORS[PLAYERCLASS]
	if (classcolor == nil or classcolor == '') then
		else
		r,g,b = classcolor.r,classcolor.g,classcolor.b
		self:SetStatusBarColor(r,g,b)
		end		
end)		

--------------------------------------------------------------------------------------------------------------
-- temp code
--------------------------------------------------------------------------------------------------------------


