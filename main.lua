--[[ 
    🚀 BRAND: MIX-N4X PRO (STABLE VERSION)
    👤 OWNER: MIX-N4X (2_panda223)
    🛡️ STATUS: FIXED & TESTED
]]

-- [1] نظام الانتظار الذكي (يمنع كراش UserId و CreateWindow)
if not game:IsLoaded() then game.Loaded:Wait() end
local Players = game:GetService("Players")
local LP = Players.LocalPlayer or Players.PlayerAdded:Wait()

-- [2] تحميل المكتبة مع حماية من الفشل
local success, WindUI = pcall(function()
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/main_example.lua'))()
end)

if not success or not WindUI then
    warn("❌ فشل تحميل المكتبة! تأكد من اتصال الإنترنت.")
    return
end

-- [3] بناء الواجهة الأساسية
local Window = WindUI:CreateWindow({
    Title = "MIX-N4X PRO HUB",
    Icon = "rbxassetid://10734950309",
    Author = "by MIX-N4X",
    Folder = "MIX_N4X_CONFIGS"
})

-- [4] إضافة التبويبات (Tabs)
local MainTab = Window:Tab({ Title = "⚡ Player", Icon = "user" })
local VisualsTab = Window:Tab({ Title = "👁️ Visuals", Icon = "eye" })
local CombatTab = Window:Tab({ Title = "⚔️ Combat", Icon = "swords" })

-- ==========================================
-- ميزات اللاعب (Main Tab)
-- ==========================================
MainTab:Section({ Title = "Movement" })

MainTab:Slider({
    Title = "Speed Overdrive",
    Min = 16, Max = 500, Default = 16,
    Callback = function(v)
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.WalkSpeed = v
        end
    end
})

MainTab:Toggle({
    Title = "Infinite Jump",
    Value = false,
    Callback = function(v) _G.InfJump = v end
})

-- ==========================================
-- ميزات الرؤية (Visuals Tab)
-- ==========================================
VisualsTab:Section({ Title = "Wallhacks" })

VisualsTab:Toggle({
    Title = "Player Highlights (ESP)",
    Value = false,
    Callback = function(v)
        _G.ESP = v
        if not v then
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("N4X_ESP") then
                    p.Character.N4X_ESP:Destroy()
                end
            end
        end
    end
})

-- ==========================================
-- ميزات القتال (Combat Tab)
-- ==========================================
CombatTab:Section({ Title = "Aura Settings" })

CombatTab:Toggle({
    Title = "Kill Aura",
    Value = false,
    Callback = function(v) _G.KillAura = v end
})

-- ==========================================
-- الأنظمة الخلفية (Back-end Logic)
-- ==========================================

-- نظام القفز
game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfJump and LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- نظام الـ ESP
task.spawn(function()
    while task.wait(2) do
        if _G.ESP then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and not p.Character:FindFirstChild("N4X_ESP") then
                    local h = Instance.new("Highlight", p.Character)
                    h.Name = "N4X_ESP"
                    h.FillColor = Color3.fromRGB(255, 0, 0)
                end
            end
        end
    end
end)

-- نظام الـ Kill Aura
task.spawn(function()
    while task.wait(0.1) do
        if _G.KillAura then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (LP.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                    if dist <= 20 then
                        local tool = LP.Character:FindFirstChildOfClass("Tool")
                        if tool then tool:Activate() end
                    end
                end
            end
        end
    end
end)

-- إشعار الترحيب
WindUI:Notify({
    Title = "MIX-N4X PRO",
    Content = "Welcome back, Master!",
    Type = "Success",
    Duration = 5
})

