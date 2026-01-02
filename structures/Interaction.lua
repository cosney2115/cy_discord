---@class Interaction
---@field id string
---@field token string
---@field type number
---@field data table
---@field member table
---@field channelId string
---@field client Client
---@field reply fun(self: Interaction, content: string|table, ephemeral: boolean): table
---@field showModal fun(self: Interaction, modal: ModalBuilder): boolean
---@field getOption fun(self: Interaction, name: string): any
---@field getCustomId fun(self: Interaction): string
---@field getValues fun(self: Interaction): table
---@field getTextInputValue fun(self: Interaction, customId: string): string
---@field isModalSubmit fun(self: Interaction): boolean
---@field hasRole fun(self: Interaction, roleIds: string|table): boolean
Interaction = {}

function Interaction:new(data, client)
    self = {}
    self.id = data.id
    self.token = data.token
    self.type = data.type
    self.data = data.data
    self.member = data.member
    self.channelId = data.channel_id
    self.client = client

    self.reply = function(this, content, ephemeral)
        local msgContent, isEphemeral = ParseArgs(this, self, content, ephemeral)

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
            end, 'POST', json.encode(Sanitize(body)), { ['Content-Type'] = 'application/json' })

        return Citizen.Await(p)
    end

    self.showModal = function(this, modal)
        local m = ParseArgs(this, self, modal)

        local body = {
            type = 9,
            data = {
                title = m.title,
                custom_id = m.custom_id,
                components = m.components
            }
        }

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
            end, 'POST', json.encode(Sanitize(body)), { ['Content-Type'] = 'application/json' })

        return Citizen.Await(p)
    end

    self.getOption = function(this, name)
        local optName = ParseArgs(this, self, name)

        local data = self.data
        if not data or not data.options then
            return nil
        end

        local options = data.options
        for i = 1, #options do
            local option = options[i]
            if option.name == optName then
                return option.value
            end
        end

        return nil
    end

    self.getCustomId = function()
        return self.data.custom_id
    end

    self.getValues = function()
        return self.data.values
    end

    self.isModalSubmit = function()
        return self.type == 5
    end

    self.getTextInputValue = function(this, customId)
        local id = ParseArgs(this, self, customId)

        if not self.data?.components then
            return nil
        end

        for i = 1, #self.data.components do
            local row = self.data.components[i]
            if row.components then
                for j = 1, #row.components do
                    local component = row.components[j]
                    if component.custom_id == id then
                        return component.value
                    end
                end
            end
        end

        return nil
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
