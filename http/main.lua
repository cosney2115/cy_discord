---@class RequestHandler
---@field token string
---@field request fun(self: RequestHandler, method: string, endpoint: string, data?: table): promise
---@field callback fun(self: RequestHandler, interactionId: string, interactionToken: string, data: table): promise
---@field webhook fun(self: RequestHandler, applicationId: string, interactionToken: string, data: table): promise
RequestHandler = {}

local API_BASE = 'https://discord.com/api/v10'

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

local function makeRequest(url, method, data, headers)
    local p = promise.new()

    PerformHttpRequest(url, function(statusCode, responseBody)
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
        p:resolve(success and body or true)
    end, method, data and json.encode(Sanitize(data)) or "", headers)

    return p
end

function RequestHandler:new(token)
    local self = {}
    self.token = token

    local authHeaders = {
        ['Authorization'] = 'Bot ' .. token,
        ['Content-Type'] = 'application/json'
    }

    local jsonHeaders = {
        ['Content-Type'] = 'application/json'
    }

    self.request = function(this, method, endpoint, data)
        return makeRequest(API_BASE .. endpoint, method, data, authHeaders)
    end

    self.callback = function(this, interactionId, interactionToken, data)
        local url = API_BASE .. '/interactions/' .. interactionId .. '/' .. interactionToken .. '/callback'
        return makeRequest(url, 'POST', data, jsonHeaders)
    end

    self.webhook = function(this, applicationId, interactionToken, data)
        local url = API_BASE .. '/webhooks/' .. applicationId .. '/' .. interactionToken
        return makeRequest(url, 'POST', data, jsonHeaders)
    end

    return self
end
