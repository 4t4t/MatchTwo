--!strict
local CardLogic = require(script.Parent.CardLogic)

export type Data = {
	new: (self: Data) -> Data,
	Debug: (self: Data) -> (),
	GetCards: (self: Data) -> { CardLogic.Data },
	Deal: (self: Data, properties: { any }, mult: number) -> (),
	Shuffle: (self: Data) -> (),
	Find: (self: Data, UIDX: number) -> CardLogic.Data?,
}

type _Data = {
	Cards: { CardLogic.Data },
}

local Deck = {}
Deck.__index = Deck

type Deck = setmetatable<_Data, typeof(Deck)> & Data

function Deck.new(): Deck
	local self = setmetatable({}, Deck) :: Deck
	self:constructor()
	return self
end

function Deck.constructor(self: Deck)
	self.Cards = {}
end

function Deck.Deal(self: Deck, properties: { any }, mult: number)
	for _, property in properties do

		for i = 1, mult do
			table.insert(self.Cards, CardLogic.new(property))
		end
	end
end

function Deck.GetCards(self: Deck): { CardLogic.Data }
	return self.Cards
end

function Deck.Shuffle(self: Deck)
	if #self.Cards <= 0 then
		return
	end

	for i, _ in self:GetCards() do
		local j = math.random(1, i)

		self.Cards[i], self.Cards[j] = self.Cards[j], self.Cards[i]
	end
end

function Deck.Find(self: Deck, UIDX: number): CardLogic.Data?
	for _, card in self:GetCards() do
		if card.UIDX == UIDX then
			return card
		end
	end

	return nil
end

function Deck.Debug(self: Deck)
	for i, card in self:GetCards() do
		print(`Card Property at {i}, Property: {card.Property}, UIDX: {card.UIDX}`)
	end
end

return Deck