local setName = function(id, data, slot)
  TriggerClientEvent("dirk-namechange:client:sign", id)
  SetTimeout(Config.signTime * 1000, function()
    Core.Player.UpdateInfo(id, "firstname", data.firstname)
    Core.Player.UpdateInfo(id, "lastname", data.lastname)
    Core.UI.Notify(id, string.format(Labels.NameChanged, data.firstname, data.lastname))
    Core.Player.RemoveItem(id, Config.item, 1, data, slot)
  end)
end

local getMetadata = function(item,extra,mf)
  local metadata = false
  if not Settings.Inventory then Core, Settings = exports['dirk-core']:getCore(); end
  if Settings.Inventory == "mf-inventory" then
    metadata = mf.metadata
  elseif type(item) == "table" and item.info or item.metadata then
    if item.info and type(item.info) == 'table' then metadata = item.info end
    if item.metadata and type(item.metadata) == 'table' then metadata = item.metadata; end
  elseif type(extra) == 'table' and extra.info or extra.metadata then
    if extra.info and type(extra.info) == 'table' then metadata = extra.info; end
    if extra.metadata and type(extra.metadata) == 'table' then metadata = extra.metadata; end
  end
  return metadata
end

local getName = function(id)
  local data = lib.callback.await("dirk-namechange:client:getname", id)
  if not data then return end
  if not (data[1] and data[2]) then return end
  return {firstname = data[1], lastname = data[2]}
end

onReady(function()
  Core.Inventory.UseableItem(Config.item, function(source, item, extra, mf)
    local metadata = getMetadata(item, extra, mf)
    if not next(metadata) and Config.allowedJobs[Core.Player.GetJob(source).name] then
      local name = getName(source)
      if not name then return end
      Core.UI.Notify(source, Labels.Signed)
      Core.Player.EditItemMetadata(source, item.slot, {firstname = name.firstname, lastname = name.lastname})
      return
    end
    setName(source, metadata, item.slot)
  end)

  local itemsToAdd = {}
  itemsToAdd[Config.item] = {
    ['name']        = Config.item, 
    ['label']       = Config.label, 
    ['weight']      = Config.weight, 
    ['type']        = "item", 
    ['image']       = string.format("%s.png", Config.item), 
    ['unique']      = true, 
    ['stackable']   = false,
    ['useable']     = true, 
    ['shouldClose'] = true, 
    ['combinable']  = nil, 
    ['description'] = Config.description,
  }

  local qbFormat = Core.Files.TableToText(itemsToAdd)
  local esxFormat = Core.Files.TableToSQL(itemsToAdd)
  local oxFormat = Core.Files.TableToText(Core.Files.OXShared(itemsToAdd))
  -- QB LAYOUT
  SaveResourceFile(GetCurrentResourceName(), "INSTALLATION/itemsToAdd/qb_items.lua", qbFormat)
  -- ESX LAYOUT
  SaveResourceFile(GetCurrentResourceName(), "INSTALLATION/itemsToAdd/esx_items.sql", esxFormat)
  -- OX LAYOUT
  SaveResourceFile(GetCurrentResourceName(), "INSTALLATION/itemsToAdd/ox_items.lua", oxFormat)
  if Config.autoAddItems then
    Core.AddAllItems(itemsToAdd)
  end
end)

