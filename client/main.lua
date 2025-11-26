---@alias DiscordEvent
---| "ready"
---| "messageCreate"
---| "messageUpdate"
---| "messageDelete"
---| "messageDeleteBulk"
---| "messageReactionAdd"
---| "messageReactionRemove"
---| "messageReactionRemoveAll"
---| "messageReactionRemoveEmoji"
---| "error"

Intents = {
    GUILDS = 1,
    GUILD_MEMBERS = 2,
    GUILD_BANS = 4,
    GUILD_EMOJIS_AND_STICKERS = 8,
    GUILD_INTEGRATIONS = 16,
    GUILD_WEBHOOKS = 32,
    GUILD_INVITES = 64,
    GUILD_VOICE_STATES = 128,
    GUILD_PRESENCES = 256,
    GUILD_MESSAGES = 512,
    GUILD_MESSAGE_REACTIONS = 1024,
    GUILD_MESSAGE_TYPING = 2048,
    DIRECT_MESSAGES = 4096,
    DIRECT_MESSAGE_REACTIONS = 8192,
    DIRECT_MESSAGE_TYPING = 16384,
    MESSAGE_CONTENT = 32768,
    GUILD_SCHEDULED_EVENTS = 65536,
    AUTO_MODERATION_CONFIGURATION = 1048576,
    AUTO_MODERATION_EXECUTION = 2097152
}

---@class ClientConfig
---@field token string
---@field guildId string
---@field intents number|table

---@class Client
---@field websocket table
---@field data ClientConfig
---@field events table
---@field intents number
---@field isReady boolean
---@field on fun(event: DiscordEvent, callback: function)
---@field connect fun(): Client
---@field emit fun(event: string, ...: any)
Client = {}

---@param data ClientConfig
---@return Client
function Client:new(data)
    ---@type Client
    self = setmetatable({}, Client)
    self.websocket = nil
    self.data = data
    self.events = {}
    self.intents = 0
    self.isReady = false

    if data.intents and type(data.intents) == "table" then
        self.intents = 0
        for i = 1, #data.intents do
            self.intents = self.intents | data.intents[i]
        end
    else
        self.intents = data.intents or 513
    end

    self.eventHandler = Events:new(self)
    self.eventHandler.init()

    self.init = function()
        self.websocket = exports['cfx-discord']:WebSocketClient(
            self.data.token,
            self.data.guildId,
            self.intents
        )

        CreateThread(function()
            local success, err = pcall(function()
                local p = promise.new()
                self.websocket.connect(function(success, err)
                    if not success then
                        p:reject(err)
                        return
                    end

                    p:resolve()
                end)
                Citizen.Await(p)
            end)

            if not success then
                self.emit("error", err)
                return
            end

            self.emit("ready")
        end)

        return self
    end

    self.on = function(event, callback)
        self.events[event] = callback
    end

    self.connect = function()
        return self.init()
    end

    self.emit = function(event, ...)
        if not self.events[event] then
            return
        end

        if type(self.events[event]) ~= "function" and type(self.events[event]) ~= "table" then
            return
        end

        self.events[event](...)
    end

    return self
end

exports('new', function(data)
    return Client:new(data)
end)
