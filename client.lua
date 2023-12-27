



-- ============= Phone Booth Script

local isNearPB = false
local isCalling = false
local currentCall = nil
local currentCash = 0

RegisterNetEvent('phonebooth:receiveCall')
AddEventHandler('phonebooth:receiveCall', function(caller, number, duration)
    local playerPed = PlayerPedId()
    if not isCalling then
        isCalling = true
        PhonePlayCall(true)
        TriggerEvent('qb-phone:receiveCall', caller, number, duration)
    end
end)

RegisterNetEvent('phonebooth:endCall')
AddEventHandler('phonebooth:endCall', function()
    isCalling = false
    PhonePlayCall(false)
    TriggerEvent('qb-phone:endCall')
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local ped = PlayerPedId()
        local pbObj, pbDistance = FindNearestPB()

        if not isCalling and (isNearPB and pbDistance < 2.0) then
            local pbCoords = QBCore.Functions.GetCoords(isNearPB)

            if IsPedInAnyVehicle(ped) and QBCore.Functions.GetPedInVehicleSeat(QBCore.Functions.GetVehiclePedIsIn(ped), -1) == ped then
                DrawText3Ds(pbCoords.x, pbCoords.y, pbCoords.z + 1.2, "Exit Vehicle To Use Phone Booth")
            else
                DrawText3Ds(pbCoords.x, pbCoords.y, pbCoords.z + 1.5, "Press ~g~E~w~ To Use Phone Booth")

                if IsControlJustReleased(0, 38) then
                    if currentCash > 0 then
                        QBCore.Functions.HasItem("phone", function(hasPhone)
                            if hasPhone == false then
                                openPhoneBoothMenu(isNearPB)
                            else
                                QBCore.Functions.Notify('You\'re already have a ~r~Handphone~s~, Use your Phone')
                            end
                        end)
                    else
                        QBCore.Functions.Notify('Not Enough Money To Send Message!')
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(250)

        if isCalling then
            local playerPed = PlayerPedId()
            local pulse = GetDistanceBetweenCoords(GetEntityCoords(playerPed), GetEntityCoords(isNearPB))
            TriggerEvent('countPulse', pulse, playerPed)
        end
    end
end)

function openPhoneBoothMenu(isNearPB)
    local elements = {}
    local menuData = {}

    elements = {
        { label = "Police", value = "police" },
        { label = "Ambulance", value = "ambulance" },
        { label = "Mechanic", value = "mecano" },
        { label = "Send SMS", value = "othersms" },
        { label = "Call Number", value = "othercall" },
    }

    menuData = {
        title = "Select to Call",
        align = "top-left",
        elements = elements
    }

    CreateMenu(menuData, isNearPB)
end

function CreateMenu(menuData, isNearPB)
    if isNearPB then
        QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'phone_booth_menu', menuData, function(data, menu)
            if data.current.value == "police" then
                TriggerServerEvent('phonebooth:makecall', 'police')
            elseif data.current.value == "ambulance" then
                menu.Close()
                TriggerServerEvent('phonebooth:makecall', 'ambulance')
            elseif data.current.value == "mecano" then
                menu.Close()
                TriggerServerEvent('phonebooth:makecall', 'mecano')
            elseif data.current.value == "othersms" then data.current.value = "othercall"
                local otherNumber = KeyboardInput("Enter Phone Number:", "", 10)
                TriggerServerEvent('phonebooth:makecall', otherNumber)
            end
        end, function(data, menu)
            menu.Close()
        end)
end

function PhonePlayCall(isCalling)
    if isCalling then
        QBCore.Functions.PlaySound(QBCore.Shared.Sounds.Calling, 'Phone')
    else
        QBCore.Functions.StopSound(QBCore.Shared.Sounds.Calling, 'Phone')
    end
end

function FindNearestPB()
    local ped = PlayerPedId()
    local closestObject, closestDistance = nil, 999999.0

    for _, object in pairs(QBCore.Functions.GetAllObjects()) do
        if object.model == "prop_phonebox_04" then
            local distance = GetDistanceBetweenCoords(GetEntityCoords(object), GetEntityCoords(ped))

            if distance < closestDistance then
                closestObject = object
                closestDistance = distance
            end
        end
    end

    return closestObject, closestDistance
end
end
           

