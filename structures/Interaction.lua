---@class Interaction
---@field id string
---@field token string
---@field type number
---@field data table
---@field member table
---@field channelId string
---@field client Client
---@field reply fun(self: Interaction, content: string|table, ephemeral: boolean): table
---@field getOption fun(self: Interaction, name: string): any
Interaction = {}

function Interaction:new(data, client)
    local self = {}
    self.id = data.id
    self.token = data.token
    self.type = data.type
    self.data = data.data
    self.member = data.member
    self.channelId = data.channel_id
    self.client = client

    self.reply = function(this, content, ephemeral)
        local msgContent = content
        local isEphemeral = ephemeral

        if this ~= self then
            msgContent = this
            isEphemeral = content
        end

        local body = {
            type = 4,
            data = {}
        }

        if type(msgContent) == "string" then
            body.data.content = msgContent
        elseif type(msgContent) == "table" then
            body.data = msgContent
        end

        if isEphemeral then
            body.data.flags = 64
        end

        local p = promise.new()

        PerformHttpRequest('https://discord.com/api/v10/interactions/' .. self.id .. '/' .. self.token .. '/callback',
            function(statusCode, responseBody, headers)
                if statusCode < 200 or statusCode >= 300 then
                    p:reject({
                        statusCode = statusCode,
                        body = responseBody
                    })
                    return
                end

                p:resolve(true)
            end, 'POST', json.encode(body), { ['Content-Type'] = 'application/json' })

        return Citizen.Await(p)
    end

    self.getOption = function(this, name)
        local optName = name
        if this ~= self then
            optName = this
        end

        if not self.data or not self.data.options then
            return nil
        end

        for i = 1, #self.data.options do
            local option = self.data.options[i]
            if option.name == optName then
                return option.value
            end
        end
        return nil
    end

    return self
end
