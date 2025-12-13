---@class VoiceState
---@field guildId string
---@field channelId string?
---@field userId string
---@field member table?
---@field sessionId string
---@field deaf boolean
---@field mute boolean
---@field selfDeaf boolean
---@field selfMute boolean
---@field selfVideo boolean
---@field suppress boolean
---@field requestToSpeakTimestamp string?
---@field client Client
VoiceState = {}

function VoiceState:new(data, client)
    local self = {}
    self.guildId = data.guild_id
    self.channelId = data.channel_id
    self.userId = data.user_id
    self.member = data.member
    self.sessionId = data.session_id
    self.deaf = data.deaf
    self.mute = data.mute
    self.selfDeaf = data.self_deaf
    self.selfMute = data.self_mute
    self.selfVideo = data.self_video
    self.suppress = data.suppress
    self.requestToSpeakTimestamp = data.request_to_speak_timestamp
    self.client = client

    return self
end
