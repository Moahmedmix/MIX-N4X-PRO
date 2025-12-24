-- [[ 🚀 MIX-N4X GIGA HUB | V7 ULTIMATE EDITION ]]
-- رابط الملف: https://raw.githubusercontent.com/Moahmedmix/MIX-N4X-PRO/main/main.lua

-- 1. تنظيف شامل للذاكرة (لحل مشكلة dead coroutine)
for _, v in pairs(game.CoreGui:GetChildren()) do
    if v.Name == "WindUI" or v:FindFirstChild("WindUI") then v:Destroy() end
end
task.wait(0.1)

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- 2. إنشاء النافذة (إصلاح سطر 10635 نهائياً)
local Window = WindUI:CreateWindow({
    Title = "🚀 MIX-N4X GIGA HUB",
    Author = "MIX-N4X",
    Icon = "solar:planet-bold",
    Folder = "MIXN4X_DATA",
    Size = UDim2.fromOffset(600, 480),
    IconSize = 20, -- قيمة ثابتة تمنع خطأ arithmetic on nil
    Transparent = false,
    Topbar = { ButtonsType = "Mac", Height = 40 }
})

-- 3. تبويب البحث الذكي
local SearchTab = Window:Tab({ Title = "Search Engine", Icon = "solar:magnifer-bold" })
SearchTab:Input({
    Title = "Global Search",
    Placeholder = "Enter Game Name...",
    Callback = function(t) WindUI:Notify({Title = "Search", Content = "Finding: "..t}) end
})

-- 4. نظام التصنيفات (Categories) - حل مشكلة تداخل الأزرار
local function AddS(tab, name, link)
    tab:Button({
        Title = name,
        Callback = function()
            WindUI:Notify({Title = "Executing", Content = "Running "..name})
            pcall(function() loadstring(game:HttpGet(link))() end)
        end
    })
end

-- [قسم ألعاب الأكشن والقتال]
local ActionTab = Window:Tab({ Title = "Action/Combat", Icon = "solar:sword-bold" })
local ActionList = ActionTab:Section({ Title = "Combat Games" })
AddS(ActionList, "Blox Fruits (Hoho Hub)", "https://raw.githubusercontent.com/acsu123/HOHO_HUB/main/StartLoad")
AddS(ActionList, "Combat Warriors", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/CombatWarriors.lua")
AddS(ActionList, "Arsenal (ThunderZ)", "https://raw.githubusercontent.com/ThunderZ-HUB/main/main.lua")
AddS(ActionList, "Bedwars", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/Bedwars.lua")

-- [قسم ألعاب الرعب والهروب]
local HorrorTab = Window:Tab({ Title = "Horror/Escape", Icon = "solar:ghost-bold" })
local HorrorList = HorrorTab:Section({ Title = "Horror Games" })
AddS(HorrorList, "Evade (Nextbot)", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/Evade.lua")
AddS(HorrorList, "Doors (Vynixius)", "https://raw.githubusercontent.com/Vynixius/Vynixius/main/Doors")
AddS(HorrorList, "Piggy", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/Piggy.lua")

-- [قسم ألعاب المحاكاة والـ RP]
local RPTab = Window:Tab({ Title = "Sim/RP", Icon = "solar:home-bold" })
local RPList = RPTab:Section({ Title = "Roleplay Games" })
AddS(RPList, "Brookhaven RP", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/Brookhaven.lua")
AddS(RPList, "Adopt Me", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/AdoptMe.lua")
AddS(RPList, "Pet Simulator 99", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/PetSim99.lua")

-- [قسم الأدوات العامة]
local ToolsTab = Window:Tab({ Title = "Universal Tools", Icon = "zap" })
AddS(ToolsTab, "OPFinality FE", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/!%20%5BFE%5D%20OPFinality%20Gui%20%5BBEST%5D.txt(2).lua")
AddS(ToolsTab, "Infinite Yield", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")

-- 5. إحصائيات النظام
local StatsTab = Window:Tab({ Title = "System", Icon = "solar:chart-bold" })
local FPSLabel = StatsTab:Section({ Title = "FPS: Calculating..." })
spawn(function()
    while task.wait(1) do
        FPSLabel:SetTitle("FPS: " .. math.floor(workspace:GetRealTimeFPS()))
    end
end)

WindUI:Notify({ Title = "MIX-N4X V7", Content = "Library Categorized & Errors Fixed!", Duration = 5 })
