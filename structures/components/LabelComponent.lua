---@class LabelComponent
---@field type number
---@field label string
---@field description string
---@field component table
---@field setLabel fun(self: LabelComponent, label: string): LabelComponent
---@field setDescription fun(self: LabelComponent, description: string): LabelComponent
---@field setComponent fun(self: LabelComponent, component: table): LabelComponent
LabelComponent = {}

function LabelComponent:new(data)
    local self = data or {}
    self.type = 18

    self.setLabel = function(this, label)
        local l = ParseArgs(this, self, label)
        self.label = l
        return self
    end

    self.setDescription = function(this, description)
        local d = ParseArgs(this, self, description)
        self.description = d
        return self
    end

    self.setComponent = function(this, component)
        local c = ParseArgs(this, self, component)
        self.component = c
        return self
    end

    return self
end
