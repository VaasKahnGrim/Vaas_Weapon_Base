if(SERVER)then
	resource.AddWorkshop'889827473'
	resource.AddWorkshop'912818711'
	resource.AddWorkshop'907051587'
	AddCSLuaFile()
end
SWEP.Base = 'weapon_base'
SWEP.Author = 'Vaas Kahn Grim'
SWEP.Category = 'Vaas Weapon Base'

SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.RPActions = false


SWEP.ExtraModels = {
	['View'] = {},
	['World'] = {}
}
SWEP.EnableVM = false
SWEP.EnableWM = false
SWEP.ViewModel = ''
SWEP.ViewModelFlip = false
SWEP.WorldModel = ''
SWEP.UseHands = false


SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.ShouldDropOnDie = false
SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Weight = 5


SWEP.FBHoldType = 'vwb_melee'
SWEP.SetHoldType = 'ar2'
SWEP.DEFAULTHOLD = 'ar2'


SWEP.PrimaryType = 'none'

SWEP.Primary.TracerName = ''
SWEP.Primary.TracerCount = 1
SWEP.Primary.NumShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.DefaultROF = true
SWEP.Primary.ClipSize = 50
SWEP.Primary.DefaultClip = 200
SWEP.Primary.Ammo = 'ar2'
SWEP.Primary.ImpactMark = ''
SWEP.Primary.Damage = 10
SWEP.Primary.Spread = 0.02
SWEP.Primary.Cone = 0
SWEP.Primary.Delay = 0.2
SWEP.Primary.ShootSound = Sound''
SWEP.Primary.ReloadSound = Sound''
SWEP.Primary.ReloadDelay = 0


SWEP.SecondaryType = 'none'

SWEP.Secondary.TracerName = ''
SWEP.Secondary.TracerCount = 1
SWEP.Secondary.NumShots = 1
SWEP.Secondary.Automatic = false
SWEP.Secondary.DefaultROF = false
SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Ammo = 'ar2'
SWEP.Secondary.ImpactMark = ''
SWEP.Secondary.Damage = 10
SWEP.Secondary.Spread = 0.02
SWEP.Secondary.Cone = 0
SWEP.Secondary.Delay = 0.2
SWEP.Secondary.ShootSound = Sound''
SWEP.Secondary.ReloadSound = Sound''
SWEP.Secondary.ReloadDelay = 0


SWEP.ReloadType = 'none'

SWEP.ZoomLevelA = 60
SWEP.ZoomLevelB = .2
SWEP.zoomEnabled = true


SWEP.MeleeSound = Sound''
SWEP.MeleeHit = Sound''
SWEP.MeleeDMG = 25


SWEP.FireTypes = {
	[1] = {
		Name = 'Normal',
		HoldType = 'ar2',
		OnLoad = function(self)
			-- Affect the guns stats possible.
		end,
		OnPrimary = function(self,bullet)
			-- Return bullet to affect the data
		end,
		OnSecondary = function(self)
			-- Not certain here? return true to stop true?
		end,
	},
	[2] = {
		Name = 'Holster',
		HoldType = 'passive',
		OnLoad = function(self)
		end,
		OnPrimary = function(self,bullet)
			return true
		end,
	}
}

function SWEP:Initialize()
	self.Time = CurTime()
	self:SetHoldType(self.DEFAULTHOLD)
	if self.FireTypes then
		self:SetHoldType(self.DEFAULTHOLD)
	end
	--[[hook.Add('SetupMove',self,self.PlayerMove)
	--hook.Add("Tick",self,self.Tick)
	if CLIENT then
		self.VElements = table.FullCopy(self.VElements)
		self:CreateModels(self.VElements)--create viewmodels
		hook.Add('PostDrawOpaqueRenderables',self,self.VMDraw)
	end
	if SERVER then
		local timerName = tostring(self)..' Hook Broken Cooldown'
		timer.Create(timerName,0.1,0,function()
			if !IsValid(self)then timer.Destroy(timerName)return end
			self:SetCooldown(math.Approach(self:GetCooldown(),0,2))
		end)
	end
	self.Primary.DefaultClip = cvars.Number'hatshook_ammo' || -1
	self.Primary.ClipSize = cvars.Number'hatshook_ammo' || -1
	self:SetClip1(cvars.Number'hatshook_ammo' || -1)
	return self.BaseClass.Initialize(self)]]
end

function SWEP:SetupDataTables()
	self:NetworkVar('Int',30,'FireType')

	--grapple hook expiramental
	--self:NetworkVar('Entity',0,'Hook')
	--self:NetworkVar('Int',0,'Cooldown')

	if SERVER then
		self:SetFireType(1)
	end

	if self.ExtraDatatables then
		self:ExtraDatatables()
	end
end

function SWEP:GetFireTypeTable()
	--print(self:GetFireType())
	return self.FireTypes[self:GetFireType()] || {}
end

SWEP.Actions = {}
SWEP.Actions.Primary = {
	['shoot'] = function(self,ply)
		if !self:CanPrimaryAttack()then
			return
		end
		local Bullet = {}
			Bullet.Num = self.Primary.NumShots
			Bullet.Src = ply:GetShootPos()
			Bullet.Dir = ply:GetAimVector()
			Bullet.Spread = Vector(self.Primary.Spread,self.Primary.Spread,0)
			Bullet.Tracer = 1
			Bullet.TracerName = self.Primary.TracerName
			Bullet.Damage = self.Primary.Damage
			Bullet.AmmoType = self.Primary.Ammo

		--[[if self.FireTypes then
			local firetable = self:GetFireTypeTable()
			local val = firetable.OnPrimary(self,Bullet)
			if val then
				if val == true then
					ply:LagCompensation(false)
					return -- They can't shoot for what ever reason
				else
					Bullet = val
				end
			end
		end]]
		self:FireBullets(Bullet)
		self:ShootEffects()
		self:EmitSound(self.Primary.ShootSound)
		self.BaseClass.ShootEffects(self)
		self:TakePrimaryAmmo(1)
		self:SetNextPrimaryFire(CurTime()+self.Primary.Delay)
	end,
	['melee'] = function(self,ply)
		local shootpos = ply:GetShootPos()
		local endshootpos = shootpos+ply:GetAimVector()*70
		local tmin = Vector(1,1,1)* -10
		local tmax = Vector(1,1,1)*10
		local tr = util.TraceHull({start = shootpos,endpos = endshootpos,filter = ply,mask = MASK_SHOT_HULL,mins = tmin,maxs = tmax})
		if !IsValid(tr.Entity)then
			tr = util.TraceLine({start = shootpos,endpos = endshootpos,filter = ply,mask = MASK_SHOT_HULL})
		end
		local ent = tr.Entity
		self:MeleeEffects()
		if IsValid(ent) && (ent:IsPlayer() || ent:IsNPC() || ent:IsNextbot())then
			ply:EmitSound(self.MeleeHit)
			ent:SetHealth(ent:Health()-self.MeleeDMG)
			if ent:Health() <= 0 then
				if ent:IsPlayer()then
					ent:Kill()
				else
					ent:Remove()
				end
			end
		elseif !IsValid(ent)then
			ply:EmitSound(self.MeleeSound)
		end
		self:SetNextPrimaryFire(CurTime()+self:SequenceDuration()+0.1)
	end,
	['grapple'] = function(self,ply)
		--[[if self:GetCooldown()>0 then return end
		self:SetNextPrimaryFire(CurTime()+self.Primary.Delay)
		self:SetNextSecondaryFire(CurTime()+self.Primary.Delay)
		if CLIENT && !IsFirstTimePredicted()then return end
		if IsValid(self:GetHook())then
			local hk = self:GetHook()
			if !(hk.GetHasHit && hk:GetHasHit())then return end
			if SERVER then hk:SetDist(math.Approach(hk:GetDist(),0,10)) end
			self:SetNextPrimaryFire(CurTime()+self.Primary.Delay)
			self:SetNextSecondaryFire(CurTime()+self.Primary.Delay)
		elseif SERVER then
			self:LaunchHook()
		end]]
	end
}

SWEP.Actions.Secondary = {
	['zoomview'] = function(self,ply)
		if self.zoomEnabled == true then
			if(self.ScopeLevel || 0) == 0 then
				if SERVER then
					self.Owner:SetFOV(self.ZoomLevelA,self.ZoomLevelB)
				end
				self.ScopeLevel = 1
			else
				if SERVER then
					self.Owner:SetFOV(0,self.ZoomLevelB)
				end
				self.ScopeLevel = 0
			end
		else
			return false
		end
	end,
	['shoot'] = function(self,ply)
		if !self:CanSecondaryAttack()then
			return
		end
		local Bullet = {}
			Bullet.Num = self.Secondary.NumShots
			Bullet.Src = ply:GetShootPos()
			Bullet.Dir = ply:GetAimVector()
			Bullet.Spread = Vector(self.Secondary.Spread,self.Secondary.Spread,0)
			Bullet.Tracer = 1
			Bullet.TracerName = self.Secondary.TracerName
			Bullet.Damage = self.Secondary.Damage
			Bullet.AmmoType = self.Secondary.Ammo

		if self.FireTypes then
			local firetable = self:GetFireTypeTable()
			local val = firetable.OnSecondary(self,Bullet)
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
		self:EmitSound(self.Secondary.ShootSound)
		self.BaseClass.ShootEffects(self)
		self:TakeSecondaryAmmo(1)
		self:SetNextSecondaryFire(CurTime()+self.Secondary.Delay)
	end,
	['ironsight'] = function(self,ply)
		ply:ChatPrint'Ironsight is not yet implemented!!!'
	end,
	['scoped'] = function(self,ply)
		ply:ChatPrint'Scopes are not yet implemented!!!'
	end,
	['grapple'] = function(self,ply)
		--look into the Realistic_Hook(under your 'new 9' tabe on the left)
		--[[if self:GetCooldown()>0 then return end
		self:SetNextPrimaryFire(CurTime()+self.Primary.Delay)
		self:SetNextSecondaryFire(CurTime()+self.Primary.Delay)
		if IsValid(self:GetHook())then
			local hk = self:GetHook()
			if !(hk.GetHasHit && hk:GetHasHit())then return end
			if SERVER then hk:SetDist(hk:GetDist()+10) end
			self:SetNextPrimaryFire(CurTime()+self.Primary.Delay)
			self:SetNextSecondaryFire(CurTime()+self.Primary.Delay)
		elseif SERVER then
			self:LaunchHook()
		end]]
	end,
	['grenade'] = function(self,ply)
		ply:ChatPrint'Grenades are not yet implemented!!!'
	end,
	['stun'] = function(self,ply)
		ply:ChatPrint'Stun is not yet implemented!!!'
	end,
	['charge'] = function(self,ply)
		ply:ChatPrint'Charged Shots are not yet implemented!!!'
	end,
	['heal'] = function(self,ply)
		ply:ChatPrint'Healing is not yet implemented!!!'
	end,
	['block'] = function(self,ply)
		ply:ChatPrint'Blocking is not yet implemented!!!'
	end,
	['repair'] = function(self,ply)
		ply:ChatPrint'Repairing is not yet implemented!!!'
	end,
	['melee'] = function(self,ply)
		local shootpos = ply:GetShootPos()
		local endshootpos = shootpos+ply:GetAimVector()*70
		local tmin = Vector(1,1,1)* -10
		local tmax = Vector(1,1,1)*10
		local tr = util.TraceHull({start = shootpos,endpos = endshootpos,filter = ply,mask = MASK_SHOT_HULL,mins = tmin,maxs = tmax})
		if !IsValid(tr.Entity)then
			tr = util.TraceLine({start = shootpos,endpos = endshootpos,filter = ply,mask = MASK_SHOT_HULL})
		end
		local ent = tr.Entity
		self:MeleeEffects()
		if IsValid(ent) && (ent:IsPlayer() || ent:IsNPC() || ent:IsNextbot())then
			ply:EmitSound(self.MeleeHit)
			ent:SetHealth(ent:Health()-self.MeleeDMG)
			if ent:Health() < 1 then
				ent:Kill()
			end
		elseif !IsValid(ent)then
			ply:EmitSound(self.MeleeSound)
		end
		self:SetNextSecondaryFire(CurTime()+self:SequenceDuration()+0.1)
	end,
}

SWEP.Actions.Reload = {
	['reload'] = function(self,ply)
		if self.Owner:KeyDown(IN_USE) && self.Owner:KeyDown(IN_SPEED)then
			if(self.cooldownvar || 0) < CurTime()then
				self.cooldownvar  = CurTime()+2
				if self.FireTypes then
					local val = self:GetFireType()+1
					if val > #self.FireTypes then
						val = 1
					end
					self:SetFireType(val)
					if self.FireTypes[val].OnLoad then
						self.FireTypes[val].OnLoad(self) -- Might want to put this in a network notify
						self:SetHoldType(self:GetFireTypeTable().HoldType)
					end
				else -- We provide support for the older weapons or types with no need for two or gun types
					if self:GetHoldType() == 'passive' then
						self:SetHoldType(self.FireTypes[1].HoldType)--('ar2')
					else
						self:SetHoldType(self.FireTypes[2].HoldType)--('passive')
					end
				end
			return -- prevents it making us reload at the same time
			end
		end
		if self.Weapon:Ammo1() <= 0 then
			return
		end
		if self.Weapon:Clip1() >= self.Primary.ClipSize then
			return
		end
		--print(CurTime(), self.Time)
		if CurTime() < self.Time then
			return
		end
		self.Time = CurTime()+self.Primary.ReloadDelay*2
		timer.Simple(self.Primary.ReloadDelay,function()self.Weapon:EmitSound(self.Primary.ReloadSound)end)
		self.Owner:SetAnimation(PLAYER_RELOAD)
		self.Weapon:DefaultReload(ACT_VM_RELOAD)
	end,
	['grapple'] = function(self,ply)
		--[[if SERVER && IsValid(self:GetHook())then
			if self:GetHook():GetDurability()>0 then
				self:SetCooldown(self:GetHook():GetDurability()+20)
			else
				self:SetCooldown(10)
			end
			self:GetHook():Remove()
			if self:Clip1()==0 then
				self:Remove()
				return
			end
		end]]
	end
}

--[[function SWEP:LaunchHook()
	if !IsValid(self.Owner)then return end
	if self:Clip1()>0 then
		self:SetClip1(math.max(self:Clip1()-1,0))
	elseif self:Clip1()==0 then
		return
	end
	if !cvars.Bool'hatshook_physics' then return self:LaunchInstant() end
	--self:EmitSound("physics/metal/metal_box_impact_bullet"..math.random(1,3)..".wav")
	sound.Play('physics/metal/metal_canister_impact_soft'..math.random(1,3)..'.wav',self.Owner:GetShootPos(),75,100,0.5)
	self.Owner:ViewPunch(Angle(math.Rand(-5,-2.5),math.Rand(-2,2),0))
	local hk = ents.Create'ent_realistic_hook'
	if !IsValid(hk)then return end--Shouldn't happen
	hk:SetPos(self.Owner:GetShootPos()-self.Owner:GetAimVector()*10)
	local ang = self.Owner:EyeAngles()
	ang:RotateAroundAxis(ang:Up(),90)
	hk:SetAngles(ang)
	hk.FireVelocity = self.Owner:GetAimVector()*500
	hk:SetOwner(self.Owner)
	hk:Spawn()
	self:SetHook(hk)
	hk:SetWep(self)
end
function SWEP:GetFilter()
	return cvars.Bool'hatshook_hookplayers' && {self.Owner} || player.GetAll()
end
function SWEP:LaunchInstant()
	local tr = util.TraceLine({start=self.Owner:GetShootPos(),endpos=self.Owner:GetShootPos()+(self.Owner:GetAimVector()*cvars.Number'hatshook_speed'),filter=self:GetFilter()})
	if tr.HitSky || !tr.Hit then return end
	sound.Play('physics/metal/metal_canister_impact_soft'..math.random(1,3)..'.wav',self.Owner:GetShootPos(),75,100,0.5)
	self.Owner:ViewPunch(Angle(math.Rand(-10,-5),math.Rand(-4,4),0))
	local hk = ents.Create'ent_realistic_hook'
	if !IsValid(hk)then return end--Shouldn't happen
	hk:SetPos(tr.HitPos)
	hk:SetAngles(tr.Normal:Angle())
	hk.FireVelocity = Vector(0,0,0)
	hk:SetOwner(self.Owner)
	hk:Spawn()
	self:SetHook(hk)
	hk:SetWep(self)
	hk:PhysicsCollide({HitEntity=tr.Entity,HitPos=tr.HitPos,HitNormal=tr.Normal})
end
local HookCable = Material'cable/cable2'
function SWEP:DrawRope(attPos)
	if !attPos then return end
	local hk = self:GetHook()
	if !IsValid(hk)then return end
	if self.Owner~=LocalPlayer() || hook.Call('ShouldDrawLocalPlayer',GAMEMODE,self.Owner)then return hk:Draw() end
	if IsValid(hk:GetTargetEnt())then
		local bpos,bang = hk:GetTargetEnt():GetBonePosition(hk:GetFollowBone())
		local npos,nang = hk:GetFollowOffset(),hk:GetFollowAngle()
		if npos && nang && bpos && bang then
			npos:Rotate(nang)
			nang = nang+bang
			npos = bpos+npos
			hk:SetPos(npos)
			hk:SetAngles(nang)
		end
	end
	render.SetMaterial(HookCable)
	render.DrawBeam(hk:GetPos(),attPos,1,0,2,Color(255,255,255,255))
end
function SWEP:DrawWorldModel()
	self:DrawModel()
	local att = self:GetAttachment(1)
	self:DrawRope(att.Pos)
end
function SWEP:VMDraw()
	if !(self.Owner==LocalPlayer() && self.Owner:GetActiveWeapon()==self && hook.Call('ShouldDrawLocalPlayer',GAMEMODE,self.Owner)~=false)then return end
	local vm = IsValid(self.Owner) && self.Owner:GetViewModel()
	local pos = self:GetPos()
	if IsValid(vm) && vm:GetAttachment(1)then pos = vm:GetAttachment(1).Pos end
	self:DrawRope(pos)
end


]]


--[[function SWEP:CanPrimaryAttack()
	if self:GetHoldType() == 'passive' then return false end
	print('Ammo: '..tostring(self:Ammo1()))
	print('Clip: '..tostring(self:Clip1()))
	if CurTime() >= self:GetNextPrimaryFire()then
		if self:Ammo1() <= 0 then
			if !self:GetHoldType() == self.FBHoldType then
				self:SetHoldType(self.FBHoldType)
				self.PrimaryType = 'melee'
				self.Primary.Automatic = false
			end
			return true
		else
			if !self:GetHoldType() == self.DEFAULTHOLD then
				self:SetHoldType(self.DEFAULTHOLD)
				self.PrimaryType = 'shoot'
				self.Primary.Automatic = self.Primary.DefaultROF
			end
			if self.Weapon:Clip1() > 0 then
				return true
			elseif self.Weapon:Clip1() <= 0 && self:Ammo1() > 0 then
				self:EmitSound'Weapon_Pistol.Empty'
				self:Reload()
				return false
			end
		end
		return false
	end
	return false
end]]
function SWEP:CanPrimaryAttack()
	if self:GetHoldType() == 'passive' then
		print'Can not shoot while passive'
		return false
	end
	print('Ammo: '..tostring(self:Ammo1()))
	print('Clip: '..tostring(self:Clip1()))
	if self:Ammo1() <= 0 && self:Clip1() <= 0 then --this if else statement SHOULD handle switching between melee and shooting based on if the player is out of ammo
		print'Ammo1 and Clip1 are both 0 or less'
		if !self:GetHoldType() == self.FBHoldType then
			self:SetHoldType(self.FBHoldType)
			self.PrimaryType = 'melee'
			self.Primary.Automatic = false
			print'Setting holdtype to melee'
			return false
		end
	else
		print'Ammo1 or Clip1 are above 0'
		if !self:GetHoldType() == self.DEFAULTHOLD then
			self:SetHoldType(self.DEFAULTHOLD)
			self.PrimaryType = 'shoot'
			self.Primary.Automatic = self.Primary.DefaultROF
			print'Setting holdtype to shoot'
			return false
		end
	end
	if CurTime() > self:GetNextPrimaryFire()then --should prevent attacking if its not time to attack yet
		print'Its time to fire'
		if self:Ammo1() > 0 then
			print'Ammo1 is greater than 0'
			return true
		else
			print'Ammo1 is 0 or less than 0'
			if self:GetHoldType() == self.FBHoldType then
				print'Melee attack running'
				return true
			else
				print'Shoot attack running'
				if self:Clip1() > 0 then
					print'Clip1 is not empty'
					return true
				else
					self:EmitSound'Weapon_Pistol.Empty'
					self:Reload()
					print'Swep reloaded'
					return false
				end
			end
		end
	else
		print'its not time to fire yet'
		return false
	end
end

function SWEP:PrimaryAttack()
	if self.Actions.Primary[self.PrimaryType] then
		self.Owner:LagCompensation(true)
		self.Actions.Primary[self.PrimaryType](self,self.Owner)
		self.Owner:LagCompensation(false)
	else
		return false
	end
end

function SWEP:CanSecondaryAttack()
	if self:GetHoldType() == 'passive' then return false end
	if self.Weapon:Clip2() <= 0 then
		self.Weapon:EmitSound('Weapon_Pistol.Empty')
		self.Weapon:SetNextSecondaryFire(CurTime()+0.2)
		return false
	end
	return true
end

function SWEP:SecondaryAttack()
	if self.Actions.Secondary[self.SecondaryType] then
		self.Owner:LagCompensation(true)
		self.Actions.Secondary[self.SecondaryType](self,self.Owner)
		self.Owner:LagCompensation(false)
	else
		return false
	end
end

function SWEP:Reload()
	if self.Actions.Reload[self.ReloadType] then
		self.Owner:LagCompensation(true)
		self.Actions.Reload[self.ReloadType](self,self.Owner)
		self.Owner:LagCompensation(false)
	else
		return false
	end
end

function SWEP:ShouldDropOnDie()
	return self.ShouldDropOnDie
end

function SWEP:OnDrop()
	self.Owner:ChatPrint('You dropped your '..self.PrintName)
end

function SWEP:DoImpactEffect(tr,dmgtype)
	if tr.HitSky then
		return true
	end
	util.Decal('fadingscorch',tr.HitPos+tr.HitNormal,tr.HitPos-tr.HitNormal)
	if game.SinglePlayer() || SERVER || !self:IsCarriedByLocalPlayer() || IsFirstTimePredicted()then
		local effect = EffectData()
			effect:SetOrigin(tr.HitPos)
			effect:SetNormal(tr.HitNormal)
		util.Effect(self.Primary.ImpactMark,effect) --util.Effect("blaster_burn",effect)
		local effect = EffectData()
			effect:SetOrigin(tr.HitPos)
			effect:SetStart(tr.StartPos)
			effect:SetDamageType(dmgtype)
		util.Effect('RagdollImpact',effect)
	end
    return true
end

function SWEP:ShootEffects()
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:MuzzleFlash()
	self.Owner:SetAnimation(PLAYER_ATTACK1)
end

function SWEP:MeleeEffects()
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
end

--[[function SWEP:FireAnimationEvent(pos,ang,event,options)
	if !self.CSMuzzleFlashes then return end
	if event == 5001 || event == 5011 || event == 5021 || event == 5031 then
		local data = EffectData()
		data:SetFlags(0)
		data:SetEntity(self.Owner:GetViewModel())
		data:SetAttachment(math.floor((event-4991)/10))
		data:SetScale(6000)
		if self.CSMuzzleX then
			util.Effect('blaster_flash',data)
		else
			util.Effect('blaster_flash',data)
		end
		return true
	end
end]]

--[[local function ShadowText(txt,font,x,y)
	draw.DrawText(txt,font,x+1,y+1,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
	draw.DrawText(txt,font,x,y,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
end
local ChargeBarCol = {White = Color(255,255,255),DefCol1 = Color(255,50,50),DefCol2 = Color(50,255,50)}
local Gradient = Material'gui/gradient'
local function DrawChargeBar(xpos,ypos,width,height,charge,col1,col2)
	draw.NoTexture()
	surface.SetDrawColor(ChargeBarCol.White)
	surface.DrawOutlinedRect(xpos,ypos,width,height)
	charge = math.Clamp(charge || 50,0,100)
	barLen = (width-2)*(charge/100)
	render.SetScissorRect(xpos+1,ypos+1,xpos+1+barLen,(ypos+height)-1,true)
		surface.SetDrawColor(col2 || ChargeBarCol.DefCol2)
		surface.DrawRect(xpos+1,ypos+1,width-1,height-2)
		surface.SetMaterial(Gradient)
		surface.SetDrawColor(col1 || ChargeBarCol.DefCol1)
		surface.DrawTexturedRect(xpos+1,ypos+1,width-1,height-2)
	render.SetScissorRect(xpos+1,ypos+1,xpos+1+barLen,(ypos+height)-1,false)
	draw.NoTexture()
end
function SWEP:DrawHUD()
	if IsValid(self:GetHook()) && self:GetHook():GetHasHit()then
		ShadowText('Rope length: '..tostring(self:GetHook():GetDist()),'hatshook_small',ScrW()/2,ScrH()/2+40)
		ShadowText((input.LookupBinding'+attack' || '[PRIMARY FIRE]'):upper()..' - Retract rope','hatshook_small',ScrW()/2,ScrH()/2+70)
		ShadowText((input.LookupBinding'+attack2' || '[SECONDARY FIRE]'):upper()..' - Extend rope','hatshook_small',ScrW()/2,ScrH()/2+85)
		ShadowText((input.LookupBinding'+reload' || '[RELOAD]'):upper()..' - Break rope','hatshook_small',ScrW()/2,ScrH()/2+100)
		if IsValid(self:GetHook():GetTargetEnt()) && self:GetHook():GetTargetEnt():IsPlayer()then
			DrawChargeBar((ScrW()/2)-70,(ScrH()/2)+20,140,15,self:GetHook():GetDurability())
		else
			ShadowText((input.LookupBinding'+use' || '[USE]'):upper()..' - Jump off','hatshook_small',ScrW()/2,ScrH()/2+115)
		end
	elseif self:GetCooldown()>0 then
		DrawChargeBar((ScrW()/2)-70,(ScrH()/2)+20,140,15,self:GetCooldown())
	end
	if self:Clip1()>=0 then
		ShadowText('Hooks Remaining: '..tostring(self:Clip1()),'hatshook_large',ScrW()/2,ScrH()-50)
	end
	return self.BaseClass.DrawHUD(self)--TTT Crosshair is drawn here, we have to call it
end
--Movement Handling
local function ValidPullEnt(ent)
	if !IsValid(ent) || ent:IsPlayer()then return false end
	local phys = ent:GetPhysicsObject()
	return !IsValid(phys) || (!phys:HasGameFlag(FVPHYSICS_NO_PLAYER_PICKUP) && (phys:GetMass()<=50) && (ent.CanPickup != false) && phys:IsMotionEnabled())
end
function SWEP:PlayerMove(ply,mv,cmd)
	if !(IsValid(self:GetHook()) && self:GetHook().GetHasHit && self:GetHook():GetHasHit())then return end
	if !(IsValid(self.Owner) && IsValid(ply) && self.Owner:Alive() && ply:Alive())then return end
	local hk = self:GetHook()
	if(IsValid(hk:GetTargetEnt()) && hk:GetTargetEnt() ~= self && ply~=hk:GetTargetEnt() && (hk:GetTargetEnt():IsPlayer() || ValidPullEnt(hk:GetTargetEnt())))then return end
	if(hk:GetTargetEnt()==hk || (!(ValidPullEnt(hk:GetTargetEnt()) || hk:GetTargetEnt():IsPlayer()))) && ply~=self.Owner then return end
	if !(ply.InVehicle && self.Owner.InVehicle)then hk:Remove() self:SetCooldown(10) return end -- What
	if ply:InVehicle() || self.Owner:InVehicle() || (!ply:Alive())then hk:Remove() self:SetCooldown(10) return end
	if ply~=self.Owner then
		ply.was_pushed = {t=CurTime(),att=self.Owner}
	end
	if ply:KeyPressed(IN_USE) && ply==self.Owner then
		if hk:GetPos()[3] > ply:GetShootPos()[3] then
			mv:SetVelocity(mv:GetVelocity()+Vector(0,0,300))
		end
		if SERVER then self:SetCooldown(10) hk:Remove() end
	end
	local TargetPoint = hk:GetPos()
	local ApproachDir = (TargetPoint-ply:GetPos()):GetNormal()
	local ShootPos = self.Owner:GetShootPos()+(Vector(0,0,(self.Owner:Crouching() && 0) || (hk:GetUp()[1]>0.9 && -45) || 0))
	local Distance = hk:GetDist()
	if ply~=self.Owner then--Swap direction
		TargetPoint = ShootPos
		ShootPos = ply:GetShootPos()+(Vector(0,0,(ply:Crouching() && 0) || (hk:GetUp()[1]>0.9 && -45) || 0))
		ApproachDir = (TargetPoint-ply:GetPos()):GetNormal()
	end
	local DistFromTarget = ShootPos:Distance(TargetPoint)
	if DistFromTarget<(Distance+5)then return end--5 units off actual distance
	local TargetPos = TargetPoint-(ApproachDir*Distance)
	local xDif = math.abs(ShootPos[1]-TargetPos[1])
	local yDif = math.abs(ShootPos[2]-TargetPos[2])
	local zDif = math.abs(ShootPos[3]-TargetPos[3])
	--local speedMult = ((DistFromTarget*0.01)^1.1)
	local speedMult = 3+((xDif + yDif)*0.5)^1.01
	local vertMult = math.max((math.Max(300-(xDif+yDif),-10)*0.08)^1.01+(zDif/2),0)
	if ply~=self.Owner && self.Owner:GetGroundEntity()==ply then vertMult = -vertMult end
	local TargetVel = (TargetPos-ShootPos):GetNormal()*10
	TargetVel[1] = TargetVel[1]*speedMult
	TargetVel[2] = TargetVel[2]*speedMult
	TargetVel[3] = TargetVel[3]*vertMult
	local dir = mv:GetVelocity()
	local clamp = 50
	local vclamp = 20
	local accel = 200
	local vaccel = 30*(vertMult/50)
	dir[1] = (dir[1]>TargetVel[1]-clamp || dir[1]<TargetVel[1]+clamp) && math.Approach(dir[1],TargetVel[1],accel) || dir[1]
	dir[2] = (dir[2]>TargetVel[2]-clamp || dir[2]<TargetVel[2]+clamp) && math.Approach(dir[2],TargetVel[2],accel) || dir[2]
	if ShootPos[3]<TargetPos[3] then
		dir[3] = (dir[3]>TargetVel[3]-vclamp || dir[3]<TargetVel[3]+vclamp) && math.Approach(dir[3],TargetVel[3],vaccel) || dir[3]
		if vertMult>0 then self.ForceJump=ply end
	end
	mv:SetVelocity(dir)
	--return mv
end
local function ForceJump(ply)
	if !(IsValid(ply) && ply:IsPlayer())then return end
	if !ply:OnGround()then return end
	local tr = util.TraceLine({start = ply:GetPos(),endpos = ply:GetPos()+Vector(0,0,20),filter = ply})
	if tr.Hit then return end
	ply:SetPos(ply:GetPos()+Vector(0,0,5))
end
function SWEP:Think()
	if self.ForceJump then
		if IsValid(self.Owner) && self.ForceJump==self.Owner then
			ForceJump(self.Owner)
		elseif IsValid(self:GetHook()) && IsValid(self:GetHook():GetTargetEnt()) && self.ForceJump == self:GetHook():GetTargetEnt()then
			ForceJump(self.ForceJump)
		end
		self.ForceJump = nil
	end
	if SERVER then
		self:EntityPull()
		if self:Clip1()==0 && !IsValid(self:GetHook())then
			self:Remove()
		end
	end
end
function SWEP:EntityPull()--For pulling entities
	local hk = self:GetHook()
	if IsValid(self.Owner) && IsValid(hk) && hk.GetTargetEnt && IsValid(hk:GetTargetEnt()) && ValidPullEnt(hk:GetTargetEnt())then
		local ply = hk:GetTargetEnt()
		local phys = ply:GetPhysicsObject()
		if ply:IsPlayer() || (!IsValid(phys))then return end
		local TargetPoint = self.Owner:GetShootPos()
		local ShootPos = ply:GetPos()
		local ApproachDir = (TargetPoint-ply:GetPos()):GetNormal()
		local Distance = hk:GetDist()
		local DistFromTarget = ShootPos:Distance(TargetPoint)
		if DistFromTarget<(Distance+5)then return end
		local TargetPos = TargetPoint-(ApproachDir*Distance)
		local xDif = math.abs(ShootPos[1]-TargetPos[1])
		local yDif = math.abs(ShootPos[2]-TargetPos[2])
		local zDif = math.abs(ShootPos[3]-TargetPos[3])
		--local speedMult = ((DistFromTarget*0.01)^1.1)
		local speedMult = 3+((xDif+yDif)*0.5)^1.01
		local vertMult = math.max((math.Max(100-(xDif + yDif),-10)*0.1)^1.01+(zDif/2),0)
		if self.Owner:GetGroundEntity()==ply then vertMult = -vertMult end
		local TargetVel = (TargetPos-ShootPos):GetNormal()*6*(1-(phys:GetMass()/50))
		TargetVel[1] = TargetVel[1]*speedMult
		TargetVel[2] = TargetVel[2]*speedMult
		TargetVel[3] = TargetVel[3]*vertMult
		local dir = ply:GetVelocity()
		local clamp = 50
		local vclamp = 20
		local accel = 200
		local vaccel = 40*(vertMult/50)
		dir[1] = (dir[1]>TargetVel[1]-clamp || dir[1]<TargetVel[1]+clamp) && math.Approach(dir[1],TargetVel[1],accel) || dir[1]
		dir[2] = (dir[2]>TargetVel[2]-clamp || dir[2]<TargetVel[2]+clamp) && math.Approach(dir[2],TargetVel[2],accel) || dir[2]
		if ShootPos[3]<TargetPos[3] && vertMult~=0 then
			dir[3] = (dir[3]>TargetVel[3]-vclamp || dir[3]<TargetVel[3]+vclamp) && math.Approach(dir[3],TargetVel[3],vaccel) || dir[3]
		end
		phys:SetVelocity(dir)
	end
end
SWEP.VElements = {
	['gun'] = {type = 'Model',model = 'models/weapons/w_alyx_gun.mdl',bone = 'ValveBiped.square',rel = '',pos = Vector(1.1,-1.1,-1.4),angle = Angle(-100,146,68),size = Vector(1,1,1),color = Color(255,255,255,255)}
}]]

if CLIENT then
	Vaas = Vaas || {}

	--related to grapple
	--surface.CreateFont('hatshook_small',{size=15})
	--surface.CreateFont('hatshook_large',{size=25,weight=1000})

	if !Vaas.CS then
		local ent = ClientsideModel('models/player/kleiner.mdl')
		ent:SetNoDraw(true)
		Vaas.CS = ent
	end
	
	function SWEP:QuickRenderEnt(data,vm)
		local pos = data.Pos
		local ang = data.Ang
		local bone = data.Bone
		local mdl = data.Model
		local scale = data.Scale || 1
		vm = vm || self
		if bone then
			local boneid = vm:LookupAttachment(bone)
			if boneid then
				local PosAng = vm:GetAttachment(boneid)
				pos = pos+PosAng.Pos
				ang = ang+PosAng.Ang
			else
				if(self.NextBoneError || 0) < CurTime()then
					self.Owner:ChatPrint(self:GetClass()..' has an issue with bone '..bone..' if this model is an error ignore this print ')
					self.NextBoneError = CurTime()+300
				end
			end
		end
		if !mdl then return end
		Vaas.CS:SetModel(mdl)
		Vaas.CS:SetAngles(ang)
		Vaas.CS:SetPos(pos)
		Vaas.CS:SetModelScale(scale)
		if data.PreRender then
			data.PreRender(self,Vaas.CS,data)
		end
		Vaas.CS:SetupBones()
		Vaas.CS:DrawModel()
		if data.PostRender then
			data.PostRender(self,Vaas.CS,data)
		end
	end

	function SWEP:PostDrawViewModel(vm,wep,ply)
		for index,data in pairs((wep.ExtraModels || {})['View'] || {})do -- This is a mess but this will prevent older weapons from causing script errors
			wep:QuickRenderEnt(data,vm)
		end
	end

	function SWEP:DrawWorldModel()
		if self.EnableWM == true then
			self:DrawModel()
		end
		for index,data in pairs((self.ExtraModels || {})['World'] || {})do
			self:QuickRenderEnt(data)
		end
	end

	function SWEP:DrawWorldModelTranslucent()
		self:DrawModel()
		for index,data in pairs((self.ExtraModels || {})['World'] || {})do
			self:QuickRenderEnt(data)
		end
	end

	function SWEP:ShouldDrawViewModel()
		if self.EnableVM == true then
			return true
		else
			return false
		end
	end

	--[[function SWEP:DrawHUD()
	end]]

	--[[function SWEP:PrintWeaponInfo(x,y,alpha)
		if self.DrawWeaponInfoBox == false then return end
		if self.InfoMarkup == nil then
			local str
			local title_color = '<color=230,230,230,255>'
			local text_color = '<color=150,150,150,255>'
			str = '<font=HudSelectionText>'
			if self.Author != '' then str = str..title_color..'Author:</color>\t'..text_color..self.Author..'</color>\n' end
			if self.Contact != '' then str = str..title_color..'Contact:</color>\t'..text_color..self.Contact..'</color>\n\n' end
			if self.Purpose != '' then str = str..title_color..'Purpose:</color>\n'..text_color..self.Purpose..'</color>\n\n' end
			if self.Instructions != '' then str = str..title_color..'Instructions:</color>\n'..text_color..self.Instructions..'</color>\n' end
			str = str..'</font>'
			self.InfoMarkup = markup.Parse(str,250)
		end
		surface.SetDrawColor(60,60,60,alpha)
		surface.SetTexture(self.SpeechBubbleLid)
		surface.DrawTexturedRect(x,y-64-5,128,64)
		draw.RoundedBox(8,x-5,y-6,260,self.InfoMarkup:GetHeight()+18,Color(60,60,60,alpha))
		self.InfoMarkup:Draw(x+5,y+5,nil,nil,alpha)
	end]]

	--[[function SWEP:CustomAmmoDisplay()
	end

	function SWEP:GetViewModelPosition(pos,ang)
		return pos,ang
	end

	function SWEP:TranslateFOV(current_fov)
		return current_fov
	end]]

	function SWEP:Holster(wep)
		if !IsFirstTimePredicted()then return end
		if self.RPActions == true then
			LocalPlayer():ChatPrint('You holstered your '..self.PrintName..' and equiped your '..(wep.PrintName || wep:GetClass()))
		end
	end
end
