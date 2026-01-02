---@class ModalBuilder
---@field title string
---@field custom_id string
---@field components table
---@field setTitle fun(self: ModalBuilder, title: string): ModalBuilder
---@field setCustomId fun(self: ModalBuilder, customId: string): ModalBuilder
---@field addComponents fun(self: ModalBuilder, ...: TextInput): ModalBuilder
ModalBuilder = {}

function ModalBuilder:new(data)
    local self = data or {}
    self.components = self.components or {}

    self.setTitle = function(this, title)
        local t = ParseArgs(this, self, title)
        self.title = t
        return self
    end

    self.setCustomId = function(this, customId)
        local id = ParseArgs(this, self, customId)
        self.custom_id = id
        return self
    end

    self.addComponents = function(this, ...)
        local components = { ... }
        if this ~= self then
            components = {
                this,
                ...
            }
        end

        for i = 1, #components do
            local component = components[i]
            self.components[#self.components + 1] = {
                type = 1,
                components = {
                    component
                }
            }
        end

        return self
    end

    return self
end
