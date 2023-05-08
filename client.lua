local BlacklistedTrigger = {}
local LimitedTrigger = {}

local hasPlayerLoaded = false

AddEventHandler('playerSpawned', function(spawnInfo)
    if not hasPlayerLoaded then
        Citizen.Wait(3500)
        TriggerServerEvent('PlayerLoadedCf')
        hasPlayerLoaded = true
    end
end)


RegisterNetEvent("InfoConfigBckTrigger")
AddEventHandler("InfoConfigBckTrigger", function(value, UseWebhooks)
    BlacklistedTrigger = value
    Citizen.Wait(10)
    for i, trigger in ipairs(BlacklistedTrigger) do
        RegisterNetEvent(trigger)
        AddEventHandler(trigger, function()
            print("[ANTICHEAT] Blacklisted Trigger detected: " .. trigger)
        if UseWebhooks then
            TriggerServerEvent("WebhookbClientSide", trigger)
            end
        end)
    end
end)

local triggerCounts = {}

RegisterNetEvent("InfoLimitTrigger")
AddEventHandler("InfoLimitTrigger", function(value, maxUse, sec, UseWebhooks)
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
            print("[ANTICHEAT] Excessive use of Limited trigger: " .. trigger)
            if UseWebhooks then
            TriggerServerEvent("WebhookLClientSide", trigger)
        end
        else
            print("[ANTICHEAT] Limited trigger detected: " .. trigger)
            Citizen.Wait(sec) -- wait 10 seconds
            triggerCounts[trigger] = triggerCounts[trigger] - 1
        end
    end)
end
end)
