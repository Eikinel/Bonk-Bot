registerCommand({"chan"}, function(msg)
    msg:delete()
    Message.channel:send("Message deleted with a lot of successful success")
end)