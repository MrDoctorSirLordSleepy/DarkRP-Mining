AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("cl_init.lua")
include("shared.lua")

local SleepyOres = {
"sleepy_gold",
"sleepy_ruby",
"sleepy_diamond",

}

function ENT:Initialize()
	self:SetModel( table.Random( RockModels ) )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
	self:SetHealth( math.random(Sleepy_RockMinHealth, Sleepy_RockMaxHealth) )
	self:SetModelScale( self:GetModelScale() * 0.80, 0)
	
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

function ENT:RespawningRock()
	local spawnPos = self:GetPos()
	self:Remove()
		local ore = ents.Create( table.Random( SleepyOres ) )
			ore:SetPos(spawnPos)
			ore:Spawn()
			SpawnRocks()
end

function SpawnRocks()
	

	local StoredRockData = {}
		if file.Exists( "sleepy_mining/" .. game.GetMap() .. ".txt" ,"DATA") then
			StoredRockData = util.JSONToTable(file.Read( "sleepy_mining/" .. game.GetMap() .. ".txt" ))
		end
		
		hook.Add("EntityRemoved", "SleepyRockRemoved", function(ent)
			if ent:GetClass() == "sleepy_rock" && ent:Health() < 1 then
			local pos = ent:GetPos()
			local ang = ent:GetAngles()
				timer.Simple(Sleepy_RockRegenTime, function()
					local rock = ents.Create("sleepy_rock")
						rock:SetPos(pos)
						rock:SetAngles(ang)
						rock:Spawn()
						rock:GetPhysicsObject():EnableMotion(false);
				end)
			end
		end)
		

end

function SetRocksPos(ply)

	if not file.IsDir("sleepy_mining/", "DATA") then
		file.CreateDir("sleepy_mining/", "DATA")
	end
	
	local Sleepy_Rocks = {}
	
	for k, v in pairs(ents.FindByClass("sleepy_rock")) do
	
		local Sleepy_Rock = {}
		Sleepy_Rock.Pos = v:GetPos()
		Sleepy_Rock.Angle = v:GetAngles()
		table.insert(Sleepy_Rocks,Sleepy_Rock)
		
	end
	
	file.Write("sleepy_mining/" .. string.lower(game.GetMap()) .. ".txt", util.TableToJSON(Sleepy_Rocks))
end
concommand.Add("mining_saverocks", function(ply,cmd,args)

	if (table.HasValue(Sleepy_AdminRanks, ply:GetUserGroup())) then
		SetRocksPos()
		ply:PrintMessage( HUD_PRINTCONSOLE, "All rocks have been saved to the map." );
	else
		ply:PrintMessage( HUD_PRINTCONSOLE, "You need to be an admin to save the rocks!" );
	end
	
end)

function DeleteAllSavedRocks()

	if file.Exists("sleepy_mining/" .. string.lower(game.GetMap()) .. ".txt", "DATA") then
		file.Delete("sleepy_mining/" .. string.lower(game.GetMap()) .. ".txt")
		for k, v in pairs(ents.FindByClass("sleepy_rock")) do
			v:Remove()
		end
	else end
end
concommand.Add("mining_deleteallrocks", function(ply,cmd,args)

	if (table.HasValue(Sleepy_AdminRanks, ply:GetUserGroup())) then
		DeleteAllSavedRocks()
		ply:PrintMessage( HUD_PRINTCONSOLE, "All rocks on the map have been deleted." );
	else
		ply:PrintMessage( HUD_PRINTCONSOLE, "You need to be an admin to save the rocks!" );
	end
	
end)

hook.Add( "InitPostEntity", "RockzSpawnz", function()

	local StoredRockData = {}
		if file.Exists( "sleepy_mining/" .. game.GetMap() .. ".txt" ,"DATA") then
			StoredRockData = util.JSONToTable(file.Read( "sleepy_mining/" .. game.GetMap() .. ".txt" ))
		end
		
	for k,v in pairs(StoredRockData) do
			local SleepyRock = ents.Create("sleepy_rock")
			SleepyRock:SetPos(v.Pos)
			SleepyRock:SetAngles(v.Angle)
			SleepyRock:Spawn()
		end

end)

function ENT:Think()

if self:Health() < 1 then
		self:RespawningRock()
		return true
end

end

