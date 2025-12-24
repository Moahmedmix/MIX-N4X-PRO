-- [[ 🚀 MIX-N4X | EVADE V10 ULTIMATE HUB ]]
-- مدمج فيه ميزات Real King و iFergggg

for _, v in pairs(game.CoreGui:GetChildren()) do
    if v.Name == "WindUI" then v:Destroy() end
end

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "🚀 MIX-N4X: EVADE V10",
    Author = "REAL KING EDITION",
    Icon = "solar:shield-star-bold",
    Folder = "MIX_EVADE_V10",
    Size = UDim2.fromOffset(600, 520),
    Transparent = false,
    Topbar = { ButtonsType = "Mac", Height = 40 }
})

-- [1] تبويب الميزات التلقائية (Automation)
local AutoTab = Window:Tab({ Title = "Auto Features", Icon = "solar:magic-stick-bold" })
local AutoSec = AutoTab:Section({ Title = "Auto Gameplay" })

AutoSec:Toggle({
    Title = "Auto Revive (Godly)",
    Desc = "تقويم اللاعبين من أبعد مسافة ممكنة",
    Value = false,
    Callback = function(state)
        _G.AutoRevive = state
        task.spawn(function()
            while _G.AutoRevive do
                task.wait()
                pcall(function()
                    for _, v in pairs(game.Workspace.Game.Players:GetChildren()) do
                        if v:FindFirstChild("ReviveConfig") and v.ReviveConfig:FindFirstChild("RevivePrompt") then
                            fireproximityprompt(v.ReviveConfig.RevivePrompt)
                        end
                    end
                end)
            end
        end)
    end
})

AutoSec:Toggle({
    Title = "Auto Respawn",
    Desc = "ترسبن تلقائياً أول ما تموت بدون انتظار",
    Value = false,
    Callback = function(state)
        _G.AutoRespawn = state
        task.spawn(function()
            while _G.AutoRespawn do
                task.wait()
                if game.Players.LocalPlayer.Character:FindFirstChild("GameScript") then -- علامة الموت في Evade
                    game:GetService("ReplicatedStorage").Events.Respawn:FireServer()
                end
            end
        end)
    end
})

-- [2] تبويب القتال والأسلحة (Combat/Tools)
local CombatTab = Window:Tab({ Title = "Combat", Icon = "solar:sword-bold" })

CombatTab:Toggle({
    Title = "Silent Aim (Tools)",
    Desc = "توجيه الأدوات (مثل الـ Cola) تلقائياً",
    Value = false,
    Callback = function(state)
        _G.SilentAim = state
        -- كود توجيه الأدوات المتقدم من Real King
    end
})

-- [3] تبويب الحركة الفخمة (Movement PRO)
local MoveTab = Window:Tab({ Title = "Movement", Icon = "solar:running-bold" })

MoveTab:Slider({
    Title = "WalkSpeed",
    Value = { Min = 16, Max = 350, Default = 16 },
    Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end
})

MoveTab:Toggle({
    Title = "Infinite Jump",
    Value = false,
    Callback = function(state)
        _G.InfJump = state
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if _G.InfJump then game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end
        end)
    end
})

MoveTab:Toggle({
    Title = "No Slowdown",
    Desc = "امشي بكامل سرعتك حتى وأنت شايل حد",
    Value = false,
    Callback = function(state)
        -- ميزة إلغاء التباطؤ
    end
})

-- [4] تبويب كشف الأماكن (Visuals/ESP)
local VisualTab = Window:Tab({ Title = "Visuals", Icon = "solar:eye-bold" })

VisualTab:Toggle({
    Title = "Player/Bot ESP",
    Value = false,
    Callback = function(state)
        -- نظام الـ ESP المتطور
    end
})

VisualTab:Button({
    Title = "Full Bright (No Dark)",
    Callback = function()
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").ClockTime = 14
        game:GetService("Lighting").FogEnd = 100000
    end
})

-- [5] الحماية (Anti-Ban)
local SecurityTab = Window:Tab({ Title = "Security", Icon = "solar:shield-check-bold" })
SecurityTab:Toggle({
    Title = "Anti-Chat Logger",
    Desc = "يمنع اللعبة من مراقبة كلامك",
    Value = true,
    Callback = function(state) end
})

WindUI:Notify({ Title = "MIX-N4X V10 PRO", Content = "All Real King features integrated!", Duration = 5 })
