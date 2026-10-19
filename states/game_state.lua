local SnakeGame = require("snake_game")
local Input = require("input")

local PlayingState = {}

local game = nil
local input = nil

-- Start a new game
function PlayingState:enter()
    game = SnakeGame:new()
    input = Input:new()

    -- Move Up
    input:bind("up", function()
        game:changeDirection(0, -1)
    end)

    -- Move Down
    input:bind("down", function()
        game:changeDirection(0, 1)
    end)

    -- Move Left
    input:bind("left", function()
        game:changeDirection(-1, 0)
    end)

    -- Move Right
    input:bind("right", function()
        game:changeDirection(1, 0)
    end)
end

-- Update the game
function PlayingState:update(dt)
    if game then
        game:update(dt)
    end
end

-- Draw the game
function PlayingState:draw()
    if game then
        game:draw()
    end
end

-- Handle keyboard input
function PlayingState:keypressed(key, gameState)
    if not game then
        return
    end

    -- Game Over controls
    if game.gameOver then
        if key == "space" or key == "return" then
            game:reset()
        elseif key == "m" then
            gameState:switch("menu")
        end

        return
    end

    -- Return to Menu
    if key == "m" then
        gameState:switch("menu")
        return
    end

    -- Execute the bound command
    input:keypressed(key)
end

return PlayingState
