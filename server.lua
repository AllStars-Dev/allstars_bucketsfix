local ESX = exports['es_extended']:getSharedObject()

local function Debug(msg)
    if Config.Debug then
        print("^3[BUCKET FIX]^0 "..msg)
    end
end

local function IsPlayerInsideInterior(ped)

    local coords = GetEntityCoords(ped)

    if coords.z < Config.InteriorZ then
        return true
    end

    return false
end

local function FixPlayerBucket(player)

    local ped = GetPlayerPed(player)

    if not ped or ped == 0 then return end

    local bucket = GetPlayerRoutingBucket(player)

    if bucket == 0 then return end

    if IsPlayerInsideInterior(ped) then
        Debug("player "..player.." inside interior bucket "..bucket)
        return
    end

    SetPlayerRoutingBucket(player, 0)

    Debug("player "..player.." bucket fixed "..bucket.." -> 0")

end

-- verification automatique
CreateThread(function()

    while true do

        Wait(Config.CheckInterval)

        local players = GetPlayers()

        for _,player in pairs(players) do

            FixPlayerBucket(player)

        end

    end

end)

-- fix au spawn
RegisterNetEvent('qs_bucketfix:spawn', function()

    local src = source

    Wait(2000)

    FixPlayerBucket(src)

end)

-- fix au join
AddEventHandler('playerJoining', function(player)

    if not Config.ResetOnJoin then return end

    Wait(5000)

    FixPlayerBucket(player)

end)

-- commande admin self
RegisterCommand('fixbucket', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    if source ~= 0 then
        if not Config.AdminGroups[xPlayer.getGroup()] then
            return
        end
    end

    FixPlayerBucket(source)

end)

-- commande admin target
RegisterCommand('fixbucketid', function(source,args)

    local xPlayer = ESX.GetPlayerFromId(source)

    if source ~= 0 then
        if not Config.AdminGroups[xPlayer.getGroup()] then
            return
        end
    end

    local target = tonumber(args[1])

    if target then
        FixPlayerBucket(target)
    end

end)