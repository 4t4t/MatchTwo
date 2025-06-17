--!strict
local ProcessInstancePhysicsService = game:GetService("ProcessInstancePhysicsService")
local InputAction = require(script.Parent.Utils.InputAction)

local DeckLogic = require(script.Parent.Game.DeckLogic)

local Deck = DeckLogic.new()

Deck:Deal({
    "A",
    "B",
    "C",
    "D",
    "E",
})

Deck:Debug()

print("------------------")

Deck:Shuffle()

Deck:Debug()