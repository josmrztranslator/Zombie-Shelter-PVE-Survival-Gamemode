ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName 		= "ZShelter Mini Turret"
ENT.Author 			= "Meika"
ENT.Contact 		= ""
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= "ZShelter"

ENT.ModelScale = 8
ENT.ModelYaw = 0
ENT.ModelAlpha = 0

if(CLIENT) then
	ENT.LastDrawTime = 0
	function ENT:Draw()
		self:DrawModel()
		if(!self:GetNWBool("Completed", false)) then return end
		if(!IsValid(self.FXModel)) then
			self.FXModel = ClientsideModel("models/zshelter/scenariotx_scan.mdl")
			self.FXModel:SetPos(self:GetPos() + Vector(0, 0, 43.5 * self.ModelScale))
			self.FXModel:SetModelScale(self.ModelScale, 0)
			self.FXModel:SetRenderMode(RENDERMODE_TRANSCOLOR)
			self.FXModel:SetColor(Color(255, 255, 255, 30))
		else
			self.ModelYaw = self.ModelYaw - ZShelter.GetFixedValue(0.85)
			if(self.ModelYaw <= -360) then
				self.ModelYaw = 0
			end
			self.FXModel:SetAngles(Angle(0, self.ModelYaw, 0))
		end
		self.LastDrawTime = SysTime() + 0.5
	end

	function ENT:OnRemove()
		if(IsValid(self.FXModel)) then
			self.FXModel:Remove()
		end
	end

	function ENT:Think()
		if(!self:GetNWBool("Completed", false)) then return end
		if(IsValid(self.FXModel)) then
			if(self.LastDrawTime < SysTime()) then
				self.ModelAlpha = math.Clamp(self.ModelAlpha - ZShelter.GetFixedValue(3), 0, 40)
			else
				self.ModelAlpha = math.Clamp(self.ModelAlpha + ZShelter.GetFixedValue(3), 0, 40)
			end
			self.FXModel:SetColor(Color(255, 255, 255, self.ModelAlpha))
		end
	end
end

