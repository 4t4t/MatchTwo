--!strict
local DeckLogic = require("./Game/DeckLogic")

local Deck = DeckLogic.new()

Deck:Deal({"A", "B", "C"}, 2)

Deck:Shuffle()
Deck:Debug()

local c1 = Deck:FindUIDX(1)
local c2 = Deck:FindUIDX(2)

local bool = Deck:Match(c1, c2)
print(`result: {bool}`)