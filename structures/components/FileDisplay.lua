---@class FileDisplay
---@field type number
---@field file table
---@field spoiler boolean
---@field setFile fun(self: FileDisplay, url: string): FileDisplay
---@field setSpoiler fun(self: FileDisplay, spoiler: boolean): FileDisplay
FileDisplay = {}

function FileDisplay:new(data)
    local self = data or {}
    self.type = 13

    self.setFile = function(this, url)
        local u = ParseArgs(this, self, url)
        self.file = { url = u }
        return self
    end

    self.setSpoiler = function(this, spoiler)
        local s = ParseArgs(this, self, spoiler)
        self.spoiler = s
        return self
    end

    return self
end
