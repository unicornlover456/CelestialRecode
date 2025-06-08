function CheckKey()
    if getgenv()["8GQ2ZNLT5X"] then
        getgenv()["8GQ2ZNLT5X"] = nil
        return true
    else
        return false
    end
end

print("Running Baseplate.lua")

if CheckKey() then
    print("Premium License")
else
    print("Standard License")
end
