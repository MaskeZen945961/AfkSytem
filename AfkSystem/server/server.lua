ESX = nil
afkok = false
CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(1000)
    end
end)

RegisterNetEvent('esx:afk')
AddEventHandler('esx:afk', function()
    afkok = true
    sourceok = source
    ExecuteCommand('me est AFK')
    

end)

RegisterNetEvent('esx:afkstop')
AddEventHandler('esx:afkstop', function()
    afkok = false
    sourceok = source
end)


CreateThread(function()
    while true do
        Wait(600000)
        TriggerClientEvent('esx:showNotification', -1, "Fait /afk pour gagner de l'argent ! Vous avez 1 chance sur 500 de gagner 20 000$ !")

    end
end)

CreateThread(function()
    while true do
        Wait(1000)

        if afkok == true then
            while afkok == true do
                Wait(100)
                local xPlayer = ESX.GetPlayerFromId(sourceok)
                Wait(10000)
                local random = math.random(AfkMaskeZen.entre, AfkMaskeZen.et)
                if random == AfkMaskeZen.nombrechance then
                    TriggerClientEvent('esx:showNotification', -1, "Un joueur a gagné 20 000$ grace au /afk!")
                    random = AfkMaskeZen.argentgagne
                end


                xPlayer.addMoney(random)
                ExecuteCommand("me J'ai gagné "..random.."$ Grâce au /afk")
                TriggerClientEvent('esx:showNotification', sourceok, "Vous avez gagné ~g~"..random.."$")

            end
        end
    end
end)
