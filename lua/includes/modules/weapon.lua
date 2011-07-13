--========== Copyleft � 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose: Scripted weapon implementation.
--
--===========================================================================--

_BASE_WEAPON = "weapon_hl2mpbase_scriptedweapon"

local table = table
local Warning = Warning

module( "weapon" )

local tWeapons = {}

-------------------------------------------------------------------------------
-- Purpose: Returns a weapon table
-- Input  : strName - Name of the weapon
-- Output : table
-------------------------------------------------------------------------------
function Get( strClassname )
  local tWeapon = tWeapons[ strClassname ]
  if ( not tWeapon ) then
    return nil
  end
  tWeapon = table.copy( tWeapon )
  if ( tWeapon.__base ~= strClassname ) then
    local tBaseWeapon = Get( tWeapon.__base )
    if ( not tBaseWeapon ) then
	  Warning( "WARNING: Attempted to initialize weapon \"" .. strClassname .. "\" with non-existing base class!\n" )
	else
	  return table.inherit( tWeapon, tBaseWeapon )
	end
  end
  return tWeapon
end

-------------------------------------------------------------------------------
-- Purpose: Returns all registered weapons
-- Input  :
-- Output : table
-------------------------------------------------------------------------------
function GetWeapons()
  return tWeapons
end

-------------------------------------------------------------------------------
-- Purpose: Registers a weapon
-- Input  : tWeapon - Weapon table
--			strClassname - Name of the weapon
--			bReload - Whether or not we're reloading this weapon data
-- Output :
-------------------------------------------------------------------------------
function Register( tWeapon, strClassname, bReload )
  if ( Get( strClassname ) ~= nil and bReload ~= true ) then
    return
  end
  tWeapons[ strClassname ] = tWeapon
end
