---@class ChannelSelect
---@field type number
---@field custom_id string
---@field placeholder string
---@field min_values number
---@field max_values number
---@field disabled boolean
---@field channel_types table
---@field default_values table
---@field setCustomId fun(self: ChannelSelect, id: string): ChannelSelect
---@field setPlaceholder fun(self: ChannelSelect, placeholder: string): ChannelSelect
---@field setMinValues fun(self: ChannelSelect, min: number): ChannelSelect
---@field setMaxValues fun(self: ChannelSelect, max: number): ChannelSelect
---@field setDisabled fun(self: ChannelSelect, disabled: boolean): ChannelSelect
---@field addChannelType fun(self: ChannelSelect, channelType: number): ChannelSelect
---@field addDefaultValue fun(self: ChannelSelect, id: string): ChannelSelect
ChannelSelect = {}

function ChannelSelect:new(data)
    local self = data or {}
    self.type = 8
    self.channel_types = self.channel_types or {}
    self.default_values = self.default_values or {}

    self.setCustomId = function(this, id)
        local i = ParseArgs(this, self, id)
        self.custom_id = i
        return self
    end

    self.setPlaceholder = function(this, placeholder)
        local p = ParseArgs(this, self, placeholder)
        self.placeholder = p
        return self
    end

    self.setMinValues = function(this, min)
        local m = ParseArgs(this, self, min)
        self.min_values = m
        return self
    end

    self.setMaxValues = function(this, max)
        local m = ParseArgs(this, self, max)
        self.max_values = m
        return self
    end

    self.setDisabled = function(this, disabled)
        local d = ParseArgs(this, self, disabled)
        self.disabled = d
        return self
    end

    self.addChannelType = function(this, channelType)
        local ct = ParseArgs(this, self, channelType)
        self.channel_types[#self.channel_types + 1] = ct
        return self
    end

    self.addDefaultValue = function(this, id)
        local i = ParseArgs(this, self, id)
        self.default_values[#self.default_values + 1] = {
            id = i,
            type = "channel"
        }
        return self
    end

    return self
end
