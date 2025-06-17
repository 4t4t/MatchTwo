--!strict
local CardLogic = require(script.Parent.CardLogic)

export type Data = {
	Deal: (self: Data, properties: { any }) -> (),
	Cards: { CardLogic.Data },
}

type _Data = {}

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

function Deck.Deal(self: Deck, properties: { any })
	for _, property in properties do
		table.insert(self.Cards, CardLogic.new(property))
		table.insert(self.Cards, CardLogic.new(property))
	end
end

function Deck.Shuffle(self: Deck)
	local DECK_SIZE = #self.Cards
	if DECK_SIZE <= 0 then
		return
	end

	for i, _ in self.Cards do
		local j = math.random(1, i)

		self.Cards[i], self.Cards[j] = self.Cards[j], self.Cards[i]
	end
end

function Deck.Debug(self: Deck)
	for i, card in self.Cards do
		print(`Card Property at {i}. Property: {card.Property}. UIDX: {card.UIDX}`)
	end
end

return Deck
