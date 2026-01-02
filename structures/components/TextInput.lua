---@class TextInputStyle
---@field Short number
---@field Paragraph number
TextInputStyle = {
    Short = 1,
    Paragraph = 2
}

---@class TextInput
---@field type number
---@field custom_id string
---@field style number
---@field label string
---@field min_length number
---@field max_length number
---@field required boolean
---@field value string
---@field placeholder string
---@field setCustomId fun(self: TextInput, customId: string): TextInput
---@field setStyle fun(self: TextInput, style: number): TextInput
---@field setLabel fun(self: TextInput, label: string): TextInput
---@field setMinLength fun(self: TextInput, min: number): TextInput
---@field setMaxLength fun(self: TextInput, max: number): TextInput
---@field setRequired fun(self: TextInput, required: boolean): TextInput
---@field setValue fun(self: TextInput, value: string): TextInput
---@field setPlaceholder fun(self: TextInput, placeholder: string): TextInput
TextInput = {}

function TextInput:new(data)
    local self = data or {}
    self.type = 4

    self.setCustomId = function(this, customId)
        local id = ParseArgs(this, self, customId)
        self.custom_id = id
        return self
    end

    self.setStyle = function(this, style)
        local s = ParseArgs(this, self, style)
        self.style = s
        return self
    end

    self.setLabel = function(this, label)
        local l = ParseArgs(this, self, label)
        self.label = l
        return self
    end

    self.setMinLength = function(this, min)
        local m = ParseArgs(this, self, min)
        self.min_length = m
        return self
    end

    self.setMaxLength = function(this, max)
        local m = ParseArgs(this, self, max)
        self.max_length = m
        return self
    end

    self.setRequired = function(this, required)
        local r = ParseArgs(this, self, required)
        self.required = r
        return self
    end

    self.setValue = function(this, value)
        local v = ParseArgs(this, self, value)
        self.value = v
        return self
    end

    self.setPlaceholder = function(this, placeholder)
        local p = ParseArgs(this, self, placeholder)
        self.placeholder = p
        return self
    end

    return self
end
