---@class Button
---@field type number
---@field style number
---@field label string
---@field emoji table
---@field custom_id string
---@field url string
---@field disabled boolean
---@field setStyle fun(self: Button, style: number): Button
---@field setLabel fun(self: Button, label: string): Button
---@field setEmoji fun(self: Button, name: string, id: string, animated: boolean): Button
---@field setCustomId fun(self: Button, id: string): Button
---@field setUrl fun(self: Button, url: string): Button
---@field setDisabled fun(self: Button, disabled: boolean): Button
Button = {}

function Button:new(data)
    local self = data or {}
    self.type = 2

    self.setStyle = function(this, style)
        local s = style
        if this ~= self then s = this end
        self.style = s
        return self
    end

    self.setLabel = function(this, label)
        local l = label
        if this ~= self then l = this end
        self.label = l
        return self
    end

    self.setEmoji = function(this, name, id, animated)
        local n = name
        local i = id
        local a = animated
        if this ~= self then
            n = this
            i = name
            a = id
        end
        self.emoji = {
            name = n,
            id = i,
            animated = a
        }
        return self
    end

    self.setCustomId = function(this, id)
        local i = id
        if this ~= self then i = this end
        self.custom_id = i
        return self
    end

    self.setUrl = function(this, url)
        local u = url
        if this ~= self then u = this end
        self.url = u
        return self
    end

    self.setDisabled = function(this, disabled)
        local d = disabled
        if this ~= self then d = this end
        self.disabled = d
        return self
    end

    return self
end
