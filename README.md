# Snake Game — Lua & LÖVE2D

## Project Description

This project is a Snake Game developed using Lua and the LÖVE2D framework.

The player controls a snake using the arrow keys. The objective is to eat food, increase the score, and avoid collisions with walls and the snake's body.

## Features

- Snake movement using arrow keys
- Random food generation
- Score tracking
- High Score saving and loading
- Wall and self-collision detection
- Game Over and Restart
- Menu and Playing game states
- Entity Component Pattern
- Vector2 Metamethods
- Input Command Pattern
- Event System (Bonus)

## Technologies

- Lua
- LÖVE2D
- Visual Studio Code

## Project Structure

- `main.lua` — Main entry point
- `gamestate.lua` — Game State Manager
- `entity.lua` — Entity Component Pattern
- `vector2.lua` — Vector2 and Metamethods
- `highscore.lua` — High Score management
- `input.lua` — Keyboard command handling
- `events.lua` — Observer Pattern
- `snake_game.lua` — Core Snake game logic
- `states/menu_state.lua` — Menu state
- `states/game_state.lua` — Playing state

## How to Run

1. Install LÖVE2D.
2. Download or clone the repository.
3. Open the project folder.
4. Run the project using LÖVE2D.

On Windows with Git Bash:

```bash
"/c/Program Files/LOVE/love.exe" .
```

## Controls

| Key | Action |
|---|---|
| Enter | Start Game |
| Arrow Keys | Move Snake |
| Space | Restart after Game Over |
| M | Return to Menu |
| Escape | Exit Game |

## Modern Lua Features

### Metatables and Metamethods

The Vector2 class uses `__add`, `__eq`, and `__tostring` to support vector addition, equality comparison, and string conversion.

### Resource Management

The game uses `love.filesystem` to save and load the highest score.

Lua 5.4 supports to-be-closed variables using `<close>`, which automatically closes file resources. LÖVE 11.x uses LuaJIT and does not support this syntax directly. A separate Lua 5.4 example demonstrates the requested feature.

### Observer Pattern

The Event System allows different parts of the game to subscribe to and respond to events such as `food_eaten` and `game_over`.

## Author

Computer Science Student — Lua Game Programming Assignment
