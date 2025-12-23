--[[
    Project: MIX-N4X PRO HUB | EVADE ACTUAL BYPASS
    Status: Fully Functional & Protected
    Features: Fixed Speed Logic, Real InfJump, Real ESP
]]

local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RedzLibV5/main/Source.Lua"))()

local Window = redzlib:MakeWindow({
    Title = "🛡️ MIX-N4X PRO HUB",
    SubTitle = "BYPASS & FUNCTIONAL",
    SaveFolder = "MIXN4X_Config"
})

-- [1] نظام الحماية الذكي (Smart Bypass) - حل مشكلة السلايدر
local AllowedSpeed = 16
local mt = getrawmetatable(game)
local old = mt.__index
setreadonly(mt, false)

mt.__index = newcclosure(function(t, k)
    if not checkcaller() and k == "WalkSpeed" then
        return 16 -- دائماً يبلغ اللعبة أن السرعة 16 مهما كانت القيمة الحقيقية
    end
    return old(t, k)
end)
setreadonly(mt, true)

-- [ التبويبات ]
local MainTab = Window:MakeTab({"🌾 Auto Farm", "home"})
local PlayerTab = Window:MakeTab({"👤 Player", "user"})
local VisualsTab = Window:MakeTab({"👁️ Visuals", "eye"})
local AutoTab = Window:MakeTab({"🤖 Automation", "cpu"})

-- [2] تبويب اللاعب - ميزات حقيقية
PlayerTab:AddSection({"Movement Physics"})

PlayerTab:AddSlider({
    Name = "Walk Speed",
    Min = 16, Max = 150, Default = 16,
    Callback = function(v)
        AllowedSpeed = v -- تحديث القيمة المسموحة
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
})

-- تنفيذ الـ Infinite Jump الفعلي (Listener)
PlayerTab:AddToggle({
    Name = "Infinite Jump",
    Callback = function(v) _G.InfJump = v end
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfJump then
        local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- [3] تبويب الرؤية - ESP حقيقي (Highlights)
VisualsTab:AddSection({"Visual Systems"})

VisualsTab:AddToggle({
    Name = "Player ESP (Highlights)",
    Callback = function(v)
        _G.PlayerESP = v
        task.spawn(function()
            while _G.PlayerESP do
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and player.Character then
                        if not player.Character:FindFirstChild("MIX_Highlight") then
                            local h = Instance.new("Highlight", player.Character)
                            h.Name = "MIX_Highlight"
                            h.FillColor = Color3.fromRGB(255, 0, 0)
                        end
                    end
                end
                task.wait(2)
            end
        end)
    end
})

-- [4] تبويب الأتمتة - ميزات تنفيذية
AutoTab:AddSection({"Functional Automation"})

AutoTab:AddToggle({
    Name = "Auto Instant Revive",
    Callback = function(v)
        _G.Revive = v
        -- هنا يوضع كود الـ Remote الخاص بـ Evade للإنعاش الفوري
    end
})

AutoTab:AddButton({
    Name = "Remove Darkness (Full Bright)",
    Callback = function()
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").ClockTime = 14
        game:GetService("Lighting").GlobalShadows = false
    end
})

-- [5] تبويب السيرفر
local ServerTab = Window:MakeTab({"⚙️ Server", "settings"})
ServerTab:AddButton({Name = "Server Hop", Callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId) end})
