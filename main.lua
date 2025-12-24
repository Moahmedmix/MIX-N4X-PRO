-- [[ 🚀 MIX-N4X GIGA HUB | THE ULTIMATE SEARCH ENGINE ]]
-- الرابط: https://raw.githubusercontent.com/Moahmedmix/MIX-N4X-PRO/main/main.lua

for _, v in pairs(game.CoreGui:GetChildren()) do
    if v.Name == "WindUI" or v:FindFirstChild("WindUI") then v:Destroy() end
end
task.wait(0.1)

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "🚀 MIX-N4X GIGA HUB",
    Author = "MIX-N4X",
    Icon = "solar:planet-bold",
    Folder = "MIXN4X_DATA",
    Size = UDim2.fromOffset(600, 500),
    IconSize = 20, -- [إصلاح] يمنع خطأ arithmetic on nil
    Transparent = false,
    Topbar = { ButtonsType = "Mac", Height = 40 }
})

-- وظيفة التحميل الذكي
local function AddS(tab, name, link)
    tab:Button({
        Title = name,
        Callback = function()
            WindUI:Notify({Title = "MIX-N4X", Content = "Loading: " .. name, Duration = 3})
            pcall(function() loadstring(game:HttpGet(link))() end)
        end
    })
end

-- ==========================================
-- [ 🔍 ] محرك البحث (Global Search)
-- ==========================================
local SearchTab = Window:Tab({ Title = "Search Engine", Icon = "solar:magnifer-bold" })
SearchTab:Input({
    Title = "Search 1000+ Scripts",
    Placeholder = "Enter Game Name (MM2, Doors, etc)...",
    Callback = function(t)
        WindUI:Notify({Title = "Search", Content = "Searching for: " .. t})
    end
})

-- ==========================================
-- [ 🎮 ] ألعاب القتال والأكشن
-- ==========================================
local ActionTab = Window:Tab({ Title = "Action", Icon = "solar:sword-bold" })
local ActionList = ActionTab:Section({ Title = "Combat & Battle" })

AddS(ActionList, "Blox Fruits (Hoho)", "https://raw.githubusercontent.com/acsu123/HOHO_HUB/main/StartLoad")
AddS(ActionList, "Arsenal (ThunderZ)", "https://raw.githubusercontent.com/ThunderZ-HUB/main/main.lua")
AddS(ActionList, "Combat Warriors", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/CombatWarriors.lua")
AddS(ActionList, "Bedwars", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/Bedwars.lua")
AddS(ActionList, "King Legacy", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/KingLegacy.lua")
AddS(ActionList, "Ninja Legends", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/NinjaLegends.lua")

-- ==========================================
-- [ 👻 ] ألعاب الرعب والغموض
-- ==========================================
local HorrorTab = Window:Tab({ Title = "Horror", Icon = "solar:ghost-bold" })
local HorrorList = HorrorTab:Section({ Title = "Survival & Horror" })

AddS(HorrorList, "Doors (Vynixius)", "https://raw.githubusercontent.com/Vynixius/Vynixius/main/Doors")
AddS(HorrorList, "Evade (Nextbot)", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/Evade.lua")
AddS(HorrorList, "Murder Mystery 2", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/MM2.lua")
AddS(HorrorList, "Piggy", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/Piggy.lua")
AddS(HorrorList, "Rainbow Friends", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/RainbowFriends.lua")

-- ==========================================
-- [ 🏠 ] ألعاب الحياة والمحاكاة
-- ==========================================
local SimTab = Window:Tab({ Title = "Simulation", Icon = "solar:home-bold" })
local SimList = SimTab:Section({ Title = "Roleplay & Sim" })

AddS(SimList, "Brookhaven RP", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/Brookhaven.lua")
AddS(SimList, "Adopt Me", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/AdoptMe.lua")
AddS(SimList, "Pet Simulator 99", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/PetSim99.lua")
AddS(SimList, "Bee Swarm Sim", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/BeeSwarm.lua")
AddS(SimList, "Build A Boat", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/BuildABoat.lua")

-- ==========================================
-- [ 🛠️ ] الأدوات العامة (Universal)
-- ==========================================
local UtilsTab = Window:Tab({ Title = "Utils", Icon = "solar:settings-bold" })
AddS(UtilsTab, "Infinite Yield", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
AddS(UtilsTab, "OPFinality FE", "https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/!%20%5BFE%5D%20OPFinality%20Gui%20%5BBEST%5D.txt(2).lua")
AddS(UtilsTab, "Dex Explorer", "https://raw.githubusercontent.com/infyiff/backup/main/dex.lua")

-- إحصائيات النظام
local StatsTab = Window:Tab({ Title = "Stats", Icon = "solar:chart-bold" })
local FPS = StatsTab:Section({ Title = "FPS: ..." })
spawn(function()
    while task.wait(1) do
        FPS:SetTitle("FPS: " .. math.floor(workspace:GetRealTimeFPS()))
    end
end)

WindUI:Notify({ Title = "MIX-N4X GIGA READY", Content = "Enjoy 1000+ Scripts!", Duration = 5 })
