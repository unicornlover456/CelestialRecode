function isPremiumUser(playerId, placeId)
    return _G["p_" .. table.concat((function()
        local r = {}
        for i = 1, math.max(#tostring(playerId), #tostring(placeId)) do
            if i <= #tostring(placeId) then table.insert(r, tostring(placeId):sub(i,i)) end
            if i <= #tostring(playerId) then table.insert(r, tostring(playerId):sub(i,i)) end
        end
        return r
    end)())] == true
end


print("Running Baseplate.lua")

if isPremiumUser(game.Players.LocalPlayer.UserId, game.PlaceId) then
    print("User is PREMIUM!")
else
    print("User is NOT premium.")
end

