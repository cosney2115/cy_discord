---@class Container
---@field type number
---@field accent_color number
---@field components table
---@field spoiler boolean
---@field setAccentColor fun(self: Container, color: number): Container
---@field addComponent fun(self: Container, component: table): Container
---@field setSpoiler fun(self: Container, spoiler: boolean): Container
Container = {}

function Container:new(data)
    local self = data or {}
    self.type = 17
    self.components = self.components or {}

    self.setAccentColor = function(this, color)
        local c = ParseArgs(this, self, color)
        self.accent_color = c
        return self
    end

    self.addComponent = function(this, component)
        local cmp = ParseArgs(this, self, component)
        self.components[#self.components + 1] = cmp
        return self
    end

    self.setSpoiler = function(this, spoiler)
        local s = ParseArgs(this, self, spoiler)
        self.spoiler = s
        return self
    end

    return self
end
