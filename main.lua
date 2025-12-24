-- [[ 🚀 MIX-N4X PRO | FINAL CLEAN VERSION ]]

-- تنظيف الذاكرة لمسح الأخطاء القديمة
for _, v in pairs(game.CoreGui:GetChildren()) do
    if v.Name == "WindUI" then v:Destroy() end
end

-- تحميل المكتبة برابط مباشر ومستقر
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- إنشاء النافذة مع وضع قيم ثابتة لمنع خطأ Nil (arithmetic unm)
local Window = WindUI:CreateWindow({
    Title = "🚀 MIX-N4X HUB",
    Author = "MIX-N4X",
    Icon = "solar:planet-bold",
    Folder = "MIXN4X_REBORN",
    Size = UDim2.fromOffset(480, 360), -- حجم ثابت لمنع الأخطاء
    IconSize = 20, -- ضروري جداً لمنع خطأ nil
    Transparent = false,
    Topbar = {
        ButtonsType = "Mac",
        Height = 40
    }
})

-- تبويب المميزات العامة (OPFinality)
local MainTab = Window:Tab({ Title = "Universal Mods", Icon = "zap" })

MainTab:Button({
    Title = "Load OPFinality FE",
    Desc = "Kill All, Bring, Invisibility",
    Callback = function()
        -- الرابط ده متصل مباشرة بملف الجيت هاب اللي بعته
        loadstring(game:HttpGet("https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/!%20%5BFE%5D%20OPFinality%20Gui%20%5BBEST%5D.txt(2).lua"))()
    end
})

-- تبويب الألعاب (Game Hub)
local GamesTab = Window:Tab({ Title = "Games List", Icon = "solar:folder-2-bold" })

-- قسم Brookhaven
GamesTab:Button({
    Title = "Brookhaven Script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/Brookhaven.lua"))()
    end
})

-- قسم Evade
GamesTab:Button({
    Title = "Evade Script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/Evade.lua"))()
    end
})

-- قسم Natural Disaster
GamesTab:Button({
    Title = "Natural Disaster",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/retpirato/Roblox-Scripts/master/NaturalDisasterSurvival.lua"))()
    end
})

-- تبويب الإعدادات
local SettingsTab = Window:Tab({ Title = "Settings", Icon = "solar:settings-bold" })
SettingsTab:Button({
    Title = "Destroy UI",
    Callback = function() Window:Destroy() end
})

-- إشعار التشغيل
WindUI:Notify({
    Title = "MIX-N4X PRO",
    Content = "Script Loaded Successfully!",
    Duration = 5
})
