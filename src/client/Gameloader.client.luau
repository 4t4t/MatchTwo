--!strict
local DeckLogic = require("./Game/DeckLogic")

local Deck = DeckLogic.new()

Deck:Deal({"A", "B"}, 2)

Deck:Shuffle()
Deck:Debug()



local bool = Deck:Match(Deck:FindUIDX(1), Deck:FindUIDX(2))
print(`result: {bool}`)