local Input = {}
Input.__index = Input

-- Create a new Input Handler
function Input:new()
    local input = {
        commands = {}
    }

    return setmetatable(input, Input)
end

-- Bind a key to a command
function Input:bind(key, command)
    self.commands[key] = command
end

-- Execute command when key is pressed
function Input:keypressed(key)
    local command = self.commands[key]

    if command then
        command()
    end
end

return Input
