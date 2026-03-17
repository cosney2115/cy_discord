function Sanitize(tbl)
    if type(tbl) ~= "table" then
        return tbl
    end

    local newTbl = {}
    for k, v in each(tbl) do
        if type(v) == "table" then
            newTbl[k] = Sanitize(v)
        elseif type(v) ~= "function" then
            newTbl[k] = v
        end
    end

    return newTbl
end

function ParseArgs(this, self, ...)
    if this ~= self then
        return this, ...
    end
    return ...
end

function BuildMessageBody(content)
    if type(content) == "string" then
        return {
            content = content
        }
    end
    
    local body = content or {}
    if body.components_v2 then
        body.flags = (body.flags or 0) | 32768
        body.components_v2 = nil
    end

    return body
end
