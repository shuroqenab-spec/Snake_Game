
local Entity = {}
Entity.__index = Entity

function Entity:new()
    local entity = {
        components = {}
    }

    return setmetatable(entity, Entity)
end

-- Add a component to the entity
function Entity:addComponent(name, component)
    self.components[name] = component
end

-- Get a component by its name
function Entity:getComponent(name)
    return self.components[name]
end

-- Check if a component exists
function Entity:hasComponent(name)
    return self.components[name] ~= nil
end

return Entity
