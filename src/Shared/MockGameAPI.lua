-- MockGameAPI.lua
-- واجهة محاكاة لاستخدامها في الاختبارات.
-- استبدل الدوال هذه بمنطق لعبتك الحقيقي عند دمج في الإنتاج.

local MockGameAPI = {}

function MockGameAPI:EnsureLeaderstats(player)
    local ls = player:FindFirstChild("leaderstats")
    if not ls then
        ls = Instance.new("Folder")
        ls.Name = "leaderstats"
        ls.Parent = player

        local xp = Instance.new("IntValue")
        xp.Name = "XP"
        xp.Value = 0
        xp.Parent = ls

        local cash = Instance.new("IntValue")
        cash.Name = "Cash"
        cash.Value = 0
        cash.Parent = ls
    end
end

function MockGameAPI:AwardXP(player, amount)
    self:EnsureLeaderstats(player)
    local xp = player.leaderstats:FindFirstChild("XP")
    if xp then
        xp.Value = xp.Value + amount
        return true
    end
    return false
end

function MockGameAPI:AwardCash(player, amount)
    self:EnsureLeaderstats(player)
    local cash = player.leaderstats:FindFirstChild("Cash")
    if cash then
        cash.Value = cash.Value + amount
        return true
    end
    return false
end

function MockGameAPI:RespawnPlayer(player)
    -- محاكاة Respawn للاختبار
    if player and player.Character then
        player:LoadCharacter()
    end
end

function MockGameAPI:CollectAll(player)
    -- محاكاة جمع الـ Collectables للاختبار (يجب استبدالها بمنطق اللعبة)
    print("MockGameAPI: CollectAll called for", player.Name)
end

return MockGameAPI
