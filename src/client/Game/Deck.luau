--!strict
local Card = require(script.Parent.Card)

export type Data = {
	Deal: (self: Data, properties: { any }) -> (),
    Cards: { Card.Data }
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

		table.insert()
	end
end

return Deck
