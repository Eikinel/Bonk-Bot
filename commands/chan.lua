local log = require('../tools/log')

registerCommand({"chan", "channel"}, function(msg, args)
    local category = msg.channel.category
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
    msg:delete()
end)