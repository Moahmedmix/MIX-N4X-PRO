-- TestHarness.server.lua
-- ضع هذا الملف في ServerScriptService
local RunService = game:GetService("RunService")
if not RunService:IsStudio() then
    warn("TestHarness: Studio-only. Stopping.")
    return
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- RemoteEvent قناة تواصل بين Client و Server
local remote = ReplicatedStorage:FindFirstChild("DevHarnessEvent")
if not remote then
    remote = Instance.new("RemoteEvent")
    remote.Name = "DevHarnessEvent"
    remote.Parent = ReplicatedStorage
end

-- لوحات تسجيل داخل ServerStorage
local logsFolder = ServerStorage:FindFirstChild("DevTestLogs")
if not logsFolder then
    logsFolder = Instance.new("Folder")
    logsFolder.Name = "DevTestLogs"
    logsFolder.Parent = ServerStorage
end

-- Modules
local Config = require(ReplicatedStorage:WaitForChild("ConfigModule"))
local MockAPI = require(ReplicatedStorage:WaitForChild("MockGameAPI"))

-- حالة التبديلات العالمية (يمكن توسيع لتكون per-player)
local state = {
    enabled = {},
    numeric = {}
}

-- تهيئة leaderstats عند دخول اللاعب
local function setupLeaderstats(player)
    MockAPI:EnsureLeaderstats(player)
end

Players.PlayerAdded:Connect(setupLeaderstats)

-- دالة لتسجيل حدث نصي داخل ServerStorage (سجل منفصل لكل تشغيل)
local function appendLogLine(line)
    local timestamp = os.time()
    local name = "log_"..tostring(timestamp)
    local sv = Instance.new("StringValue")
    sv.Name = name
    sv.Value = "["..tostring(os.date("%Y-%m-%d %H:%M:%S", timestamp)).."] "..line
    sv.Parent = logsFolder
    -- لأغراض Studio: طبع أيضًا في Output
    print(sv.Value)
end

-- معالجة أحداث من الـ Client (مقيدة بالمالك)
remote.OnServerEvent:Connect(function(player, action, payload)
    if not player then return end
    if player.UserId ~= Config.OwnerUserId then
        warn("DevHarness: Rejected control from", player.Name)
        appendLogLine(("Rejected control attempt from %s (UserId=%d)"):format(player.Name, player.UserId))
        return
    end

    if action == "SetToggle" and payload and payload.key ~= nil then
        state.enabled[payload.key] = payload.value
        appendLogLine(("Toggle %s set to %s by %s"):format(tostring(payload.key), tostring(payload.value), player.Name))
    elseif action == "SetNumber" and payload and payload.key ~= nil then
        state.numeric[payload.key] = payload.value
        appendLogLine(("Number %s set to %s by %s"):format(tostring(payload.key), tostring(payload.value), player.Name))
    elseif action == "RequestState" then
        remote:FireClient(player, "StateUpdate", { enabled = state.enabled, numeric = state.numeric })
    elseif action == "RunScenario" and payload and payload.name then
        -- اطلب تشغيل سيناريو محدد عبر ScenarioRunner (يُحمّل من ServerScriptService)
        local scenarioRunner = script.Parent:FindFirstChild("ScenarioRunner")
        if scenarioRunner and scenarioRunner:IsA("ModuleScript") then
            local runner = require(scenarioRunner)
            spawn(function()
                runner:RunScenario(payload.name, player, state, appendLogLine)
            end)
        else
            appendLogLine("ScenarioRunner module not found.")
        end
    end
end)

-- حلقة AutoFarm / تأثيرات ستطبق في Studio فقط
spawn(function()
    while RunService:IsStudio() do
        for _, player in pairs(Players:GetPlayers()) do
            if state.enabled["AutoFarmXP"] then
                local success = MockAPI:AwardXP(player, state.numeric["AutoFarmXPAmount"] or 10)
                if success then
                    appendLogLine(("Awarded XP to %s"):format(player.Name))
                end
            end
            if state.enabled["AutoFarmCash"] then
                local success = MockAPI:AwardCash(player, state.numeric["AutoFarmCashAmount"] or 5)
                if success then
                    appendLogLine(("Awarded Cash to %s"):format(player.Name))
                end
            end
            if state.enabled["AutoCollectables"] then
                MockAPI:CollectAll(player)
            end
            if state.enabled["AutoInstantRevive"] then
                -- محاكاة Instant Revive: فقط لطباعة/اختبار
                appendLogLine(("AutoInstantRevive triggered for %s"):format(player.Name))
            end
            if state.enabled["AutoRespawn"] then
                MockAPI:RespawnPlayer(player)
                appendLogLine(("Respawned %s"):format(player.Name))
            end
        end
        wait(Config.TickInterval or 1)
    end
end)

appendLogLine("TestHarness.server.lua loaded (Studio-only).")
