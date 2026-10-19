
local GameState = {}
GameState.__index = GameState

function GameState:new()
    local state = {
        current = "menu",
        states = {
            menu = require("states.menu_state"),
            playing = require("states.game_state")
        }
    }

    return setmetatable(state, GameState)
end

function GameState:switch(newState)
    if self.states[newState] then
        self.current = newState

        local state = self.states[newState]

        if state.enter then
            state:enter()
        end
    end
end

function GameState:update(dt)
    local state = self.states[self.current]
    state:update(dt)
end

function GameState:draw()
    local state = self.states[self.current]
    state:draw()
end

function GameState:keypressed(key)
    local state = self.states[self.current]

    if state.keypressed then
        state:keypressed(key, self)
    end
end

return GameState
