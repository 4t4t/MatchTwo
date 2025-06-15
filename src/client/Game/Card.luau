--!strict
local RunService = game:GetService("RunService")

type CardState = {
	Turned: boolean,
	Turning: boolean,
	Locked: boolean,
}

export type Data = {
	new: (self: Data, model: Instance) -> Data,
	Card: Model,
	State: CardState,
}
type _Data = {}

local Card = {}
Card.__index = Card

type Card = setmetatable<_Data, typeof(Card)> & Data

function Card.new(card: Model): Card
	local self = setmetatable({}, Card) :: Card
	self:constructor(card)
	return self
end

function Card.constructor(self: Card, card: Model)
	self.Card = card:Clone()
	self.Card.Parent = workspace

	self.State = {
		Turned = false,
		Turning = false,
		Locked = false,
	}
end

function Card.Turn(self: Card, duration: number)
	if (self.Card and not self.State.Turning and not self.State.Locked) then
		self.State.Turning = true
		local elapsed = 0

		local start = self.Card:GetPivot()
		local goal = start * CFrame.Angles(math.rad(180), 0, 0)

		RunService:BindToRenderStep("Turn", 0, function(dt)
			elapsed += dt

			local alpha = math.clamp(elapsed / duration, 0, 1)
			local current = start:Lerp(goal, alpha)
			self.Card:PivotTo(current)

			if alpha >= 1 then
				RunService:UnbindFromRenderStep("Turn")
				self.State.Turning = false
				self.State.Turned = not self.State.Turned
			end
		end)
	end
end

function Card.Lock(self: Card)
	self.State.Locked = true
end

return Card
