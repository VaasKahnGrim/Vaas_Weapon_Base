--[[sets up your content downloading stuff]]
if(SERVER)then
	resource.AddWorkshop('889827473')
	resource.AddWorkshop('912818711')
	resource.AddWorkshop('907051587')
	--missing alot of addons most likely for starwars weapons. just copy each addons ID into here.

	--[[DO ***NOT*** PUT THEM IN YOUR CONTENT COLLECTION, EXTRACT THEM AND UPLOAD THEM TO YOUR SERVER INSTEAD AND REMOVE THE LUA CODE FROM THEM!!!! ITS BETTER TO JUST REMAKE THEM FROM SCRATCH!!!!
	JUST MAKE SURE YOU KNOW HOW TO MAKE A BASIC SWEP FIRST AND YOU'LL BE FINE.
	YOU SHOULD BE DOING THIS ANYWAYS FOR YOUR ADDONS ALREADY BTW!!! ;)
	]]
end
AddCSLuaFile()


--[[SWEP CONFIGURATION SETTINGS, MAKE A NEW LUA FILE FOR YOUR SWEPS AND COPY THE CONFIGE BELOW AND EDIT IT TO YOUR LIKING]]


SWEP.Base = "weapon_base"--[[KEEP THIS AS"vaas_weapon_base" when you make new sweps with it!]]

SWEP.Author = "Vaas Kahn Grim" --[[SWEP AUTHOR NAME HERE]]
SWEP.PrintName = "Template" --[[name of the weapon]]
SWEP.Instructions = "Example" --[[What ever you want players to know]]
SWEP.Category = "Vaas Weapon Base" --[[where it will be in the q-menu; Try to keep it in the same category of similiar weapons. Check around for whats in use!]]

SWEP.Spawnable = false --[[will it even show up in q-menu?]]
SWEP.AdminSpawnable = false --[[is it only spawnable by BADMINS]]

SWEP.EnableVM = true
SWEP.EnableWM = true
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
SWEP.TracerName = "fucking_laser_blue" --[[the laser that actually fires out the gun. don't fuck with this unless you know how effects work in lua]]
SWEP.TracerCount = 1 --[[its a laser gun, best not to change the tracer count unless its a Republic shotgun or something]]
SWEP.Primary.NumShots = 1 --[[how many blasts come out per shot? leave as 1 unless its a shotgun or something]]

SWEP.ImpactMark = "blaster_burn" --[[Allows you to change the impact mark bullets/rounds make when striking a surface]]

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

SWEP.ShootSound = Sound("weapons/dc15a/dc15a_fire.ogg") --[[the sound of the gun when you shoot it]]
SWEP.ReloadSound = Sound("weapons/shared/standard_reload.ogg") --[[don't bother changing the sound for reloading unless you really want to]]


--[[leave these unchanged for now, will probably rework later for other uses]]
SWEP.ReloadDelay = 0 --[[how long it takes to begin reloading the gun. For later features to use. leave default for now]]
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false

-- removed the SWEp.FireTypes

SWEP.ExtraModels = {
	["View"] = {},
	["World"] = {},
}
--[[
	//////////////////////////////////////////////////////////////////
	////////////////////END OF CONFIGURATION//////////////////////////
	//////////////////////////////////////////////////////////////////
	EVERYTHING BELOW IS SETUP THE WAY IT NEEDS TO BE TO WORK WITH YOUR
	NEW SWEPS YOU MAKE! DO NOT COPY ANYTHING BELOW THIS INTO YOUR NEW
	SWEPS!!! ITS ALREADY BEING USED WHEN YOU SET SWEP.Base = "vaas_weapon_base"
	Seriously I made this thing easy to use for a reason, its basic as
	fuck but atleast you won't have the insane retarded issues that alot
	of people have with TFA Weapons. I'll update it later with new features
	but atleast take the time to read it as your going about editing the
	config for each swep. I included some somewhat helpful advice for each
	entry in the config. Lastly don't forget to follow the instructions at
	the top regarding the downloading of content for this.
										With Lua,
													Vaas Kahn Grim
													[RAPADANT NETWORKS]
]]
-- There was a global here for all people this was VERY stupid
function SWEP:Initialize()
	print("Hi?")
	self.Time = CurTime()
	self:SetHoldType(self.DEFAULTHOLD)
	if self.FireTypes then
		self:SetHoldType(self.FireTypes[1].HoldType)
	end
end

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 30, "FireType") -- We give it 31 so that other developers should never have to worry about overridding this

	if SERVER then
		self:SetFireType(1)
	end

	if self.ExtraDatatables then
		self:ExtraDatatables()
	end
end

function SWEP:GetFireTypeTable()
	print(self:GetFireType())
	return self.FireTypes[self:GetFireType()] || {}
end

function SWEP:PrimaryAttack()
	if self:GetHoldType() == "passive" then return end
	if(not self:CanPrimaryAttack())then
		return
	end
	local ply = self:GetOwner()
	ply:LagCompensation(true)
	local Bullet = {}
		Bullet.Num = self.Primary.NumShots
		Bullet.Src = ply:GetShootPos()
		Bullet.Dir = ply:GetAimVector()
		Bullet.Spread = Vector(self.Primary.Spread,self.Primary.Spread,0)
		Bullet.Tracer = 1
		Bullet.TracerName = self.TracerName
		Bullet.Damage = self.Primary.Damage
		Bullet.AmmoType = self.Primary.Ammo

	if self.FireTypes then
		local firetable = self:GetFireTypeTable()
		PrintTable(firetable)
		print("FUCKED")
		local val = firetable.OnPrimary(self, Bullet)
		if val then
			if val == true then
				ply:LagCompensation(false)
				return -- They can't shoot for what ever reason
			else
				Bullet = val
			end
		end
	end
	self:FireBullets(Bullet)
	self:ShootEffects()
	self:EmitSound(self.ShootSound)
	self.BaseClass.ShootEffects(self)
	self:TakePrimaryAmmo(1)
	self:SetNextPrimaryFire(CurTime()+self.Primary.Delay)
	ply:LagCompensation(false)
end
function SWEP:SecondaryAttack() -- could do something with fire types for zooming
	if(self.zoomEnabled == true)then
		if((self.ScopeLevel || 0) == 0)then
			if(SERVER)then
				self.Owner:SetFOV(self.ZoomLevelA,self.ZoomLevelB)
			end
			self.ScopeLevel = 1
		else
			if(SERVER)then
				self.Owner:SetFOV(0,self.ZoomLevelB)
			end
			self.ScopeLevel = 0
		end
	else
		return false
	end
end


function SWEP:Reload()
	if self.Owner:KeyDown(IN_USE)and self.Owner:KeyDown(IN_SPEED)then
    	if(self.cooldownvar || 0) < CurTime()then
        	self.cooldownvar  = CurTime() + 2
			if self.FireTypes then
	            		local val = self:GetFireType() + 1
				if val > #self.FireTypes then
					val = 1
				end
				self:SetFireType(val)
				if self.FireTypes[val].OnLoad then
					self.FireTypes[val].OnLoad(self) -- Might want to put this in a network notify
					self:SetHoldType(self:GetFireTypeTable().HoldType)
				end
			else -- We provide support for the older weapons or types with no need for two or gun types
				if(self:GetHoldType() == "passive")then
	            	self:SetHoldType("ar2")
	            else
	            	self:SetHoldType("passive")
				end
			end
		return -- prevents it making us reload at the same time
        end
    end
	if(self.Weapon:Ammo1() <= 0)then
		return
	end
	if(self.Weapon:Clip1() >= self.Primary.ClipSize)then
		return
	end
	print(CurTime(), self.Time)
	if(CurTime() < self.Time)then
		return
	end
	self.Time = CurTime() + self.ReloadDelay*2
	timer.Simple(self.ReloadDelay,function() self.Weapon:EmitSound(self.ReloadSound)end)
	self.Owner:SetAnimation(PLAYER_RELOAD)
	self.Weapon:DefaultReload(ACT_VM_RELOAD)
end
function SWEP:ShouldDropOnDie()
	return false
end
function SWEP:DoImpactEffect(tr,dmgtype)
	if(tr.HitSky)then
		return true
	end
	util.Decal("fadingscorch",tr.HitPos + tr.HitNormal,tr.HitPos - tr.HitNormal)
	if(game.SinglePlayer()or SERVER or not self:IsCarriedByLocalPlayer()or IsFirstTimePredicted())then
		local effect = EffectData()
		effect:SetOrigin(tr.HitPos)
		effect:SetNormal(tr.HitNormal)
		util.Effect(self.ImpactMark,effect) --util.Effect("blaster_burn",effect)
		local effect = EffectData()
		effect:SetOrigin(tr.HitPos)
		effect:SetStart(tr.StartPos)
		effect:SetDamageType(dmgtype)
		util.Effect("RagdollImpact",effect)
	end
    return true
end
--[[function SWEP:FireAnimationEvent(pos,ang,event,options)
	if(!self.CSMuzzleFlashes)then return end
	if(event == 5001 or event == 5011 or event == 5021 or event == 5031)then
		local data = EffectData()
		data:SetFlags(0)
		data:SetEntity(self.Owner:GetViewModel())
		data:SetAttachment(math.floor((event - 4991) / 10))
		data:SetScale(6000)
		if(self.CSMuzzleX)then
			util.Effect("blaster_flash",data)
		else
			util.Effect("blaster_flash",data)
		end
		return true
	end
end]]
 if SERVER then return end
Vaas = Vaas || {}
if !Vaas.CS then
	local ent = ClientsideModel("models/player/kleiner.mdl")
	ent:SetNoDraw(true)

	Vaas.CS = ent
end
function SWEP:QuickRenderEnt(data, vm)
	local pos = data.Pos
	local ang = data.Ang
	local bone = data.Bone
	local mdl = data.Model
	local scale = data.Scale || 1
	vm   = vm || self

	if bone then
		local boneid = vm:LookupAttachment(bone)
		if boneid then
			local PosAng = vm:GetAttachment(boneid)
			pos = pos + PosAng.Pos
			ang = ang + PosAng.Ang
		else
			if (self.NextBoneError || 0 ) < CurTime() then
				self.Owner:ChatPrint( self:GetClass() .. " has an issue with bone " .. bone .. " if this model is an error ignore this print " )
				self.NextBoneError = CurTime() + 300
			end
		end
	end
	if !mdl then return end
	Vaas.CS:SetModel(mdl)
	Vaas.CS:SetAngles(ang)
	Vaas.CS:SetPos(pos)
	Vaas.CS:SetModelScale(scale)
	if data.PreRender then
		data.PreRender(self, Vaas.CS, data)
	end
	Vaas.CS:SetupBones()
	Vaas.CS:DrawModel()
	if data.PostRender then
		data.PostRender(self, Vaas.CS, data)
	end
end

function SWEP:PostDrawViewModel(vm,wep, ply)
	for index, data in pairs(  (wep.ExtraModels || {} )["View"] || {} ) do -- This is a mess but this will prevent older weapons from causing script errors
		wep:QuickRenderEnt(data, vm)
	end
end

function SWEP:DrawWorldModel()
	if self.EnableWM = true --Will this work? Should only prevent drawing it on the client, should still exist
		self:DrawModel()
	end --Will this work?
	for index, data in pairs( (wep.ExtraModels || {} )["World"] || {} ) do
		wep:QuickRenderEnt(data)
	end
end

function SWEP:DrawWorldModelTranslucent()
	self:DrawModel()
	for index, data in pairs( (wep.ExtraModels || {} )["World"] || {} ) do
		wep:QuickRenderEnt(data)
	end
end

function SWEP:ShouldDrawViewModel()--Will this work? Should only prevent drawing it on the client, should still exist
	if self.EnableVM = true then
		return true
	else
		return false
	end
end
