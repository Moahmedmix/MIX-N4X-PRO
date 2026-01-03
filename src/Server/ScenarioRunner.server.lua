-- ScenarioRunner.server.lua
-- Module لتشغيل سيناريوهات اختبارية آلية ومُسجّلة (ضعه في ServerScriptService بجانب TestHarness)
local RunService = game:GetService("RunService")
if not RunService:IsStudio() then
    warn("ScenarioRunner: Studio-only.")
    return {}
end

local Module = {}

-- مثال سيناريوهات قابلة للتوسيع؛ كل دالة تأخذ (initiatorPlayer, state, appendLogLine)
Module.Scenarios = {}

-- مثال سيناريو: TestAutoFarm
Module.Scenarios["TestAutoFarm"] = function(initiator, state, appendLogLine)
    appendLogLine("Scenario TestAutoFarm: started by "..initiator.Name)
    -- فعّل AutoFarmXP وAutoFarmCash مؤقتاً
    state.enabled["AutoFarmXP"] = true
    state.enabled["AutoFarmCash"] = true
    state.numeric["AutoFarmXPAmount"] = 20
    state.numeric["AutoFarmCashAmount"] = 10

    local duration = 10 -- ثواني للاختبار
    appendLogLine("Scenario TestAutoFarm: running for "..tostring(duration).." seconds")
    wait(duration)

    -- إيقاف
    state.enabled["AutoFarmXP"] = false
    state.enabled["AutoFarmCash"] = false
    appendLogLine("Scenario TestAutoFarm: completed")
end

-- مثال سيناريو: MovementTest (يغيّر القيم العددية)
Module.Scenarios["MovementTest"] = function(initiator, state, appendLogLine)
    appendLogLine("Scenario MovementTest: started by "..initiator.Name)
    local prevWalk = state.numeric["WalkSpeed"]
    local prevJump = state.numeric["JumpPower"]
    state.numeric["WalkSpeed"] = 40
    state.numeric["JumpPower"] = 100
    appendLogLine("MovementTest: WalkSpeed=40, JumpPower=100 for 8s")
    wait(8)
    state.numeric["WalkSpeed"] = prevWalk
    state.numeric["JumpPower"] = prevJump
    appendLogLine("MovementTest: restored values")
end

function Module:RunScenario(name, initiator, stateRef, appendLogLine)
    local fn = Module.Scenarios[name]
    if not fn then
        appendLogLine("RunScenario: scenario not found: "..tostring(name))
        return
    end
    -- تنفيذ السيناريو في مساحة منفصلة
    pcall(function()
        fn(initiator, stateRef, appendLogLine)
    end)
end

return Module
