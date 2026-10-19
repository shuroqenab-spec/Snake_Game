local GameState = require("gamestate")

local gameState

function love.load()
    love.window.setMode(600, 600)
    love.window.setTitle("Snake Game")

    gameState = GameState:new()
end

function love.update(dt)
    gameState:update(dt)
end

function love.draw()
    gameState:draw()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
        return
    end

    gameState:keypressed(key)
end
