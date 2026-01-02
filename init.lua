local function loadModule(path)
    local content = LoadResourceFile('cy_discord', path)
    if not content then
        return error('Failed to load: ' .. path)
    end

    local fn, err = load(content, '@cy_discord/' .. path)
    if not fn then
        return error('Failed to parse: ' .. path .. ' - ' .. err)
    end

    fn()
end

loadModule('http/main.lua')
loadModule('structures/Embed.lua')
loadModule('structures/Channel.lua')
loadModule('structures/Message.lua')
loadModule('structures/VoiceState.lua')
loadModule('structures/Interaction.lua')
loadModule('structures/components/Button.lua')
loadModule('structures/components/SelectMenu.lua')
loadModule('structures/components/ActionRow.lua')
loadModule('structures/components/TextInput.lua')
loadModule('structures/components/ModalBuilder.lua')
loadModule('client/main.lua')
loadModule('events/main.lua')
loadModule('utils/helpers.lua')
loadModule('utils/version.lua')
