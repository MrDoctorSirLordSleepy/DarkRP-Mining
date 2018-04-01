AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("cl_init.lua")
include("shared.lua")


function ENT:Initialize()
	self:SetModel( table.Random( OreModels ) )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
	self:SetHealth( 100 )
	self:SetColor( Sleepy_Ore3Color )
	

	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end
	end

function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local SpawnPos = ply:GetShootPos() + ply:GetForward()*80

	local ent = ents.Create( ClassName )
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	return ent
end



function ENT:Use(activator, caller)
	
	caller:addMoney(Sleepy_Ore3SellPrice)	
	self:Remove()
	caller:SendLua("local messagetoclient = {Color(200,200, 50,255), [[Mining: ]], Color(255,255,255), [[You have sold your ]] .. string.lower(Sleepy_Ore3Name) .. [[ for $]] .. Sleepy_Ore3SellPrice } chat.AddText(unpack(messagetoclient))")
	

end

function ENT:Think()


end

