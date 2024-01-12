Config = {
  autoAddItems = true, --## Automatically add items to the database or shared.lua (DOESNT WORK WITH OX)
  -- Name Change Agreement
  signTime    = 10,                                                --## Time in seconds to sign the agreement
  item        = "name_change_agreement",                           --## Change this if you want the name of the item to be different
  label       = "Name Change Agreement",                           --## USED FOR AUTOADD METHOD ONLY
  weight      = 1000,                                              --## USED FOR AUTOADD METHOD ONLY
  description = "A document that allows you to change your name.", --## USED FOR AUTOADD METHOD ONLY
  
  maxFirstName = 16, --## MAX LENGTH OF FIRST NAME
  maxLastName  = 16, --## MAX LENGTH OF LAST NAME

  allowedJobs = { --## JOBS ALLOWED TO USE THE ITEM
    police = true,
  }
}

Core, Settings = exports['dirk-core']:getCore();
