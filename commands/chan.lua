registerCommand({"chan"}, function(msg)
    local category = msg.channel.category
    local newChan = msg.guild:createTextChannel("channel_created")

    if (newChan) then
        msg.channel:send("Channel created")
    else
        msg.channel:send("Error while creating channel")
    end
    newChan:setCategory(category)
    msg:delete()
end)