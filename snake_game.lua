local Events = require("events")
local Entity = require("entity")
local HighScore = require("highscore")
local SnakeGame = {}
SnakeGame.__index = SnakeGame

local GRID = 20
local CELL = 30
local STEP_TIME = 0.12

-- Create a new Snake Game
function SnakeGame:new()
  local game = {
    snake = {},
    events = Events:new(),
    snakeEntity = Entity:new(),
    direction = { x = 1, y = 0 },
    nextDirection = { x = 1, y = 0 },
    food = nil,
    score = 0,
    gameOver = false,
    timer = 0,
    highScore = HighScore:load()
  }
game.eventMessage = ""

game.events:subscribe("food_eaten", function(newScore)
    game.eventMessage = "Food eaten! Score: " .. newScore
end)

game.events:subscribe("game_over", function(finalScore)
    game.eventMessage = "Game Over! Final Score: " .. finalScore
end)

  setmetatable(game, SnakeGame)
  game.events:subscribe("food_eaten", function(newScore)
    print("Food eaten! Score:", newScore)
end)

game.events:subscribe("game_over", function(finalScore)
    print("Game Over! Final Score:", finalScore)
end)
  game:reset()

  return game

  
end

-- Reset the game
function SnakeGame:reset()
  self.snake = {
    { x = 10, y = 10 },
    { x = 9,  y = 10 },
    { x = 8,  y = 10 }
  }
self.eventMessage = ""
  self.direction = { x = 1, y = 0 }
  self.nextDirection = { x = 1, y = 0 }

  self.score = 0
  self.timer = 0
  self.gameOver = false

  -- Position Component
  self.snakeEntity:addComponent("position", {
    x = self.snake[1].x,
    y = self.snake[1].y
  })

  -- Movement Component
  self.snakeEntity:addComponent("movement", {
    dx = self.direction.x,
    dy = self.direction.y
  })

  -- Renderer Component
  self.snakeEntity:addComponent("renderer", {
    color = { 0.3, 0.8, 0.4 },
    size = CELL
  })

  self:spawnFood()
end

-- Generate food at a random empty position
function SnakeGame:spawnFood()
  if #self.snake >= GRID * GRID then
    self.food = nil
    self.gameOver = true
    return
  end

  while true do
    local x = love.math.random(0, GRID - 1)
    local y = love.math.random(0, GRID - 1)

    local free = true

    for _, segment in ipairs(self.snake) do
      if segment.x == x and segment.y == y then
        free = false
        break
      end
    end

    if free then
      self.food = { x = x, y = y }
      return
    end
  end
end

function SnakeGame:finishGame()
    if self.gameOver then
        return
    end

    self.gameOver = true

    if self.score > self.highScore then
        self.highScore = self.score
        HighScore:save(self.highScore)
    end

    self.events:emit("game_over", self.score)
end

-- Move the snake
function SnakeGame:moveSnake()
  self.direction = self.nextDirection

  local head = self.snake[1]

  local newHead = {
    x = head.x + self.direction.x,
    y = head.y + self.direction.y
  }

  -- Wall Collision
  if newHead.x < 0 or newHead.x >= GRID
      or newHead.y < 0 or newHead.y >= GRID then
    self:finishGame()
    return
  end

  -- Check if snake eats food
  local eating = self.food
      and newHead.x == self.food.x
      and newHead.y == self.food.y

  -- Self Collision
  local lastIndex = eating
      and #self.snake or #self.snake - 1

  for i = 1, lastIndex do
    local segment = self.snake[i]

    if newHead.x == segment.x
        and newHead.y == segment.y then
      self:finishGame()
      return
    end
  end

  -- Add new head
  table.insert(self.snake, 1, newHead)

  -- Update Position Component
  local position =
      self.snakeEntity:getComponent("position")

  position.x = newHead.x
  position.y = newHead.y

  -- Update Movement Component
  local movement =
      self.snakeEntity:getComponent("movement")

  movement.dx = self.direction.x
  movement.dy = self.direction.y

  -- Handle food eating
  if eating then
    self.score = self.score + 1

    self.events:emit("food_eaten", self.score)

    self:spawnFood()
else
    table.remove(self.snake)
end
end

-- Update game
function SnakeGame:update(dt)
  if self.gameOver then
    return
  end

  self.timer = self.timer + dt

  while self.timer >= STEP_TIME
    and not self.gameOver do
    self.timer = self.timer - STEP_TIME
    self:moveSnake()
  end
end

-- Draw game
function SnakeGame:draw()
  love.graphics.setBackgroundColor(0.1, 0.1, 0.12)

  -- Draw Food
  if self.food then
    love.graphics.setColor(1, 0.3, 0.3)

    love.graphics.rectangle(
      "fill",
      self.food.x * CELL,
      self.food.y * CELL,
      CELL - 2,
      CELL - 2
    )
  end

  -- Get Renderer Component
  local renderer =
      self.snakeEntity:getComponent("renderer")

  -- Draw Snake
  for i, segment in ipairs(self.snake) do
    if i == 1 then
      love.graphics.setColor(0.5, 1, 0.6)
    else
      love.graphics.setColor(renderer.color)
    end

    love.graphics.rectangle(
      "fill",
      segment.x * renderer.size,
      segment.y * renderer.size,
      renderer.size - 2,
      renderer.size - 2
    )
  end

  -- Draw Score
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(
    "Score: " .. self.score,
    10, 10
  )
  love.graphics.print(
    "High Score: " .. self.highScore,
    10, 30
  )

  love.graphics.setColor(1, 1, 0)
love.graphics.print(self.eventMessage or "", 10, 50)
  -- Game Over Screen
  if self.gameOver then
    love.graphics.setColor(0, 0, 0, 0.75)

    love.graphics.rectangle(
      "fill",
      0, 0,
      GRID * CELL,
      GRID * CELL
    )

    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(
      "GAME OVER\nScore: " .. self.score ..
      "\nPress SPACE to restart" ..
      "\nPress M for Menu",
      0,
      250,
      GRID * CELL,
      "center"
    )
  end
end

-- Change snake direction
function SnakeGame:changeDirection(dx, dy)
  if self.gameOver then
    return
  end

  -- Prevent reverse direction
  if dx == -self.direction.x
      and dy == -self.direction.y then
    return
  end

  -- Prevent multiple turns in one step
  if self.nextDirection.x ~= self.direction.x
      or self.nextDirection.y ~= self.direction.y then
    return
  end

  self.nextDirection = {
    x = dx,
    y = dy
  }
end

return SnakeGame
