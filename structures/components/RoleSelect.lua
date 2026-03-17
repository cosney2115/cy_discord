---@class RoleSelect
---@field type number
---@field custom_id string
---@field placeholder string
---@field min_values number
---@field max_values number
---@field disabled boolean
---@field default_values table
---@field setCustomId fun(self: RoleSelect, id: string): RoleSelect
---@field setPlaceholder fun(self: RoleSelect, placeholder: string): RoleSelect
---@field setMinValues fun(self: RoleSelect, min: number): RoleSelect
---@field setMaxValues fun(self: RoleSelect, max: number): RoleSelect
---@field setDisabled fun(self: RoleSelect, disabled: boolean): RoleSelect
---@field addDefaultValue fun(self: RoleSelect, id: string): RoleSelect
RoleSelect = {}

function RoleSelect:new(data)
    local self = data or {}
    self.type = 6
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

    self.addDefaultValue = function(this, id)
        local i = ParseArgs(this, self, id)
        self.default_values[#self.default_values + 1] = {
            id = i,
            type = "role"
        }
        return self
    end

    return self
end
