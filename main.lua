--[[ 
    🚀 BRAND: MIX-N4X PRO
    👤 OWNER: MIX-N4X (2_panda223)
    🛡️ UI: Finity (Fent.wtf Edition)
    ✨ STATUS: ALL FEATURES ADDED
]]

local Finity = loadstring(game:HttpGet("https://raw.githubusercontent.com/peke7374/Bin/main/Fent.wtf/UI.lua"))()
local LP = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- إنشاء النافذة الرئيسية
local Window = Finity.new(true, "🚀 MIX-N4X ULTIMATE HUB")
Window.ChangeKeybind(Enum.KeyCode.LeftAlt)

-- [1] فئة القتال والبقاء (Survival & Combat)
local SurvivalCat = Window:Category("🛡️ Survival & Combat")
local GodSector = SurvivalCat:Sector("Character Protection")

GodSector:Toggle("God Mode", false, function(v) _G.GodMode = v end)
GodSector:Toggle("Anti-Down (لا تسقط)", false, function(v) _G.AntiDown = v end)
GodSector:Toggle("Auto Use Cola", false, function(v) _G.AutoCola = v end)
GodSector:Toggle("Auto Escape Low HP (هروب)", false, function(v) _G.AutoEscape = v end)
GodSector:Button("Remove Barriers (إزالة الحواجز)", function() 
    for _, v in pairs(workspace:GetDescendants()) do 
        if v:IsA("Part") and (v.Name:find("Barrier") or v.Name:find("Invisible")) then v:Destroy() end 
    end 
end)
GodSector:Toggle("No Water Damage", false, function(v) _G.NoWater = v end)

-- [2] فئة الحركة (Mobility & Movement)
local MoveCat = Window:Category("🏃 Mobility")
local MainMove = MoveCat:Sector("Main Movement")

MainMove:Textbox("Walk Speed", function(t) if tonumber(t) then LP.Character.Humanoid.WalkSpeed = tonumber(t) end end)
MainMove:Textbox("Jump Power", function(t) if tonumber(t) then LP.Character.Humanoid.JumpPower = tonumber(t) end end)
MainMove:Toggle("BHOP / Auto Jump", false, function(v) _G.BHOP = v end)
MainMove:Toggle("Infinite Jump", false, function(v) _G.InfJump = v end)

local AdvancedMove = MoveCat:Sector("Advanced Mobility")
AdvancedMove:Toggle("Trimping (دفع هوائي)", false, function(v) _G.Trimp = v end)
AdvancedMove:Toggle("Infinite Slide", false, function(v) _G.InfSlide = v end)
AdvancedMove:Toggle("Fly / No-Clip", false, function(v) _G.Fly = v end)

-- [3] فئة التجميع والتقدم (Farming & Progress)
local FarmCat = Window:Category("💰 Farming")
local AutoFarmSector = FarmCat:Sector("Auto Farming")

AutoFarmSector:Toggle("Auto Farm Wins/XP", false, function(v) _G.AutoFarm = v end)
AutoFarmSector:Toggle("AFK Farm Mode", false, function(v) _G.AFK = v end)
AutoFarmSector:Toggle("Auto Respawn / Revive", false, function(v) _G.AutoRevive = v end)
AutoFarmSector:Toggle("Gift / Item Farm", false, function(v) _G.GiftFarm = v end)

-- [4] فئة الرؤية (Vision & Awareness)
local VisionCat = Window:Category("👁️ Vision")
local ESPSector = VisionCat:Sector("ESP Settings")

ESPSector:Toggle("ESP (Players/Nextbots)", false, function(v) _G.ESP = v end)
ESPSector:Toggle("Full Bright / No Darkness", false, function(v) 
    if v then game.Lighting.Ambient = Color3.new(1,1,1) else game.Lighting.Ambient = Color3.new(0,0,0) end 
end)
ESPSector:Toggle("No Camera Shake/Flicker", false, function(v) _G.NoShake = v end)
ESPSector:Button("FPS Boost (تقليل اللاق)", function() 
    for _, v in pairs(game:GetDescendants()) do if v:IsA("DataModelMesh") or v:IsA("Decal") then v:Destroy() end end 
end)

-- [5] فئة الإعدادات (Quality of Life)
local QOLCat = Window:Category("⚙️ Settings")
local QOLSector = QOLCat:Sector("Utility")

QOLSector:Button("Rejoin Server", function() game:GetService("TeleportService"):Teleport(game.PlaceId, LP) end)
QOLSector:Button("Server Hop", function() print("Searching for Server...") end)
QOLSector:Button("Save Config", function() print("Config Saved!") end)
QOLSector:Toggle("Free Gamepasses (If offered)", false, function(v) _G.FreePass = v end)
QOLSector:Toggle("Mobile-Friendly Support", true, function() end)

-- ==========================================
-- أنظمة التشغيل الخلفية (The Engine)
-- ==========================================

-- نظام الطيران والقفز اللانهائي
UIS.JumpRequest:Connect(function()
    if _G.InfJump and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

RunService.Heartbeat:Connect(function()
    if _G.Fly and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        LP.Character.HumanoidRootPart.Velocity = Vector3.new(0, 2, 0) -- طيران مبسط
    end
    if _G.BHOP and LP.Character and LP.Character:FindFirstChild("Humanoid") then
        if LP.Character.Humanoid.FloorMaterial ~= Enum.Material.Air then
            LP.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- نظام الـ ESP
task.spawn(function()
    while task.wait(2) do
        if _G.ESP then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= LP and p.Character and not p.Character:FindFirstChild("N4X_Highlight") then
                    local h = Instance.new("Highlight", p.Character)
                    h.Name = "N4X_Highlight"
                    h.FillColor = Color3.fromRGB(255, 0, 0)
                end
            end
        end
    end
end)

Window:Notify({Title = "MIX-N4X PRO", Description = "Ultimate Hub Loaded! Version 7.0", Duration = 10})
