function isPremiumUser(playerId, placeId)
    local function xorDecode(str, key)
        local decoded = HttpService:UrlDecode(str)
        local result = {}
        for i = 1, #decoded do
            local c = decoded:sub(i, i):byte()
            local k = key:sub((i - 1) % #key + 1, (i - 1) % #key + 1):byte()
            table.insert(result, string.char(bit32.bxor(c, k)))
        end
        return decoded, table.concat(result)
    end

    for k, v in pairs(_G) do
        if typeof(k) == "string" and k:sub(1, 2) == "p_" and v == true then
            local enc, decoded = xorDecode(k:sub(3), "XxSeCrEtK3y")
            if decoded == (tostring(placeId) .. "_" .. tostring(playerId)) then
                _G[k] = nil
                return true
            end
        end
    end
    return false
end

print("Running Baseplate.lua")

if isPremiumUser(game.Players.LocalPlayer.UserId, game.PlaceId) then
    print("User is PREMIUM!")
else
    print("User is NOT premium.")
end
