---Disables auto seat switching
---@param seatIndex number
local function disableAutoShuffle(seatIndex)
    SetPedConfigFlag(cache.ped, 184, true)

    if cache.vehicle and not cache.seat then
        SetPedIntoVehicle(cache.ped, cache.vehicle, seatIndex)
    end
end

lib.onCache('seat', disableAutoShuffle)

---Makes the player ped shuffle to the next vehicle seat. 
local function shuffleSeat(self)
    self:disable(true)
    if cache.vehicle and cache.seat then
        TaskShuffleToNextVehicleSeat(cache.ped, cache.vehicle)
        repeat
            Wait(0)
        until not GetIsTaskActive(cache.ped, 165)
    end
    self:disable(false)
end

lib.addKeybind({
    name = 'shuffleSeat',
    description = '',
    defaultKey = 'O',
    onPressed = shuffleSeat
})
