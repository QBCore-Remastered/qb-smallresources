local cruisedSpeed = 0
local vehicleClasses = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = false,
    [14] = false,
    [15] = false,
    [16] = false,
    [17] = true,
    [18] = true,
    [19] = true,
    [20] = true,
    [21] = false
}

local function TriggerCruiseControl()
    if cruisedSpeed == 0 and cache.seat == -1 then
        cruisedSpeed = GetEntitySpeed(cache.vehicle)

        if cruisedSpeed > 0 and GetVehicleCurrentGear(cache.vehicle) > 0 then

            TriggerEvent('seatbelt:client:ToggleCruise')
            exports.qbx_core:Notify('Cruise control enabled!', 'success')

            CreateThread(function()
                while cruisedSpeed > 0 and cache.vehicle do
                    Wait(0)
                    local speed = GetEntitySpeed(cache.vehicle)
                    local turningOrBraking = IsControlPressed(2, 76) or IsControlPressed(2, 63) or IsControlPressed(2, 64)

                    if not turningOrBraking and speed < (cruisedSpeed - 1.5) then
                        cruisedSpeed = 0
                        TriggerEvent('seatbelt:client:ToggleCruise')
                        exports.qbx_core:Notify('Cruise control disabled!', 'error')
                        Wait(500)
                        break
                    end

                    if not turningOrBraking and IsVehicleOnAllWheels(cache.vehicle) and speed < cruisedSpeed then
                        SetVehicleForwardSpeed(cache.vehicle, cruisedSpeed)
                    end

                    if IsControlJustPressed(1, 246) then
                        TriggerEvent('seatbelt:client:ToggleCruise')
                        cruisedSpeed = GetEntitySpeed(cache.vehicle)
                    end

                    if IsControlJustPressed(2, 72) then
                        cruisedSpeed = 0
                        TriggerEvent('seatbelt:client:ToggleCruise')
                        exports.qbx_core:Notify('Cruise control disabled!', 'error')
                        Wait(500)
                        break
                    end
                end
            end)
        end
    end
end

RegisterCommand('togglecruise', function()
    local vehicleClass = GetVehicleClass(cache.vehicle)

    if cache.seat == -1 then
        if vehicleClasses[vehicleClass] then
            TriggerCruiseControl()
        else
            exports.qbx_core:Notify('Cruise control unavailable', 'error')
        end
    end
end, false)

RegisterKeyMapping('togglecruise', 'Toggle Cruise Control', 'keyboard', 'y')
