function isPremiumUser(playerId, placeId)
    local function deobfuscateKey(mixed)
        local placeIdChars = {}
        local userIdChars = {}

        for i = 1, #mixed do
            local c = mixed:sub(i, i)
            if i % 2 == 1 then
                -- odd index: placeId char first, then userId char
                if #placeIdChars < math.ceil(#mixed / 2) then
                    table.insert(placeIdChars, c)
                else
                    table.insert(userIdChars, c)
                end
            else
                -- even index: userId char first, then placeId char
                if #userIdChars < math.floor(#mixed / 2) then
                    table.insert(userIdChars, c)
                else
                    table.insert(placeIdChars, c)
                end
            end
        end

        local decodedPlaceId = table.concat(placeIdChars)
        local decodedUserId = table.concat(userIdChars)
        return decodedPlaceId, decodedUserId
    end

    local playerIdStr = tostring(playerId)
    local placeIdStr = tostring(placeId)

    for k, v in pairs(_G) do
        if typeof(k) == "string" and k:sub(1, 2) == "p_" and v == true then
            local mixedKey = k:sub(3)
            local decodedPlaceId, decodedUserId = deobfuscateKey(mixedKey)

            if decodedPlaceId == placeIdStr and decodedUserId == playerIdStr then
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
