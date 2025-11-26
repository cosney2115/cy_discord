---@class RequestHandler
---@field token string
RequestHandler = {}

function RequestHandler:new(token)
    local self = {}
    self.token = token

    self.request = function(this, method, endpoint, data)
        local p = promise.new()

        local headers = {
            ['Authorization'] = 'Bot ' .. self.token,
            ['Content-Type'] = 'application/json'
        }

        PerformHttpRequest('https://discord.com/api/v10' .. endpoint, function(statusCode, responseBody, headers)
            if statusCode >= 200 and statusCode < 300 then
                local success, body = pcall(json.decode, responseBody)

                if not success then
                    p:resolve(nil)
                    return
                end

                p:resolve(body)
            else
                p:reject({
                    statusCode = statusCode,
                    body = responseBody
                })
            end
        end, method, data and json.encode(data) or "", headers)

        return p
    end

    return self
end
