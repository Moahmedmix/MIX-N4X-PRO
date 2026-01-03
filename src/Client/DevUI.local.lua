-- DevUI.local.lua
-- ضع هذا الملف في StarterPlayer > StarterPlayerScripts
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

if not RunService:IsStudio() then
    warn("DevUI: Studio-only UI. Stopping.")
    return
end

local player = Players.LocalPlayer
local remote = ReplicatedStorage:WaitForChild("DevHarnessEvent")
local ok, ConfigModule = pcall(function() return require(ReplicatedStorage:WaitForChild("ConfigModule")) end)
if not ok or type(ConfigModule) ~= "table" then
    warn("DevUI: ConfigModule missing in ReplicatedStorage.")
    return
end

if player.UserId ~= ConfigModule.OwnerUserId then
    warn("DevUI: You are not the configured OwnerUserId. UI will not run.")
    return
end

-- GUI creation (مبسط) — يمكنك استبداله بـ ScreenGui تصميمي
local function createGui()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DevHarnessUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 360, 0, 420)
    frame.Position = UDim2.new(0, 12, 0, 12)
    frame.BackgroundColor3 = Color3.fromRGB(28,28,28)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 36)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 18
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Text = "Dev Test Harness — Controls"
    title.Parent = frame

    local y = 46
    local function addToggle(labelText, key, default)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0, 220, 0, 28)
        lbl.Position = UDim2.new(0, 8, 0, y)
        lbl.BackgroundTransparency = 1
        lbl.Font = Enum.Font.SourceSans
        lbl.TextSize = 14
        lbl.TextColor3 = Color3.fromRGB(220,220,220)
        lbl.Text = labelText
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = frame

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 80, 0, 24)
        btn.Position = UDim2.new(0, 240, 0, y + 2)
        btn.BackgroundColor3 = default and Color3.fromRGB(0,160,0) or Color3.fromRGB(120,120,120)
        btn.BorderSizePixel = 0
        btn.Font = Enum.Font.SourceSansBold
        btn.TextSize = 14
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Text = default and "ON" or "OFF"
        btn.Parent = frame

        local state = default or false
        btn.MouseButton1Click:Connect(function()
            state = not state
            btn.BackgroundColor3 = state and Color3.fromRGB(0,160,0) or Color3.fromRGB(120,120,120)
            btn.Text = state and "ON" or "OFF"
            remote:FireServer("SetToggle", { key = key, value = state })
        end)

        y = y + 34
        return btn
    end

    local function addNumberField(labelText, key, default)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0, 140, 0, 28)
        lbl.Position = UDim2.new(0, 8, 0, y)
        lbl.BackgroundTransparency = 1
        lbl.Font = Enum.Font.SourceSans
        lbl.TextSize = 14
        lbl.TextColor3 = Color3.fromRGB(220,220,220)
        lbl.Text = labelText
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = frame

        local box = Instance.new("TextBox")
        box.Size = UDim2.new(0, 80, 0, 24)
        box.Position = UDim2.new(0, 150, 0, y + 2)
        box.BackgroundColor3 = Color3.fromRGB(60,60,60)
        box.BorderSizePixel = 0
        box.Font = Enum.Font.SourceSans
        box.TextSize = 14
        box.TextColor3 = Color3.fromRGB(255,255,255)
        box.Text = tostring(default or "")
        box.ClearTextOnFocus = false
        box.Parent = frame

        local applyBtn = Instance.new("TextButton")
        applyBtn.Size = UDim2.new(0, 40, 0, 24)
        applyBtn.Position = UDim2.new(0, 236, 0, y + 2)
        applyBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
        applyBtn.BorderSizePixel = 0
        applyBtn.Font = Enum.Font.SourceSansBold
        applyBtn.TextSize = 14
        applyBtn.Text = "OK"
        applyBtn.TextColor3 = Color3.fromRGB(255,255,255)
        applyBtn.Parent = frame

        applyBtn.MouseButton1Click:Connect(function()
            local n = tonumber(box.Text)
            if n then
                remote:FireServer("SetNumber", { key = key, value = n })
            else
                box.Text = tostring(default or "")
            end
        end)

        y = y + 34
        return box
    end

    -- toggles and fields
    local tgs = {}
    tgs.AutoFarmXP = addToggle("Auto Farm XP", "AutoFarmXP", false)
    tgs.AutoFarmCash = addToggle("Auto Farm Cash", "AutoFarmCash", false)
    tgs.AutoCollectables = addToggle("Auto Collectables", "AutoCollectables", false)
    tgs.AutoInstantRevive = addToggle("Auto Instant Revive", "AutoInstantRevive", false)
    tgs.AutoRespawn = addToggle("Auto Respawn", "AutoRespawn", false)
    tgs.InfiniteJump = addToggle("Infinite Jump (test)", "InfiniteJump", false)
    tgs.FullBright = addToggle("Full Bright", "FullBright", false)
    tgs.ESP = addToggle("ESP (debug)", "ESP", false)

    local walkField = addNumberField("WalkSpeed", "WalkSpeed", ConfigModule.Features and ConfigModule.Features.WalkSpeed or 16)
    local jumpField = addNumberField("JumpPower", "JumpPower", ConfigModule.Features and ConfigModule.Features.JumpPower or 50)
    local xpAmtField = addNumberField("AutoFarm XP Amount", "AutoFarmXPAmount", 10)
    local cashAmtField = addNumberField("AutoFarm Cash Amount", "AutoFarmCashAmount", 5)

    -- زر لتشغيل سيناريو
    local scenarioBox = Instance.new("TextBox")
    scenarioBox.Size = UDim2.new(0, 160, 0, 28)
    scenarioBox.Position = UDim2.new(0, 8, 0, y + 6)
    scenarioBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
    scenarioBox.Text = "TestAutoFarm"
    scenarioBox.Parent = frame

    local runBtn = Instance.new("TextButton")
    runBtn.Size = UDim2.new(0, 120, 0, 28)
    runBtn.Position = UDim2.new(0, 180, 0, y + 6)
    runBtn.Text = "Run Scenario"
    runBtn.Font = Enum.Font.SourceSansBold
    runBtn.TextSize = 14
    runBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
    runBtn.TextColor3 = Color3.fromRGB(255,255,255)
    runBtn.Parent = frame

    runBtn.MouseButton1Click:Connect(function()
        local name = scenarioBox.Text
        remote:FireServer("RunScenario", { name = name })
    end)

    -- Refresh state button
    local refreshBtn = Instance.new("TextButton")
    refreshBtn.Size = UDim2.new(0, 120, 0, 28)
    refreshBtn.Position = UDim2.new(0, 8, 0, y + 46)
    refreshBtn.Text = "Refresh State"
    refreshBtn.Font = Enum.Font.SourceSansBold
    refreshBtn.TextSize = 14
    refreshBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
    refreshBtn.TextColor3 = Color3.fromRGB(255,255,255)
    refreshBtn.Parent = frame

    refreshBtn.MouseButton1Click:Connect(function()
        remote:FireServer("RequestState")
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.Escape then
            screenGui.Enabled = not screenGui.Enabled
        end
    end)

    return screenGui
end

local gui = createGui()

-- استقبال تحديث الحالة وعرض أي رسائل إن لزم
remote.OnClientEvent:Connect(function(action, payload)
    if action == "StateUpdate" and type(payload) == "table" then
        -- هنا يمكن تحديث الحقول إن أردت (تم تبسيط العرض)
        print("DevUI: Received StateUpdate")
    end
end)

-- طلب حالة عند البداية
remote:FireServer("RequestState")
