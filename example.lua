CreateThread(function()
    local client = Client:new {
        token = GetConvar('discord_token', ""),
        guildId = GetConvar('discord_guild_id', ""),
        intents = {
            Intents.GUILD_MESSAGES,
            Intents.GUILD_MESSAGE_REACTIONS,
            Intents.GUILD_MESSAGE_TYPING,
            Intents.DIRECT_MESSAGES,
            Intents.DIRECT_MESSAGE_REACTIONS,
            Intents.DIRECT_MESSAGE_TYPING,
            Intents.MESSAGE_CONTENT
        }
    }

    client.on("ready", function(data)
        print("READY")
    end)

    client.on("messageCreate", function(data)
        print(data.content)
    end)

    client:connect()
end)
