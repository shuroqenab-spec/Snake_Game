
local MenuState = {}

function MenuState:update(dt)
    -- No updates needed for the menu yet
end

function MenuState:draw()
    love.graphics.setBackgroundColor(0.1, 0.1, 0.12)

    love.graphics.setColor(0.3, 0.9, 0.4)
    love.graphics.printf(
        "SNAKE GAME",
        0, 180, 600, "center"
    )

    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(
        "Press ENTER to Start",
        0, 280, 600, "center"
    )

    love.graphics.printf(
        "Use Arrow Keys to Move",
        0, 320, 600, "center"
    )
end

function MenuState:keypressed(key, gameState)
    if key == "return" then
        gameState:switch("playing")
    end
end

return MenuState
