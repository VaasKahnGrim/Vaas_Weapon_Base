AddCSLuaFile()
SWEP.Base = 'vaas_weapon_base'
SWEP.Author = 'Vaas Kahn Grim, Servius'
SWEP.PrintName = 'DC-15a Test Rifle'
SWEP.Category = 'Vaas Weapon Base'

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.RPActions = true


SWEP.EnableVM = true
SWEP.EnableWM = true
SWEP.ViewModel = 'models/weapons/v_DC15A.mdl'
SWEP.ViewModelFlip = false
SWEP.WorldModel = 'models/weapons/W_DC15A.mdl'
SWEP.UseHands = false


SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.ShouldDropOnDie = false
SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.Weight = 5


SWEP.FBHoldType = 'vwb_melee'
SWEP.SetHoldType = 'ar2'
SWEP.DEFAULTHOLD = 'ar2'


SWEP.PrimaryType = 'shoot'

SWEP.Primary.TracerName = 'fucking_laser_blue'
SWEP.Primary.TracerCount = 1
SWEP.Primary.NumShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 50
SWEP.Primary.DefaultClip = 200
SWEP.Primary.Ammo = 'ar2'
SWEP.Primary.ImpactMark = 'blaster_burn'
SWEP.Primary.Damage = 10
SWEP.Primary.Spread = 0.02
SWEP.Primary.Cone = 0
SWEP.Primary.Delay = 0.2
SWEP.Primary.ShootSound = Sound'weapons/dc15a/dc15a_fire.ogg'
SWEP.Primary.ReloadSound = Sound'weapons/shared/standard_reload.ogg'
SWEP.Primary.ReloadDelay = 0.5


SWEP.SecondaryType = 'zoomview'

SWEP.Secondary.TracerName = 'fucking_laser_blue'
SWEP.Secondary.TracerCount = 1
SWEP.Secondary.NumShots = 1
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Ammo = 'ar2'
SWEP.Secondary.ImpactMark = 'blaster_burn'
SWEP.Secondary.Damage = 10
SWEP.Secondary.Spread = 0.02
SWEP.Secondary.Cone = 0
SWEP.Secondary.Delay = 0.2
SWEP.Secondary.ShootSound = Sound'weapons/dc15a/dc15a_fire.ogg'
SWEP.Secondary.ReloadSound = Sound'weapons/shared/standard_reload.ogg'
SWEP.Secondary.ReloadDelay = 0


SWEP.ReloadType = 'reload'

SWEP.ZoomLevelA = 60
SWEP.ZoomLevelB = .2
SWEP.zoomEnabled = true


SWEP.MeleeSound = Sound'Weapon_Crowbar.single'
SWEP.MeleeHit = Sound'Weapon_Crowbar.Melee_Hit'
SWEP.MeleeDMG = 25
--[[SWEP.ExtraModels = {
	["View"] = {
		[1] = {
			Bone = "1",
			Scale = 0.2,
			Pos = Vector(0,0,5),
			Ang = Angle(0,0,0),
			Model = "models/hunter/blocks/cube025x025x025.mdl"
  		},
	}
}]]
