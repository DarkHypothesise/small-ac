local TriggerSec = 10000 -- 10 Sekunden
local TriggerCount = 5 -- mal

local BlacklistedTriggers = {
     "toggleDuty",
    -- "dark-admin:revive",
     -- Weitere Blacklisted Triggers hier hinzufügen

}

local LimitTrigger = {
    -- "toggleDuty",
     "dark-admin:revive",
   
}
   
AddEventHandler('onResourceStart', function(resourceName)
    Citizen.Wait(5000)
    print("[ANTICHEAT] Config geladen Clientside")
    TriggerClientEvent("InfoConfigBckTrigger", -1, BlacklistedTriggers) 
    TriggerClientEvent("InfoLimitTrigger", -1, LimitTrigger, TriggerCount, TriggerSec) 
end)

RegisterNetEvent("PlayerLoaded")
AddEventHandler("PlayerLoaded", function()
    print("[ANTICHEAT] Config geladen Clientside")
    TriggerClientEvent("InfoConfigBckTrigger", -1, BlacklistedTriggers) 
    TriggerClientEvent("InfoLimitTrigger", -1, LimitTrigger, TriggerCount, TriggerSec) 
end)


-- ServerSide Blacklisted Trigger Check
for _, trigger in ipairs(BlacklistedTriggers) do
    RegisterNetEvent(trigger)
    AddEventHandler(trigger, function()
        print("[ANTICHEAT] Blacklisted Trigger detected: " .. trigger)
    end)
end

-- ServerSide Blacklisted Trigger Count Check
local triggerCounts = {}
for _, trigger in ipairs(LimitTrigger) do
    RegisterNetEvent(trigger)
    AddEventHandler(trigger, function()
        if not triggerCounts[trigger] then
            triggerCounts[trigger] = 1
        else
            triggerCounts[trigger] = triggerCounts[trigger] + 1
        end
        
        if triggerCounts[trigger] >= TriggerCount then
            print("[ANTICHEAT] Übermäßige Verwendung Limited trigger: " .. trigger)
        else
            print("[ANTICHEAT] Limited trigger detected: " .. trigger)
            Citizen.Wait(TriggerSec) -- wait 10 seconds
            triggerCounts[trigger] = triggerCounts[trigger] - 1
        end
    end)
end
