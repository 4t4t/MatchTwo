--!strict
local InputAction = require(script.Parent.Utils.InputAction)
local Card = require(script.Parent.Game.Card)

local Model = game.ReplicatedStorage.Assets.Card :: Model
local card = Card.new(Model)

local TurnAction = InputAction.new(Enum.UserInputType.Keyboard, true)
TurnAction:BindTo({Enum.KeyCode.F})
TurnAction:SubscribeBegan(function()
    card:Turn(0.75)
end)

