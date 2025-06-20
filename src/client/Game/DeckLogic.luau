--!strict

local CardLogic = require("./CardLogic")

export type Data = {
	Debug: (self: Data) -> (),
	GetCards: (self: Data) -> { CardLogic.Data },
	SetCards: (self: Data, cards: { CardLogic.Data }) -> (),
	FindUIDX: (self: Data, UIDX: number) -> CardLogic.Data?,
	Deal: (self: Data, properties: { any }, mult: number) -> (),
	Shuffle: (self: Data) -> (),
	Match: (self: Data, ... CardLogic.Data) -> boolean,
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

function Deck.GetCards(self: Deck): { CardLogic.Data }
	return self.Cards
end

function Deck.SetCards(self: Deck, cards: { CardLogic.Data })
	self.Cards = cards
end

function Deck.FindUIDX(self: Deck, UIDX: number): CardLogic.Data?
	local cards = self:GetCards()

	for i = 1, #cards do
		if cards[i]:GetUIDX() == UIDX then
			return cards[i]
		end
	end

	return nil
end

function Deck.Deal(self: Deck, properties: { any }, mult: number): ()
	for _, property in properties do

		for i = 1, mult do
			table.insert(self.Cards, CardLogic.new(property))
		end
	end
end

function Deck.Shuffle(self: Deck): ()
	if #self.Cards <= 0 then
		return
	end

	for i = 1, #self.Cards do
		local j = math.random(1, i)


		self.Cards[i], self.Cards[j] = self.Cards[j], self.Cards[i]
	end
end

-- maybe implement point matching system. what the fuck
function Deck.Match(self: Deck, ...: CardLogic.Data): boolean
	local cards = table.pack(...)
	local first = cards[1]

	for i = 2, #cards do
		if not cards[i]:MatchProperty(first) or cards[i]:GetLocked() then
			return false
		end
	end

	for i = 1, #cards do
		cards[i]:Lock()
	end

	return true
end

function Deck.Debug(self: Deck): ()
	local cards = self:GetCards()

	for i = 1, #cards do
		print(`Card: property: {cards[i].Property}, index: {i}, UIDX: {cards[i]:GetUIDX()}`)
	end
end

return Deck