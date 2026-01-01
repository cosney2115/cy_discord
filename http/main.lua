---@class RequestHandler
---@field token string
---@field request fun(self: RequestHandler, method: string, endpoint: string, data?: table): promise
RequestHandler = {}

local errorMessages = {
    [400] = "Bad Request",
    [401] = "Unauthorized - check your bot token",
    [403] = "Forbidden - bot lacks permissions",
    [404] = "Not Found - invalid channel/resource ID",
    [429] = "Rate Limited - too many requests",
    [500] = "Discord Server Error",
    [502] = "Discord Gateway Error",
    [503] = "Discord Service Unavailable"
}

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
            if statusCode < 200 or statusCode >= 300 then
                local errorMsg = errorMessages[statusCode] or "Unknown Error"
                local details = ""

                local success, parsed = pcall(json.decode, responseBody)
                if success and parsed then
                    if parsed.message then
                        details = parsed.message
                    end
                    if parsed.code then
                        details = details .. " (code: " .. parsed.code .. ")"
                    end
                end

                p:reject({
                    statusCode = statusCode,
                    message = errorMsg,
                    details = details,
                    body = responseBody
                })
                return
            end

            local success, body = pcall(json.decode, responseBody)

            if not success then
                p:reject({
                    statusCode = 0,
                    message = "JSON Parse Error",
                    details = tostring(body),
                    body = responseBody
                })
                return
            end

            p:resolve(body)
        end, method, data and json.encode(Sanitize(data)) or "", headers)

        return p
    end

    return self
end
