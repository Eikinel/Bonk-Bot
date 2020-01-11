local log = require('tools/log')
local conf = require('conf')
require('tools/table')

local function create(msg, name)
    local channel = msg.guild:createTextChannel(name)
    local category = msg.guild.categories:find(function(c) return c.name == conf.guild.categoryName end)

    if not category then category = msg.guild:createCategory(conf.guild.categoryName) end
    channel:setCategory(category.id)
    msg.channel:send("Nouveau channel créé ! Cliquez pour rejoindre <#" .. channel.id .. ">.")
end

local function delete(msg, tag)
    local category = msg.guild.categories:find(function(c) return c.name == conf.guild.categoryName end)
    if not category then msg.channel:send("La catégorie " .. conf.guild.categoryName .. " n'existe pas.") return end
    local channel = category.textChannels:find(function(c) return c.name == tag or c.id == tag end)
    if not channel then msg.channel:send("Le channel " .. tag .. " n'existe pas.") return end

    channel:delete()
    msg.channel:send("Channel #" .. channel.name .. " supprimé.")

    -- MAKES DISCORD CRASH !!
    -- if #category.textChannels == 0 then category:delete() end
end

registerCommand({"chan", "channel"}, function(msg, args)
    local action, name = unpack(args)
    local fn = {
        create = create,
        delete = delete
    }

    if #args > 1 and fn[action] then
        fn[action](msg, name)
    end

    --[[local category = msg.channel.category
    local guild = msg.guild
    
    if (args[1] == "create" and args[2]) then
        local newChan = msg.guild:createTextChannel(args[2])
        newChan:setCategory(category)
        msg.channel:send("Channel created")
    elseif (args[1] == "delete" and args[2]) then
        local chan = guild:getChannel(args[2])
        msg.channel:send("Deleted channel \"".. chan.name .. "")
        chan:delete()
    end
    --remove next line after debug
    msg:delete()]]--
end)