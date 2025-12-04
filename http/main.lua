---@class RequestHandler
---@field token string
---@field request fun(self: RequestHandler, method: string, endpoint: string, data?: table): promise
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

        local function sanitize(tbl)
            if type(tbl) ~= "table" then return tbl end
            local newTbl = {}
            for k, v in pairs(tbl) do
                if type(v) == "table" then
                    newTbl[k] = sanitize(v)
                elseif type(v) ~= "function" then
                    newTbl[k] = v
                end
            end
            return newTbl
        end

        PerformHttpRequest('https://discord.com/api/v10' .. endpoint, function(statusCode, responseBody, headers)
            if statusCode < 200 or statusCode >= 300 then
                p:reject({
                    statusCode = statusCode,
                    body = responseBody
                })
                return
            end

            local success, body = pcall(json.decode, responseBody)

            if not success then
                p:reject(body)
                return
            end

            p:resolve(body)
        end, method, data and json.encode(sanitize(data)) or "", headers)

        return p
    end

    return self
end
