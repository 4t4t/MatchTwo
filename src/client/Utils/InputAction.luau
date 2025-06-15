--!strict
local RS = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")

type UserKeyInputs = Enum.KeyCode
type Subscription = { Unsubscribe: (self: Subscription) -> () } 

type Action = {
	BindTo: (self: Action, key : {UserKeyInputs}) -> (),
	SubscribeBegan: (self: Action, func: () -> (), any) -> Subscription,
	SubscribeEnded: (self: Action, func: () -> (), any) -> Subscription,
	SubscribeChanged: (self: Action, func: () -> (), any) -> Subscription,
	Destroy: (self: Action) -> (),
}

export type _Action = {
	Bindings: { RBXScriptConnection },
	KeyCodes: { Enum.KeyCode },
	InputType: Enum.UserInputType,
	Destroyed: boolean,
	ToProcess: boolean,
}

type Funct = (input: any) -> ()

-- slighty shit module
local Class = {}
Class.__index = Class

type Class = typeof(setmetatable({} :: _Action, Class)) & Action

function Class.new(InputType: Enum.UserInputType,toprocess: boolean)
	local self = setmetatable({},Class) :: Class
	self:constructor(InputType, toprocess)
	return self
end

function Class.constructor(self: Class, InputType, toprocess)
	self.InputType = InputType
	self.ToProcess = toprocess
	self.Bindings = {}
end

local function Connect(self: Class, InputSignal: RBXScriptSignal, func: Funct) : Subscription
	local signal = InputSignal:Connect(function(input, gameprocessed)
		if self.ToProcess == true and gameprocessed == true then return	end

		if input.UserInputType == self.InputType then
			if self.KeyCodes == nil then
				task.spawn(func, input)
				return
			end
			
			for _, KeyCode in self.KeyCodes do -- what the fuck is this
				if KeyCode == input.KeyCode then
					task.spawn(func, input)
				end
			end
		end
	end)

	table.insert(self.Bindings, signal)
	
	return {
		Unsubscribe = function()
			local idx = table.find(self.Bindings, signal)
			table.remove(self.Bindings, idx)
			signal:Disconnect()
		end,
	}
end

function Class.BindTo(self: Class, keys: {UserKeyInputs})
	assert(typeof(keys) == "table", "InputAction: BindTo, Expected Table got nontable")
	self.KeyCodes = keys
end

function Class.SubscribeBegan(self: Class, func: Funct)
	return Connect(self, UIS.InputBegan, func)
end

function Class.SubscribeEnded(self: Class, func: Funct)
	return Connect(self, UIS.InputEnded, func)
end

function Class.SubscribeChanged(self: Class, func: Funct)
	return Connect(self, UIS.InputChanged, func)
end

function Class.Destroy(self: Class)
	if self.Destroyed == true then return false end
	for i, binding in self.Bindings do
		binding:Disconnect()
	end
	self.Destroyed = true
	return true
end

return Class