AddCSLuaFile()


--[[SWEP CONFIGURATION SETTINGS, MAKE A NEW LUA FILE FOR YOUR SWEPS AND COPY THE CONFIGE BELOW AND EDIT IT TO YOUR LIKING]]
SWEP.Base = "vaas_weapon_base"--[[KEEP THIS AS"vaas_weapon_base" when you make new sweps with it!]]

SWEP.Author = "Vaas Kahn Grim, Servius" --[[SWEP AUTHOR NAME HERE]]
SWEP.PrintName = "DC-15a Test Rifle" --[[name of the weapon]]
SWEP.Instructions = "Example" --[[What ever you want players to know]]
SWEP.Category = "Vaas Weapon Base" --[[where it will be in the q-menu; Try to keep it in the same category of similiar weapons. Check around for whats in use!]]

SWEP.Spawnable = true --[[will it even show up in q-menu?]]
SWEP.AdminSpawnable = true --[[is it only spawnable by BADMINS]]

SWEP.ViewModel = "models/weapons/v_DC15A.mdl" --[[what you see in first person view]]
SWEP.ViewModelFlip = false --[[if its upside down in first person set this to true]]
SWEP.WorldModel = "models/weapons/W_DC15A.mdl" --[[what other players see you holding]]
SWEP.UseHands = false --[[keep this false unless you don't see hands properly]]

SWEP.SetHoldType = "ar2" --[[set to "ar2" for rifle like weapons, set to "pistol" for pistols.]]
SWEP.DEFAULTHOLD = "ar2" --[[set to same as above just in case something tries to overide SWEP.SetHoldType]]

SWEP.AutoSwitchTo = true --[[switch to this weapon when you pick it up?]]
SWEP.AutoSwitchFrom = false--[[switch from this weapon when you pick up another?]]
SWEP.ShouldDropOnDie = false --[[do you want to drop it on death? not sure what any starwarsRP server would want that considering lots of minges join servers to RDM]]

SWEP.Slot = 0 --[[which key do you want to press to get to this weapon? 1,2,3,4,5 or 6]] 
SWEP.SlotPos = 0 --[[basically sort order of weapons on the same slot. 0 will be highest and 99 at botem of list]]

SWEP.DrawAmmo = false --[[apparently important. I suggest leave false unless you think it needs to be true]]
SWEP.DrawCrosshair = true --[[a crosshair thats basic and default with garrysmod. true if you want it, false if you don't]]

SWEP.Weight = 5 --[[how heavy your swep is? I guess it could be useful so why the hell not put it here for you]]
SWEP.TracerName = "blue" --[[the laser that actually fires out the gun. don't fuck with this unless you know how effects work in lua]]
SWEP.TracerCount = 1 --[[its a laser gun, best not to change the tracer count unless its a Republic shotgun or something]]
SWEP.Primary.NumShots = 1 --[[how many blasts come out per shot? leave as 1 unless its a shotgun or something]]

SWEP.Primary.Automatic = true --[[single shot or automatic? will have better method later for this]]
SWEP.Primary.ClipSize = 50 --[[how much ammo per clip]]
SWEP.Primary.DefaultClip = 200 --[[ammo in reserve]]
SWEP.Primary.Ammo = "ar2" --[[ammo type, leave the same or getting ammo is a bitch for players]]

SWEP.Primary.Damage = 10 --[[how much damage for each shot]]
SWEP.Primary.Spread = 0.02 --[[how much it spreads out when firing. keep in mind that its easy to fuck up this one. keep the number small]]
SWEP.Primary.Cone = 0 --[[noticed nothing changing from this so ignore unless you know what to do with it.]]
SWEP.Primary.Delay = 0.2 --[[how long between each shot being fired from the gun. lower is faster]]

SWEP.ZoomLevelA = 60 --[[how far you zoom in? will redo this later probably]]
SWEP.ZoomLevelB = .2 --[[how fast you zoom in]]
SWEP.zoomEnabled = true --[[can you zoom in at all?]]

local ShootSound = Sound("weapons/dc15a/dc15a_fire.ogg") --[[the sound of the gun when you shoot it]]
SWEP.ReloadSound = Sound("weapons/shared/standard_reload.ogg") --[[don't bother changing the sound for reloading unless you really want to]]


--[[leave these unchanged for now, will probably rework later for other uses]]
SWEP.ReloadDelay = 0.5 --[[how long it takes to begin reloading the gun. For later features to use. leave default for now]]
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
	["View"] = {},
	["World"] = {},
}
