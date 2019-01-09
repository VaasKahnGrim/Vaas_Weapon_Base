AddCSLuaFile()


--[[SWEP CONFIGURATION SETTINGS, MAKE A NEW LUA FILE FOR YOUR SWEPS AND COPY THE CONFIGE BELOW AND EDIT IT TO YOUR LIKING]]

--[[SWEP AUTHOR NAME HERE]]
SWEP.Author = "Star"
--[[CHANGE THIS TO "vaas_weapon_base" when you make your new sweps with it]]
SWEP.Base = "vaas_weapon_base"
--[[name of the weapon]]
SWEP.PrintName = "Star Light's Development Gun"
--[[What ever you want players to know]]
SWEP.Instructions = "Example"
--[[what you see in first person view]]
SWEP.ViewModel = "models/weapons/v_DC15A.mdl"
--[[if its upside down in first person set this to true]]
SWEP.ViewModelFlip = false
--[[keep this false unless you don't see hands properly]]
SWEP.UseHands = false
--[[what other players see you holding]]
SWEP.WorldModel = "models/weapons/W_DC15A.mdl"
--[[set to "ar2" for rifle like weapons, set to "pistol" for pistols.]]
SWEP.SetHoldType = "ar2"
--[[set to same as above just in case something tries to overide SWEP.SetHoldType]]
SWEP.DEFAULTHOLD = "ar2"
--[[how heavy your swep is? I guess it could be useful so why the hell not put it here for you]]
SWEP.Weight = 5
--[[switch to this weapon when you pick it up?]]
SWEP.AutoSwitchTo = true
--[[switch from this weapon when you pick up another?]]
SWEP.AutoSwitchFrom = false
--[[which key do you want to press to get to this weapon? 1,2,3,4,5 or 6]] 
SWEP.Slot = 0
--[[basically sort order of weapons on the same slot. 0 will be highest and 99 at botem of list]]
SWEP.SlotPos = 0
--[[apparently important. I suggest leave false unless you think it needs to be true]]
SWEP.DrawAmmo = false
--[[a crosshair thats basic and default with garrysmod. true if you want it, false if you don't]]
SWEP.DrawCrosshair = true
--[[where it will be in the q-menu]]
SWEP.Category = "Vaas Weapon Base"
--[[will it even show up in q-menu?]]
SWEP.Spawnable = true
--[[is it only spawnable by BADMINS]]
SWEP.AdminSpawnable = true
--[[the laser that actually fires out the gun. don't fuck with this unless you know how effects work in lua]]
SWEP.TracerName = "blue"
--[[its a laser gun, best not to change the tracer count unless its a Republic shotgun or something]]
SWEP.TracerCount = 1
--[[how much ammo per clip]]
SWEP.Primary.ClipSize = 50
--[[ammo in reserve]]
SWEP.Primary.DefaultClip = 200
--[[ammo type, leave the same or getting ammo is a bitch for players]]
SWEP.Primary.Ammo = "ar2"
--[[single shot or automatic? will have better method later for this]]
SWEP.Primary.Automatic = true
--[[how much damage for each shot]]
SWEP.Primary.Damage = 10
--[[how many blasts come out per shot? leave as 1 unless its a shotgun or something]]
SWEP.Primary.NumShots = 1
--[[how much it spreads out when firing. keep in mind that its easy to fuck up this one. keep the number small]]
SWEP.Primary.Spread = 0.02
--[[noticed nothing changing from this so ignore unless you know what to do with it.]]
SWEP.Primary.Cone = 0
--[[how long between each shot being fired from the gun. lower is faster]]
SWEP.Primary.Delay = 0.2
--[[how long it takes to begin reloading the gun. For later features to use. leave default for now]]
SWEP.ReloadDelay = 0.5
--[[how far you zoom in? will redo this later probably]]
SWEP.ZoomLevelA = 60
--[[how fast you zoom in]]
SWEP.ZoomLevelB = .2 --zoom speed
--[[can you zoom in at all?]]
SWEP.zoomEnabled = true
--[[don't bother changing the sound for reloading unless you really want to]]
SWEP.ReloadSound = Sound("weapons/shared/standard_reload.ogg")
--[[leave these unchanged for now, will probably rework later for other uses]]
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false

SWEP.FireTypes = {
	[1] = {
		Name	 	= "Normal",
		HoldType 	= "ar2",
		OnLoad 	 	= function(self)
			-- Affect the guns stats possible.
		end,
		OnPrimary 	= function(self, bullet)
			-- Return bullet to affect the data
		end,
		OnSecondary 	= function(self)
			-- Not certain here? return true to stop true?
		end,
	},
	[2] = {
		Name 		= "Holster",
		HoldType	= "passive",
		OnLoad		= function(self)
				
		end,
		OnPrimary	= function(self, bullet)
			return true
		end,
	},
}

SWEP.ExtraModels = {
  ["View"] = {
    [1] = {
      Pos = Vector(0,10,0),
      Ang = Angle(0,0,0),
      Model = "models/hunter/blocks/cube025x025x025.mdl"
  },
}
