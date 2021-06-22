local extratoggle1
local extratoggle2

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            local data 
            for i,v in pairs(Config.Vehicles) do
                if GetEntityModel(vehicle) == GetHashKey(v.model) then
                    data = v
                end
            end
            if GetPedInVehicleSeat(vehicle, -1) == ped then
                if data ~= nil then
                    if GetVehicleCurrentGear(vehicle) == 0 then -- Checks if vehicle is reversing
                        if extratoggle1 == false then
                            SetVehicleExtra(vehicle, data.type.reverse, 0)
                        end
                        extratoggle1 = true
                    else
                        if extratoggle1 == true then
                            SetVehicleExtra(vehicle, data.type.reverse, 1)
                        end
                        extratoggle1 = false
                    end
                end
                if data ~= nil then
                    if GetVehicleWheelBrakePressure(vehicle) ~= 0.0 then -- Checks if vehicle is braking
                        if extratoggle2 == false then
                            SetVehicleExtra(vehicle, data.type.brake, 0)
                        end
                        extratoggle2 = true
                    else
                        if extratoggle2 == true then
                            SetVehicleExtra(vehicle, data.type.brake, 1)
                        end
                        extratoggle2 = false
                    end
                end
            end
        end
        Citizen.Wait(75)
    end
end)