---@class Thumbnail
---@field type number
---@field media table
---@field spoiler boolean
---@field setMedia fun(self: Thumbnail, url: string): Thumbnail
---@field setSpoiler fun(self: Thumbnail, spoiler: boolean): Thumbnail
Thumbnail = {}

function Thumbnail:new(data)
    local self = data or {}
    self.type = 11

    self.setMedia = function(this, url)
        local u = ParseArgs(this, self, url)
        self.media = { url = u }
        return self
    end

    self.setSpoiler = function(this, spoiler)
        local s = ParseArgs(this, self, spoiler)
        self.spoiler = s
        return self
    end

    return self
end
