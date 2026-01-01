---@class Message
---@field id string
---@field content string
---@field channelId string
---@field author table
---@field member table
---@field components table
---@field client Client
---@field channel Channel
---@field reply fun(self: Message, content: string|table): table
---@field hasRole fun(self: Message, roleIds: string|table): boolean
Message = {}

function Message:new(data, client)
    self = {}
    self.id = data.id
    self.content = data.content
    self.channelId = data.channel_id
    self.author = data.author
    self.member = data.member
    self.components = data.components
    self.client = client

    self.channel = Channel:new({ id = self.channelId, type = 0 }, client)

    self.reply = function(this, content)
        local msgContent = ParseArgs(this, self, content)

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

    self.hasRole = function(this, roleIds)
        local ids = ParseArgs(this, self, roleIds)

        if not self.member?.roles then
            return false
        end

        if type(ids) ~= "table" then
            ids = { ids }
        end

        for i = 1, #self.member.roles do
            for j = 1, #ids do
                if self.member.roles[i] == ids[j] then
                    return true
                end
            end
        end

        return false
    end

    return self
end
