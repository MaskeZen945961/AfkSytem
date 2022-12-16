
ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1000)
    end
end)

local random = nil
open = false
menuouverte = true
arrete = false
local mainMenu = RageUI.CreateMenu(AfkMaskeZen.NomduMenu, "Interaction")
mainMenu.Closed = function() 
    open = false 
end

local function openMenuCoords()
    if open then 
        open = false 
        RageUI.Visible(mainMenu, false)
        return 
    else
        open = true 
        RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while open do 
                local coords = GetEntityCoords(PlayerPedId())               
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Button("AFK", nil, {}, menuouverte, {
                        onSelected = function()
                            FreezeEntityPosition(PlayerPedId(), true)
                            TriggerServerEvent('esx:afk')
                            menuouverte = false
                            Wait(10000)
                            arrete = true
                        end
                    })
                    RageUI.Button("Stop", nil, {}, arrete, {
                        onSelected = function()
                            --Freez Player
                            FreezeEntityPosition(PlayerPedId(), false)
                            SetEntityVisible(PlayerPedId(), false)
                            SetEntityInvincible(PlayerPedId(), false)
                            TriggerServerEvent('esx:afkstop')
                            arrete = false
                            Wait(10000)
                            menuouverte = true
                        end
                    })
                end)
                Wait(0)
            end
        end)
    end
end

RegisterCommand(AfkMaskeZen.Nomdelacommande, function()
    openMenuCoords()
end, false)
