CreateThread(function()
    local client = Client:new {
        token = GetConvar('discord_token', ""),
        guildId = GetConvar('discord_guild_id', ""),
        applicationId = GetConvar('discord_application_id', ""),
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

    client:on("ready", function()
        print("Bot is ready!")

        -- slash commands
        client:createCommand({
            name = "ping",
            description = "Pong!",
        })

        client:createCommand({
            name = "say",
            description = "Say something",
            options = {
                {
                    name = "message",
                    description = "The message to say",
                    type = OptionType.STRING,
                    required = true
                },
                {
                    name = "channel",
                    description = "The channel to send the message to",
                    type = OptionType.CHANNEL,
                    required = true
                }
            }
        })

        client:createCommand({
            name = "embed",
            description = "Send an embed"
        })
    end)

    client:on("interactionCreate", function(interaction)
        if interaction.data.name == "ping" then
            interaction:reply("Pong!", true)
            return
        end

        if interaction.data.name == "say" then
            local message = interaction:getOption("message")
            local channelId = interaction:getOption("channel")
            local channel = client:getChannel(channelId)

            channel:send(message)
            interaction:reply("Message sent!", true)
            return
        end

        if interaction.data.name == "embed" then
            local embed = Embed:new()
                :setTitle("Hello World")
                :setDescription("This is an embed")
                :setColor(0x00FF00)
                :addField("Field 1", "Value 1", true)
                :addField("Field 2", "Value 2", true)
                :setFooter("Footer text", "https://picsum.photos/200")

            interaction:reply({
                embeds = {
                    embed
                }
            }, false)
            return
        end
    end)

    -- Can use commands like that or ^ with interactionCreate
    client:on("messageCreate", function(message)
        if message.author.bot then return end

        -- !ping
        if message.content == '!ping' then
            message:reply("Pong!")
        end

        -- !say <channel_id> <message>
        if string.sub(message.content, 1, 5) == "!say " then
            local args = {}
            for substring in message.content:gmatch("%S+") do
                args[#args + 1] = substring
            end

            local channelId = args[2]
            local content = string.sub(message.content, #args[1] + #args[2] + 3)

            if not channelId or not content or content == "" then
                message:reply("Usage: !say <channel_id> <message>")
                return
            end

            local channel = client:getChannel(channelId)
            local success, err = pcall(function()
                channel:send(content)
            end)

            if not success then
                message:reply("Failed to send message: " .. tostring(err))
                return
            end

            message:reply("Message sent!")
        end

        -- !revive <player_id>
        if string.sub(message.content, 1, 7) == '!revive' then
            local playerId = string.sub(message.content, 8)

            local isPlayerExist = GetPlayerPed(playerId)
            if isPlayerExist == 0 or not isPlayerExist then
                message:reply("Player not found!")
                return
            end

            local success, err = pcall(function()
                -- example trigger
                TriggerClientEvent('esx_ambulancejob:revive', playerId)
            end)

            if not success then
                message:reply("Failed to revive player: " .. tostring(err))
                return
            end

            message:reply("Revived player!")
        end
    end)

    client:connect()
end)
