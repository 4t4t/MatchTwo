--!strict

type CardState = {
	Turned: boolean,
	Turning: boolean,
	Locked: boolean,
}

export type Data = {
	Turn: (self: Data, duration: number) -> (),
	MatchProperty: (self: Data, Card: Data) -> (),
	UIDX: number,
	Property: any,
	State: CardState,
}

type _Data = {}

local iterator = 1

local Card = {}
Card.__index = Card

type Card = setmetatable<_Data, typeof(Card)> & Data

function Card.new(property: any): Card
	local self = setmetatable({}, Card) :: Card
	self:constructor(property)
	return self
end

function Card.constructor(self: Card, property: any)
	self.Property = property
	self.UIDX = iterator

	self.State = {
		Turned = false,
		Turning = false,
		Locked = false,
	}

	iterator += 1 
end

function Card.Turn(self: Card, duration: number): ()
	if (self.State.Turning == false and self.State.Locked == false) :: boolean then
		self.State.Turning = true

		-- Not sure if logic should account for visual changes, but probably yes
		task.delay(duration, function()
			self.State.Turning = false
			self.State.Turned = not self.State.Turned
		end)
	end
end

function Card.MatchProperty(self: Card, Card: Card): boolean
	if self.Property == Card.Property then
		return true
	end

	return false
end

return Card