---@class MediaGallery
---@field type number
---@field items table
---@field addItem fun(self: MediaGallery, url: string, description: string): MediaGallery
MediaGallery = {}

function MediaGallery:new(data)
    local self = data or {}
    self.type = 12
    self.items = self.items or {}

    self.addItem = function(this, url, description)
        local u, d = ParseArgs(this, self, url, description)
        self.items[#self.items + 1] = {
            media = { url = u },
            description = d
        }
        return self
    end

    return self
end
