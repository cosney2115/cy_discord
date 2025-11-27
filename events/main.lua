Events = {}

local function toCamelCase(str)
    return str:lower():gsub("_(%w)", function(c) return c:upper() end)
end

function Events:new(client)
    local self = setmetatable({}, Events)
    self.client = client

    self.init = function()
        AddEventHandler('discord:message', function(payload)
            self.handleMessage(payload)
        end)
    end

    self.handleMessage = function(payload)
        if not payload or payload.op ~= 0 then
            return
        end

        local eventType = payload.t
        local eventName = toCamelCase(eventType)

        if eventType == "READY" then
            self.client.isReady = true
        end

        local data = payload.d
        if eventType == "MESSAGE_CREATE" then
            data = Message:new(data, self.client)
        elseif eventType == "INTERACTION_CREATE" then
            data = Interaction:new(data, self.client)
        end

        self.client.emit(eventName, data)
    end

    return self
end
