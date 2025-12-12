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
        local t = type
        if this ~= self then t = this end
        self.type = t
        return self
    end

    self.setCustomId = function(this, id)
        local i = id
        if this ~= self then i = this end
        self.custom_id = i
        return self
    end

    self.setPlaceholder = function(this, placeholder)
        local p = placeholder
        if this ~= self then p = this end
        self.placeholder = p
        return self
    end

    self.setMinValues = function(this, min)
        local m = min
        if this ~= self then m = this end
        self.min_values = m
        return self
    end

    self.setMaxValues = function(this, max)
        local m = max
        if this ~= self then m = this end
        self.max_values = m
        return self
    end

    self.setDisabled = function(this, disabled)
        local d = disabled
        if this ~= self then d = this end
        self.disabled = d
        return self
    end

    self.addOption = function(this, label, value, description, emoji, default)
        local l = label
        local v = value
        local d = description
        local e = emoji
        local def = default

        if this ~= self then
            l = this
            v = label
            d = value
            e = description
            def = emoji
        end

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
