--[[ 
    MIX-N4X PRO HUB | CREATOR & KEY SYSTEM EDITION
    Owner: Moahmedmix
]]

-- 1. إعدادات الأمان الخاصة بك (تعديل هام)
local CreatorID = 000000000 -- استبدل الأصفار بـ UserID الخاص بك لدخول فوري بدون مفتاح
local VIP_Key = "MIX-ADMIN-SECRET-2025" -- مفتاح خاص بك أنت فقط (للطوارئ)
local User_Key_URL = "https://keysystem.cc/getkey/MIX-N4X" -- رابط المفتاح للمستخدمين

-- 🟢 دالة تشغيل السكريبت الرئيسي
local function LaunchMainScript()
    -- [ هنا نضع كود الـ Immortal Edition المصلح الذي بنيناه سابقاً ]
    local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RedzLibV5/main/Source.Lua"))()
    local Window = redzlib:MakeWindow({Name = "🛡️ MIX-N4X PRO", SubTitle = "Welcome Creator"})
    
    local PlayerTab = Window:MakeTab({"👤 Player", "user"})
    PlayerTab:AddSection({"Movement Bypass"})
    
    -- (أضف باقي ميزات السرعة، الـ ESP، والقفز هنا)
    warn("✅ MIX-N4X PRO: FULL ACCESS GRANTED")
end

-- 🔐 [ نظام بوابة التحقق الذكي ]
local LP = game.Players.LocalPlayer

-- الحالة الأولى: إذا كان المشغل هو أنت (المطور)
if LP.UserId == CreatorID then
    LaunchMainScript()
else
    -- الحالة الثانية: إظهار نافذة المفتاح للمستخدمين
    local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RedzLibV5/main/Source.Lua"))()
    local AuthWin = redzlib:MakeWindow({Name = "🔑 MIX-N4X AUTH", SubTitle = "Key Required"})
    local Tab = AuthWin:MakeTab({"Verification", "lock"})

    Tab:AddSection({"Developer: Moahmedmix"})

    Tab:AddTextBox({
        Name = "Enter Key",
        Callback = function(input)
            -- التحقق من المفتاح الخاص بك أو المفتاح اليومي
            if input == VIP_Key or input == "MIX-DAILY-123" then 
                AuthWin:Destroy()
                LaunchMainScript()
            else
                print("❌ Access Denied")
            end
        end
    })

    Tab:AddButton({
        Name = "Get Key (Copy Link)",
        Callback = function()
            setclipboard(User_Key_URL)
            print("Key link copied to clipboard!")
        end
    })
end
--[[ 
    MIX-N4X PRO HUB | FINAL REPAIRED VERSION
    Fixes: [Type Safety, Dynamic Bypass, Character Respawn, Anti-Memory Leak]
]]

-- 🟢 نظام تحديث الشخصية التلقائي (حل مشكلة الموت)
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local Char, Humanoid

local function RefreshReferences(newChar)
    Char = newChar
    Humanoid = Char:WaitForChild("Humanoid")
end

LP.CharacterAdded:Connect(RefreshReferences)
if LP.Character then RefreshReferences(LP.Character) end

-- 🛡️ [ حل مشكلة الحماية الذكية والمتزامنة ]
local AllowedSpeed = 16
local AllowedJump = 50

local success, err = pcall(function()
    local mt = getrawmetatable(game)
    local oldIndex = mt.__index
    local oldNewIndex = mt.__newindex
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)

    -- 1. إصلاح Type Safety (حل مشكلة IsA) والمزامنة
    mt.__index = newcclosure(function(t, k)
        if not checkcaller() and typeof(t) == "Instance" then
            if t:IsA("Humanoid") and k == "WalkSpeed" then return 16 end
            if t:IsA("Humanoid") and k == "JumpPower" then return 50 end
        end
        return oldIndex(t, k)
    end)

    -- 2. إصلاح __newindex (السماح بالقيم الطبيعية فقط)
    mt.__newindex = newcclosure(function(t, k, v)
        if not checkcaller() and typeof(t) == "Instance" then
            if t:IsA("Humanoid") and (k == "WalkSpeed" or k == "JumpPower") then
                if v == 16 or v == 50 then return oldNewIndex(t, k, v) end
                return -- يمنع اللعبة من تغيير سرعتك لقيم غريبة
            end
        end
        return oldNewIndex(t, k, v)
    end)

    -- 3. نظام Anti-Kick الشامل (Destroy & Remote)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if not checkcaller() then
            if method == "Kick" or method == "Destroy" and self == LP then return nil end
            if method == "FireServer" and tostring(self):find("Kick") then return nil end
        end
        return oldNamecall(self, ...)
    end)

    setreadonly(mt, true)
end)

-- 🟢 تحميل الواجهة
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RedzLibV5/main/Source.Lua"))()
local Window = redzlib:MakeWindow({Name = "🛡️ MIX-N4X PRO", SubTitle = "Immortal Edition"})

local PlayerTab = Window:MakeTab({"👤 Player", "user"})
local VisualsTab = Window:MakeTab({"👁️ Visuals", "eye"})

-- 🟢 ميزات اللاعب (مزامنة فورية بدون Loop خطر)
PlayerTab:AddSlider({
    Name = "Speed Bypass",
    Min = 16, Max = 150, Default = 16,
    Callback = function(v)
        AllowedSpeed = v
        if Humanoid then Humanoid.WalkSpeed = v end
    end
})

-- 🟢 Infinite Jump المحدث (يعمل بعد الموت)
_G.InfJump = false
PlayerTab:AddToggle({Name = "Infinite Jump", Callback = function(v) _G.InfJump = v end})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfJump and Humanoid then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- 🟢 ESP المصلح (تنظيف تلقائي لمنع الـ Lag)
VisualsTab:AddToggle({
    Name = "Player ESP",
    Callback = function(v)
        _G.PlayerESP = v
        if not v then
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("MIX_HL") then
                    p.Character.MIX_HL:Destroy()
                end
            end
        end
    end
})

-- وظيفة التحديث الذكي للـ ESP
task.spawn(function()
    while true do
        if _G.PlayerESP then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and not p.Character:FindFirstChild("MIX_HL") then
                    local hl = Instance.new("Highlight", p.Character)
                    hl.Name = "MIX_HL"
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                end
            end
        end
        task.wait(1)
    end
end)

warn("✅ MIX-N4X IMMORTAL LOADED & REPAIRED")
