---@class ActionRow
---@field type number
---@field components table
---@field addComponent fun(self: ActionRow, component: Button|SelectMenu): ActionRow
ActionRow = {}

function ActionRow:new(data)
    local self = data or {}
    self.type = 1
    self.components = self.components or {}

    self.addComponent = function(this, component)
        local c = ParseArgs(this, self, component)
        self.components[#self.components + 1] = c
        return self
    end

    return self
end
