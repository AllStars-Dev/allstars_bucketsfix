AddEventHandler('playerSpawned', function()

    TriggerServerEvent('qs_bucketfix:spawn')

end)

-- securite supplementaire
CreateThread(function()

    while true do

        Wait(30000)

        if NetworkIsSessionStarted() then
            TriggerServerEvent('qs_bucketfix:spawn')
        end

    end

end)