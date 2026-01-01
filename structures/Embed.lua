---@class Embed
---@field title string
---@field type string
---@field description string
---@field url string
---@field timestamp string
---@field color number
---@field footer table
---@field image table
---@field thumbnail table
---@field video table
---@field provider table
---@field author table
---@field fields table
---@field setTitle fun(self: Embed, title: string): Embed
---@field setDescription fun(self: Embed, description: string): Embed
---@field setUrl fun(self: Embed, url: string): Embed
---@field setColor fun(self: Embed, color: number): Embed
---@field setTimestamp fun(self: Embed, timestamp: string): Embed
---@field setFooter fun(self: Embed, text: string, iconUrl: string): Embed
---@field setImage fun(self: Embed, url: string): Embed
---@field setThumbnail fun(self: Embed, url: string): Embed
---@field setAuthor fun(self: Embed, name: string, url: string, iconUrl: string): Embed
---@field addField fun(self: Embed, name: string, value: string, inline: boolean): Embed
Embed = {}

function Embed:new(data)
    local self = data or {}
    self.fields = self.fields or {}

    self.setTitle = function(this, title)
        local t = ParseArgs(this, self, title)
        self.title = t
        return self
    end

    self.setDescription = function(this, description)
        local d = ParseArgs(this, self, description)
        self.description = d
        return self
    end

    self.setUrl = function(this, url)
        local u = ParseArgs(this, self, url)
        self.url = u
        return self
    end

    self.setColor = function(this, color)
        local c = ParseArgs(this, self, color)
        self.color = c
        return self
    end

    self.setTimestamp = function(this, timestamp)
        local t = ParseArgs(this, self, timestamp)
        self.timestamp = t or os.date("!%Y-%m-%dT%H:%M:%S")
        return self
    end

    self.setFooter = function(this, text, iconUrl)
        local t, i = ParseArgs(this, self, text, iconUrl)
        self.footer = {
            text = t,
            icon_url = i
        }
        return self
    end

    self.setImage = function(this, url)
        local u = ParseArgs(this, self, url)
        self.image = {
            url = u
        }
        return self
    end

    self.setThumbnail = function(this, url)
        local u = ParseArgs(this, self, url)
        self.thumbnail = {
            url = u
        }
        return self
    end

    self.setAuthor = function(this, name, url, iconUrl)
        local n, u, i = ParseArgs(this, self, name, url, iconUrl)
        self.author = {
            name = n,
            url = u,
            icon_url = i
        }
        return self
    end

    self.addField = function(this, name, value, inline)
        local n, v, i = ParseArgs(this, self, name, value, inline)
        self.fields[#self.fields + 1] = {
            name = n,
            value = v,
            inline = i
        }
        return self
    end

    return self
end
