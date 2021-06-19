ESX              = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(250)
	end
end)

Citizen.CreateThread(function()
	while not NetworkIsSessionStarted() do
		Wait(500)
	end

	while true do
		Citizen.Wait(1)
		while #(GetEntityCoords(PlayerPedId()) - Config.Location) <= 1.0 do
			Citizen.Wait(0)
			ESX.Game.Utils.DrawText3D(Config.Location, "Press ~y~[E]~s~ to change number", 0.4)
			if IsControlJustReleased(0, 51) then
				OpenMenu()
				while ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "general_menu") do
					Wait(50)
				end
			end
		end
	end
end)

if Config.EnableMarker then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1)
			DrawMarker(25, Config.Location.x, Config.Location.y, Config.Location.z - 0.98, 
			0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 0, 255, 0, 155, false, true, 2, nil, nil, false)
		end
	end)
end

Citizen.CreateThread(function()
	if Config.EnableBlip then
		local blip = AddBlipForCoord(Config.Location.x, Config.Location.y, Config.Location.z)
		SetBlipSprite (blip, Config.BlipSprite)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 1.0)
		SetBlipColour(blip, Config.BlipColor)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Change Number')
		EndTextCommandSetBlipName(blip)
	end
end)

RegisterCommand('_closeAllMenus', function()
	ESX.UI.Menu.CloseAll()
end)

function OpenMenu()	
	--Insert Items
	local options = {
		{label = "Change Number ($" .. Config.Price .. ')', value = 'change_number'}
	}

	--Open Menu
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'general_menu', {
		title = "Change Number",
		align = "left",
		elements = options
	}, function(data, menu)		
		
		if data.current.value == 'change_number' then
			
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'change_number_input', {
				title = 'Change Number'
			}, function(data2, menu2)
				ESX.ShowNotification('New Number: ~b~' .. data2.value)
				TriggerServerEvent('esx_NewNumber:ChangeNumber', data2.value)
				menu2.close()
			end, function(data2, menu2)
				menu2.close()
			end)

		end

	end,
	function(data, menu)
		menu.close()
	end)
end