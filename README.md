# cy_discord

**A lightweight, no-nonsense Discord wrapper for FiveM.**

<p>
  <img src="https://img.shields.io/github/v/release/cosney2115/cy_discord?style=for-the-badge&color=blue" alt="Release" />
</p>

<br />

## Features

- <img src="https://img.shields.io/badge/Real--time-Fast-2ea44f?style=flat-square" valign="middle" /> Handles messages and interactions instantly.
- <img src="https://img.shields.io/badge/Slash_Commands-Easy-0366d6?style=flat-square" valign="middle" /> Easy registration and handling.
- <img src="https://img.shields.io/badge/Simple_API-Event--driven-f1e05a?style=flat-square" valign="middle" /> Event-driven design familiar to Discord.js users.

## Installation

1.  **Download**: Place `cy_discord` in your `resources` directory.
2.  **Config**: Add `ensure cy_discord` to your `server.cfg`.
3.  **Setup**: Set your bot credentials in `server.cfg`.

## Configuration

Add the following to your `server.cfg`:

```cfg
set discord_token "YOUR_BOT_TOKEN"
set discord_guild_id "YOUR_GUILD_ID"
set discord_application_id "YOUR_APPLICATION_ID"
```

## Usage

### Initialization

```lua
local client = Client:new({
    token = GetConvar('discord_token', ""),
    guildId = GetConvar('discord_guild_id', ""),
    applicationId = GetConvar('discord_application_id', ""),
    intents = {
        Intents.GUILD_MESSAGES,
        Intents.MESSAGE_CONTENT
    }
})

client:on('ready', function()
    print('Bot is ready!')
end)

client:connect()
```

### Slash Commands

```lua
-- Register command on ready
client:on('ready', function()
    client:createCommand({
        name = 'ping',
        description = 'Replies with Pong!'
    })
end)

-- Handle interactions
client:on('interactionCreate', function(interaction)
    if interaction.data.name == 'ping' then
        -- Second argument 'true' sends an ephemeral message
        interaction:reply('Pong! 🏓', true)
    end
end)
```

### Messages

```lua
client:on('messageCreate', function(message)
    if message.author.bot then return end

    if message.content == '!hello' then
        message:reply('Hello world!')
    end
end)
```

### Embeds

```lua
client:on('interactionCreate', function(interaction)
    if interaction.data.name == 'embed' then
        local embed = Embed:new()
            :setTitle("Hello World")
            :setDescription("This is an embed")
            :setColor(0x00FF00)
            :addField("Field 1", "Value 1", true)
            :addField("Field 2", "Value 2", true)
            :setFooter("Footer text", "https://picsum.photos/200")

        interaction:reply({
            embeds = { --[[ array of embeds ]]
                embed
            }
        }, false --[[ ephemeral ]])
        return
    end
end)
```

## fxmanifest

Add the following to your `fxmanifest.lua` in `server_scripts`:

```lua
server_script '@cy_discord/client/main.lua'

```

## Future Plans

- [x] Event handler
- [x] Slash commands
- [x] Message events
- [x] Embeds support (Rich messages)
- [ ] Components (Buttons, Select Menus)
- [ ] Voice channel events
- [ ] Modal support
- [ ] Permission handling
- [ ] Webhooks support
- [ ] Better error handling
