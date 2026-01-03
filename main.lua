-- [[ 🚀 MIX-N4X HUB | SMART LOGIC EDITION V1.0 ]]
-- النسخة النهائية منظمة وخانات/sections لكل ميزة + حفظ الإعدادات

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService") -- لحفظ الإعدادات كـ JSON

-- ملف حفظ الإعدادات
local SettingsFile = "MIXN4X_Settings.json"
local Settings = {}

-- تحميل WindUI
local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
end)
if not success then
    warn("Failed to load WindUI")
    return
end

-- فتح النافذة الرئيسية
local Window = WindUI:CreateWindow({
    Title = "MIX-N4X HUB V1.0",
    Author = "By MIX-N4X",
    Icon = "rbxthumb://type=AvatarHeadShot&id=" .. Player.UserId .. "&w=150&h=150",
    Folder = "MIXN4X_SMART_LOGIC",
    Size = UDim2.fromOffset(600, 500),
    Transparent = false,
    Topbar = { ButtonsType = "Mac", Height = 40 }
})

-- ================= حفظ/تحميل الإعدادات =================
local function SaveSettings()
    pcall(function()
        writefile(SettingsFile, HttpService:JSONEncode(Settings))
    end)
end

local function LoadSettings()
    if isfile(SettingsFile) then
        local data = readfile(SettingsFile)
        Settings = HttpService:JSONDecode(data)
    else
        Settings = {}
    end
end

LoadSettings()

-- ================= Main Logic =================
local MainTab = Window:Tab({ Title = "Main Logic", Icon = "solar:cpu-bold" })
local MovementSec = MainTab:Section({ Title = "Adaptive Movement" })

MovementSec:Slider({
    Title = "Speed Management",
    Desc = "Smart attribute manipulation",
    Value = { Min = 16, Max = 250, Default = Settings.Speed or 16 },
    Callback = function(v)
        Settings.Speed = v
        SaveSettings()
        task.spawn(function()
            pcall(function()
                if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                    Player.Character.Humanoid:SetAttribute("RealSpeed", v)
                end
            end)
        end)
    end
})

-- ================= God Mode =================
local SafetyTab = Window:Tab({ Title = "Fail-Safe", Icon = "solar:shield-bold" })

SafetyTab:Toggle({
    Title = "Smart God Mode",
    Desc = "Maintains character integrity",
    Value = Settings.GodMode or false,
    Callback = function(state)
        Settings.GodMode = state
        SaveSettings()
        _G.GodMode = state
        if state then
            task.spawn(function()
                while _G.GodMode do
                    pcall(function()
                        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                            Player.Character.Humanoid.Parent = nil
                            Player.Character.Humanoid.Parent = Player.Character
                        end
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})

-- ================= Automation =================
local AutoTab = Window:Tab({ Title = "Automation", Icon = "solar:magic-stick-bold" })

AutoTab:Toggle({
    Title = "Smart Auto-Revive",
    Desc = "Logic-based player assistance",
    Value = Settings.AutoRevive or false,
    Callback = function(state)
        Settings.AutoRevive = state
        SaveSettings()
        _G.AutoRevive = state
        task.spawn(function()
            while _G.AutoRevive do
                pcall(function()
                    if workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players") then
                        for _, v in pairs(workspace.Game.Players:GetChildren()) do
                            if v:FindFirstChild("ReviveConfig") then
                                local prompt = v.ReviveConfig:FindFirstChildOfClass("ProximityPrompt")
                                if prompt then fireproximityprompt(prompt) end
                            end
                        end
                    end
                end)
                task.wait(0.2)
            end
        end)
    end
})

-- ================= Visuals =================
local VisualTab = Window:Tab({ Title = "Environment", Icon = "solar:filters-bold" })
VisualTab:Section({ Title = "Environment Control" })

VisualTab:Button({
    Title = "Optimize Visuals",
    Desc = "Full bright and remove fog",
    Callback = function()
        pcall(function()
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
        end)
        WindUI:Notify({
            Title = "Visuals",
            Content = "Environment optimized",
            Duration = 3
        })
    end
})

-- ================= Performance =================
local PerfTab = Window:Tab({ Title = "📊 Performance", Icon = "solar:speed-bold" })
PerfTab:Section({ Title = "Extreme FPS Boosters" })

-- Smooth Materials
PerfTab:Toggle({
    Title = "Smooth Materials (Plastic)",
    Desc = "يحول كل الأسطح لبلاستيك لتقليل الضغط على المعالج",
    Value = Settings.SmoothMaterials or false,
    Callback = function(Value)
        Settings.SmoothMaterials = Value
        SaveSettings()
        task.spawn(function()
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
                    v.Material = Enum.Material.SmoothPlastic
                    v.Reflectance = 0
                end
            end
        end)
    end
})

-- Remove Decals & Textures
PerfTab:Toggle({
    Title = "Remove Textures & Decals",
    Desc = "يمسح الصور والملصقات من الجدران لزيادة السرعة",
    Value = Settings.RemoveDecals or false,
    Callback = function(Value)
        Settings.RemoveDecals = Value
        SaveSettings()
        task.spawn(function()
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("Decal") or v:IsA("Texture") then
                    v.Transparency = Value and 1 or 0
                end
            end
        end)
    end
})

-- Disable Shadows
PerfTab:Toggle({
    Title = "Disable Shadows",
    Desc = "إيقاف كل الظلال في اللعبة (يرفع الفريمات جداً)",
    Value = Settings.DisableShadows or false,
    Callback = function(Value)
        Settings.DisableShadows = Value
        SaveSettings()
        task.spawn(function()
            Lighting.GlobalShadows = not Value
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CastShadow = not Value
                end
            end
        end)
    end
})

-- باقي Performance وButtons زي Remove Particles, Clear Atmosphere, Unlock FPS ... ممكن أضيفهم بنفس الطريقة مع حفظ الإعدادات

-- ================= Final Notification =================
WindUI:Notify({
    Title = "MIX-N4X HUB",
    Content = "Smart Framework Loaded Successfully (V1.0) with Settings",
    Duration = 5
})
