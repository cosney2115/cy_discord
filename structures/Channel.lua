---@class Channel
---@field id string
---@field type number
---@field client Client
---@field send fun(self: Channel, content: string|table): table
Channel = {}

function Channel:new(data, client)
    local self = {}
    self.id = data.id
    self.type = data.type
    self.client = client

    self.send = function(this, content)
        local body = {}
        local msgContent = content

        if this ~= self then
            msgContent = this
        end

        if type(msgContent) == "string" then
            body.content = msgContent
        elseif type(msgContent) == "table" then
            body = msgContent
        end

        local p = promise.new()

        self.client.rest:request('POST', '/channels/' .. self.id .. '/messages', body)
            :next(function(data)
                p:resolve(data)
            end, function(err)
                p:reject("Discord API Error: " .. tostring(err.statusCode) .. " - " .. tostring(err.body))
            end)

        return Citizen.Await(p)
    end

    return self
end
