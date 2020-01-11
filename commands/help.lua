local embed = require('tools/embed')
local conf = require('conf')

-- TODO: Automatiser le help en ajoutant des annotations au dessus des fonctions
registerCommand({"help", "man"}, function(msg)
    membed = embed:new()

    membed:setColor(conf.colorChart.default)
    membed:setAuthor("Liste des commandes", "", msg.client.user:getAvatarURL())
    membed:setDescription("Voici la liste de toutes les commandes que je peux effectuer, ainsi que leurs options.\n" ..
    "Pour toute question/report de problème, veuillez envoyer un message privé à " .. msg.client.owner.mentionString)
    membed:addField(
        "**1 - Bot**",
        "**" .. conf.bot.prefix .. "help, " .. conf.bot.prefix .. "man** : affiche cette bulle d'aide"
    )

    msg.author:send({embed = membed})
    msg:delete()
end)