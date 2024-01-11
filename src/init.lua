onReady = function(func)
  CreateThread(function()
    while not Core do Wait(500); end
    func()
  end)
end