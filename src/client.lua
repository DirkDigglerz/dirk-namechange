onReady(function()
  if not Settings.Inventory then Core, Settings = exports['dirk-core']:getCore(); end
  if Settings.Inventory == "ox_inventory" then
    local oxInv = exports.ox_inventory
    oxInv:displayMetadata({
      firstname = Labels.FirstName,
      lastname  = Labels.LastName,
    })
  end
end)


local clearArea = function()
  local myPos = GetEntityCoords(cache.ped)
  local objectPool = GetGamePool("CObject")
  for i = 1, #objectPool do
    local object = objectPool[i]
    if DoesEntityExist(object) then
      local model = GetEntityModel(object)
      local pos = GetEntityCoords(object)
      local dist = #(pos - myPos)
      if dist <= 1.5 then
        local clipboard = GetHashKey("p_cs_clipboard")
        if model == clipboard then
          SetEntityAsMissionEntity(object, true, true)
          DeleteEntity(object)
        end
      end
    end
  end
end

lib.callback.register("dirk-namechange:client:getname", function(id)
  lib.closeInputDialog()
  TaskStartScenarioInPlace(cache.ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
  local input = lib.inputDialog("Enter your new name", {
    {type = "input", description = Labels.FirstName, value = "", maxlength = Config.maxFirstName, required = true},
    {type = "input", description = Labels.LastName,  value = "", maxlength = Config.maxLastName, required = true},
  })

  if input then
    Core.UI.ProgressBar({
      time  = Config.signTime * 1000,
      label =  Labels.Signing,
      usewhileDead = false,
      canCancel = false,
      disableControl = true,
    })
  end

  ClearPedTasks(cache.ped)
  clearArea()

  if not input then return end
  for k, v in pairs(input) do
    if not v then return end
  end
  return input
end)

RegisterNetEvent("dirk-namechange:client:sign" , function()
  TaskStartScenarioInPlace(cache.ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
  Core.UI.ProgressBar({
    time  = Config.signTime * 1000,
    label =  Labels.Signing,
    usewhileDead = false,
    canCancel = false,
    disableControl = true,
  })

  ClearPedTasks(cache.ped)
  clearArea()
end)
