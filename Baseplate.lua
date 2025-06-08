function isPremiumUser(playerId, placeId)
    local function deobfuscateKey(str)
        local raw = HttpService:UrlDecode(str)
        local filtered = {}
        for i = 1, #raw, 4 do
            table.insert(filtered, raw:sub(i, i))
        end
        return table.concat(filtered)
    end

    for k, v in pairs(_G) do
        if typeof(k) == "string" and k:sub(1, 2) == "p_" and v == true then
            local encoded = deobfuscateKey(k:sub(3))
            local expected = placeId .. "_" .. playerId
            local match = true
            for i = 1, #expected do
                local expectedByte = expected:sub(i, i):byte()
                local encodedByte = encoded:sub(i, i):byte()
                local decodedChar = (encodedByte - 17 - (i % 5)) % 126
                if decodedChar ~= expectedByte then
                    match = false
                    break
                end
            end
            if match then
                _G[k] = nil
                return true
            end
        end
    end
    return false
end

print("Running Baseplate.lua")

local success, resultOrError = pcall(function()
    return isPremiumUser(game.Players.LocalPlayer.UserId, game.PlaceId)
end)

if success then
    if resultOrError then
        print("User is PREMIUM!")
    else
        print("User is NOT premium.")
    end
else
    warn("Error running isPremiumUser:", resultOrError)
end
