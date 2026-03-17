fx_version 'cerulean'
game 'gta5'

author 'cosney'
version '1.0.8'

server_scripts {
    'websocket/*.js',
    'http/main.lua',
    'structures/Channel.lua',
    'structures/Message.lua',
    'structures/components/Button.lua',
    'structures/components/SelectMenu.lua',
    'structures/components/UserSelect.lua',
    'structures/components/RoleSelect.lua',
    'structures/components/MentionableSelect.lua',
    'structures/components/ChannelSelect.lua',
    'structures/components/TextDisplay.lua',
    'structures/components/Section.lua',
    'structures/components/Thumbnail.lua',
    'structures/components/MediaGallery.lua',
    'structures/components/FileDisplay.lua',
    'structures/components/Separator.lua',
    'structures/components/Container.lua',
    'structures/components/LabelComponent.lua',
    'structures/components/ActionRow.lua',
    'structures/components/TextInput.lua',
    'structures/components/ModalBuilder.lua',
    'structures/Interaction.lua',
    'structures/Embed.lua',
    'structures/VoiceState.lua',
    'client/*.lua',
    'events/*.lua',
    'utils/helpers.lua',
    'utils/version.lua',
    'init.lua',

    -- examples
    'examples/*.lua',
}

server_only 'yes'
lua54 'yes'

use_experimental_fxv2_oal 'yes'
