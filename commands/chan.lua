local embed = require('tools/embed')
local conf = require('conf')

registerCommand({"chan"}, function(msg)
    msg:delete()
    membed = embed:new()

    membed:setColor(conf.colorChart.default)
    membed:setAuthor("State of command :", "", msg.client.user:getAvatarURL())
    membed:setDescription("Le resultat de cette commande est... " .. msg.client.owner.mentionString)
    membed:addField(
    "Message deleted with a lot of successful success !!"
    Message.channel:send({embed = membed})
end)