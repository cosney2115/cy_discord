---@class Message
---@field id string
---@field content string
---@field channelId string
---@field author table
---@field components table
---@field client Client
---@field channel Channel
---@field reply fun(self: Message, content: string|table): table
Message = {}

function Message:new(data, client)
    local self = {}
    self.id = data.id
    self.content = data.content
    self.channelId = data.channel_id
    self.author = data.author
    self.components = data.components
    self.client = client

    self.channel = Channel:new({ id = self.channelId, type = 0 }, client)

    self.reply = function(this, content)
        local msgContent = content
        if this ~= self then
            msgContent = this
        end

        local body = {}
        if type(msgContent) == "string" then
            body.content = msgContent
        elseif type(msgContent) == "table" then
            body = msgContent
        end

        body.message_reference = {
            message_id = self.id
        }

        return self.channel:send(body)
    end

    return self
end
