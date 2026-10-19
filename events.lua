
local Events = {}
Events.__index = Events

function Events:new()
    local eventSystem = {
        listeners = {}
    }

    return setmetatable(eventSystem, Events)
end

-- Subscribe to an event
function Events:subscribe(eventName, callback)
    if not self.listeners[eventName] then
        self.listeners[eventName] = {}
    end

    table.insert(
        self.listeners[eventName],
        callback
    )
end

-- Emit an event
function Events:emit(eventName, ...)
    local callbacks = self.listeners[eventName]

    if callbacks then
        for _, callback in ipairs(callbacks) do
            callback(...)
        end
    end
end

return Events
