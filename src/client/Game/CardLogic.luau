--!strict

type CardState = {
	Turned: boolean,
	Locked: boolean,
}

export type Data = {
	Turn: (self: Data) -> (),
	Lock: (self: Data) -> (),
	MatchProperty: (self: Data, Card: Data) -> (),
	GetUIDX: (self: Data) -> number,
	Property: any,
}

type _Data = {
	State: CardState,
	UIDX: number,
}

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
		Locked = false,
	}

	iterator += 1 
end

function Card.Turn(self: Card): ()
	if self.State.Locked == false :: boolean then
		self.State.Turned = not self.State.Turned
	end
end

function Card.Lock(self: Card): ()
	self.State.Locked = true
end

function Card.MatchProperty(self: Card, Card: Card): boolean
	if self.Property == Card.Property then
		return true
	end

	return false
end

function Card.GetUIDX(self: Card): number
	return self.UIDX
end

return Card