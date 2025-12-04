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
        local t = title
        if this ~= self then t = this end
        self.title = t
        return self
    end

    self.setDescription = function(this, description)
        local d = description
        if this ~= self then d = this end
        self.description = d
        return self
    end

    self.setUrl = function(this, url)
        local u = url
        if this ~= self then u = this end
        self.url = u
        return self
    end

    self.setColor = function(this, color)
        local c = color
        if this ~= self then c = this end
        self.color = c
        return self
    end

    self.setTimestamp = function(this, timestamp)
        local t = timestamp
        if this ~= self then t = this end
        self.timestamp = t or os.date("!%Y-%m-%dT%H:%M:%S")
        return self
    end

    self.setFooter = function(this, text, iconUrl)
        local t = text
        local i = iconUrl
        if this ~= self then
            t = this
            i = text
        end
        self.footer = {
            text = t,
            icon_url = i
        }
        return self
    end

    self.setImage = function(this, url)
        local u = url
        if this ~= self then u = this end
        self.image = {
            url = u
        }
        return self
    end

    self.setThumbnail = function(this, url)
        local u = url
        if this ~= self then u = this end
        self.thumbnail = {
            url = u
        }
        return self
    end

    self.setAuthor = function(this, name, url, iconUrl)
        local n = name
        local u = url
        local i = iconUrl
        if this ~= self then
            n = this
            u = name
            i = url
        end
        self.author = {
            name = n,
            url = u,
            icon_url = i
        }
        return self
    end

    self.addField = function(this, name, value, inline)
        local n = name
        local v = value
        local i = inline
        if this ~= self then
            n = this
            v = name
            i = value
        end

        self.fields[#self.fields + 1] = {
            name = n,
            value = v,
            inline = i
        }
        return self
    end

    return self
end
