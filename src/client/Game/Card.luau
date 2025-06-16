--!strict

type CardState = {
	Turned: boolean,
	Turning: boolean,
	Locked: boolean,
}

export type Data = {
	new: (self: Data, model: Instance) -> Data,
	Turn: (self: Data, duration: number) -> (),
	Model: Model,
	Property: any,
	State: CardState,
}
type _Data = {}

local Card = {}
Card.__index = Card

type Card = setmetatable<_Data, typeof(Card)> & Data

function Card.new(model: Model, property: any): Card
	local self = setmetatable({}, Card) :: Card
	self:constructor(model, property)
	return self
end

function Card.constructor(self: Card, model: Model, property: any)
	self.Model = model:Clone()
	self.Model.Parent = workspace
	
	self.Property = property
	self.State = {
		Turned = false,
		Turning = false,
		Locked = false,
	}
end

-- TODO remove visual logic out entirely
function Card.Turn(self: Card, duration: number)
	if self.State.Turning == false and self.State.Locked == false then
		self.State.Turning = true -- beta typechecker infers this insanely weridly

		-- task.wait(duration) might be sufficent but unsure if thread blocking
		task.delay(duration, function()
			self.State.Turning = false
			self.State.Turned = not self.State.Turned
		end)
	end

	--[[
	local elapsed = 0
	local start = self.Model:GetPivot()
	local goal = start * CFrame.Angles(math.rad(180), 0, 0)
	RunService:BindToRenderStep("Turn", 0, function(dt)
		elapsed += dt
		local alpha = math.clamp(elapsed / duration, 0, 1)
		local current = start:Lerp(goal, alpha)
		self.Model:PivotTo(current)
		if alpha >= 1 then
			RunService:UnbindFromRenderStep("Turn")
		end
	end)
	]]
end

function Card.Match(self: Card, property)
	if self.Property == property then
		return true
	end

	return false
end

return Card
