ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

AddEventHandler('playerSpawned', function()
    isDead = false
end)

AddEventHandler('esx:onPlayerDeath', function(data)
    isDead = true
end)

--[[
    Menu job check: 
    return not isDead and PlayerData.job.name == 'police'
]]

rootMenuConfig =  {
    {
        id = "general",
        displayName = "General",
        icon = "#globe-europe",
        enableMenu = function()
            return not isDead
        end,
        subMenus = { "general:flipvehicle" }
    },
    {
        id = "blips",
        displayName = "Blips",
        icon = "#blips",
        enableMenu = function()
            return not isDead
        end,
        subMenus = { "blips:garages", "blips:barbershop", "blips:tattooshop"}
    },
    {
        id = "vehicle",
        displayName = "Vehicle",
        icon = "#vehicle-options-vehicle",
        functionName = "veh:options",
        enableMenu = function()
            return (not isDead and IsPedInAnyVehicle(PlayerPedId(), false))
        end
    }
}

newSubMenus = {
	--[[
		General
	]]
    ['general:flipvehicle'] = {
        title = "Flip Vehicle",
        icon = "#general-flip-vehicle",
        functionName = "nert:flipVehicle"
    },
    --[[
		Blips
	]]
    ['blips:gasstations'] = {
        title = "Gas Stations",
        icon = "#blips-gasstations",
        functionName = "CarPlayerHud:ToggleGas"
    },
    ['blips:garages'] = {
        title = "Garages",
        icon = "#blips-garages",
        functionName = "nert_garage:ToggleGarageBlip"
    },
    ['blips:barbershop'] = {
        title = "Barber Shop",
        icon = "#blips-barbershop",
        functionName = "nert_base:ToggleHairBlip"
    },    
    ['blips:tattooshop'] = {
        title = "Tattoo Shop",
        icon = "#blips-tattooshop",
        functionName = "nert_base:ToggleTattooBlip"
    }
}