--!strict
local ProcessInstancePhysicsService = game:GetService("ProcessInstancePhysicsService")
local InputAction = require(script.Parent.Utils.InputAction)

local DeckLogic = require(script.Parent.Game.DeckLogic)

local Deck = DeckLogic.new()

Deck:Deal({1,2,3,4,5,6,7})

Deck:Debug()

print("------------------")

Deck:Shuffle()

Deck:Debug()