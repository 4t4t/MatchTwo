--!strict
local CardLogic = require("./Game/CardLogic")
local InputAction = require(script.Parent.Utils.InputAction)
local DeckLogic = require(script.Parent.Game.DeckLogic)

local Deck = DeckLogic.new()

Deck:Deal({"A", "B", "C", "D"}, 2)

local FirstCard = Deck:Find(1) :: CardLogic.Data

Deck:Shuffle()
Deck:Debug()

for _, card in Deck:GetCards() do
    if card == FirstCard then
        continue
    end

    if card:Match(FirstCard) then
        print("Found Match:", card)
        break
    end
end