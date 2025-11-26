Message = {}

function Message:new(data, client)
    local self = {}
    self.id = data.id
    self.content = data.content
    self.channelId = data.channel_id
    self.author = data.author
    self.client = client

    self.channel = Channel:new({ id = self.channelId, type = 0 }, client)

    self.reply = function(this, content)
        local msgContent = content
        if this ~= self then
            msgContent = this
        end
        return self.channel:send(msgContent)
    end

    return self
end
