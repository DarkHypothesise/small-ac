local BlacklistedTrigger = {}
local LimitedTrigger = {}

AddEventHandler('playerSpawned', function(resourceName)
  TriggerServerEvent("PlayerLoaded")
end)

RegisterNetEvent("InfoConfigBckTrigger")
AddEventHandler("InfoConfigBckTrigger", function(value)
    BlacklistedTrigger = value
    Citizen.Wait(10)
    for i, trigger in ipairs(BlacklistedTrigger) do
        RegisterNetEvent(trigger)
        AddEventHandler(trigger, function()
            print("[ANTICHEAT] Blacklisted Trigger detected: " .. trigger)
        end)
    end
end)

local triggerCounts = {}

RegisterNetEvent("InfoLimitTrigger")
AddEventHandler("InfoLimitTrigger", function(value, maxUse, sec)
    LimitedTrigger = value
    Citizen.Wait(10)
    for i, trigger in ipairs(LimitedTrigger) do
    RegisterNetEvent(trigger)
    AddEventHandler(trigger, function()
        if not triggerCounts[trigger] then
            triggerCounts[trigger] = 1
        else
            triggerCounts[trigger] = triggerCounts[trigger] + 1
        end
        
        if triggerCounts[trigger] >= maxUse then
            print("[ANTICHEAT] Übermäßige Verwendung Limited trigger: " .. trigger)
        else
            print("[ANTICHEAT] Limited trigger detected: " .. trigger)
            Citizen.Wait(sec) -- wait 10 seconds
            triggerCounts[trigger] = triggerCounts[trigger] - 1
        end
    end)
end
end)