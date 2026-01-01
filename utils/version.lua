CreateThread(function()
    PerformHttpRequest('https://api.github.com/repos/cosney2115/cy_discord/releases/latest', function(status, response)
        if status ~= 200 then
            return
        end

        local data = json.decode(response)
        if not data?.tag_name then
            return
        end

        local latest = data.tag_name:gsub('v', '')
        local currentVersion = GetResourceMetadata('cy_discord', 'version', 0)

        if latest == currentVersion then
            return
        end

        print('New version available: v' .. latest .. ' (current: v' .. currentVersion .. ')')
        print('Download: https://github.com/cosney2115/cy_discord/releases/latest')
    end, 'GET', '')
end)
