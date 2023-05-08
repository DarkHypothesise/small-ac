Config = {}

Config.TriggerSec = 10000 -- 10 seconds (Basic)
Config.TriggerCount = 5 -- times

Config.BlacklistedTriggers = {
    "toggleDuty",
    "admin:revive",
    -- Add more blacklisted triggers here
}

Config.LimitTrigger = {
    "testeat:hello",
    "admin:sellfood",
   -- Add more Limit Triggers here
}



Config.UseWebhooks = true -- If you don't want webhooks set this to false
Config.Webhooks = ""

Config.BotName = "CB-Development"
Config.BotImage = "https://media.discordapp.net/attachments/1098753098123591690/1099121588558909601/cb_4x.png" -- Example
