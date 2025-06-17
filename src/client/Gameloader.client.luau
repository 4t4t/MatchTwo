--!strict
local CardLogic = require("./Game/CardLogic")
local DeckLogic = require("./Game/DeckLogic")

local Deck = DeckLogic.new()

Deck:Deal({"A", "B"}, 2)

local FirstCard = Deck:Find(1) :: CardLogic.Data

Deck:Shuffle()
Deck:Debug()

for _, card in Deck:GetCards() do
    if card == FirstCard then
        continue
    end

   if card:MatchProperty(FirstCard) then
        print("Found Match", card)
   end
end