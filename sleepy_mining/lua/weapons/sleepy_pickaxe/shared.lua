SWEP.Author              		= "Sleepy"
SWEP.Contact             		= "www.sleepy.online"
SWEP.Purpose             		= "Mine the rocks!"
SWEP.Instructions        		= "Left click to mine."
SWEP.Category 					= "www.ViscaGaming.com"

SWEP.Spawnable                  = true
SWEP.AdminSpawnable             = true

SWEP.ViewModel                  = "models/weapons/v_mgs_pickaxe.mdl"
SWEP.WorldModel					= "models/weapons/w_mgs_pickaxe.mdl"
SWEP.HoldType   				= "normal"
SWEP.Cooldown 					= 1
SWEP.ShootDistance 				= 470

SWEP.Primary.ClipSize           = -1
SWEP.Primary.DefaultClip        = -1
SWEP.Primary.Automatic          = false
SWEP.Primary.Ammo               = "none"
SWEP.Primary.Spread 			= 0.1
SWEP.Primary.Recoil 			= .2

SWEP.Secondary.ClipSize         = -1
SWEP.Secondary.DefaultClip      = -1
SWEP.Secondary.Automatic        = true
SWEP.Secondary.Ammo             = "none"

function SWEP:PrimaryAttack()
tr = self.Owner:GetEyeTrace()
startpos = tr.StartPos
hitpos = tr.HitPos

	if tr.Entity:GetClass() == "sleepy_rock" and self.Owner:GetPos():Distance( tr.Entity:GetPos() ) < Sleepy_MiningDistance && tr.Entity:GetNWBool("active",true) then
		sound.Play( "physics/metal/metal_canister_impact_soft3.wav", Vector( self:GetPos() ), 75, 100, 0.2 )
		tr.Entity:SetHealth(tr.Entity:Health() - 1)
	else end
end

function SWEP:SecondaryAttack()
end
