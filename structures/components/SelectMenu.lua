---@class SelectMenu
---@field type number
---@field custom_id string
---@field options table
---@field placeholder string
---@field min_values number
---@field max_values number
---@field disabled boolean
---@field setCustomId fun(self: SelectMenu, id: string): SelectMenu
---@field setPlaceholder fun(self: SelectMenu, placeholder: string): SelectMenu
---@field setMinValues fun(self: SelectMenu, min: number): SelectMenu
---@field setMaxValues fun(self: SelectMenu, max: number): SelectMenu
---@field setDisabled fun(self: SelectMenu, disabled: boolean): SelectMenu
---@field addOption fun(self: SelectMenu, label: string, value: string, description: string, emoji: table, default: boolean): SelectMenu
---@field setType fun(self: SelectMenu, type: number): SelectMenu
SelectMenu = {}

function SelectMenu:new(data)
    local self = data or {}
    self.type = self.type or 3
    self.options = self.options or {}

    self.setType = function(this, type)
        local t = ParseArgs(this, self, type)
        self.type = t
        return self
    end

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

    self.addOption = function(this, label, value, description, emoji, default)
        local l, v, d, e, def = ParseArgs(this, self, label, value, description, emoji, default)
        self.options[#self.options + 1] = {
            label = l,
            value = v,
            description = d,
            emoji = e,
            default = def
        }
        return self
    end

    return self
end
