--!strict

export type Data = {
	Lock: (self: Data) -> (),
	MatchProperty: (self: Data, Card: Data) -> (),
	GetUIDX: (self: Data) -> number,
	GetLocked: (self: Data) -> boolean,
	Property: any,
}

type _Data = {
	UIDX: number,
	Locked: boolean,
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
	self.Locked = false

	iterator += 1 
end

function Card.Lock(self: Card): ()
	self.Locked = true
end

function Card.MatchProperty(self: Card, Card: Card): boolean
	if self.Locked or Card.Locked then
		return false
	end
	
	if self.Property == Card.Property then
		return true
	end

	return false
end

function Card.GetUIDX(self: Card): number
	return self.UIDX
end

function Card.GetLocked(self: Card): boolean
	return self.Locked
end

return Card