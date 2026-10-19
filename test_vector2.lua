
local Vector2 = require("vector2")

local a = Vector2:new(2, 3)
local b = Vector2:new(4, 5)

-- Test addition
local c = a + b
print("Addition:", tostring(c))

-- Test equality
local d = Vector2:new(2, 3)

print("Equality (a == d):", a == d)
print("Equality (a == b):", a == b)

-- Test tostring
print("Vector a:", tostring(a))

-- Verify expected results
assert(c.x == 6 and c.y == 8)
assert(a == d)
assert(not (a == b))

print("All Vector2 tests passed!")
