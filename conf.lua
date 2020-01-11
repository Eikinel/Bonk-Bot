-- Global conf for all guilds
local conf = {}
conf.__index = conf

conf.folders = {
    commands = "commands/",
    tools = "tools/"
}

conf.guild = {
    id = "663798033669947423",
    channels = { "663801770933354506" }
}

conf.bot = {
    prefix = "'-'",
    colors = {
        default = 0xC8C846
    }
}

return conf