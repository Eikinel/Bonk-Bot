local discordia = require('discordia')
local log = require('tools/log')
local conf = require('conf')
require('tools/split')
require('tools/table')

local client = discordia.Client({cacheAllMembers = true})
local trigger = "?!"
local commands = {}

client:once('ready', function()
    -- List all files in /commands
    local files = io.popen("ls commands","r")

    -- Process each file and store function in commands using pcall
    for file in files:lines() do
        local f, err = loadfile("commands/" .. file)

        if not f then
            log:print("Error while loading command file : " .. err, 3)
        else
            local func, err = pcall(f)

            if not func then
                log:print("Error in pcall while parsing command files : " .. err, 3)
            end
        end
    end

    log:print('Logged in as '.. client.user.username .. " on server " .. client:getGuild(conf.guild.id).name)
end)

client:on('messageCreate', function(msg)
    if string.sub(msg.content, 0, #trigger) == trigger and
    table.contains(conf.guild.channels, msg.channel.id) then
        local sep = string.find(msg.content, " ")
        if sep then sep = sep - 1 end
        local command = string.sub(msg.content, #trigger + 1, sep)
        local args = string.sub(msg.content, #trigger + #command + 2):split(" ", true) -- true preserves quotes

        -- Execute the command if it exists
        if commands[command] then
            log:print(msg.author.tag .. " called function " .. command)
            commands[command](msg, args)
        else
            log:print(msg.author.tag .. " : command " .. command .. " does not exist", 2)
		end
    end
end)

client:on('reactionAdd', function(reaction, userId)
    local message = reaction.message
    local guild = message.guild
    local user = guild:getMember(userId)
end)


-- TOOLS FOR PROPER EVENT HANDLING

-- Security measure to not let the token hard coded
function getBotToken(filename)
    local file = io.open(filename)

    if not file then
        log:print("Cannot open file " .. filename)
        return ""
    end

    local token = file:read()

    file:close()

	return token
end

-- Register command using its name and code
function _G.registerCommand(aliases, callback)
    local name = aliases[1]

    commands[name] = function(msg, args) callback(msg, args) end
    log:print("Command '" .. name .. "' registered")

    for i = 2, #aliases do
        commands[aliases[i]] = commands[name]
        log:print("Alias '" .. aliases[i] .. "' of command '" .. name .. "' registered")
    end
end

client:run('Bot ' .. getBotToken("token.txt"))