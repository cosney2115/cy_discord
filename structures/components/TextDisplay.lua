---@class TextDisplay
---@field type number
---@field content string
---@field setContent fun(self: TextDisplay, content: string): TextDisplay
TextDisplay = {}

function TextDisplay:new(data)
    local self = data or {}
    self.type = 10

    self.setContent = function(this, content)
        local c = ParseArgs(this, self, content)
        self.content = c
        return self
    end

    return self
end
