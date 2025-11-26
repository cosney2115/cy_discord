Events = {}

local function toCamelCase(str)
    return str:lower():gsub("_(%w)", function(c) return c:upper() end)
end

function Events:new(client)
    self = setmetatable({}, Events)
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

        self.client.emit(eventName, payload.d)
    end

    return self
end
