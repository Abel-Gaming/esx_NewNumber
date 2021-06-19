ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_NewNumber:ChangeNumber')
AddEventHandler('esx_NewNumber:ChangeNumber', function(newnumber)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayerIdentifier = xPlayer.getIdentifier()

    print('Checking for money')

    if Config.Price <= xPlayer.getMoney() then

        MySQL.Async.execute('UPDATE users SET phone_number = @number WHERE identifier = @owner', {
            ['@number'] = newnumber,
            ['@owner'] = xPlayer.identifier
        }, function (rowsChanged)
            if rowsChanged == 0 then
                
            else
                print('Player ' .. xPlayerIdentifier .. ' has just changed their phone number to: ' .. newnumber)
            end
        end)

    else

        xPlayer.showNotification('~r~[ERROR]~w~ You do not have enough money!')

    end
end)