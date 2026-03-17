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

        AddEventHandler('discord:error', function(data)
            self.client.emit('onError', data)
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
        elseif eventType == "VOICE_STATE_UPDATE" then
            data = VoiceState:new(data, self.client)
        end

        self.client.emit(eventName, data)

        if eventType == "READY" then
            if #self.client.buffered_commands > 0 then
                CreateThread(function()
                    Wait(1000)
                    local success, err = pcall(function()
                        self.client:registerCommands(self.client.buffered_commands)
                    end)
                    if success then
                        print("[cy_discord] Successfully auto-registered " ..
                            #self.client.buffered_commands .. " slash commands.")
                        return
                    end

                    self.client.emit("error", "Failed to auto-register commands: " .. tostring(err))
                end)
            end
        end
    end

    return self
end
