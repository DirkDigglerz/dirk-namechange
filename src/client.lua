local oxInv = exports.ox_inventory
if oxInv then
  oxInv:displayMetadata({
    firstname = Labels.FirstName,
    lastname  = Labels.LastName,
  })
end

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
    {type = "input", description = Labels.FirstName, value = "", maxlength = 20, required = true},
    {type = "input", description = Labels.LastName,  value = "", maxlength = 20, required = true},
  })

  ClearPedTasks(cache.ped)
  clearArea()

  if not input then return end
  for k, v in pairs(input) do
    if not v then return end
  end

  return input
end)