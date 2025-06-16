--!strict
local CardLogic = require(script.Parent.CardLogic)

export type Data = {
	Deal: (self: Data, properties: { any }) -> (),
    Cards: { [number]: { [number]: CardLogic.Data } },
	Front: { X: number, Y: number, },
}

type _Data = {}

-- maybe take this in constructor?
local DECK_WIDTH = 6

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
	self.Front = {
		X = 1,
		Y = 1,
	}
end

local function IncrementFront(self: Deck)
	 if self.Front.X >= DECK_WIDTH then
		self.Front.X = 1
		self.Front.Y += 1
	else
		self.Front.X += 1
	end
end

-- Fix repeations using functions idk something smart
function Deck.Deal(self: Deck, properties: { any })
	for _, property in properties do
		local newCard = CardLogic.new(property)

		if self.Cards[self.Front.X] == nil then
			self.Cards[self.Front.X] = {}
		end
		
		self.Cards[self.Front.X][self.Front.Y] = newCard
		IncrementFront(self)
	end
end

-- fix this iteration too
function Deck.Shuffle(self: Deck)
	local DECK_SIZE = #self.Cards
	if DECK_SIZE <= 0 then
		return
	end

	for x, col in self.Cards do
		for y, card in col do
		local z, w = math.random(1, x), math.random(1, y)
		
		self.Cards[x][y], self.Cards[z][w] = self.Cards[z][w], self.Cards[x][y]
		end
	end
end

-- fix this
function Deck.Debug(self: Deck)
	for x, col in self.Cards do
		for y, card in col do
			print(`Card property at ({x}, {y}) =`, card.Property)
		end
	end
end


return Deck