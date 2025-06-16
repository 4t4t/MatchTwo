--!strict
local InputAction = require(script.Parent.Utils.InputAction)

local DeckLogic = require(script.Parent.Game.DeckLogic)


local Deck = DeckLogic.new()
Deck:Deal({
    "A",
    "B",
    "C",
})

Deck:Debug()
Deck:Shuffle()
Deck:Debug()