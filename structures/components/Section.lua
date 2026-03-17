---@class Section
---@field type number
---@field components table
---@field accessory table
---@field addComponent fun(self: Section, component: table): Section
---@field setAccessory fun(self: Section, accessory: table): Section
Section = {}

function Section:new(data)
    local self = data or {}
    self.type = 9
    self.components = self.components or {}

    self.addComponent = function(this, component)
        local cmp = ParseArgs(this, self, component)
        self.components[#self.components + 1] = cmp
        return self
    end

    self.setAccessory = function(this, accessory)
        local acc = ParseArgs(this, self, accessory)
        self.accessory = acc
        return self
    end

    return self
end
