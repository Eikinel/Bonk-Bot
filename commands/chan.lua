local embed = require('tools/embed')
local conf = require('conf')

registerCommand({"chan"}, function(msg)
    membed = embed:new()
    
    membed:setColor(conf.colorChart.default)
    membed:setAuthor("State of command :", "", msg.client.user:getAvatarURL())
    membed:setDescription("Result of this command is ... " .. msg.client.owner.mentionString)
    membed:addField(
        "Message deleted with a lot of successful success !!")
    msg.channel:reply({embed = membed})
    msg:delete()
end)