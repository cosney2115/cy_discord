---@class Separator
---@field type number
---@field divider boolean
---@field spacing number
---@field setDivider fun(self: Separator, divider: boolean): Separator
---@field setSpacing fun(self: Separator, spacing: number): Separator
Separator = {}

function Separator:new(data)
    local self = data or {}
    self.type = 14

    self.setDivider = function(this, divider)
        local d = ParseArgs(this, self, divider)
        self.divider = d
        return self
    end

    self.setSpacing = function(this, spacing)
        local s = ParseArgs(this, self, spacing)
        self.spacing = s
        return self
    end

    return self
end
