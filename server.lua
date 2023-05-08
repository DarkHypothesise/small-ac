AddEventHandler('onResourceStart', function(resourceName)
    Citizen.Wait(5000)
    print("[ANTICHEAT] Config geladen Clientside")
    TriggerClientEvent("InfoConfigBckTrigger", -1, Config.BlacklistedTriggers) 
    TriggerClientEvent("InfoLimitTrigger", -1, Config.LimitTrigger, Config.TriggerCount, Config.TriggerSec) 
end)

RegisterNetEvent("PlayerLoaded")
AddEventHandler("PlayerLoaded", function()
    print("[ANTICHEAT] Config geladen Clientside")
    TriggerClientEvent("InfoConfigBckTrigger", -1, Config.BlacklistedTriggers) 
    TriggerClientEvent("InfoLimitTrigger", -1, Config.LimitTrigger, Config.TriggerCount, Config.TriggerSec) 
end)


-- ServerSide Blacklisted Trigger Check
for _, trigger in ipairs(Config.BlacklistedTriggers) do
    RegisterNetEvent(trigger)
    AddEventHandler(trigger, function(source)
        local playerName = GetPlayerName(source) or "Unknown Player"
        local identifiers = ExtractIdentifiers(source)
        local discordId = identifiers.discord or "Unknown Discord ID"
        local ip = identifiers.ip or "Unknown ip"
        
        print("[ANTICHEAT] Blacklisted Trigger detected: " .. trigger .. " by player " .. playerName)
        sendWebhook("Blacklisted Trigger use\n"..triggerName.." \n\n[PLAYER INFO]\n", "**"..playerName.. " | ID: "..source.."**\n**DISCORD :<@"..discordId..">**\n**IP :"..ip.."**", 14356753)
    end)
end


-- ServerSide Blacklisted Trigger Count Check
local triggerCounts = {}

for _, trigger in ipairs(Config.LimitTrigger) do
    RegisterNetEvent(trigger)
    AddEventHandler(trigger, function()
        local source = source
        local playerName = GetPlayerName(source) or "Unknown Player"
        local identifiers = ExtractIdentifiers(source)
        local discordId = identifiers.discord or "Unknown Discord ID"
        local ip = identifiers.ip or "Unknown ip"

        if not triggerCounts[source] then
            triggerCounts[source] = {}
        end
        
        if not triggerCounts[source][trigger] then
            triggerCounts[source][trigger] = 1
        else
            triggerCounts[source][trigger] = triggerCounts[source][trigger] + 1
        end
        
        if triggerCounts[source][trigger] >= Config.TriggerCount then
            print("[ANTICHEAT] Excessive use of Limited trigger by client "..playerName.. "["..source.."]: " .. trigger)
            sendWebhook("Excessive Trigger use\n"..trigger.." \n\n[PLAYER INFO]\n", "**"..playerName.. " | ID: "..source.."**\n**DISCORD :<@"..discordId..">**\n**IP :"..ip.."**", 14356753)
        else
            print("[ANTICHEAT] Limited trigger detected for Client "..playerName.. "["..source.."]: " .. trigger)
            Citizen.Wait(Config.TriggerSec) -- wait for specified seconds
            triggerCounts[source][trigger] = triggerCounts[source][trigger] - 1
        end
    end)
end



function sendWebhook(name, message, color)
    local connect = {
      {
        ["color"] = color,
        ["title"] = "**".. name .."**",
        ["description"] = message,
        ["footer"] = {
        ["text"]= "CB-Development - "..os.date("%d.%m.%Y %H:%M:%S %p"),
        },
      }
    }
    PerformHttpRequest(Config.Webhooks, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = connect, avatar_url = Config.BotImage}), { ['Content-Type'] = 'application/json' })
  end
  

  function ExtractIdentifiers(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    local result = {
      steam = "Unknown Steam ID",
      discord = "Unknown Discord ID",
      license = "Unknown License",
      ip = "Unknown IP",
      xbox = "Unknown Xbox ID",
      live = "Unknown Live ID",
    }
  
    -- print out the player's identifiers
    for _, identifier in ipairs(identifiers) do
      if string.find(identifier, "steam:") then
        result.steam = string.sub(identifier, 7)
      elseif string.find(identifier, "discord:") then
        result.discord = string.sub(identifier, 9)
      elseif string.find(identifier, "license:") then
        result.license = string.sub(identifier, 9)
      elseif string.find(identifier, "ip:") then
        result.ip = string.sub(identifier, 4)
      elseif string.find(identifier, "xbl:") then
        result.xbox = string.sub(identifier, 5)
      elseif string.find(identifier, "live:") then
        result.live = string.sub(identifier, 6)
      end
    end
  
    return result
  end


RegisterServerEvent('WebhookbClientSide')
AddEventHandler('WebhookbClientSide', function(triggerName)
  local playerName = GetPlayerName(source) or "Unknown Player"
  local identifiers = ExtractIdentifiers(source)
  local discordId = identifiers.discord or "Unknown Discord ID"
  local ip = identifiers.ip or "Unknown ip"

  sendWebhook("Blacklisted Trigger use\n"..triggerName.." \n\n[PLAYER INFO]\n", "**"..playerName.. " | ID: "..source.."**\n**DISCORD :<@"..discordId..">**\n**IP :"..ip.."**", 14356753)
end)


RegisterServerEvent('WebhookLClientSide')
AddEventHandler('WebhookLClientSide', function(triggerName)
  local playerName = GetPlayerName(source) or "Unknown Player"
  local identifiers = ExtractIdentifiers(source)
  local discordId = identifiers.discord or "Unknown Discord ID"
  local ip = identifiers.ip or "Unknown ip"

  sendWebhook("Excessive Trigger use\n"..triggerName.." \n\n[PLAYER INFO]\n", "**"..playerName.. " | ID: "..source.."**\n**DISCORD :<@"..discordId..">**\n**IP :"..ip.."**", 14356753)
end)
