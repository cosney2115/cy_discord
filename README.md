# cy_discord

**A lightweight Discord wrapper for FiveM**

<p>
  <img src="https://img.shields.io/github/v/release/cosney2115/cy_discord?style=for-the-badge&color=blue" alt="Release" />
</p>

## Features

- <img src="https://img.shields.io/badge/Real--time-Fast-2ea44f?style=flat-square" valign="middle" /> Handles messages and interactions instantly
- <img src="https://img.shields.io/badge/Slash_Commands-Easy-0366d6?style=flat-square" valign="middle" /> Easy registration and handling
- <img src="https://img.shields.io/badge/Simple_API-Event--driven-f1e05a?style=flat-square" valign="middle" /> Event-driven design familiar to Discord.js users

## Quick Start

### 1. Installation

```
resources/
└── cy_discord/
    └── (place files here)
```

Add to `server.cfg`:

```cfg
ensure cy_discord

set discord_token "YOUR_BOT_TOKEN"
set discord_guild_id "YOUR_GUILD_ID"
set discord_application_id "YOUR_APPLICATION_ID"
```

### 2. Basic Usage

```lua
local client = Client:new {
    token = GetConvar('discord_token', ''),
    guildId = GetConvar('discord_guild_id', ''),
    applicationId = GetConvar('discord_application_id', ''),
    intents = { Intents.GUILD_MESSAGES, Intents.MESSAGE_CONTENT }
}

client:on('ready', function()
    print('Bot is ready!')
end)

client:connect()
```

---

## Examples

### Slash Commands

```lua
client:on('ready', function()
    client:createCommand({ name = 'ping', description = 'Pong!' })
end)

client:on('interactionCreate', function(interaction)
    if interaction.data.name == 'ping' then
        interaction:reply('Pong! 🏓', true)
    end
end)
```

### Messages

```lua
client:on('messageCreate', function(message)
    if message.author.bot then
        return
    end

    if message.content == '!hello' then
        message:reply('Hello!')
    end
end)
```

### Embeds

```lua
local embed = Embed:new()
    :setTitle("Title")
    :setDescription("Description")
    :setColor(0x5865F2)
    :addField("Field", "Value", true)
    :setTimestamp()

interaction:reply({ embeds = { embed } })
```

### Components

```lua
local row = ActionRow:new()
    :addComponent(
        Button:new()
            :setLabel("Click Me")
            :setStyle(1)
            :setCustomId("btn_click")
    )

interaction:reply({ content = "Buttons!", components = { row } })

if interaction:getCustomId() == "btn_click" then
    interaction:reply("Clicked!", true)
end
```

### Modals

```lua
local modal = ModalBuilder:new()
    :setTitle("Report")
    :setCustomId("report_modal")
    :addComponents(
        TextInput:new()
            :setCustomId("reason")
            :setLabel("Reason")
            :setStyle(TextInputStyle.Paragraph)
            :setRequired(true)
    )

interaction:showModal(modal)

if interaction:isModalSubmit() then
    local reason = interaction:getTextInputValue("reason")
    interaction:reply("Submitted: " .. reason, true)
end
```

### Role Checking

```lua
if not message:hasRole("123456789") then
    message:reply("No permission!")
    return
end

if not interaction:hasRole({ "role1", "role2" }) then
    interaction:reply("No permission!", true)
    return
end
```

### Voice Events

```lua
client:on('voiceStateUpdate', function(state)
    if state.channelId then
        print(state.userId .. " joined " .. state.channelId)
    end
end)
```

---

## Using in Other Resources

`fxmanifest.lua`:

```lua
fx_version 'cerulean'
game 'gta5'

dependency 'cy_discord'

server_scripts {
    '@cy_discord/init.lua',
    'server/main.lua'
}

lua54 'yes'
```

---

## Roadmap

- [x] Event handler
- [x] Slash commands
- [x] Messages
- [x] Embeds
- [x] Components
- [x] Voice events
- [x] Role checking
- [x] Modals
- [ ] Webhooks
