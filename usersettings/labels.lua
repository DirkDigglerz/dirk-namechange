Labels = {
  ENG = {
    NameChanged = "Your name has been changed to %s %s",
    FirstName   = "First Name",
    LastName    = "Last Name",
  },
} 

setmetatable(Labels, {
  __index = function(t, label)
    local lang = Settings.Language
    return Labels[lang][label] or label
  end
})
