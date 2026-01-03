-- ConfigModule.lua
-- ضع هذا الملف في ReplicatedStorage
local RunService = game:GetService("RunService")

if not RunService:IsStudio() then
    warn("ConfigModule: Intended for Studio-only test harness.")
    -- الاستدعاء سيستمر لكن كل سكربتات الحزمة تتحقق أيضاً من IsStudio
end

local Config = {
    OwnerUserId = 12345678, -- <-- عيّن UserId الخاص بك هنا
    TickInterval = 1,       -- فترة التكرار بالثواني
    ScenarioTimeout = 30,   -- مهلة افتراضية للسيناريو بالثواني
    Features = {
        AutoFarmXP = false,
        AutoFarmCash = false,
        AutoCollectables = false,
        AutoInstantRevive = false,
        AutoRespawn = false,
        WalkSpeed = 16,
        JumpPower = 50,
        InfiniteJump = false,
        FullBright = false,
        RemoveFog = false,
        ESP = false
    }
}

return Config
