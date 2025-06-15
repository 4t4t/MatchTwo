--!strict
local Card = require(script.Parent.Game.Card)
local Model = game.ReplicatedStorage.Assets.Card :: Model
local card = Card.new(Model)

while task.wait(1) do
    card:Turn(0.75)
end

