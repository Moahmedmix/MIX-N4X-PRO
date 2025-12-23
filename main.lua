--[[ 
    🛡️ MIX-N4X PRO HUB | THE ULTIMATE EDITION
    Creator: Moahmedmix
    Status: Secured, Bypassed, & Fully Functional
]]

-- [1] إعدادات المطور والمفاتيح (تعديل هام)
local CreatorID = 1684333634 -- تأكد من وضع الـ UserID الخاص بك هنا
local VIP_Key = "MIX-ADMIN-2025" -- مفتاحك الخاص للدخول من أي حساب
local User_Key_URL = "https://keysystem.cc/getkey/MIX-N4X" -- رابط الحصول على المفتاح

-- 🟢 دالة تشغيل السكريبت الرئيسي (Launch)
local function LaunchMainScript()
    -- الخدمات الأساسية
    local Players = game:GetService("Players")
    local LP = Players.LocalPlayer
    local UIS = game:GetService("UserInputService")
    local Lighting = game:GetService("Lighting")
    
    -- نظام التحديث التلقائي للشخصية (لحل مشكلة الموت)
    local Char, Humanoid
    local function RefreshReferences(newChar)
        Char = newChar
        Humanoid = Char:WaitForChild("Humanoid")
    end
    LP.CharacterAdded:Connect(RefreshReferences)
    if LP.Character then RefreshReferences(LP.Character) end

    -- [2] نظام اختراق الحمايات المتقدم (Advanced Bypass)
    local AllowedSpeed = 16
    local success, err = pcall(function()
        local mt = getrawmetatable(game)
        local oldIndex = mt.__index
        local oldNewIndex = mt.__newindex
        local oldNamecall = mt.__namecall
        setreadonly(mt, false)

        -- منع اللعبة من قراءة القيم الحقيقية
        mt.__index = newcclosure(function(t, k)
            if not checkcaller() and typeof(t) == "Instance" then
                if t:IsA("Humanoid") and k == "WalkSpeed" then return 16 end
                if t:IsA("Humanoid") and k == "JumpPower" then return 50 end
            end
            return oldIndex(t, k)
        end)

        -- منع اللعبة من تعديل قيم السرعة (Anti-Reset)
        mt.__newindex = newcclosure(function(t, k, v)
            if not checkcaller() and typeof(t) == "Instance" then
                if t:IsA("Humanoid") and (k == "WalkSpeed" or k == "JumpPower") then
                    if v == 16 or v == 50 then return oldNewIndex(t, k, v) end
                    return -- رفض أي تغيير غير طبيعي من اللعبة
                end
            end
            return oldNewIndex(t, k, v)
        end)

        -- حماية ضد الطرد (Anti-Kick)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if not checkcaller() then
                if method == "Kick" or (method == "Destroy" and self == LP) then return nil end
                if method == "FireServer" and tostring(self):find("Kick") then return nil end
            end
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
    end)

    -- [3] بناء واجهة المستخدم (RedzLib)
    local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RedzLibV5/main/Source.Lua"))()
    local Window = redzlib:MakeWindow({
        Name = "🛡️ MIX-N4X PRO",
        SubTitle = "Immortal Edition",
        ConfigurationSaving = {Enabled = true, FolderName = "MIXN4X_CONFIG"}
    })

    -- التبويبات
    local PlayerTab = Window:MakeTab({"👤 Player", "user"})
    local VisualsTab = Window:MakeTab({"👁️ Visuals", "eye"})
    local ServerTab = Window:MakeTab({"⚙️ Server", "settings"})

    -- ميزات اللاعب (Player Features)
    PlayerTab:AddSection({"Movement Bypass"})

    PlayerTab:AddSlider({
        Name = "Walk Speed",
        Min = 16, Max = 250, Default = 16,
        Callback = function(v)
            AllowedSpeed = v
            if Humanoid then Humanoid.WalkSpeed = v end
        end
    })

    PlayerTab:AddSlider({
        Name = "Jump Power",
        Min = 50, Max = 300, Default = 50,
        Callback = function(v)
            if Humanoid then
                Humanoid.UseJumpPower = true
                Humanoid.JumpPower = v
            end
        end
    })

    _G.InfJump = false
    PlayerTab:AddToggle({
        Name = "Infinite Jump",
        Callback = function(v) _G.InfJump = v end
    })

    UIS.JumpRequest:Connect(function()
        if _G.InfJump and Humanoid then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)

    -- ميزات الرؤية (Visual Features)
    VisualsTab:AddSection({"ESP & Environment"})

    VisualsTab:AddToggle({
        Name = "Player ESP (Highlights)",
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
            task.wait(2)
        end
    end)

    VisualsTab:AddButton({
        Name = "Full Bright / No Fog",
        Callback = function()
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        end
    })

    -- ميزات السيرفر (Server Features)
    ServerTab:AddButton({
        Name = "Server Hop",
        Callback = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId)
        end
    })

    ServerTab:AddButton({
        Name = "Rejoin Game",
        Callback = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
        end
    })

    warn("✅ MIX-N4X PRO: LOADED SUCCESSFULLY")
end

-- [4] نظام بوابة التحقق (Key System Logic)
local LP = game.Players.LocalPlayer
if LP.UserId == CreatorID then
    LaunchMainScript() -- دخول فوري للمطور
else
    local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RedzLibV5/main/Source.Lua"))()
    local AuthWin = redzlib:MakeWindow({Name = "🔑 MIX-N4X AUTH", SubTitle = "Verification"})
    local Tab = AuthWin:MakeTab({"Key System", "lock"})

    Tab:AddSection({"Developer: Moahmedmix"})

    Tab:AddTextBox({
        Name = "Enter Key",
        Callback = function(input)
            if input == VIP_Key or input == "MIX-N4X-FREE" then 
                AuthWin:Destroy()
                LaunchMainScript()
            end
        end
    })

    Tab:AddButton({
        Name = "Copy Key Link",
        Callback = function()
            setclipboard(User_Key_URL)
        end
    })
end
