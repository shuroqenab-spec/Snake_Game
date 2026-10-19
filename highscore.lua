
local HighScore = {}

-- Save the highest score
function HighScore:save(score)
    love.filesystem.write(
        "highscore.txt",
        tostring(score)
    )
end

-- Load the highest score
function HighScore:load()
    if love.filesystem.getInfo("highscore.txt") then
        local content = love.filesystem.read("highscore.txt")
        return tonumber(content) or 0
    end

    return 0
end

return HighScore
