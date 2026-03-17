---@class MentionableSelect
---@field type number
---@field custom_id string
---@field placeholder string
---@field min_values number
---@field max_values number
---@field disabled boolean
---@field setCustomId fun(self: MentionableSelect, id: string): MentionableSelect
---@field setPlaceholder fun(self: MentionableSelect, placeholder: string): MentionableSelect
---@field setMinValues fun(self: MentionableSelect, min: number): MentionableSelect
---@field setMaxValues fun(self: MentionableSelect, max: number): MentionableSelect
---@field setDisabled fun(self: MentionableSelect, disabled: boolean): MentionableSelect
MentionableSelect = {}

function MentionableSelect:new(data)
    local self = data or {}
    self.type = 7

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

    return self
end
