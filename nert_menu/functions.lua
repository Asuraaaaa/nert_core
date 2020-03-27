function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle

    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)  
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        
        offset = offset - 1

        if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    
    if distance > 3000 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

RegisterNetEvent('nert:flipVehicle')
AddEventHandler('nert:flipVehicle', function()
    local finished = exports["nert_taskbar"]:taskBar(5000,"Flipping Vehicle Over",false,true) 
    if finished == 100 then
        local playerped = PlayerPedId()
        local coordA = GetEntityCoords(playerped, 1)
        local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
        local targetVehicle = getVehicleInDirection(coordA, coordB)
        SetVehicleOnGroundProperly(targetVehicle)
    end
end)

