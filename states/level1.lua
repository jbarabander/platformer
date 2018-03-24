local LevelState = require "states.level"
local level2 = require "states.level2"
local level = LevelState({
    {x=120, y=180},
    {x=160, y=250},
    {x=240, y=170}
}, level2)

return level